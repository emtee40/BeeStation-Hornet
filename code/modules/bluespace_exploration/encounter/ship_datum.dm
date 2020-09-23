/datum/ship_datum
	var/ship_name = "cringelord"
	var/ship_faction = /datum/faction/station

	//Integrity calculations
	var/max_ship_integrity	//The ship integrity at it's highest
	var/current_ship_integrity	//The ships current ingerity

	var/integrity_remaining

	//The mobile port ID
	var/mobile_port_id = ""

	//Are we in critical status and about to blow up?
	var/critical = FALSE

	//Does the ship show up on weapons console, and is it allowed to use weapons
	var/combat_allowed = TRUE

	//Do we use bluespace or normal generation
	var/bluespace = TRUE

	//The star systems we can go to (We can choose 1 and new ones are generated after we jump)
	var/list/star_systems

	//For difficulty calculation
	var/jumps = 0

/datum/ship_datum/New()
	. = ..()
	//TODO: Make it share a faction for gods sake
	ship_faction = new ship_faction

/datum/ship_datum/proc/update_ship()
	if(critical)
		return
	//If somehow the docking port manages to get destroyed, assume the ship to be lost
	var/obj/docking_port/mobile/M = SSshuttle.getShuttle(mobile_port_id, FALSE)
	if(!M)
		log_runtime("Unable to locate docking port [mobile_port_id]")
		qdel(src)
		return
	if(M.mode != SHUTTLE_IDLE)
		return
	//Calculate Health
	var/list/turfs = M.return_turfs()
	calculate_health(turfs)
	//Boom
	if(integrity_remaining < 0)
		hull_critical(turfs)
	return turfs

/datum/ship_datum/proc/calculate_health(list/turfs)
	var/calculated_health = 0
	for(var/turf/T in turfs)
		if(istype(T, /turf/closed/wall))
			calculated_health += 5		//Walls are always 5 health
		else if(istype(T, /turf/open/floor))
			//Broken plating - 1, plating - 2, broken floor - 3, floor - 4
			var/turf/open/floor/F = T
			calculated_health += 1
			if(!F.broken && !F.burnt)
				calculated_health += 1
			if(!istype(T, /turf/open/floor/plating))
				calculated_health += 2
	if(calculated_health > max_ship_integrity)
		max_ship_integrity = calculated_health
	message_admins("Ship has [calculated_health] integrity")
	current_ship_integrity = calculated_health
	var/difference = max_ship_integrity - current_ship_integrity
	var/used_health_pool = max_ship_integrity * SHIP_INTEGRITY_FACTOR
	integrity_remaining = used_health_pool - difference

/datum/ship_datum/proc/hull_critical(list/turfs)
	if(critical)
		return
	critical = TRUE
	if(!LAZYLEN(turfs))
		WARNING("Ship [ship_name], port_id [mobile_port_id] has no turfs.")
		return
	var/turf/first_turf = turfs[1]
	message_admins("The [ship_name], port_id [mobile_port_id] has been destroyed, at [ADMIN_JMP(first_turf)]")
	log_attack("The [ship_name], port_id [mobile_port_id] has been destroyed!")
	var/obj/docking_port/mobile/M = SSshuttle.getShuttle(mobile_port_id, FALSE)
	if(M)
		WARNING("Warning, no docking port located on shuttle [ship_name]")
		qdel(M, force = TRUE)
	for(var/turf/T in turfs)
		for(var/obj/machinery/light/L in T)
			L.force_emergency_mode = TRUE
			L.update()
		//Play an alarm to anyone / any observers on the shuttle
		for(var/mob/smob in T)
			if(smob.client)
				SEND_SOUND(smob.client, 'sound/machines/alarm.ogg')
	addtimer(CALLBACK(src, .proc/destroy_ship, turfs), 140)

/datum/ship_datum/proc/destroy_ship(list/turfs)
	set waitfor = FALSE
	var/exploded = FALSE
	for(var/turf/T in turfs)
		for(var/obj/machinery/bluespace_drive/BS in T)
			if(!exploded)
				//Blow up the bluespace drive (basically the ships reactor / core)
				explosion(T, 12, 15, 18, -1, FALSE)
				exploded = TRUE
			qdel(BS)
		for(var/obj/machinery/power/apc/A in T)
			//No more power
			A.set_broken()
	//No explosion, explode anyway
	if(!exploded)
		explosion(pick(turfs), 12, 15, 18, -1, FALSE)
	if(mobile_port_id == "exploration")
		print_command_report("Sensors of your station's exploration shuttle, The Pathfinder have gone dark. The ship and its crew are assumed lost. Their bodies could potentially be recovered, however their last known sector is known to be dangerous.")
	qdel(src)

//Removes all the star systems we could jump to, and generates new ones
//Called: on ship jump
/datum/ship_datum/proc/recalculate_star_systems()
	//Don't initialize until we need it, byond memory doesn't come cheap
	if(!islist(star_systems))
		star_systems = list()
	else
		star_systems.Cut()
	for(var/i = 0 to 5)
		//Generate star systems
		var/datum/star_system/system = new
		system.bluespace_ruins = bluespace
		//Note: If another system has the same name, it will be overwritten which is fine.
		star_systems[system.name] = system
	jumps ++
