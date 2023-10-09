
/obj/item/bodypart/proc/can_dismember(obj/item/I)
	if(dismemberable)
		return TRUE

//Dismember a limb
/obj/item/bodypart/proc/dismember(dam_type = BRUTE)
	if(!owner)
		return FALSE
	var/mob/living/carbon/C = owner
	if(!dismemberable)
		return FALSE
	if(C.status_flags & GODMODE)
		return FALSE
	if(HAS_TRAIT(C, TRAIT_NODISMEMBER))
		return FALSE

	var/obj/item/bodypart/affecting = C.get_bodypart(BODY_ZONE_CHEST)
	affecting.receive_damage(CLAMP(brute_dam/2 * affecting.body_damage_coeff, 15, 50), CLAMP(burn_dam/2 * affecting.body_damage_coeff, 0, 50)) //Damage the chest based on limb's existing damage
	C.visible_message("<span class='danger'><B>[C]'s [src.name] has been violently dismembered!</B></span>")

	if(C.stat <= SOFT_CRIT)//No more screaming while unconsious
		if(IS_ORGANIC_LIMB(affecting))//Chest is a good indicator for if a carbon is robotic in nature or not.
			C.emote("scream")

	SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "dismembered", /datum/mood_event/dismembered)
	drop_limb()

	C.update_equipment_speed_mods() // Update in case speed affecting item unequipped by dismemberment
	var/turf/location = C.loc
	if(istype(location))
		C.add_splatter_floor(location)

	if(QDELETED(src)) //Could have dropped into lava/explosion/chasm/whatever
		return TRUE
	if(dam_type == BURN)
		burn()
		return TRUE
	add_mob_blood(C)
	var/direction = pick(GLOB.cardinals)
	var/t_range = rand(2,max(throw_range/2, 2))
	var/turf/target_turf = get_turf(src)
	for(var/i in 1 to t_range-1)
		var/turf/new_turf = get_step(target_turf, direction)
		if(!new_turf)
			break
		target_turf = new_turf
		if(new_turf.density)
			break
	throw_at(target_turf, throw_range, throw_speed)
	return TRUE


/obj/item/bodypart/chest/dismember()
	if(!owner)
		return FALSE
	var/mob/living/carbon/chest_owner = owner
	if(!dismemberable)
		return FALSE
	if(HAS_TRAIT(chest_owner, TRAIT_NODISMEMBER))
		return FALSE
	. = list()
	var/organ_spilled = 0
	if(isturf(chest_owner.loc))
		chest_owner.add_splatter_floor(chest_owner.loc)
	playsound(get_turf(chest_owner), 'sound/misc/splort.ogg', 80, TRUE)
	for(var/obj/item/organ/organ as anything in chest_owner.internal_organs)
		var/org_zone = check_zone(organ.zone)
		if(org_zone != BODY_ZONE_CHEST)
			continue
		organ.Remove(chest_owner)
		organ.forceMove(chest_owner.loc)
		. += organ
	if(cavity_item)
		cavity_item.forceMove(chest_owner.loc)
		. += cavity_item
		cavity_item = null
		organ_spilled = 1

	if(organ_spilled)
		chest_owner.visible_message("<span class='danger'><B>[chest_owner]'s internal organs spill out onto the floor!</B></span>")



