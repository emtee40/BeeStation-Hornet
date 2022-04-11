/// How often the sensor data updates.
#define SENSORS_UPDATE_PERIOD 10 SECONDS

/// The job sorting ID associated with otherwise unknown jobs
#define UNKNOWN_JOB_ID	81

/obj/machinery/computer/crew
	name = "crew monitoring console"
	desc = "Used to monitor active health sensors built into most of the crew's uniforms."
	icon_screen = "crew"
	icon_keyboard = "med_key"
	use_power = IDLE_POWER_USE
	idle_power_usage = 250
	active_power_usage = 500
	circuit = /obj/item/circuitboard/computer/crew

	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/crew/syndie
	icon_keyboard = "syndie_key"

/obj/machinery/computer/crew/ui_interact(mob/user)
	GLOB.crewmonitor.show(user,src)

GLOBAL_DATUM_INIT(crewmonitor, /datum/crewmonitor, new)

/datum/crewmonitor

	/// List of user -> UI source
	var/list/ui_sources = list()

	/// Cache of data generated by z-level, used for serving the data within SENSOR_UPDATE_PERIOD of the last update
	var/list/data_by_z = list()

	/// Cache of last update time for each z-level
	var/list/last_update = list()

	/// Map of job to ID for sorting purposes
	var/list/jobs = list(
		// Note that jobs divisible by 10 are considered heads of staff, and bolded
		// 00: Captain
		"Captain" = 00,
		// 10-19: Security
		"Head of Security" = 10,
		"Warden" = 11,
		"Security Officer" = 12,
		"Detective" = 13,
		"Brig Physician" = 14,
		"Deputy" = 15,
		// 20-29: Medbay
		"Chief Medical Officer" = 20,
		"Chemist" = 21,
		"Geneticist" = 22,
		"Virologist" = 23,
		"Medical Doctor" = 24,
		"Paramedic" = 25,
		"Psychiatrist" = 26,
		// 30-39: Science
		"Research Director" = 30,
		"Scientist" = 31,
		"Roboticist" = 32,
		"Exploration Crew" = 33,
		// 40-49: Engineering
		"Chief Engineer" = 40,
		"Station Engineer" = 41,
		"Atmospheric Technician" = 42,
		// 50-59: Cargo
		"Head of Personnel" = 50,
		"Quartermaster" = 51,
		"Shaft Miner" = 52,
		"Cargo Technician" = 53,
		// 60+: Civilian/other
		"Bartender" = 61,
		"Cook" = 62,
		"Botanist" = 63,
		"Curator" = 64,
		"Chaplain" = 65,
		"Clown" = 66,
		"Mime" = 67,
		"Janitor" = 68,
		"Lawyer" = 69,
		"Barber" = 71,
		"Stage Magician" = 72,
		"VIP" = 73,
		// ANYTHING ELSE = UNKNOWN_JOB_ID, Unknowns/custom jobs will appear after civilians, and before assistants
		"Assistant" = 999,

		// 200-229: Centcom
		"Admiral" = 200,
		"CentCom Commander" = 210,
		"Custodian" = 211,
		"Medical Officer" = 212,
		"Research Officer" = 213,
		"Emergency Response Team Commander" = 220,
		"Security Response Officer" = 221,
		"Engineer Response Officer" = 222,
		"Medical Response Officer" = 223
	)


/datum/crewmonitor/Destroy()
	return ..()


/datum/crewmonitor/ui_state(mob/user)
	return GLOB.default_state

/datum/crewmonitor/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CrewConsole")
		ui.open()
		ui.set_autoupdate(TRUE)

/datum/crewmonitor/proc/show(mob/M, source)
	ui_sources[WEAKREF(M)] = source
	ui_interact(M)

/datum/crewmonitor/ui_host(mob/user)
	return ui_sources[WEAKREF(user)]

/datum/crewmonitor/ui_data(mob/user)
	var/z = user.get_virtual_z_level()
	var/turf/T = get_turf(user)
	if(!z)
		z = T.get_virtual_z_level()
	. = list(
		"sensors" = update_data(z, T.z),
		"link_allowed" = isAI(user)
	)

/// z represents the virtual z-level the user is on
/// zlevel represents the physical z-level the mob is at.
/datum/crewmonitor/proc/update_data(z, zlevel)
	if(data_by_z["[z]"] && last_update["[z]"] && world.time <= last_update["[z]"] + SENSORS_UPDATE_PERIOD)
		return data_by_z["[z]"]

	var/list/results = list()

	for(var/mob/living/carbon/human/H as() in GLOB.suit_sensors_list)
		if(!H)
			stack_trace("Null reference in suit sensors list")

		var/turf/pos = get_turf(H)
		if(!pos)
			continue

		var/virtual_z_level = H.get_virtual_z_level()

		// Check if their virtual z-level is correct or in case it isn't
		// check if they are on station's 'real' z-level
		if (virtual_z_level != z && !(is_station_level(pos.z) && is_station_level(zlevel)))
			continue

		// Determine if this person is using nanites for sensors,
		// in which case the sensors are always set to full detail
		var/nanite_sensors = (H in SSnanites.nanite_monitored_mobs)

		// Check for a uniform if not using nanites
		var/obj/item/clothing/under/uniform = H.w_uniform
		if(!nanite_sensors && !uniform)
			continue

		//	Radio transmitters are jammed
		if(nanite_sensors ? H.is_jammed() : uniform.is_jammed())
			continue

		// Are the suit sensors on?
		if (!nanite_sensors && (!uniform.has_sensor || !uniform.sensor_mode))
			continue

		// The entry for this human
		var/list/entry = list(
			"ref" = REF(H),
			"name" = "Unknown",
			"ijob" = UNKNOWN_JOB_ID,
		)

		var/obj/item/card/id/I = H.wear_id ? H.wear_id.GetID() : null

		if (I)
			entry["name"] = I.registered_name
			entry["assignment"] = I.assignment
			if(jobs[I.assignment] != null)
				entry["ijob"] = jobs[I.assignment]

		// Binary living/dead status
		if (nanite_sensors || uniform.sensor_mode >= SENSOR_LIVING)
			entry["life_status"] = !H.stat

		// Damage
		if (nanite_sensors || uniform.sensor_mode >= SENSOR_VITALS)
			entry["oxydam"] = round(H.getOxyLoss(), 1)
			entry["toxdam"] = round(H.getToxLoss(), 1)
			entry["burndam"] = round(H.getFireLoss(), 1)
			entry["brutedam"] = round(H.getBruteLoss(), 1)

		// Area
		if (pos && (nanite_sensors || uniform.sensor_mode >= SENSOR_COORDS))
			entry["area"] = get_area_name(H, TRUE)

		// Trackability
		entry["can_track"] = H.can_track()

		results[++results.len] = entry

	data_by_z["[z]"] = results
	last_update["[z]"] = world.time

	return results

/datum/crewmonitor/ui_act(action,params)

	switch (action)
		if ("select_person")
			var/mob/living/silicon/ai/AI = usr
			if(!istype(AI))
				return
			AI.ai_camera_track(params["name"])

#undef SENSORS_UPDATE_PERIOD
#undef UNKNOWN_JOB_ID
