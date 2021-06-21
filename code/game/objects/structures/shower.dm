#define SHOWER_FREEZING "freezing"
#define SHOWER_FREEZING_TEMP 100
#define SHOWER_NORMAL "normal"
#define SHOWER_NORMAL_TEMP 300
#define SHOWER_BOILING "boiling"
#define SHOWER_BOILING_TEMP 400
// The volume of it's internal reagents the shower applies to everything it sprays.
#define SHOWER_SPRAY_VOLUME 5
// How much the volume of the shower's spay reagents are amplified by when it sprays something.
#define SHOWER_EXPOSURE_MULTIPLIER 2	// Showers effectively double exposed reagents

/obj/machinery/shower
	name = "shower"
	desc = "The HS-452. Installed in the 2550s by the Nanotrasen Hygiene Division, now with 2560 lead compliance! Passively replenishes itself with water when not in use."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "shower"
	density = FALSE
	use_power = NO_POWER_USE
	//is the shower on/off?
	var/on = FALSE
	//what temp the shower reagents are set to
	var/current_temperature = SHOWER_NORMAL
	//what sound will be played on loop when the shower is on and pouring
	var/datum/looping_sound/showering/soundloop
	//what reagent should the shower be filled with when initially being built
	var/reagent_id = /datum/reagent/water
	//How much reagent capacity should the shower being with when built
	var/reagent_capacity = 200
	//How many units the shower refills every second.
	var/refill_rate = 0.5
	//Whether or not the shower's water reclaimer is operating.
	var/can_refill = TRUE
	//Whether to allow players to toggle the water reclaimer.
	var/can_toggle_refill = TRUE

/obj/machinery/shower/Initialize()
	. = ..()
	create_reagents(reagent_capacity)
	reagents.add_reagent(reagent_id, reagent_capacity)
	soundloop = new(list(src), FALSE)
	AddComponent(/datum/component/plumbing/simple_demand)

/obj/machinery/shower/examine(mob/user)
	. = ..()
	. += "<span class='notice'>[reagents.total_volume]/[reagents.maximum_volume] liquids remaining.</span>"

/obj/machinery/shower/Destroy()
	QDEL_NULL(soundloop)
	QDEL_NULL(reagents)
	return ..()

/obj/machinery/shower/interact(mob/M)
	if(reagents.total_volume < 5)
		to_chat(M,"<span class='notice'>\The [src] is dry.</span>")
		return FALSE
	on = !on
	update_icon()
	handle_mist()
	add_fingerprint(M)
	if(on)
		START_PROCESSING(SSmachines, src)
		process(SSMACHINES_DT)
		soundloop.start()
	else
		soundloop.stop()
		if(isopenturf(loc))
			var/turf/open/tile = loc
			tile.MakeSlippery(TURF_WET_WATER, min_wet_time = 5 SECONDS, wet_time_to_add = 1 SECONDS)

/obj/machinery/shower/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_ANALYZER)
		to_chat(user, "<span class='notice'>The water temperature seems to be [current_temperature].</span>")
	else
		return ..()

/obj/machinery/shower/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(. || !can_toggle_refill)
		return

	can_refill = !can_refill
	to_chat(user, "<span class=notice>You [can_refill ? "en" : "dis"]able the shower's water recycler.</span>")
	playsound(src, 'sound/machines/click.ogg', 20, TRUE)
	return TRUE

/obj/machinery/shower/wrench_act(mob/living/user, obj/item/I)
	to_chat(user, "<span class='notice'>You begin to adjust the temperature valve with \the [I]...</span>")
	if(I.use_tool(src, user, 50))
		switch(current_temperature)
			if(SHOWER_NORMAL)
				current_temperature = SHOWER_FREEZING
			if(SHOWER_FREEZING)
				current_temperature = SHOWER_BOILING
			if(SHOWER_BOILING)
				current_temperature = SHOWER_NORMAL
		user.visible_message("<span class='notice'>[user] adjusts the shower with \the [I].</span>", "<span class='notice'>You adjust the shower with \the [I] to [current_temperature] temperature.</span>")
		user.log_message("has wrenched a shower at [AREACOORD(src)] to [current_temperature].", LOG_ATTACK)
		add_hiddenprint(user)
	handle_mist()
	return TRUE


