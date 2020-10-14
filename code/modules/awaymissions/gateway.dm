GLOBAL_DATUM(the_gateway, /obj/machinery/gateway/centerstation)
GLOBAL_DATUM(awaygatelist, /obj/machinery/gateway/centeraway)

/obj/machinery/gateway
	name = "gateway"
	desc = "A mysterious gateway built by unknown hands, it allows for faster than light travel to far-flung locations."
	icon = 'icons/obj/machines/gateway.dmi'
	icon_state = "off"
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/active = 0
	var/checkparts = TRUE
	var/list/obj/effect/landmark/randomspawns = list()
	var/calibrated = TRUE
	var/list/linked = list()
	var/can_link = FALSE	//Is this the centerpiece?

/obj/machinery/gateway/Initialize()
	randomspawns = GLOB.awaydestinations
	update_icon()
	if(!istype(src, /obj/machinery/gateway/centerstation) && !istype(src, /obj/machinery/gateway/centeraway))
		switch(dir)
			if(SOUTH,SOUTHEAST,SOUTHWEST)
				density = FALSE
	return ..()

/obj/machinery/gateway/proc/toggleoff()
	for(var/obj/machinery/gateway/G in linked)
		G.active = 0
		G.update_icon()
	active = 0
	update_icon()

/obj/machinery/gateway/proc/detect()
	if(!can_link)
		return FALSE
	linked = list()	//clear the list
	var/turf/T = loc
	var/ready = FALSE

	for(var/i in GLOB.alldirs)
		T = get_step(loc, i)
		var/obj/machinery/gateway/G = locate(/obj/machinery/gateway) in T
		if(G)
			linked.Add(G)
			continue

		//this is only done if we fail to find a part
		ready = FALSE
		toggleoff()
		break

	if((linked.len == 8) || !checkparts)
		ready = TRUE
	return ready

/obj/machinery/gateway/update_icon()
	if(active)
		icon_state = "on"
		return
	icon_state = "off"

/obj/machinery/gateway/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!detect())
		return
	if(!active)
		toggleon(user)
		return
	toggleoff()

/obj/machinery/gateway/proc/toggleon(mob/user)
	return FALSE

/obj/machinery/gateway/safe_throw_at(atom/target, range, speed, mob/thrower, spin = TRUE, diagonals_first = FALSE, datum/callback/callback, force = MOVE_FORCE_STRONG)
	return

/obj/machinery/gateway/centerstation/Initialize()
	. = ..()
	if(!GLOB.the_gateway)
		GLOB.the_gateway = src
	update_icon()
	awaygate = locate(/obj/machinery/gateway/centeraway)

/obj/machinery/gateway/centerstation/Destroy()
	if(GLOB.the_gateway == src)
		GLOB.the_gateway = null
	return ..()

//this is da important part wot makes things go
/obj/machinery/gateway/centerstation
	density = TRUE
	icon_state = "offcenter"
	use_power = IDLE_POWER_USE

	//warping vars
	var/obj/machinery/gateway/centeraway/awaygate = null
	can_link = TRUE

/obj/machinery/gateway/centerstation/update_icon()
	if(active)
		icon_state = "oncenter"
		return
	icon_state = "offcenter"

/obj/machinery/gateway/centerstation/process()
	if((stat & (NOPOWER)) && use_power)
		if(active)
			toggleoff()
		return

	if(active)
		use_power(5000)

/obj/machinery/gateway/centerstation/toggleon(mob/user)
	if(!detect())
		return
	if(!powered())
		return
	var/targetdestination = stripped_input(user, "Enter the target destination ID", "Destination selection:", "MAIN_MISSION")
	for(var/obj/machinery/gateway/centeraway/G in world)
		if(G.targetid == targetdestination)
			awaygate = G
			if(!G.calibrated)
				say("Target is not calibrated. Travel will not be possible.")
	if(!awaygate)
		say("Error: No destination found.")
		return

	for(var/obj/machinery/gateway/G in linked)
		G.active = 1
		G.update_icon()
	active = 1
	update_icon()

//okay, here's the good teleporting stuff
/obj/machinery/gateway/centerstation/Bumped(atom/movable/AM)
	if(!active)
		return
	if(!detect())
		return
	if(!awaygate || QDELETED(awaygate))
		return

	if(awaygate.calibrated)
		AM.forceMove(get_step(awaygate.loc, SOUTH))
		AM.setDir(SOUTH)
		if (ismob(AM))
			var/mob/M = AM
			if (M.client)
				M.client.move_delay = max(world.time + 5, M.client.move_delay)
		return
	else
		say("Error: Target destination is not calibrated. Entry is impossible.")
		return

/obj/machinery/gateway/centeraway/multitool_act(mob/living/user, obj/item/I)
	if(calibrated)
		to_chat(user, "\black The gate is already calibrated, there is no work for you to do here.")
	else
		to_chat(user, "<span class='boldnotice'>Recalibration successful!</span>: \black This gate's systems have been fine tuned.  Travel to this gate will now be possible.")
		calibrated = TRUE
	return TRUE

/////////////////////////////////////Away////////////////////////


/obj/machinery/gateway/centeraway
	density = TRUE
	icon_state = "offcenter"
	use_power = NO_POWER_USE
	var/obj/machinery/gateway/centerstation/stationgate = null
	can_link = TRUE
	var/targetid = "MAIN_MISSION"


/obj/machinery/gateway/centeraway/Initialize()
	. = ..()
	update_icon()
	stationgate = locate(/obj/machinery/gateway/centerstation)
	if(!GLOB.awaygatelist)
		GLOB.awaygatelist += src