//limb removal. The "special" argument is used for swapping a limb with a new one without the effects of losing a limb kicking in.
/obj/item/bodypart/proc/drop_limb(special, dismembered)
	if(!owner)
		return
	var/atom/drop_loc = owner.drop_location()
	var/mob/living/carbon/phantom_owner

	SEND_SIGNAL(owner, COMSIG_CARBON_REMOVE_LIMB, src, dismembered)
	SEND_SIGNAL(src, COMSIG_BODYPART_REMOVED, owner, dismembered)
	update_limb(TRUE)
	phantom_owner.bodyparts -= src

	if(held_index)
		if(phantom_owner.hand_bodyparts[held_index] == src)
			// We only want to do this if the limb being removed is the active hand part.
			// This catches situations where limbs are "hot-swapped" such as augmentations and roundstart prosthetics.
			phantom_owner.dropItemToGround(owner.get_item_for_held_index(held_index), 1)
			phantom_owner.hand_bodyparts[held_index] = null

	/*
	for(var/datum/wound/wound as anything in wounds)
		wound.remove_wound(TRUE)

	for(var/datum/scar/scar as anything in scars)
		scar.victim = null
		LAZYREMOVE(owner.all_scars, scar)
	*/

	for(var/datum/surgery/surgery as anything in phantom_owner.surgeries) //if we had an ongoing surgery on that limb, we stop it.
		if(surgery.operated_bodypart == src)
			phantom_owner.surgeries -= surgery
			qdel(surgery)
			break

	for(var/obj/item/embedded in embedded_objects)
		embedded_objects -= embedded
		embedded.forceMove(src)
	if(!phantom_owner.has_embedded_objects())
		phantom_owner.clear_alert("embeddedobject")
		SEND_SIGNAL(phantom_owner, COMSIG_CLEAR_MOOD_EVENT, "embedded")

	if(!special)
		if(phantom_owner.dna)
			for(var/datum/mutation/mutation as anything in phantom_owner.dna.mutations) //some mutations require having specific limbs to be kept.
				if(mutation.limb_req && mutation.limb_req == body_zone)
					phantom_owner.dna.force_lose(mutation)

		for(var/obj/item/organ/organ as anything in phantom_owner.internal_organs) //internal organs inside the dismembered limb are dropped.
			var/org_zone = check_zone(organ.zone)
			if(org_zone != body_zone)
				continue
			organ.transfer_to_limb(src, phantom_owner)


	update_icon_dropped()
	synchronize_bodytypes(phantom_owner)
	phantom_owner.update_health_hud() //update the healthdoll
	phantom_owner.update_body()
	phantom_owner.update_hair()
	phantom_owner.update_mobility()

	if(!drop_loc) // drop_loc = null happens when a "dummy human" used for rendering icons on prefs screen gets its limbs replaced.
		qdel(src)
		return

	if(is_pseudopart)
		drop_organs(phantom_owner) //Psuedoparts shouldn't have organs, but just in case
		qdel(src)
		return

	forceMove(drop_loc)
	SEND_SIGNAL(phantom_owner, COMSIG_CARBON_POST_REMOVE_LIMB, src, dismembered)


//when a limb is dropped, the internal organs are removed from the mob and put into the limb
/obj/item/organ/proc/transfer_to_limb(obj/item/bodypart/LB, mob/living/carbon/C)
	Remove(C, TRUE)
	forceMove(LB)

/obj/item/organ/brain/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	Remove(C)	//Changeling brain concerns are now handled in Remove
	forceMove(LB)
	LB.brain = src
	if(brainmob)
		LB.brainmob = brainmob
		brainmob = null
		LB.brainmob.forceMove(LB)
		LB.brainmob.set_stat(DEAD)

/obj/item/organ/eyes/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	LB.eyes = src
	..()

/obj/item/organ/ears/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	LB.ears = src
	..()

/obj/item/organ/tongue/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	LB.tongue = src
	..()

/obj/item/bodypart/chest/drop_limb(special)
	if(special)
		..()

/obj/item/bodypart/r_arm/drop_limb(special)
	var/mob/living/carbon/C = owner
	..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(drop_location())
			C.handcuffed.dropped(C)
			C.handcuffed = null
			C.update_handcuffed()
		if(C.hud_used)
			var/atom/movable/screen/inventory/hand/R = C.hud_used.hand_slots["[held_index]"]
			if(R)
				R.update_icon()
		if(C.gloves)
			C.dropItemToGround(C.gloves, TRUE)
		C.update_inv_gloves() //to remove the bloody hands overlay


/obj/item/bodypart/l_arm/drop_limb(special)
	var/mob/living/carbon/C = owner
	..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(drop_location())
			C.handcuffed.dropped(C)
			C.handcuffed = null
			C.update_handcuffed()
		if(C.hud_used)
			var/atom/movable/screen/inventory/hand/L = C.hud_used.hand_slots["[held_index]"]
			if(L)
				L.update_icon()
		if(C.gloves)
			C.dropItemToGround(C.gloves, TRUE)
		C.update_inv_gloves() //to remove the bloody hands overlay


/obj/item/bodypart/r_leg/drop_limb(special)
	if(owner && !special)
		if(owner.legcuffed)
			owner.legcuffed.forceMove(owner.drop_location()) //At this point bodypart is still in nullspace
			owner.legcuffed.dropped(owner)
			owner.legcuffed = null
			owner.update_inv_legcuffed()
		if(owner.shoes)
			owner.dropItemToGround(owner.shoes, TRUE)
	..()

