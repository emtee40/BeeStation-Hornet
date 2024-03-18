//Station Shield
// A chain of satellites encircles the station
// Satellites be actived to generate a shield that will block unorganic matter from passing it.
/datum/station_goal/station_shield
	name = "Station Shield"
	var/coverage_goal = 500

/datum/station_goal/station_shield/get_report()
	return list(
		"<blockquote>The station is located in a zone full of space debris.",
		"We have a prototype shielding system you must deploy to reduce collision-related accidents.",
		"",
		"You can order the satellites and control systems at cargo.</blockquote>",
	).Join("\n")

/datum/station_goal/station_shield/check_completion()
	if(..())
		return TRUE
	if(get_coverage() >= coverage_goal)
		return TRUE
	return FALSE

/datum/station_goal/proc/get_coverage()
	var/list/coverage = list()
	for(var/obj/machinery/satellite/meteor_shield/A in GLOB.machines)
		if(!A.active || !is_station_level(A.z))
			continue
		coverage |= view(A.kill_range,A)
	return coverage.len

/obj/machinery/computer/sat_control
	name = "satellite control"
	desc = "Used to control the satellite network."
	circuit = /obj/item/circuitboard/computer/sat_control



	var/notice


/obj/machinery/computer/sat_control/ui_state(mob/user)
	return GLOB.default_state

/obj/machinery/computer/sat_control/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SatelliteControl")
		ui.open()
		ui.set_autoupdate(TRUE) // Satellite stats (could probably be refactored to update when satellite status changes)

/obj/machinery/computer/sat_control/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("toggle")
			toggle(text2num(params["id"]))
			. = TRUE

/obj/machinery/computer/sat_control/proc/toggle(id)
	for(var/obj/machinery/satellite/S in GLOB.machines)
		if(S.id == id && S.get_virtual_z_level() == get_virtual_z_level())
			S.toggle()

/obj/machinery/computer/sat_control/ui_data()
	var/list/data = list()

	data["satellites"] = list()
	for(var/obj/machinery/satellite/S in GLOB.machines)
		data["satellites"] += list(list(
			"id" = S.id,
			"active" = S.active,
			"mode" = S.mode
		))
	data["notice"] = notice


	var/datum/station_goal/station_shield/G = locate() in SSticker.mode.station_goals
	if(G)
		data["meteor_shield"] = 1
		data["meteor_shield_coverage"] = G.get_coverage()
		data["meteor_shield_coverage_max"] = G.coverage_goal
	return data


/obj/machinery/satellite
	name = "\improper Defunct Satellite"
	desc = ""
	icon = 'icons/obj/machines/satellite.dmi'
	icon_state = "sat_inactive"
	anchored = FALSE
	density = TRUE
	use_power = FALSE
	var/mode = "NTPROBEV0.8"
	var/active = FALSE
	var/static/gid = 0
	var/id = 0

/obj/machinery/satellite/Initialize(mapload)
	. = ..()
	id = gid++

/obj/machinery/satellite/interact(mob/user)
	toggle(user)

/obj/machinery/satellite/set_anchored(anchorvalue)
	. = ..()
	if(isnull(.))
		return //no need to process if we didn't change anything.
	active = anchorvalue
	if(anchorvalue)
		begin_processing()
		animate(src, pixel_y = 2, time = 10, loop = -1)
	else
		end_processing()
		animate(src, pixel_y = 0, time = 10)
	update_icon()

/obj/machinery/satellite/proc/toggle(mob/user)
	if(!active && !isinspace())
		if(user)
			to_chat(user, "<span class='warning'>You can only activate [src] in space.</span>")
		return FALSE
	if(user)
		to_chat(user, "<span class='notice'>You [active ? "deactivate": "activate"] [src].</span>")
	set_anchored(!anchored)

/obj/machinery/satellite/update_icon()
	icon_state = active ? "sat_active" : "sat_inactive"

/obj/machinery/satellite/multitool_act(mob/living/user, obj/item/I)
	to_chat(user, "<span class='notice'>// NTSAT-[id] // Mode : [active ? "PRIMARY" : "STANDBY"] //[(obj_flags & EMAGGED) ? "DEBUG_MODE //" : ""]</span>")
	return TRUE

/obj/item/meteor_shield
	name = "\improper Meteor Shield Satellite Deploy Capsule"
	desc = "A bluespace capsule which a single unit of meteor shield satellite is compressed within. If you activate this capsule, a meteor shield satellite will pop out. You still need to install these."
	icon = 'icons/obj/mining.dmi'
	icon_state = "capsule"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/meteor_shield/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/deployable, /obj/machinery/satellite/meteor_shield, time_to_deploy = 10 SECONDS)

/obj/machinery/satellite/meteor_shield
	name = "\improper Meteor Shield Satellite"
	desc = "A meteor point-defense satellite."
	mode = "M-SHIELD"
	processing_flags = START_PROCESSING_MANUALLY
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	var/kill_range = 14

/obj/machinery/satellite/meteor_shield/proc/space_los(meteor)
	for(var/turf/T in getline(src,meteor))
		if(!isspaceturf(T))
			return FALSE
	return TRUE

/obj/machinery/satellite/meteor_shield/process()
	if(!active)
		return
	for(var/obj/effect/meteor/M in GLOB.meteor_list)
		if(M.get_virtual_z_level() != get_virtual_z_level())
			continue
		if(get_dist(M,src) > kill_range)
			continue
		if(!(obj_flags & EMAGGED) && space_los(M))
			Beam(get_turf(M),icon_state="sat_beam", time = 5)
			qdel(M)

/obj/machinery/satellite/meteor_shield/toggle(user)
	if(!..(user))
		return FALSE
	if(obj_flags & EMAGGED)
		if(active)
			change_meteor_chance(2)
		else
			change_meteor_chance(0.5)

/obj/machinery/satellite/meteor_shield/proc/change_meteor_chance(mod)
	var/datum/round_event_control/E = locate(/datum/round_event_control/meteor_wave) in SSevents.control
	if(E)
		E.weight *= mod

/obj/machinery/satellite/meteor_shield/Destroy()
	. = ..()
	if(active && (obj_flags & EMAGGED))
		change_meteor_chance(0.5)

/obj/machinery/satellite/meteor_shield/on_emag(mob/user)
	..()
	to_chat(user, "<span class='notice'>You access the satellite's debug mode, increasing the chance of meteor strikes.</span>")
	if(active)
		change_meteor_chance(2)
