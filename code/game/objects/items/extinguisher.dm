/obj/item/extinguisher
	name = "fire extinguisher"
	desc = "A traditional red fire extinguisher."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "fire_extinguisher0"
	item_state = "fire_extinguisher"
	hitsound = 'sound/weapons/smash.ogg'
	flags_1 = CONDUCT_1
	throwforce = 10
	w_class = WEIGHT_CLASS_LARGE
	throw_speed = 2
	throw_range = 7
	force = 10
	custom_materials = list(/datum/material/iron = 90)
	attack_verb_continuous = list("slams", "whacks", "bashes", "thunks", "batters", "bludgeons", "thrashes")
	attack_verb_simple = list("slam", "whack", "bash", "thunk", "batter", "bludgeon", "thrash")
	dog_fashion = /datum/dog_fashion/back
	resistance_flags = FIRE_PROOF
	var/max_water = 50
	var/last_use = 1
	var/chem = /datum/reagent/water
	var/safety = TRUE
	var/refilling = FALSE
	var/tanktype = /obj/structure/reagent_dispensers/watertank
	var/sprite_name = "fire_extinguisher"
	var/power = 5 //Maximum distance launched water will travel
	var/precision = FALSE //By default, turfs picked from a spray are random, set to 1 to make it always have at least one water effect per row
	var/cooling_power = 2 //Sets the cooling_temperature of the water reagent datum inside of the extinguisher when it is refilled

/obj/item/extinguisher/mini
	name = "pocket fire extinguisher"
	desc = "A light and compact fibreglass-framed model fire extinguisher."
	icon_state = "miniFE0"
	item_state = "miniFE"
	hitsound = null	//it is much lighter, after all.
	flags_1 = null //doesn't CONDUCT_1
	throwforce = 2
	w_class = WEIGHT_CLASS_SMALL
	force = 3
	custom_materials = list(/datum/material/iron = 50, /datum/material/glass = 40)
	max_water = 30
	sprite_name = "miniFE"
	dog_fashion = null

/obj/item/extinguisher/proc/refill()
	create_reagents(max_water, AMOUNT_VISIBLE)
	reagents.add_reagent(chem, max_water)

/obj/item/extinguisher/Initialize(mapload)
	. = ..()
	refill()

/obj/item/extinguisher/advanced
	name = "advanced fire extinguisher"
	desc = "Used to stop thermonuclear fires from spreading inside your engine."
	icon_state = "foam_extinguisher0"
	item_state = "foam_extinguisher"
	dog_fashion = null
	chem = /datum/reagent/firefighting_foam
	tanktype = /obj/structure/reagent_dispensers/foamtank
	sprite_name = "foam_extinguisher"
	precision = TRUE

/obj/item/extinguisher/suicide_act(mob/living/carbon/user)
	if (!safety && (reagents.total_volume >= 1))
		user.visible_message("<span class='suicide'>[user] puts the nozzle to [user.p_their()] mouth. It looks like [user.p_theyre()] trying to extinguish the spark of life!</span>")
		afterattack(user,user)
		return OXYLOSS
	else if (safety && (reagents.total_volume >= 1))
		user.visible_message("<span class='warning'>[user] puts the nozzle to [user.p_their()] mouth... The safety's still on!</span>")
		return SHAME
	else
		user.visible_message("<span class='warning'>[user] puts the nozzle to [user.p_their()] mouth... [src] is empty!</span>")
		return SHAME

/obj/item/extinguisher/attack_self(mob/user)
	safety = !safety
	src.icon_state = "[sprite_name][!safety]"
	to_chat(user, "The safety is [safety ? "on" : "off"].")
	return

/obj/item/extinguisher/attack(mob/M, mob/user)
	if(user.a_intent == INTENT_HELP && !safety) //If we're on help intent and going to spray people, don't bash them.
		return FALSE
	else
		return ..()

/obj/item/extinguisher/attack_obj(obj/O, mob/living/user)
	if(AttemptRefill(O, user))
		refilling = TRUE
		return FALSE
	else
		return ..()

/obj/item/extinguisher/examine(mob/user)
	. = ..()
	. += "The safety is [safety ? "on" : "off"]."

	if(reagents.total_volume)
		. += "<span class='notice'>Alt-click to empty it.</span>"

/obj/item/extinguisher/proc/AttemptRefill(atom/target, mob/user)
	if(istype(target, tanktype) && target.Adjacent(user))
		var/safety_save = safety
		safety = TRUE
		if(reagents.total_volume == reagents.maximum_volume)
			to_chat(user, "<span class='warning'>\The [src] is already full!</span>")
			safety = safety_save
			return 1
		var/obj/structure/reagent_dispensers/W = target //will it work?
		var/transferred = W.reagents.trans_to(src, max_water, transfered_by = user)
		if(transferred > 0)
			to_chat(user, "<span class='notice'>\The [src] has been refilled by [transferred] units.</span>")
			playsound(src.loc, 'sound/effects/refill.ogg', 50, 1, -6)
			for(var/datum/reagent/water/R in reagents.reagent_list)
				R.cooling_temperature = cooling_power
		else
			to_chat(user, "<span class='warning'>\The [W] is empty!</span>")
		safety = safety_save
		return 1
	else
		return 0

