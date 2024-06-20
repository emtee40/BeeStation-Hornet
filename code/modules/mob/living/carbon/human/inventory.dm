/mob/living/carbon/human/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	return dna.species.can_equip(I, slot, disable_warning, src, bypass_equip_delay_self)

// Return the item currently in the slot ID
/mob/living/carbon/human/get_item_by_slot(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_BACK)
			return back
		if(ITEM_SLOT_MASK)
			return wear_mask
		if(ITEM_SLOT_NECK)
			return wear_neck
		if(ITEM_SLOT_HANDCUFFED)
			return handcuffed
		if(ITEM_SLOT_LEGCUFFED)
			return legcuffed
		if(ITEM_SLOT_BELT)
			return belt
		if(ITEM_SLOT_ID)
			return wear_id
		if(ITEM_SLOT_EARS)
			return ears
		if(ITEM_SLOT_EYES)
			return glasses
		if(ITEM_SLOT_GLOVES)
			return gloves
		if(ITEM_SLOT_HEAD)
			return head
		if(ITEM_SLOT_FEET)
			return shoes
		if(ITEM_SLOT_OCLOTHING)
			return wear_suit
		if(ITEM_SLOT_ICLOTHING)
			return w_uniform
		if(ITEM_SLOT_LPOCKET)
			return l_store
		if(ITEM_SLOT_RPOCKET)
			return r_store
		if(ITEM_SLOT_SUITSTORE)
			return s_store
	return null

/mob/living/carbon/human/proc/get_all_slots()
	. = get_head_slots() | get_body_slots()

/mob/living/carbon/human/proc/get_body_slots()
	return list(
		back,
		s_store,
		handcuffed,
		legcuffed,
		wear_suit,
		gloves,
		shoes,
		belt,
		wear_id,
		l_store,
		r_store,
		w_uniform
		)

/mob/living/carbon/human/proc/get_head_slots()
	return list(
		head,
		wear_mask,
		wear_neck,
		glasses,
		ears,
		)

/mob/living/carbon/human/proc/get_storage_slots()
	return list(
		back,
		belt,
		l_store,
		r_store,
		s_store,
		)

//This is an UNSAFE proc. Use mob_can_equip() before calling this one! Or rather use equip_to_slot_if_possible() or advanced_equip_to_slot_if_possible()
/mob/living/carbon/human/equip_to_slot(obj/item/I, slot, initial = FALSE, redraw_mob = FALSE)
	if(!..()) //a check failed or the item has already found its slot
		return

	var/not_handled = FALSE //Added in case we make this type path deeper one day
	switch(slot)
		if(ITEM_SLOT_BELT)
			belt = I
			update_inv_belt()
		if(ITEM_SLOT_ID)
			wear_id = I
			sec_hud_set_ID()
			update_inv_wear_id()
		if(ITEM_SLOT_EARS)
			ears = I
			update_inv_ears()
		if(ITEM_SLOT_EYES)
			glasses = I
			var/obj/item/clothing/glasses/G = I
			if(G.glass_colour_type)
				update_glasses_color(G, 1)
			if(G.tint)
				update_tint()
			if(G.vision_correction)
				clear_fullscreen("nearsighted")
				clear_fullscreen("eye_damage")
			if(G.vision_flags || G.darkness_view || G.invis_override || G.invis_view || !isnull(G.lighting_alpha))
				update_sight()
			update_inv_glasses()
		if(ITEM_SLOT_GLOVES)
			gloves = I
			update_inv_gloves()
		if(ITEM_SLOT_FEET)
			shoes = I
			update_inv_shoes()
		if(ITEM_SLOT_OCLOTHING)
			wear_suit = I
			if(I.flags_inv & HIDEJUMPSUIT)
				update_inv_w_uniform()
			if(wear_suit.breakouttime) //when equipping a straightjacket
				ADD_TRAIT(src, TRAIT_RESTRAINED, SUIT_TRAIT)
				ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, SUIT_TRAIT)
				stop_pulling() //can't pull if restrained
				update_action_buttons_icon() //certain action buttons will no longer be usable.
			update_inv_wear_suit()
		if(ITEM_SLOT_ICLOTHING)
			w_uniform = I
			update_suit_sensors()
			update_inv_w_uniform()
		if(ITEM_SLOT_LPOCKET)
			l_store = I
			update_inv_pockets()
		if(ITEM_SLOT_RPOCKET)
			r_store = I
			update_inv_pockets()
		if(ITEM_SLOT_SUITSTORE)
			s_store = I
			update_inv_s_store()
		else
			to_chat(src, "<span class='danger'>You are trying to equip this item to an unsupported inventory slot. Report this to a coder!</span>")

	//Item is handled and in slot, valid to call callback, for this proc should always be true
	if(!not_handled)
		I.equipped(src, slot, initial)

		// Send a signal for when we equip an item that used to cover our feet/shoes. Used for bloody feet
		if((I.body_parts_covered & FEET) || (I.flags_inv | I.transparent_protection) & HIDESHOES)
			SEND_SIGNAL(src, COMSIG_CARBON_EQUIP_SHOECOVER, I, slot, initial, redraw_mob)

	return not_handled //For future deeper overrides

