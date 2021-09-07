/obj/item/lipstick
	gender = PLURAL
	name = "red lipstick"
	desc = "A generic brand of lipstick."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "lipstick"
	w_class = WEIGHT_CLASS_TINY
	var/colour = "red"
	var/open = FALSE

/obj/item/lipstick/purple
	name = "purple lipstick"
	colour = "purple"

/obj/item/lipstick/jade
	//It's still called Jade, but theres no HTML color for jade, so we use lime.
	name = "jade lipstick"
	colour = "lime"

/obj/item/lipstick/black
	name = "black lipstick"
	colour = "black"

/obj/item/lipstick/random
	name = "lipstick"
	icon_state = "random_lipstick"

/obj/item/lipstick/random/Initialize()
	. = ..()
	icon_state = "lipstick"
	colour = pick("red","purple","lime","black","green","blue","white")
	name = "[colour] lipstick"

/obj/item/lipstick/attack_self(mob/user)
	cut_overlays()
	to_chat(user, "<span class='notice'>You twist \the [src] [open ? "closed" : "open"].</span>")
	open = !open
	if(open)
		var/mutable_appearance/colored_overlay = mutable_appearance(icon, "lipstick_uncap_color")
		colored_overlay.color = colour
		icon_state = "lipstick_uncap"
		add_overlay(colored_overlay)
	else
		icon_state = "lipstick"

/obj/item/lipstick/attack(mob/M, mob/user)
	if(!open)
		return

	if(!ismob(M))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.is_mouth_covered())
			to_chat(user, "<span class='warning'>Remove [ H == user ? "your" : "[H.p_their()]" ] mask!</span>")
			return
		if(H.lip_style)	//if they already have lipstick on
			to_chat(user, "<span class='warning'>You need to wipe off the old lipstick first!</span>")
			return
		if(H == user)
			user.visible_message("<span class='notice'>[user] does [user.p_their()] lips with \the [src].</span>", \
								 "<span class='notice'>You take a moment to apply \the [src]. Perfect!</span>")
			H.lip_style = "lipstick"
			H.lip_color = colour
			H.update_body()
		else
			user.visible_message("<span class='warning'>[user] begins to do [H]'s lips with \the [src].</span>", \
								 "<span class='notice'>You begin to apply \the [src] on [H]'s lips...</span>")
			if(do_after(user, 20, target = H))
				user.visible_message("[user] does [H]'s lips with \the [src].", \
									 "<span class='notice'>You apply \the [src] on [H]'s lips.</span>")
				H.lip_style = "lipstick"
				H.lip_color = colour
				H.update_body()
	else
		to_chat(user, "<span class='warning'>Where are the lips on that?</span>")

//you can wipe off lipstick with paper!
/obj/item/paper/attack(mob/M, mob/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(!ismob(M))
			return

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H == user)
				to_chat(user, "<span class='notice'>You wipe off the lipstick with [src].</span>")
				H.lip_style = null
				H.update_body()
			else
				user.visible_message("<span class='warning'>[user] begins to wipe [H]'s lipstick off with \the [src].</span>", \
								 	 "<span class='notice'>You begin to wipe off [H]'s lipstick...</span>")
				if(do_after(user, 10, target = H))
					user.visible_message("[user] wipes [H]'s lipstick off with \the [src].", \
										 "<span class='notice'>You wipe off [H]'s lipstick.</span>")
					H.lip_style = null
					H.update_body()
	else
		..()

/obj/item/razor
	name = "electric razor"
	desc = "The latest and greatest power razor born from the science of shaving."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "razor"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	var/extended = 1

/obj/item/razor/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins shaving [user.p_them()]self without the razor guard! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	shave(user, BODY_ZONE_PRECISE_MOUTH)
	shave(user, BODY_ZONE_HEAD)//doesnt need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/razor/proc/shave(mob/living/carbon/human/H, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		H.facial_hair_style = "Shaved"
	else
		H.hair_style = "Skinhead"

	H.update_hair()
	playsound(loc, 'sound/items/welder2.ogg', 20, 1)