/obj/item/bodypart/l_leg/drop_limb(special) //copypasta
	if(owner && !special)
		if(owner.legcuffed)
			owner.legcuffed.forceMove(owner.drop_location())
			owner.legcuffed.dropped(owner)
			owner.legcuffed = null
			owner.update_inv_legcuffed()
		if(owner.shoes)
			owner.dropItemToGround(owner.shoes, TRUE)
	..()

/obj/item/bodypart/head/drop_limb(special)
	if(!special)
		//Drop all worn head items
		for(var/obj/item/head_item as anything in list(owner.glasses, owner.ears, owner.wear_mask, owner.head))
			owner.dropItemToGround(head_item, force = TRUE)

	//Remove the creampie overlay :flushed:
	qdel(owner.GetComponent(/datum/component/creamed))

	//Handle dental implants
	for(var/datum/action/item_action/hands_free/activate_pill/pill_action in owner.actions)
		pill_action.Remove(owner)
		var/obj/pill = pill_action.target
		if(pill)
			pill.forceMove(src)

	name = owner ? "[owner.real_name]'s head" : "unknown [limb_id] head"
	..()

//Attach a limb to a human and drop any existing limb of that type.
/obj/item/bodypart/proc/replace_limb(mob/living/carbon/C, special, is_creating = FALSE)
	if(!istype(C))
		return
	var/obj/item/bodypart/O = C.get_bodypart(body_zone) //needs to happen before attach because multiple limbs in same zone breaks helpers
	if(!attach_limb(C, special))//we can attach this limb and drop the old after because of our robust bodyparts system. you know, just for a sec.
		return
	if(O)
		O.drop_limb(1)

/obj/item/bodypart/head/replace_limb(mob/living/carbon/C, special, is_creating = FALSE)
	if(!istype(C))
		return
	var/obj/item/bodypart/head/O = C.get_bodypart(body_zone)
	if(!attach_limb(C, special))
		return
	if(O)
		O.drop_limb(1)

/obj/item/bodypart/proc/attach_limb(mob/living/carbon/new_limb_owner, special, is_creating = FALSE)
	if(SEND_SIGNAL(new_limb_owner,  COMSIG_CARBON_ATTACH_LIMB, src, special) & COMPONENT_NO_ATTACH)
		return FALSE

	. = TRUE
	SEND_SIGNAL(src, COMSIG_BODYPART_ATTACHED, new_limb_owner, special)

	/*
	var/obj/item/bodypart/chest/mob_chest = new_limb_owner.get_bodypart(BODY_ZONE_CHEST)
	if(mob_chest && !(mob_chest.acceptable_bodytype & bodytype) && !special)
		return FALSE
	*/

	moveToNullspace()
	owner = new_limb_owner
	new_limb_owner.bodyparts += src
	if(held_index)
		if(held_index > new_limb_owner.hand_bodyparts.len)
			new_limb_owner.hand_bodyparts.len = held_index
		new_limb_owner.hand_bodyparts[held_index] = src
		if(new_limb_owner.dna.species.mutanthands && !is_pseudopart)
			new_limb_owner.put_in_hand(new new_limb_owner.dna.species.mutanthands(), held_index)
		if(new_limb_owner.hud_used)
			var/atom/movable/screen/inventory/hand/hand = new_limb_owner.hud_used.hand_slots["[held_index]"]
			if(hand)
				hand.update_appearance()
		new_limb_owner.update_inv_gloves()

	if(special) //non conventional limb attachment
		for(var/datum/surgery/attach_surgery as anything in new_limb_owner.surgeries) //if we had an ongoing surgery to attach a new limb, we stop it.
			var/surgery_zone = check_zone(attach_surgery.location)
			if(surgery_zone == body_zone)
				new_limb_owner.surgeries -= attach_surgery
				qdel(attach_surgery)
				break

	for(var/obj/item/organ/limb_organ in contents)
		limb_organ.Insert(new_limb_owner)

	/* WOUNDS
	for(var/datum/wound/wound as anything in wounds)
		// we have to remove the wound from the limb wound list first, so that we can reapply it fresh with the new person
		// otherwise the wound thinks it's trying to replace an existing wound of the same type (itself) and fails/deletes itself
		LAZYREMOVE(wounds, wound)
		wound.apply_wound(src, TRUE)

	for(var/datum/scar/scar as anything in scars)
		if(scar in new_limb_owner.all_scars) // prevent double scars from happening for whatever reason
			continue
		scar.victim = new_limb_owner
		LAZYADD(new_limb_owner.all_scars, scar)
	*/

	synchronize_bodytypes(new_limb_owner)
	if(is_creating)
		update_limb(is_creating = TRUE)
	update_bodypart_damage_state()
	/*
	if(can_be_disabled)
		update_disabled()
	*/

	new_limb_owner.updatehealth()
	new_limb_owner.update_body()
	new_limb_owner.update_hair()
	new_limb_owner.update_mobility()
	SEND_SIGNAL(new_limb_owner, COMSIG_CARBON_POST_ATTACH_LIMB, src, special)