/mob/living/carbon/human/equipped_speed_mods()
	. = ..()
	for(var/sloties in get_all_slots() - list(l_store, r_store, s_store))
		var/obj/item/thing = sloties
		. += thing?.slowdown

/mob/living/carbon/human/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, was_thrown = FALSE, silent = FALSE, bypass_delay = TRUE)
	var/index = get_held_index_of_item(I)
	if(index && !QDELETED(src) && dna.species.mutanthands) //hand freed, fill with claws, skip if we're getting deleted.
		put_in_hand(new dna.species.mutanthands(), index)
	if(I == wear_suit)
		if (I.strip_delay_self && !bypass_delay)
			var/mob/living/carbon/human/H = src
			if(!(I in held_items))
				H.visible_message("<span class='notice'>[H] starts unequipping [I]...</span>", "<span class='notice'>You start unequipping [I]...</span>")
				if(!do_after(H, I.strip_delay_self, TRUE, H))
					if(s_store && invdrop)
						return FALSE
		dropItemToGround(s_store, TRUE) //It makes no sense for your suit storage to stay on you if you drop your suit.
		if(wear_suit.breakouttime) //when unequipping a straightjacket
			REMOVE_TRAIT(src, TRAIT_RESTRAINED, SUIT_TRAIT)
			REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, SUIT_TRAIT)
			drop_all_held_items() //suit is restraining
			update_action_buttons_icon() //certain action buttons may be usable again.
		wear_suit = null
		if(!QDELETED(src)) //no need to update we're getting deleted anyway
			if(I.flags_inv & HIDEJUMPSUIT)
				update_inv_w_uniform()
			update_inv_wear_suit()
	else if(I == w_uniform)
		if(invdrop)
			if(r_store)
				dropItemToGround(r_store, TRUE) //Again, makes sense for pockets to drop.
			if(l_store)
				dropItemToGround(l_store, TRUE)
			if(wear_id)
				dropItemToGround(wear_id)
			if(belt)
				dropItemToGround(belt)
		w_uniform = null
		update_suit_sensors()
		if(!QDELETED(src))
			update_inv_w_uniform()
	else if(I == gloves)
		gloves = null
		if(!QDELETED(src))
			update_inv_gloves()
	else if(I == glasses)
		glasses = null
		var/obj/item/clothing/glasses/G = I
		if(G.glass_colour_type)
			update_glasses_color(G, 0)
		if(G.tint)
			update_tint()
		if(G.vision_correction)
			if(HAS_TRAIT(src, TRAIT_NEARSIGHT))
				overlay_fullscreen("nearsighted", /atom/movable/screen/fullscreen/impaired, 1)
		if(G.vision_flags || G.darkness_view || G.invis_override || G.invis_view || !isnull(G.lighting_alpha))
			update_sight()
		if(!QDELETED(src))
			update_inv_glasses()
	else if(I == ears)
		ears = null
		if(!QDELETED(src))
			update_inv_ears()
	else if(I == shoes)
		shoes = null
		if(!QDELETED(src))
			update_inv_shoes()
	else if(I == belt)
		belt = null
		if(!QDELETED(src))
			update_inv_belt()
	else if(I == wear_id)
		wear_id = null
		sec_hud_set_ID()
		if(!QDELETED(src))
			update_inv_wear_id()
	else if(I == r_store)
		r_store = null
		if(!QDELETED(src))
			update_inv_pockets()
	else if(I == l_store)
		l_store = null
		if(!QDELETED(src))
			update_inv_pockets()
	else if(I == s_store)
		s_store = null
		if(!QDELETED(src))
			update_inv_s_store()
	. = ..(I, force, newloc, no_move, invdrop, was_thrown) //See mob.dm for an explanation on this and some rage about people copypasting instead of calling ..() like they should.
	if(!. || !I)
		return

	// Send a signal for when we unequip an item that used to cover our feet/shoes. Used for bloody feet
	if((I.body_parts_covered & FEET) || (I.flags_inv | I.transparent_protection) & HIDESHOES)
		SEND_SIGNAL(src, COMSIG_CARBON_UNEQUIP_SHOECOVER, I, force, newloc, no_move, invdrop, silent)