/obj/machinery/shower/update_overlays()
	. = ..()
	if(on)
		var/mutable_appearance/water_falling = mutable_appearance('icons/obj/watercloset.dmi', "water", ABOVE_MOB_LAYER)
		water_falling.color = mix_color_from_reagents(reagents.reagent_list)
		. += water_falling

/obj/machinery/shower/proc/handle_mist()
	// If there is no mist, and the shower was turned on (on a non-freezing temp): make mist in 5 seconds
	// If there was already mist, and the shower was turned off (or made cold): remove the existing mist in 25 sec
	var/obj/effect/mist/mist = locate() in loc
	if(!mist && on && current_temperature != SHOWER_FREEZING)
		addtimer(CALLBACK(src, .proc/make_mist), 5 SECONDS)

	if(mist && (!on || current_temperature == SHOWER_FREEZING))
		addtimer(CALLBACK(src, .proc/clear_mist), 25 SECONDS)

/obj/machinery/shower/proc/make_mist()
	var/obj/effect/mist/mist = locate() in loc
	if(!mist && on && current_temperature != SHOWER_FREEZING)
		var/obj/effect/mist/new_mist = new /obj/effect/mist(loc)
		new_mist.color = mix_color_from_reagents(reagents.reagent_list)

/obj/machinery/shower/proc/clear_mist()
	var/obj/effect/mist/mist = locate() in loc
	if(mist && (!on || current_temperature == SHOWER_FREEZING))
		qdel(mist)


/obj/machinery/shower/Crossed(atom/movable/AM)
	..()
	if(on && reagents.total_volume)
		wash_atom(AM)

/obj/machinery/shower/proc/wash_atom(atom/target)
	SEND_SIGNAL(target, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
	reagents.reaction(target, TOUCH, SHOWER_EXPOSURE_MULTIPLIER * SHOWER_SPRAY_VOLUME / max(reagents.total_volume, SHOWER_SPRAY_VOLUME))

	if(isobj(target))
		wash_obj(target)
	else if(isturf(target))
		wash_turf(target)
	else if(isliving(target))
		wash_mob(target)
		check_heat(target)

	contamination_cleanse(target)

/obj/machinery/shower/proc/wash_obj(obj/O)
	. = SEND_SIGNAL(O, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
	O.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)


/obj/machinery/shower/proc/wash_turf(turf/tile)
	SEND_SIGNAL(tile, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
	tile.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	for(var/obj/effect/E in tile)
		if(is_cleanable(E))
			qdel(E)


/obj/machinery/shower/proc/wash_mob(mob/living/L)
	SEND_SIGNAL(L, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
	L.wash_cream()
	L.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	if(iscarbon(L))
		var/mob/living/carbon/M = L
		. = TRUE

		for(var/obj/item/I in M.held_items)
			wash_obj(I)

		if(M.back && wash_obj(M.back))
			M.update_inv_back(0)

		var/list/obscured = M.check_obscured_slots()

		if(M.head && wash_obj(M.head))
			M.update_inv_head()

		if(M.glasses && !(ITEM_SLOT_EYES in obscured) && wash_obj(M.glasses))
			M.update_inv_glasses()

		if(M.wear_mask && !(ITEM_SLOT_MASK in obscured) && wash_obj(M.wear_mask))
			M.update_inv_wear_mask()

		if(M.ears && !(HIDEEARS in obscured) && wash_obj(M.ears))
			M.update_inv_ears()

		if(M.wear_neck && !(ITEM_SLOT_NECK in obscured) && wash_obj(M.wear_neck))
			M.update_inv_neck()

		if(M.shoes && !(HIDESHOES in obscured) && wash_obj(M.shoes))
			M.update_inv_shoes()

		var/washgloves = FALSE
		if(M.gloves && !(HIDEGLOVES in obscured))
			washgloves = TRUE

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(check_clothes(L))
				if(H.hygiene <= 75)
					to_chat(H, "<span class='warning'>You have to remove your clothes to get clean!</span>")
			else
				H.set_hygiene(HYGIENE_LEVEL_CLEAN)
				SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "shower", /datum/mood_event/nice_shower)

			if(H.wear_suit && wash_obj(H.wear_suit))
				H.update_inv_wear_suit()
			else if(H.w_uniform && wash_obj(H.w_uniform))
				H.update_inv_w_uniform()

			if(washgloves)
				SEND_SIGNAL(H, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRENGTH_BLOOD)

			if(!H.is_mouth_covered())
				H.lip_style = null
				H.update_body()

			if(H.belt && wash_obj(H.belt))
				H.update_inv_belt()
		else
			SEND_SIGNAL(M, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRENGTH_BLOOD)
			SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "shower", /datum/mood_event/nice_shower)
	else
		SEND_SIGNAL(L, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRENGTH_BLOOD)
		SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "shower", /datum/mood_event/nice_shower)

