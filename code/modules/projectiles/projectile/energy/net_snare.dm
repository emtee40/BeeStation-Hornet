/obj/item/projectile/energy/net
	name = "energy netting"
	icon_state = "e_netting"
	damage = 10
	damage_type = STAMINA
	flag = "stamina"
	hitsound = 'sound/weapons/taserhit.ogg'
	range = 10

/obj/item/projectile/energy/net/Initialize(mapload)
	. = ..()
	SpinAnimation()

/obj/item/projectile/energy/net/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/turf/Tloc = get_turf(target)
		if(!locate(/obj/effect/nettingportal) in Tloc)
			new /obj/effect/nettingportal(Tloc)
	..()

/obj/item/projectile/energy/net/on_range()
	do_sparks(1, TRUE, src)
	..()

/obj/effect/nettingportal
	name = "DRAGnet teleportation field"
	desc = "A field of bluespace energy, locking on to teleport a target."
	icon = 'icons/effects/effects.dmi'
	icon_state = "dragnetfield"
	light_range = 3
	anchored = TRUE

/obj/effect/nettingportal/Initialize(mapload)
	. = ..()
	var/obj/item/beacon/teletarget = null

	for(var/obj/item/beacon/bea in GLOB.teleportbeacons)
		if(is_eligible(bea) && bea.nettingportal) //is it quick dragnet beacon?
			teletarget = bea

	addtimer(CALLBACK(src, PROC_REF(pop), teletarget), 30)

/obj/effect/nettingportal/proc/is_eligible(atom/movable/AM)
	//this code has to be ported in so it is not abused

	var/turf/T = get_turf(AM)
	if(!T)
		return FALSE

	var/turf/S = get_turf(src)
	if (S.get_virtual_z_level() != T.get_virtual_z_level())	//cannot teleport to another Zlevel
		return FALSE
	var/area/A = get_area(T)
	if(!A || A.teleport_restriction)
		return FALSE
	return TRUE

/obj/effect/nettingportal/proc/pop(teletarget)
	if(teletarget)
		for(var/mob/living/L in get_turf(src))
			do_teleport(L, teletarget, 0, channel = TELEPORT_CHANNEL_BLUESPACE)//teleport what's in the tile to the beacon
	else
		for(var/mob/living/L in get_turf(src))
			do_teleport(L, L, 15, channel = TELEPORT_CHANNEL_BLUESPACE) //Otherwise it just warps you off somewhere.

	qdel(src)

/obj/effect/nettingportal/singularity_act()
	return

/obj/effect/nettingportal/singularity_pull()
	return

/obj/item/projectile/energy/trap
	name = "energy snare"
	icon_state = "e_snare"
	nodamage = TRUE
	hitsound = 'sound/weapons/taserhit.ogg'
	range = 4

/obj/item/projectile/energy/trap/on_hit(atom/target, blocked = FALSE)
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - drop a trap
		new/obj/item/restraints/legcuffs/beartrap/energy(get_turf(loc))
	else if(iscarbon(target))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy(get_turf(target))
		B.spring_trap(null, target)
	. = ..()

/obj/item/projectile/energy/trap/on_range()
	new /obj/item/restraints/legcuffs/beartrap/energy(loc)
	..()

/obj/item/projectile/energy/trap/cyborg
	name = "Energy Bola"
	icon_state = "e_snare"
	nodamage = TRUE
	paralyze = 0
	hitsound = 'sound/weapons/taserhit.ogg'
	range = 10

/obj/item/projectile/energy/trap/cyborg/on_hit(atom/target, blocked = FALSE)
	if(!ismob(target) || blocked >= 100)
		do_sparks(1, TRUE, src)
		qdel(src)
	if(iscarbon(target))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy/cyborg(get_turf(target))
		B.spring_trap(null, target)
	QDEL_IN(src, 10)
	. = ..()

/obj/item/projectile/energy/trap/cyborg/on_range()
	do_sparks(1, TRUE, src)
	qdel(src)

/obj/item/projectile/energy/trap/cyborg/emp_act(severity)
	do_sparks(1, TRUE, src)
	qdel(src)