/obj/machinery/gateway/centeraway/update_icon()
	if(active)
		icon_state = "oncenter"
		return
	icon_state = "offcenter"

/obj/machinery/gateway/centeraway/toggleon(mob/user)
	if(!detect())
		return
	if(!stationgate)
		say("Error: No destination found.")
		return

	for(var/obj/machinery/gateway/G in linked)
		G.active = 1
		G.update_icon()
	active = 1
	update_icon()

/obj/machinery/gateway/centeraway/proc/check_exile_implant(mob/living/L)
	for(var/obj/item/implant/exile/E in L.implants)//Checking that there is an exile implant
		to_chat(L, "\black The station gate has detected your exile implant and is blocking your entry.")
		return TRUE
	return FALSE

/obj/machinery/gateway/centeraway/Bumped(atom/movable/AM)
	if(!detect())
		return
	if(!active)
		return
	if(!stationgate || QDELETED(stationgate))
		return
	if(isliving(AM))
		if(check_exile_implant(AM))
			return
	else
		for(var/mob/living/L in AM.contents)
			if(check_exile_implant(L))
				say("Rejecting [AM]: Exile implant detected in contained lifeform.")
				return
	if(AM.has_buckled_mobs())
		for(var/mob/living/L in AM.buckled_mobs)
			if(check_exile_implant(L))
				say("Rejecting [AM]: Exile implant detected in close proximity lifeform.")
				return
	AM.forceMove(get_step(stationgate.loc, SOUTH))
	AM.setDir(SOUTH)
	if (ismob(AM))
		var/mob/M = AM
		if (M.client)
			M.client.move_delay = max(world.time + 5, M.client.move_delay)

/obj/machinery/gateway/centeraway/unstable
	targetid = "TIMED_MISSION"
	var/timeinmission = 300
	var/collapsetime = null
	var/list/obj/item/pinpointer/pinpointer_gateway/linked_pinpointers = list()
	desc = "An unstable temporal gateway, linking our world to this strange anomaly in time. Anyone still trapped here when it collapses will die to the sands of time."

/obj/machinery/gateway/centeraway/unstable/Initialize()
	. = ..()
	collapsetime = world.time + timeinmission

/obj/machinery/gateway/centeraway/unstable/proc/get_time()
	var/showtime = collapsetime - world.time
	return showtime / 10

/obj/machinery/gateway/centeraway/unstable/examine(mob/user)
	. = ..()
	to_chat(user, "This gateway will collapse in [get_time()] seconds.")

/obj/machinery/gateway/centeraway/unstable/process()
	if(collapsetime < world.time)
		collapse()
	else
		var/volume = (get_time() <= 20 ? 30 : 5)
		playsound(loc, 'sound/items/timer.ogg', volume, FALSE)

/obj/machinery/gateway/centeraway/unstable/proc/collapse()
	for(var/obj/item/pinpointer/pinpointer_gateway/P in linked_pinpointers)
		P.alert = FALSE
		P.linked_gate = null
	for(var/mob/living/M in GLOB.mob_list)
		if(M.z == z)
			M.dust()
	for(var/obj/machinery/gateway/G in linked)
		qdel(G)
	qdel(src)

/obj/machinery/gateway/centeraway/unstable/attackby(obj/item/pinpointer/pinpointer_gateway/P, mob/user, params)
	. = ..()
	to_chat(user, "<span class='notice'>You link [P] to [src], allowing the time until collapse to be tracked.</span>")
	P.linked_gate = src
	linked_pinpointers += P

/obj/machinery/gateway/centeraway/admin
	desc = "A mysterious gateway built by unknown hands, this one seems more compact."

/obj/machinery/gateway/centeraway/admin/detect()
	return TRUE


/obj/item/paper/fluff/gateway
	info = "Congratulations,<br><br>Your station has been selected to carry out the Gateway Project.<br><br>The equipment will be shipped to you at the start of the next quarter.<br> You are to prepare a secure location to house the equipment as outlined in the attached documents.<br><br>--Nanotrasen Bluespace Research"
	name = "Confidential Correspondence, Pg 1"

/obj/item/paper/fluff/itemnotice
	info = "Notice: Over the last few weeks there have been increased reports of surplus, trash items such as wrappers being found in Bluespace Capsule Products. In the event this encampment has any such item, please dispose of them within a wastebin or the provided bonfire, especially if such items include frivolous, frankly embarassing things. We apologise for the inconvienence. Thank you. -- Nanotrasen BS Productions"
	name = "Surplus Item Removal Notice"

/obj/item/paper/fluff/encampmentwelcome
	info = "Welcome! If you are reading this, then you have bought and deployed the new line of bluespace capsule shelters, the mining encampment! This capsule provides standard shelter equipment and more, such as an expanded food vendor, floor safe, restroom, suit storage, spare equipment, and a personal requisitions vendor! The outside has even been lined with basalt tiles, just so no rocks get in the way of the cozy courtyard! We hope you stay safe, and enjoy the amenities! - Nanotrasen BS Productions"
	name = "Welcome!"

/obj/item/paper/fluff/shuttlenotice
	info = "To the acting captain of Nanotrasen Research Station SS13, Due to the nature of your emergency, we sadly had to expedite the process of constructing this shuttle, and as such it does not follow standard sanitary regulations. We appreciate your purchase, and apologise for the inconvienence. Thank you, and have a safe flight! -- Nanotrasen BS Productions Engineering Team"
	name = "Shuttle Notice"