/obj/item/extinguisher/afterattack(atom/target, mob/user , flag)
	. = ..()
	// Make it so the extinguisher doesn't spray yourself when you click your inventory items
	if (target.loc == user)
		return
	//TODO; Add support for reagents in water.

	if(refilling)
		refilling = FALSE
		return
	if (!safety)


		if (src.reagents.total_volume < 1)
			to_chat(usr, "<span class='warning'>\The [src] is empty!</span>")
			return

		if (world.time < src.last_use + 12)
			return

		src.last_use = world.time

		playsound(src.loc, 'sound/effects/extinguish.ogg', 75, 1, -3)

		var/direction = get_dir(src,target)

		if(user.buckled && isobj(user.buckled) && !user.buckled.anchored)
			var/obj/B = user.buckled
			var/movementdirection = turn(direction,180)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/extinguisher, move_chair), B, movementdirection), 1)

		else
			user.newtonian_move(turn(direction, 180))

		//Get all the turfs that can be shot at
		var/turf/T = get_turf(target)
		var/turf/T1 = get_step(T,turn(direction, 90))
		var/turf/T2 = get_step(T,turn(direction, -90))
		var/list/the_targets = list(T,T1,T2)
		if(precision)
			var/turf/T3 = get_step(T1, turn(direction, 90))
			var/turf/T4 = get_step(T2,turn(direction, -90))
			the_targets.Add(T3,T4)

		var/list/water_particles = list()
		for(var/a in 1 to 5)
			var/obj/effect/particle_effect/water/extinguisher/water = new /obj/effect/particle_effect/water/extinguisher(get_turf(src))
			var/my_target = pick(the_targets)
			water_particles[water] = my_target
			// If precise, remove turf from targets so it won't be picked more than once
			if(precision)
				the_targets -= my_target
			var/datum/reagents/water_reagents = new /datum/reagents(5)
			water.reagents = water_reagents
			water_reagents.my_atom = water
			reagents.trans_to(water, 1, transfered_by = user)

		//Make em move dat ass, hun
		move_particles(water_particles)

//Particle movement loop
/obj/item/extinguisher/proc/move_particles(list/particles)
	var/delay = 2
	for(var/obj/effect/particle_effect/water/extinguisher/water as anything in particles)
		SSmove_manager.move_towards_legacy(water, particles[water], delay, timeout = delay * power, flags = MOVEMENT_LOOP_START_FAST, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)

//Chair movement loop
/obj/item/extinguisher/proc/move_chair(obj/buckled_object, movementdirection)
	//Only move things with weak move resist
	if (buckled_object.move_resist > MOVE_FORCE_NORMAL)
		return
	var/datum/move_loop/loop = SSmove_manager.move(buckled_object, movementdirection, 1, timeout = 9, flags = MOVEMENT_LOOP_START_FAST, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	//This means the chair slowing down is dependant on the extinguisher existing, which is weird
	//Couldn't figure out a better way though
	RegisterSignal(loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(manage_chair_speed))

/obj/item/extinguisher/proc/manage_chair_speed(datum/move_loop/move/source)
	SIGNAL_HANDLER
	var/multiplier = 3
	if (source.moving.move_resist <= MOVE_FORCE_VERY_WEAK)
		multiplier = 1
	else if(source.moving.move_resist <= MOVE_FORCE_WEAK)
		multiplier = 2
	switch(source.lifetime)
		if(6 to INFINITY)
			source.delay = multiplier
		if(4 to 5)
			source.delay = multiplier + 1
		if(1 to 3)
			source.delay = multiplier + 2

/obj/item/extinguisher/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	EmptyExtinguisher(user)

/obj/item/extinguisher/proc/EmptyExtinguisher(var/mob/user)
	if(loc == user && reagents.total_volume)
		reagents.clear_reagents()

		var/turf/T = get_turf(loc)
		if(isopenturf(T))
			var/turf/open/theturf = T
			theturf.MakeSlippery(TURF_WET_WATER, min_wet_time = 10 SECONDS, wet_time_to_add = 5 SECONDS)

		user.visible_message("[user] empties out \the [src] onto the floor using the release valve.", "<span class='info'>You quietly empty out \the [src] using its release valve.</span>")

//firebot assembly
/obj/item/extinguisher/attackby(obj/O, mob/user, params)
	if(istype(O, /obj/item/bodypart/l_arm/robot) || istype(O, /obj/item/bodypart/r_arm/robot))
		to_chat(user, "<span class='notice'>You add [O] to [src].</span>")
		qdel(O)
		qdel(src)
		user.put_in_hands(new /obj/item/bot_assembly/firebot)
	else
		..()