/mob/living/carbon/human/toggle_internals(obj/item/tank, is_external = FALSE)
	// Just close the tank if it's the one the mob already has open.
	var/obj/item/existing_tank = is_external ? external : internal
	if(tank == existing_tank)
		return toggle_close_internals(is_external)
	// Use breathing tube regardless of mask.
	if(can_breathe_tube())
		return toggle_open_internals(tank, is_external)
	// Use mask in absence of tube.
	if(isclothing(wear_mask) && ((wear_mask.visor_flags & MASKINTERNALS) || (wear_mask.clothing_flags & MASKINTERNALS)))
		// Adjust dishevelled breathing mask back onto face.
		if (wear_mask.mask_adjusted)
			wear_mask.adjustmask(src)
		return toggle_open_internals(tank, is_external)
	// Use helmet in absence of tube or valid mask.
	if(can_breathe_helmet())
		return toggle_open_internals(tank, is_external)
	// Notify user of missing valid breathing apparatus.
	if(wear_mask)
		// Invalid mask
		to_chat(src, "<span class='warning'>[wear_mask] can't use [tank]!</span>")
	else if(head)
		// Invalid headgear
		to_chat(src, "<span class='warning'>[head] isn't airtight! You need a mask!</span>")
	else
		// Not wearing any breathing apparatus.
		to_chat(src, "<span class='warning'>You need a mask!</span>")

/// Returns TRUE if the tank successfully toggles open/closed. Opens the tank only if a breathing apparatus is found.
/mob/living/carbon/human/toggle_externals(obj/item/tank)
	return toggle_internals(tank, TRUE)

/mob/living/carbon/human/wear_mask_update(obj/item/I, toggle_off = 1)
	if((I.flags_inv & (HIDEHAIR|HIDEFACIALHAIR)) || (initial(I.flags_inv) & (HIDEHAIR|HIDEFACIALHAIR)))
		update_hair()
	// Close internal air tank if mask was the only breathing apparatus.
	if(invalid_internals())
		update_internals_hud_icon(0)
		cutoff_internals()
	if(I.flags_inv & HIDEEYES)
		update_inv_glasses()
	sec_hud_set_security_status()
	..()

/mob/living/carbon/human/head_update(obj/item/I, forced)
	if((I.flags_inv & (HIDEHAIR|HIDEFACIALHAIR)) || forced)
		update_hair()
	else
		var/obj/item/clothing/C = I
		if(istype(C) && C.dynamic_hair_suffix)
			update_hair()
	// Close internal air tank if helmet was the only breathing apparatus.
	if(invalid_internals())
		cutoff_internals()
	if(I.flags_inv & HIDEEYES || forced)
		update_inv_glasses()
	if(I.flags_inv & HIDEEARS || forced)
		update_body()
	sec_hud_set_security_status()
	..()

/mob/living/carbon/human/proc/equipOutfit(outfit, visualsOnly = FALSE)
	var/datum/outfit/O = null

	if(ispath(outfit))
		O = new outfit
	else
		O = outfit
		if(!istype(O))
			return 0
	if(!O)
		return 0

	return O.equip(src, visualsOnly)

//delete all equipment without dropping anything
/mob/living/carbon/human/proc/delete_equipment()
	for(var/slot in get_all_slots())//order matters, dependant slots go first
		qdel(slot)
	for(var/obj/item/I in held_items)
		qdel(I)
