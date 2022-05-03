

/obj/machinery/computer/upload
	var/mob/living/silicon/current = null //The target of future law uploads
	icon_screen = "command"
	var/code = null

/obj/machinery/computer/upload/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Encrypted Upload")
	GLOB.uploads_list += src
	if(mapload)
		set_code_upload()
	else
		set_code_upload_new()

/obj/machinery/computer/upload/Destroy()
	. = ..()
	GLOB.uploads_list -= src


/obj/machinery/computer/upload/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/aiModule))
		var/obj/item/aiModule/M = O
		if(stat & (NOPOWER|BROKEN|MAINT))
			return
		if(!current)
			to_chat(user, "<span class='caution'>You haven't selected anything to transmit laws to!</span>")
			return
		var/input = stripped_input(user, "Please enter the Upload code.", "Uplode Code Check")
		if(!(input == src.code))
			return
		if(!can_upload_to(current))
			to_chat(user, "<span class='caution'>Upload failed!</span> Check to make sure [current.name] is functioning properly.")
			current = null
			return
		var/turf/currentloc = get_turf(current)
		var/turf/user_turf = get_turf(user)
		if(currentloc && user.get_virtual_z_level() != currentloc.get_virtual_z_level() && (!is_station_level(currentloc.z) || !is_station_level(user_turf.z)))
			to_chat(user, "<span class='caution'>Upload failed!</span> Unable to establish a connection to [current.name]. You're too far away!")
			current = null
			return
		M.install(current.laws, user)
		switch(alert("Do you wish to scramble the upload code?", "Scramble Code", "Yes", "No"))
			if("Yes")
				set_code_upload()
				to_chat(usr, "<span class='notice'>You scramble the upload code</span>")
	else
		return ..()

/proc/set_code_upload()
	var/C = random_nukecode()
	for(var/obj/machinery/computer/upload/U in GLOB.uploads_list)
		U.code = C

/obj/machinery/computer/upload/proc/set_code_upload_new()
	var/L = length(GLOB.uploads_list)
	if(L > 1)
		var/obj/machinery/computer/upload/U = GLOB.uploads_list[1]
		src.code = U.code
	else
		set_code_upload()

/obj/machinery/computer/upload/proc/can_upload_to(mob/living/silicon/S)
	if(S.stat == DEAD)
		return FALSE
	return TRUE

/obj/machinery/computer/upload/ai
	name = "\improper AI upload console"
	desc = "Used to upload laws to the AI."
	circuit = /obj/item/circuitboard/computer/aiupload

/obj/machinery/computer/upload/ai/interact(mob/user)
	current = select_active_ai(user)

	if (!current)
		to_chat(user, "<span class='caution'>No active AIs detected!</span>")
	else
		to_chat(user, "[current.name] selected for law changes.")

/obj/machinery/computer/upload/ai/can_upload_to(mob/living/silicon/ai/A)
	if(!A || !isAI(A))
		return FALSE
	if(A.control_disabled)
		return FALSE
	return ..()


/obj/machinery/computer/upload/borg
	name = "Cyborg upload console"
	desc = "Used to upload laws to Cyborgs."
	circuit = /obj/item/circuitboard/computer/borgupload

/obj/machinery/computer/upload/borg/interact(mob/user)
	current = select_active_free_borg(user)

	if(!current)
		to_chat(user, "<span class='caution'>No active unslaved cyborgs detected!</span>")
	else
		to_chat(user, "[current.name] selected for law changes.")

/obj/machinery/computer/upload/borg/can_upload_to(mob/living/silicon/robot/B)
	if(!B || !iscyborg(B))
		return FALSE
	if(B.scrambledcodes || B.emagged)
		return FALSE
	return ..()