/obj/item/razor/attack(mob/M, mob/user)
	if(ishuman(M) && extended == 1 && user.a_intent != INTENT_HARM)
		var/mob/living/carbon/human/H = M
		var/location = user.zone_selected
		var/mirror = FALSE
		if(HAS_TRAIT(H, TRAIT_SELF_AWARE) || locate(/obj/structure/mirror) in range(1, H))
			mirror = TRUE
		if((location in list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !H.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, "<span class='warning'>[H] doesn't have a head!</span>")
			return
		if(location == BODY_ZONE_PRECISE_MOUTH)
			if(user.a_intent == INTENT_HELP)
				if(H.gender == MALE)
					INVOKE_ASYNC(src, .proc/new_facial_hairstyle, H, user, mirror)
					return
				else
					return
			else
				if(!(FACEHAIR in H.dna.species.species_traits))
					to_chat(user, "<span class='warning'>There is no facial hair to shave!</span>")
					return
				if(!get_location_accessible(H, location))
					to_chat(user, "<span class='warning'>The mask is in the way!</span>")
					return
				if(H.facial_hair_style == "Shaved")
					to_chat(user, "<span class='warning'>Already clean-shaven!</span>")
					return

				if(H == user) //shaving yourself
					user.visible_message("[user] starts to shave [user.p_their()] facial hair with [src].", \
										 "<span class='notice'>You take a moment to shave your facial hair with [src]...</span>")
					if(do_after(user, 50, target = H))
						user.visible_message("[user] shaves [user.p_their()] facial hair clean with [src].", \
											 "<span class='notice'>You finish shaving with [src]. Fast and clean!</span>")
						shave(H, location)
				else
					user.visible_message("<span class='warning'>[user] tries to shave [H]'s facial hair with [src].</span>", \
										 "<span class='notice'>You start shaving [H]'s facial hair...</span>")
					if(do_after(user, 50, target = H))
						user.visible_message("<span class='warning'>[user] shaves off [H]'s facial hair with [src].</span>", \
											 "<span class='notice'>You shave [H]'s facial hair clean off.</span>")
						shave(H, location)

		else if(location == BODY_ZONE_HEAD)
			if(user.a_intent == INTENT_HELP)
				INVOKE_ASYNC(src, .proc/new_hairstyle, H, user, mirror)
				return
			else
				if(!(HAIR in H.dna.species.species_traits))
					to_chat(user, "<span class='warning'>There is no hair to shave!</span>")
					return
				if(!get_location_accessible(H, location))
					to_chat(user, "<span class='warning'>The headgear is in the way!</span>")
					return
				if(H.hair_style == "Bald" || H.hair_style == "Balding Hair" || H.hair_style == "Skinhead")
					to_chat(user, "<span class='warning'>There is not enough hair left to shave!</span>")
					return

				if(H == user) //shaving yourself
					user.visible_message("[user] starts to shave [user.p_their()] head with [src].", \
										 "<span class='notice'>You start to shave your head with [src]...</span>")
					if(do_after(user, 5, target = H))
						user.visible_message("[user] shaves [user.p_their()] head with [src].", \
											 "<span class='notice'>You finish shaving with [src].</span>")
						shave(H, location)
				else
					var/turf/H_loc = H.loc
					user.visible_message("<span class='warning'>[user] tries to shave [H]'s head with [src]!</span>", \
										 "<span class='notice'>You start shaving [H]'s head...</span>")
					if(do_after(user, 50, target = H))
						if(H_loc == H.loc)
							user.visible_message("<span class='warning'>[user] shaves [H]'s head bald with [src]!</span>", \
												 "<span class='notice'>You shave [H]'s head bald.</span>")
							shave(H, location)
		else
			..()
	else
		..()

/obj/item/razor/proc/new_hairstyle(mob/living/carbon/human/H, mob/user, mirror)
	var/location = user.zone_selected
	if (H == user && !mirror)
		to_chat(user, "<span class='warning'>You need a mirror to properly style your own hair!</span>")
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/new_style = input(user, "Select a hair style", "Grooming")  as null|anything in GLOB.hair_styles_list
	if(!get_location_accessible(H, location))
		to_chat(user, "<span class='warning'>The headgear is in the way!</span>")
		return
	user.visible_message("<span class='notice'>[user] tries to change [H]'s hairstyle using [src].</span>", "<span class='notice'>You try to change [H]'s hairstyle using [src].</span>")
	if(new_style && do_after(user, 60, target = H))
		user.visible_message("<span class='notice'>[user] successfully changes [H]'s hairstyle using [src].</span>", "<span class='notice'>You successfully change [H]'s hairstyle using [src].</span>")
		H.hair_style = new_style
		H.update_hair()

/obj/item/razor/proc/new_facial_hairstyle(mob/living/carbon/human/H, mob/user, var/mirror)
	var/location = user.zone_selected
	if(H == user && !mirror)
		to_chat(user, "<span class='warning'>You need a mirror to properly style your own facial hair!</span>")
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/new_style = input(user, "Select a facial hair style", "Grooming")  as null|anything in GLOB.facial_hair_styles_list
	if(!get_location_accessible(H, location))
		to_chat(user, "<span class='warning'>The mask is in the way!</span>")
		return
	user.visible_message("<span class='notice'>[user] tries to change [H]'s facial hair style using [src].</span>", "<span class='notice'>You try to change [H]'s facial hair style using [src].</span>")
	if(new_style && do_after(user, 60, target = H))
		user.visible_message("<span class='notice'>[user] successfully changes [H]'s facial hair style using [src].</span>", "<span class='notice'>You successfully change [H]'s facial hair style using [src].</span>")
		H.facial_hair_style = new_style
		H.update_hair()

/obj/item/razor/straightrazor
	name = "straight razor"
	icon_state = "straightrazor"
	desc = "An incredibly sharp razor used to shave chins, make surgical incisions, and slit the throats of unpaying customers"
	flags_1 = CONDUCT_1
	force = 3
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 6
	hitsound = 'sound/weapons/genhit.ogg'
	attack_verb = list("stubbed", "poked")
	extended = 0
	var/extended_force = 10
	var/extended_throwforce = 7
	var/extended_icon_state = "straightrazor_open"

/obj/item/razor/straightrazor/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is slitting [user.p_their()] own throat with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/razor/attack(mob/M, mob/user)
	. = ..()
	if(ishuman(M) && extended == 1 && (user.a_intent == INTENT_HARM))
		var/mob/living/carbon/human/H = M
		var/def_check = H.getarmor("melee")
		H.bleed_rate += ((force * 10) - def_check)/30 //sharp blade causes a shitload of blood loss if on harm intent
		if(H.bleed_rate >= 10)
			to_chat(M, "<span class='userdanger'>You're losing blood fast!</span>")

/obj/item/razor/straightrazor/attack_self(mob/user)
	extended = !extended
	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	if(extended)
		force = extended_force
		w_class = WEIGHT_CLASS_SMALL //if it becomes normal you can decapitate a guy with a straight razor
		throwforce = extended_throwforce
		icon_state = extended_icon_state
		attack_verb = list("slashed", "stabbed", "sliced", "slit", "shaved", "diced", "cut")
		hitsound = 'sound/weapons/bladeslice.ogg'
		sharpness = IS_SHARP
		tool_behaviour = TOOL_SCALPEL
	else
		force = initial(force)
		w_class = WEIGHT_CLASS_TINY
		throwforce = initial(throwforce)
		icon_state = initial(icon_state)
		attack_verb = list("stubbed", "poked")
		hitsound = 'sound/weapons/genhit.ogg'
		sharpness = IS_BLUNT
		tool_behaviour = null

/obj/item/handmirror
	name = "hand mirror"
	desc = "A cheap plastic hand mirror. Useful for shaving and self-diagnoses"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "handmirror"
	w_class = WEIGHT_CLASS_SMALL
	force = 2
	throwforce = 2
	throw_speed = 3
	throw_range = 6

/obj/item/handmirror/attack_self(mob/user)
	ADD_TRAIT(user, TRAIT_SELF_AWARE, "mirror_trait")
	to_chat(user, "<span class='notice'>You look into the mirror</span>")
	sleep(150)
	REMOVE_TRAIT(user, TRAIT_SELF_AWARE, "mirror_trait")

/obj/item/hair_painter
	name = "hair painter"
	desc = "A modified airlock painter. Used for changing one's hair colour and occasionally violating safety regulations."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "hair sprayer"
	item_state = "hair sprayer"
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	materials = list(/datum/material/iron=50, /datum/material/glass=50)
	var/max_dye = 20
	var/dye_usage = 1
	var/dye_color = "#ffffff"

/obj/item/hair_painter/Initialize()
	. = ..()
	create_reagents(max_dye, REFILLABLE | DRAWABLE) // Easy to pour into, harder to get the reagents out

/obj/item/hair_painter/proc/get_dye()
	return reagents.get_reagent_amount(/datum/reagent/hair_dye)

/obj/item/hair_painter/proc/use_dye()
	reagents.remove_reagent(/datum/reagent/hair_dye,dye_usage)

/obj/item/hair_painter/proc/can_use()
	if(get_dye() >= dye_usage)
		return TRUE
	return FALSE

/obj/item/hair_painter/examine(mob/user)
	. = ..()
	. += "[src]'s dye storage capacity is [max_dye] unit\s."
	. += "The gauge reads [reagents.total_volume] unit\s of dye."
	if (get_dye() != reagents.total_volume)
		. += "The dye contamination light is lit!"

/obj/item/hair_painter/attack_self(mob/user)
	dye_color = input(usr,"Choose The Dye Color","Dye Color",dye_color) as color|null

/obj/item/hair_painter/attack(mob/M, mob/user)
	if(M && ishuman(M) && user.a_intent != INTENT_HARM)
		if(!can_use())
			to_chat(user, "<span class='warning'>[src]'s dye tank has no quantum hair dye in it!</span>")
			return
		var/mob/living/carbon/human/H = M
		var/location = user.zone_selected
		var/mirror = FALSE
		if(HAS_TRAIT(H, TRAIT_SELF_AWARE) || locate(/obj/structure/mirror) in range(1, H))
			mirror = TRUE
		if((location in list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !H.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, "<span class='warning'>[H] doesn't have a head!</span>")
			return
		if((location == BODY_ZONE_PRECISE_MOUTH) || (location == BODY_ZONE_HEAD))
			// Checks for species without hair or 'hair' like oozelings, slimes, ethereals and others which can't have its colour changed
			switch(location)
				if(BODY_ZONE_PRECISE_MOUTH)
					if(!(FACEHAIR in H.dna.species.species_traits) || (MUTCOLORS in H.dna.species.species_traits) || (DYNCOLORS in H.dna.species.species_traits) || H.facial_hair_style == "Shaved")
						to_chat(user, "<span class='warning'>There is no facial hair to paint!</span>")
						return
				if(BODY_ZONE_HEAD)
					if(!(HAIR in H.dna.species.species_traits) || (MUTCOLORS in H.dna.species.species_traits) || (DYNCOLORS in H.dna.species.species_traits) || H.hair_style == "Bald")
						to_chat(user, "<span class='warning'>There is no hair to paint!</span>")
						return
			if(!get_location_accessible(H, location))
				to_chat(user, "<span class='warning'>The [location == BODY_ZONE_PRECISE_MOUTH ? "mask" : "headgear"] is in the way!</span>")
				return
			// Is there enough paint to start
			if(!can_use())
				to_chat(user, "<span class='warning'>[src]'s dye tank has no quantum hair dye in it!</span>")
				return
			INVOKE_ASYNC(src, .proc/recolor_hair, H, user, mirror, user.zone_selected)
			return
	else
		..()

/obj/item/hair_painter/suicide_act(mob/living/carbon/user)
	var/mob/living/carbon/human/H = user
	ADD_TRAIT(src, TRAIT_NODROP, GENERIC_ITEM_TRAIT) // No going back now
	user.visible_message("<span class='suicide'>[user] turns off [src]'s pump safeties and sticks its output in [user.p_their()] mouth! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src.loc, 'sound/machines/engine_alert1.ogg', 50, 1)
	sleep(30)
	for(var/obj/item/W in H)
		H.dropItemToGround(W)
		if(prob(50))
			step(W, pick(GLOB.alldirs))
	ADD_TRAIT(H, TRAIT_DISFIGURED, TRAIT_GENERIC)
	H.bleed_rate = 5
	H.gib_animation()
	H.adjustBruteLoss(1000)
	H.spawn_gibs()
	H.spill_organs()
	H.spread_bodyparts()
	playsound(src.loc, 'sound/misc/splort.ogg',60,1)
	chem_splash(get_turf(src),2,list(reagents))
	qdel(src)
	return MANUAL_SUICIDE

/obj/item/hair_painter/proc/recolor_hair(mob/living/carbon/human/H, mob/user, mirror, target_zone)
	if(H == user && !mirror)
		to_chat(user, "<span class='warning'>You need a mirror to properly paint your own[target_zone == BODY_ZONE_PRECISE_MOUTH ? " facial" : ""] hair!</span>")
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	user.visible_message("<span class='notice'>[user] tries to paint [H]'s[target_zone == BODY_ZONE_PRECISE_MOUTH ? " facial" : ""] hair using [src].</span>", "<span class='notice'>You try to paint [H]'s[target_zone == BODY_ZONE_PRECISE_MOUTH ? " facial" : ""] hair using [src].</span>")
	if(dye_color && do_after(user, 60, target = H))
		if(!can_use())
			to_chat(user, "<span class='warning'>[src]'s dye tank has no quantum hair dye in it!</span>")
			return
		use_dye()
		if(!get_location_accessible(H, target_zone))
			to_chat(user, "<span class='warning'>The [target_zone == BODY_ZONE_PRECISE_MOUTH ? "mask" : "headgear"] is in the way!</span>")
			return
		user.visible_message("<span class='notice'>[user] successfully paints [H]'s[target_zone == BODY_ZONE_PRECISE_MOUTH ? " facial" : ""] hair using [src].</span>", "<span class='notice'>You successfully paint [H]'s[target_zone == BODY_ZONE_PRECISE_MOUTH ? " facial" : ""] hair using [src].</span>")
		switch(target_zone)
			if(BODY_ZONE_PRECISE_MOUTH)
				H.facial_hair_color = sanitize_hexcolor(dye_color)
			if(BODY_ZONE_HEAD)
				H.hair_color = sanitize_hexcolor(dye_color)
		H.update_hair()
		H.update_body()
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, 1)

/obj/item/hair_painter/verb/empty()
	set name = "Empty Dye Storage"
	set category = "Object"
	set src in usr
	if(usr.incapacitated())
		return
	if (alert(usr, "Are you sure you want to empty that?", "Empty Dye Storage:", "Yes", "No") != "Yes")
		return
	if(isturf(usr.loc) && src.loc == usr)
		to_chat(usr, "<span class='notice'>You empty \the [src] onto the floor.</span>")
		reagents.reaction(usr.loc)
		src.reagents.clear_reagents()
