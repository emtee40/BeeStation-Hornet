/datum/orbital_object/z_linked
	name = "Unidentified Beacon"
	//The space level we are linked to
	var/datum/space_level/linked_z_level
	//If docking is forced upon collision
	//If you hit a planet, you are going to the planet whether you like it or not.
	var/forced_docking = FALSE
	//Can you dock on this Z-level anywhere?
	var/can_dock_anywhere = FALSE
	//If we can't dock anywhere, will we just crash on the Z-level at a random position?
	var/random_docking = FALSE
	//Inherit the name of z-level?
	var/inherit_name = FALSE

/datum/orbital_object/z_linked/proc/link_to_z(datum/space_level/level)
	linked_z_level = level
	if(inherit_name)
		name = level.name

/datum/orbital_object/z_linked/explode()
	message_admins("ORBITAL BODY [name] WAS DESTROYED.")
	log_game("Orbital body [name] was destroyed.")
	//Holy shit this is bad.
	for(var/mob/living/L in GLOB.mob_living_list)
		if(L.z == linked_z_level.z_value)
			qdel(L)
	//Prevent access to the z-level.
	//Announcement
	priority_announce("The orbital body [name] has been destroyed. Transit to this location is no longer possible.", "Nanotrasen Orbital Body Division")
	qdel(src)

/datum/orbital_object/z_linked/collision(datum/orbital_object/other)
	//Send shuttle to z-level for docking.
	if(istype(other, /datum/orbital_object/shuttle))
		//send them to the place
		var/datum/orbital_object/shuttle/shuttle = other
		if(other.collision_ignored || collision_ignored)
			//Collisions are currently ignored, give the ability to dock via a button and dont force it
			shuttle.can_dock_with = src
			return
		shuttle.commence_docking(src)