/obj/machinery/shower/proc/contamination_cleanse(atom/thing)
	var/datum/component/radioactive/healthy_green_glow = thing.GetComponent(/datum/component/radioactive)
	if(!healthy_green_glow || QDELETED(healthy_green_glow))
		return
	var/strength = healthy_green_glow.strength
	if(strength <= RAD_BACKGROUND_RADIATION)
		qdel(healthy_green_glow)
		return
	healthy_green_glow.strength -= max(0, (healthy_green_glow.strength - (RAD_BACKGROUND_RADIATION * 2)) * 0.2)

/obj/machinery/shower/process(delta_time)
	if(on && reagents.total_volume >= 5)
		wash_atom(loc)
		for(var/AM in loc)
			var/atom/movable/movable_content = AM
			wash_atom(movable_content)
		reagents.remove_any(SHOWER_SPRAY_VOLUME)
		return
	on = FALSE
	soundloop.stop()
	handle_mist()
	if(can_refill)
		reagents.add_reagent(reagent_id, refill_rate * delta_time)
	update_icon()
	if(reagents.total_volume == reagents.maximum_volume)
		return PROCESS_KILL

/obj/machinery/shower/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/iron(drop_location(), 3)
	qdel(src)

/obj/machinery/shower/proc/check_heat(mob/living/L)
	var/mob/living/carbon/C = L

	if(current_temperature == SHOWER_FREEZING)
		if(iscarbon(L))
			C.adjust_bodytemperature(-80, 80)
		to_chat(L, "<span class='warning'>[src] is freezing!</span>")
	else if(current_temperature == SHOWER_BOILING)
		if(iscarbon(L))
			C.adjust_bodytemperature(35, 0, 500)
		L.adjustFireLoss(5)
		to_chat(L, "<span class='danger'>[src] is searing!</span>")

/obj/machinery/shower/proc/check_clothes(mob/living/carbon/human/H)
	if(H.wear_suit && (H.wear_suit.clothing_flags & SHOWEROKAY))
		// Do not check underclothing if the over-suit is suitable.
		// This stops people feeling dumb if they're showering
		// with a radiation suit on.
		return FALSE

	. = FALSE
	if(H.wear_suit && !(H.wear_suit.clothing_flags & SHOWEROKAY))
		. = TRUE
	else if(H.w_uniform && !(H.w_uniform.clothing_flags & SHOWEROKAY))
		. = TRUE
	else if(H.wear_mask && !(H.wear_mask.clothing_flags & SHOWEROKAY))
		. = TRUE
	else if(H.head && !(H.head.clothing_flags & SHOWEROKAY))
		. = TRUE

/obj/structure/showerframe
	name = "shower frame"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "shower_frame"
	desc = "A shower frame, that needs a water recycler to finish construction."
	anchored = FALSE

/obj/structure/showerframe/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stock_parts/water_recycler))
		qdel(I)
		var/obj/machinery/shower/new_shower = new /obj/machinery/shower(loc)
		new_shower.setDir(dir)
		qdel(src)
		return
	return ..()

/obj/structure/showerframe/Initialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, .proc/can_be_rotated))

/obj/structure/showerframe/proc/can_be_rotated(mob/user, rotation_type)
	if(anchored)
		to_chat(user, "<span class='warning'>It is fastened to the floor!</span>")
	return !anchored

/obj/effect/mist
	name = "mist"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "mist"
	layer = FLY_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

#undef SHOWER_SPRAY_VOLUME
#undef SHOWER_EXPOSURE_MULTIPLIER
#undef SHOWER_BOILING_TEMP
#undef SHOWER_BOILING
#undef SHOWER_NORMAL_TEMP
#undef SHOWER_NORMAL
#undef SHOWER_FREEZING_TEMP
#undef SHOWER_FREEZING