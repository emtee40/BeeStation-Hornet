/datum/species/leanman
	name = "\improper Leanman"
	id = SPECIES_PLASMAMAN
	bodyflag = FLAG_PLASMAMAN
	say_mod = "rattles"
	sexes = 0
	meat = /obj/item/stack/sheet/mineral/lean
	species_traits = list(NOBLOOD,NOTRANSSTING)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RADIMMUNE,TRAIT_NOHUNGER,TRAIT_ALWAYS_CLEAN)
	inherent_biotypes = list(MOB_INORGANIC, MOB_HUMANOID)
	mutantlungs = /obj/item/organ/lungs/leanman
	mutanttongue = /obj/item/organ/tongue/bone/leanman
	mutantliver = /obj/item/organ/liver/leanman
	mutantstomach = /obj/item/organ/stomach/leanman
	burnmod = 1.5
	heatmod = 1.5
	brutemod = 1.5
	breathid = "tox"
	damage_overlay_type = ""//let's not show bloody wounds or burns over bones.
	var/internal_fire = FALSE //If the bones themselves are burning clothes won't help you much
	disliked_food = FRUIT
	liked_food = VEGETABLES
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	outfit_important_for_life = /datum/outfit/leanman
	species_language_holder = /datum/language_holder/skeleton

	species_chest = /obj/item/bodypart/chest/leanman
	species_head = /obj/item/bodypart/head/leanman
	species_l_arm = /obj/item/bodypart/l_arm/leanman
	species_r_arm = /obj/item/bodypart/r_arm/leanman
	species_l_leg = /obj/item/bodypart/l_leg/leanman
	species_r_leg = /obj/item/bodypart/r_leg/leanman

/datum/species/leanman/spec_life(mob/living/carbon/human/H)
	var/atmos_sealed = FALSE
	if (H.wear_suit && H.head && isclothing(H.wear_suit) && isclothing(H.head))
		var/obj/item/clothing/CS = H.wear_suit
		var/obj/item/clothing/CH = H.head
		if (CS.clothing_flags & CH.clothing_flags & STOPSPRESSUREDAMAGE)
			atmos_sealed = TRUE
	if(H.w_uniform && H.head)
		var/obj/item/clothing/CU = H.w_uniform
		var/obj/item/clothing/CH = H.head
		if (CU.envirosealed && (CH.clothing_flags & STOPSPRESSUREDAMAGE))
			atmos_sealed = TRUE
	if(!atmos_sealed && (!istype(H.w_uniform, /obj/item/clothing/under/leanman) || !istype(H.head, /obj/item/clothing/head/helmet/space/leanman) || !istype(H.gloves, /obj/item/clothing/gloves)))
		var/datum/gas_mixture/environment = H.loc.return_air()
		if(environment)
			if(environment.total_moles())
				if(environment.get_moles(GAS_O2) >= 1) //Same threshhold that extinguishes fire
					H.adjust_fire_stacks(0.5)
					if(!H.on_fire && H.fire_stacks > 0)
						H.visible_message("<span class='danger'>[H]'s body reacts with the atmosphere and bursts into flames!</span>","<span class='userdanger'>Your body reacts with the atmosphere and bursts into flame!</span>")
					H.IgniteMob()
					internal_fire = TRUE
	else if(H.fire_stacks)
		var/obj/item/clothing/under/leanman/P = H.w_uniform
		if(istype(P))
			P.Extinguish(H)
			internal_fire = FALSE
	else
		internal_fire = FALSE
	H.update_fire()

/datum/species/leanman/handle_fire(mob/living/carbon/human/H, no_protection)
	if(internal_fire)
		no_protection = TRUE
	. = ..()

/datum/species/leanman/after_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source = null)
	H.internal = H.get_item_for_held_index(2)
	H.update_internals_hud_icon(1)

	if(!preference_source)
		return
	var/path = J.species_outfits[SPECIES_PLASMAMAN]
	var/datum/outfit/leanman/O = new path
	var/datum/preferences/prefs = preference_source.prefs
	if(prefs.helmet_style != HELMET_DEFAULT)
		if(O.helmet_variants[prefs.helmet_style])
			var/helmet = O.helmet_variants[prefs.helmet_style]
			qdel(H.head)
			H.equip_to_slot(new helmet, ITEM_SLOT_HEAD)

/datum/species/leanman/qualifies_for_rank(rank, list/features)
	if(rank in GLOB.security_positions)
		return 0
	if(rank == "Clown" || rank == "Mime")//No funny bussiness
		return 0
	return ..()

/datum/species/leanman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_leanman_name()

	var/randname = leanman_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/leanman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/consumable/milk)
		if(chem.volume > 10)
			H.reagents.remove_reagent(chem.type, chem.volume - 10)
			to_chat(H, "<span class='warning'>The excess milk is dripping off your bones!</span>")
		H.heal_bodypart_damage(1.5,0, 0)
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate)
		return TRUE
	if(chem.type == /datum/reagent/toxin/bonehurtingjuice)
		H.adjustStaminaLoss(7.5, 0)
		H.adjustBruteLoss(0.5, 0)
		if(prob(20))
			switch(rand(1, 3))
				if(1)
					H.say(pick("oof.", "ouch.", "my bones.", "oof ouch.", "oof ouch my bones."), forced = /datum/reagent/toxin/bonehurtingjuice)
				if(2)
					H.emote("me", 1, pick("oofs silently.", "looks like their bones hurt.", "grimaces, as though their bones hurt."))
				if(3)
					to_chat(H, "<span class='warning'>Your bones hurt!</span>")
		if(chem.overdosed)
			if(prob(4) && iscarbon(H)) //big oof
				var/selected_part = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) //God help you if the same limb gets picked twice quickly.
				var/obj/item/bodypart/bp = H.get_bodypart(selected_part) //We're so sorry skeletons, you're so misunderstood
				if(bp)
					playsound(H, get_sfx("desecration"), 50, TRUE, -1) //You just want to socialize
					H.visible_message("<span class='warning'>[H] rattles loudly and flails around!!</span>", "<span class='danger'>Your bones hurt so much that your missing muscles spasm!!</span>")
					H.say("OOF!!", forced=/datum/reagent/toxin/bonehurtingjuice)
					bp.receive_damage(200, 0, 0) //But I don't think we should
				else
					to_chat(H, "<span class='warning'>Your missing arm aches from wherever you left it.</span>")
					H.emote("sigh")
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate)
		return TRUE
	return ..()