/obj/item/bodypart/head/attach_limb(mob/living/carbon/new_head_owner, special = FALSE, abort = FALSE, is_creating = FALSE)
	. = ..()
	if(!.)
		return .
	//Transfer some head appearance vars over
	if(brain)
		if(brainmob)
			brainmob.container = null //Reset brainmob head var.
			brainmob.forceMove(brain) //Throw mob into brain.
			brain.brainmob = brainmob //Set the brain to use the brainmob
			brainmob = null //Set head brainmob var to null
		brain.Insert(new_head_owner) //Now insert the brain proper
		brain = null //No more brain in the head

	if(tongue)
		tongue = null
	if(ears)
		ears = null
	if(eyes)
		eyes = null

	if(ishuman(new_head_owner) && !is_creating) // don't overwrite if the mob being created
		var/mob/living/carbon/human/H = new_head_owner
		H.hair_color = hair_color
		H.hair_style = hair_style
		H.facial_hair_color = facial_hair_color
		H.facial_hair_style = facial_hair_style
		H.lip_style = lip_style
		H.lip_color = lip_color
	if(real_name)
		new_head_owner.real_name = real_name
	real_name = ""
	name = initial(name)

	//Handle dental implants
	for(var/obj/item/reagent_containers/pill/pill in src)
		for(var/datum/action/item_action/hands_free/activate_pill/pill_action in pill.actions)
			pill.forceMove(new_head_owner)
			pill_action.Grant(new_head_owner)
			break

	new_head_owner.updatehealth()
	new_head_owner.update_body()
	new_head_owner.update_hair()
	new_head_owner.update_damage_overlays()
	new_head_owner.update_mobility()

/obj/item/bodypart/proc/synchronize_bodytypes(mob/living/carbon/carbon_owner)
	if(!carbon_owner.dna.species)
		return
	//This codeblock makes sure that the owner's bodytype flags match the flags of all of it's parts.
	var/all_limb_flags
	for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
		/*
		for(var/obj/item/organ/external/ext_organ as anything in limb.external_organs)
			all_limb_flags = all_limb_flags | ext_organ.external_bodytypes
		*/
		all_limb_flags =  all_limb_flags | limb.bodytype

	carbon_owner.dna.species.bodytype = all_limb_flags

//Regenerates all limbs. Returns amount of limbs regenerated
/mob/living/proc/regenerate_limbs(list/excluded_zones = list())
	SEND_SIGNAL(src, COMSIG_LIVING_REGENERATE_LIMBS, excluded_zones)

/mob/living/carbon/regenerate_limbs(list/excluded_zones = list())
	SEND_SIGNAL(src, COMSIG_LIVING_REGENERATE_LIMBS, excluded_zones)
	var/list/zone_list = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	if(length(excluded_zones))
		zone_list -= excluded_zones
	for(var/limb_zone in zone_list)
		regenerate_limb(limb_zone)

/mob/living/proc/regenerate_limb(limb_zone)
	return

/mob/living/carbon/regenerate_limb(limb_zone)
	var/obj/item/bodypart/limb
	if(get_bodypart(limb_zone))
		return FALSE
	limb = newBodyPart(limb_zone, 0, 0)
	if(limb)
		if(!limb.attach_limb(src, 1))
			qdel(limb)
			return FALSE
		limb.replace_limb(src, TRUE, TRUE)
	return TRUE
