/obj/machinery/computer/system_map
	name = "system map console"
	desc = "system map here"
	icon_screen = "cameras"
	icon_keyboard = "security_key"
	circuit = /obj/item/circuitboard/computer/security
	light_color = LIGHT_COLOR_RED
	ui_x = 480
	ui_y = 708

	// Note: Not all shuttles have a bluespace drive
	var/datum/weakref/linked_bluespace_drive

	// Shuttle_ID as seen in SSshuttles
	var/shuttle_id

/obj/machinery/computer/system_map/exploration
	shuttle_id = "exploration"

/obj/machinery/computer/system_map/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	//Locate the shuttle ID we are attatched to (if we are attatched)
	if(!shuttle_id)
		var/turf/our_turf = get_turf(src)
		for(var/shuttle_dock_id in SSbluespace_exploration.tracked_ships)
			var/obj/docking_port/mobile/M = SSshuttle.getShuttle(shuttle_dock_id)
			if(!M)
				continue
			if(M.z != z)
				continue
			if(our_turf in M.return_turfs())
				shuttle_id = M.id
				break
	//Locate the bluespace drive
	addtimer(CALLBACK(src, .proc/locate_bluespace_drive), 10)

/obj/machinery/computer/system_map/ui_interact(\
		mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
		datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	if(!shuttle_id)
		to_chat(usr, "<span class='warning'>Console not attatched to a bluespace capable shuttle.</span>")
		return
	// Update UI
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		// Open UI
		ui = new(user, src, ui_key, "SystemMap", name, ui_x, ui_y, master_ui, state)
		ui.open()

/obj/machinery/computer/system_map/ui_act(action, params)
	switch(action)
		if("jump")
			var/obj/machinery/bluespace_drive/bs_drive = null
			if(linked_bluespace_drive)
				bs_drive = linked_bluespace_drive.resolve()
			if(!bs_drive || QDELETED(bs_drive))
				say("Your drive is experiencing issues. Please contact your ships engineer, or report to a repair depot in the sector.")
				return
			//Locate Star
			var/star_id = params["id"]
			var/star = SSbluespace_exploration.star_systems[star_id]
			if(!star)
				return
			//Locate the BS drive and then trigger jump
			bs_drive.engage(star)
			return
		if("subjump")
			switch(params["target"])
				if("hyperspace")
					var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttle_id)
					if(!shuttle)
						return FALSE
					//Send the shuttle to the transit level
					shuttle.destination = null
					shuttle.mode = SHUTTLE_IGNITING
					shuttle.setTimer(shuttle.ignitionTime)
				if("system")
					var/obj/docking_port/mobile/shuttle = SSshuttle.getShuttle(shuttle_id)
					if(!shuttle)
						return FALSE
					//Send the shuttle to the transit level
					shuttle.destination = null
					shuttle.mode = SHUTTLE_IGNITING
					shuttle.setTimer(shuttle.ignitionTime)

/obj/machinery/computer/system_map/ui_data(mob/user)
	var/list/data = list()
	data["ship_status"] = "eek"
	data["active_lanes"] = 0
	data["queue_length"] = 0
	data["departure_time"] = 0
	return data

/obj/machinery/computer/system_map/ui_static_data(mob/user)
	var/list/data = list()
	var/datum/ship_datum/SD = SSbluespace_exploration.tracked_ships[shuttle_id]
	if(SD)
		data["ship_name"] = SD.ship_name
		var/datum/faction/faction = SD.ship_faction
		data["ship_faction"] = faction.name
		//Initial setup
		if(!islist(SD.star_systems))
			SD.recalculate_star_systems()
		for(var/star_id in SD.star_systems)
			var/datum/star_system/system = star_id
			var/list/formatted_star = list(
				"name" = system.name,
				"alignment" = system.system_alignment,
				"threat" = system.calculated_threat,
				"research_value" = system.calculated_research_potential,
				"distance" = system.distance_from_center,
			)
			data["stars"] += list(formatted_star)
	else
		data["ship_name"] = "Unknown"
		data["ship_faction"] = "independant"
	return data

//Do this a few frames after loading everything, since if it loads at the same time as the drive it can fail to be located
/obj/machinery/computer/system_map/proc/locate_bluespace_drive()
	var/obj/docking_port/mobile/M = SSshuttle.getShuttle(shuttle_id)
	if(M)
		for(var/obj/machinery/bluespace_drive/BSD as anything in GLOB.bluespace_drives)
			if(get_turf(BSD) in M.return_turfs())
				linked_bluespace_drive = WEAKREF(BSD)
				return
