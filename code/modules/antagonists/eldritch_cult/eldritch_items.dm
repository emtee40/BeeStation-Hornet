/obj/item/living_heart
	name = "Living Heart"
	desc = "Link to the worlds beyond."
	icon = 'icons/obj/eldritch.dmi'
	icon_state = "living_heart"
	w_class = WEIGHT_CLASS_SMALL
	///Target
	var/mob/living/carbon/human/target

/obj/item/living_heart/attack_self(mob/user)
	. = ..()
	if(!IS_HERETIC(user))
		return
	if(!target)
		to_chat(user,"<span class='warning'>No target could be found. Put the living heart on the rune and use the rune to recieve a target.</span>")
		return
	var/dist = get_dist(user.loc,target.loc)
	var/dir = get_dir(user.loc,target.loc)
	if(user.z != target.z)
		to_chat(user,"<span class='warning'>[target.real_name] is on another plane of existance!</span>")
	else
		switch(dist)
			if(0 to 15)
				to_chat(user,"<span class='warning'>[target.real_name] is near you. They are to the [dir2text(dir)] of you!</span>")
			if(16 to 31)
				to_chat(user,"<span class='warning'>[target.real_name] is somewhere in your vicinty. They are to the [dir2text(dir)] of you!</span>")
			else
				if (dir)
					to_chat(user,"<span class='warning'>[target.real_name] is far away from you. They are to the [dir2text(dir)] of you!</span>")
				else
					to_chat(user,"<span class='warning'>[target.real_name] is beyond our reach.</span>")

	if(target.stat == DEAD)
		to_chat(user,"<span class='warning'>[target.real_name] is dead. Bring them onto a transmutation rune!</span>")

/datum/action/innate/heretic_shatter
	name = "Shattering Offer"
	desc = "By breaking your blade you are noticed by the hill or rust and are granted an escape from a dire sitatuion. (Teleports you to a random safe z turf on your current z level but destroys your blade.)"
	background_icon_state = "bg_ecult"
	button_icon_state = "shatter"
	icon_icon = 'icons/mob/actions/actions_ecult.dmi'
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUN
	var/mob/living/carbon/human/holder
	var/obj/item/melee/sickly_blade/sword

/datum/action/innate/heretic_shatter/Grant(mob/user, obj/object)
	sword = object
	holder = user
	//i know what im doing
	return ..()

/datum/action/innate/heretic_shatter/IsAvailable()
	if(IS_HERETIC(holder) || IS_HERETIC_MONSTER(holder))
		return TRUE
	else
		return FALSE

/datum/action/innate/heretic_shatter/Activate()
	var/turf/safe_turf = find_safe_turf(zlevels = sword.z, extended_safety_checks = TRUE)
	do_teleport(holder,safe_turf,forceMove = TRUE)
	to_chat(holder,"<span class='warning'> You feel a gust of energy flow through your body, Rusted Hills heard your call...")
	qdel(sword)


/obj/item/melee/sickly_blade
	name = "Sickly blade"
	desc = "A sickly green crescent blade, decorated with an ornamental eye. You feel like you're being watched..."
	icon = 'icons/obj/eldritch.dmi'
	icon_state = "eldritch_blade"
	item_state = "eldritch_blade"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	flags_1 = CONDUCT_1
	sharpness = IS_SHARP
	w_class = WEIGHT_CLASS_NORMAL
	force = 17
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "rends")
	var/datum/action/innate/heretic_shatter/linked_action

/obj/item/melee/sickly_blade/Initialize()
	. = ..()
	linked_action = new(src)

/obj/item/melee/sickly_blade/attack(mob/living/M, mob/living/user)
	if(!(IS_HERETIC(user) || IS_HERETIC_MONSTER(user)))
		to_chat(user,"<span class='danger'>You feel a pulse of some alien intellect lash out at your mind!</span>")
		var/mob/living/carbon/human/human_user = user
		human_user.AdjustParalyzed(5 SECONDS)
		return FALSE
	return ..()

/obj/item/melee/sickly_blade/pickup(mob/user)
	. = ..()
	linked_action.Grant(user, src)

/obj/item/melee/sickly_blade/dropped(mob/user, silent)
	. = ..()
	linked_action.Remove(user, src)

/obj/item/melee/sickly_blade/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	var/datum/antagonist/heretic/cultie = user.mind.has_antag_datum(/datum/antagonist/heretic)
	if(!cultie || !proximity_flag)
		return
	var/list/knowledge = cultie.get_all_knowledge()
	for(var/X in knowledge)
		var/datum/eldritch_knowledge/eldritch_knowledge_datum = knowledge[X]
		eldritch_knowledge_datum.on_eldritch_blade(target,user,proximity_flag,click_parameters)

/obj/item/melee/sickly_blade/rust
	name = "\improper Rusted Blade"
	desc = "This crescent blade is decrepit, wasting to dust. Yet still it bites, catching flesh with jagged, rotten teeth."
	icon_state = "rust_blade"
	item_state = "rust_blade"

/obj/item/melee/sickly_blade/ash
	name = "\improper Ashen Blade"
	desc = "Molten and unwrought, a hunk of metal warped to cinders and slag. Unmade, it aspires to be more than it is, and shears soot-filled wounds with a blunt edge."
	icon_state = "ash_blade"
	item_state = "ash_blade"

/obj/item/melee/sickly_blade/flesh
	name = "\improper Flesh Blade"
	desc = "A crescent blade born from a fleshwarped creature. Keenly aware, it seeks to spread to others the excruitations it has endured from dread origins."
	icon_state = "flesh_blade"
	item_state = "flesh_blade"

/obj/item/clothing/neck/eldritch_amulet
	name = "Warm Eldritch Medallion"
	desc = "A strange medallion. Peering through the crystalline surface, the world around you melts away. You see your own beating heart, and the pulse of a thousand others."
	icon = 'icons/obj/eldritch.dmi'
	icon_state = "eye_medalion"
	w_class = WEIGHT_CLASS_SMALL
	///What trait do we want to add upon equipiing
	var/trait = TRAIT_THERMAL_VISION

/obj/item/clothing/neck/eldritch_amulet/equipped(mob/user, slot)
	. = ..()
	if(ishuman(user) && user.mind && slot == SLOT_NECK && IS_HERETIC(user) )
		ADD_TRAIT(user, trait, CLOTHING_TRAIT)
		user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, trait, CLOTHING_TRAIT)
	user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/piercing
	name = "Piercing Eldritch Medallion"
	desc = "A strange medallion. Peering through the crystalline surface, the light refracts into new and terrifying spectrums of color. You see yourself, reflected off cascading mirrors, warped into improbable shapes."
	trait = TRAIT_XRAY_VISION

/obj/item/clothing/head/hooded/cult_hoodie/eldritch
	name = "ominous hood"
	icon_state = "eldritch"
	desc = "A torn, dust-caked hood. Strange eyes line the inside."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flash_protect = 1

/obj/item/clothing/suit/hooded/cultrobes/eldritch
	name = "ominous armor"
	desc = "A ragged, dusty set of robes. Strange eyes line the inside."
	icon_state = "eldritch_armor"
	item_state = "eldritch_armor"
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	allowed = list(/obj/item/melee/sickly_blade, /obj/item/forbidden_book)
	hoodtype = /obj/item/clothing/head/hooded/cult_hoodie/eldritch
	// slightly better than normal cult robes
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50,"energy" = 50, "bomb" = 35, "bio" = 20, "rad" = 0, "fire" = 20, "acid" = 20)

/obj/item/reagent_containers/glass/beaker/eldritch
	name = "flask of eldritch essence"
	desc = "Toxic to the close minded. Healing to those with knowledge of the beyond."
	icon = 'icons/obj/eldritch.dmi'
	icon_state = "eldrich_flask"
	list_reagents = list(/datum/reagent/eldritch = 50)

/obj/item/toy/artifact
	name = "avatar"
	description = "A cobble statuette of some sorts."
	var/deity = 0
	var/godname = "Cthulhu"
	var/infused = FALSE

/obj/item/toy/artifact/Initialize()
	deity = rand(1,15)
	switch (deity)
		if (1)	//force awake
			godname = "Lobon"
		if (2)	//eye heal - cure blindness
			godname = "Nath-Horthath"
		if (3)	//brain heal 
			godname = "Oukranos"
		if (4)	//heal toxin
			godname = "Tamash"
		if (5)	//heal burn
			godname = "Karakal"
		if (6)	// heal brute
			godname = "D’endrrah"	
		if (7)	// eye damage - blind
			godname = "Azathoth"
		if (8)	//tongue damage - mute
			godname = "Abhoth"
		if (9)	//brain damage - induce sleep
			godname = "Aiueb Gnshal"
		if (10)	//brute
			godname = "Ialdagorth"
		if (11)	//burn
			godname = "Tulzscha"
		if (12)	//paralyze legs
			godname = "C'thalpa"
		if (13)	//paralyze hands	
			godname = "Mh'ithrha"
		if (14)	//emp - emag
			godname = "Shabbith-Ka"
		if (15)	// depacification - eldritch antag
			godname = "Yomagn'tho"
	name = "statue of [godname]"

/obj/item/toy/artifact/examine(mob/user)
	. = ..()
	var/heretic_user = IS_HERETIC(user)
	if(heretic_user || IS_HERETIC_MONSTER(user) || user.job in list("Curator"))
		switch (deity)
			if (1)
				.+="Lore"
	if (heretic_user)
		if (!infused)
			.+="This [src] has not been infused with magic."
		else
			switch (deity)
				if (1)
					.+="The blessing of [godname] will awake the sleeping."
				if (2)
					.+="The blessing of [godname] will heal the blind."
				if (3)
					.+="The blessing of [godname] will cure stupidity."
				if (4)
					.+="The blessing of [godname] will cauterize bruises."
				if (5)	
					.+="The blessing of [godname] will mend burns."
				if (1)	//force awake - induce sleep
					godname = "Lobon"
				if (2)	//eye heal - cure blindness
					godname = "Nath-Horthath"
				if (3)	//brain heal 
					godname = "Oukranos"
				if (4)	//heal toxin
					godname = "Tamash"
				if (5)	//heal burn
					godname = "Karakal"
				if (6)	// heal brute
					godname = "D’endrrah"	
				if (7)	// eye damage
					godname = "Azathoth"
				if (8)	//tongue damage
					godname = "Abhoth"
				if (9)	//brain damage
					godname = "Aiueb Gnshal"
				if (10)	//brute
					godname = "Ialdagorth"
				if (11)	//burn
					godname = "Tulzscha"
				if (12)	//paralyze legs
					godname = "C'thalpa"
				if (13)	//paralyze hands	
					godname = "Mh'ithrha"
				if (14)	//emp - emag
					godname = "Shabbith-Ka"
				if (15)	// depacification - eldritch antag
					godname = "Yomagn'tho"
			
		var/datum/antagonist/heretic/her = user.mind.has_antag_datum(/datum/antagonist/heretic)
		if (her && !her.analyzed_artifacts[deity])
			.+="You have not gained the favor of [godname]."
	

/obj/item/toy/artifact/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if (. && do_after(user,20,target))
		infuse_blessing(target)
	return .

/obj/item/toy/artifact/attack_self(mob/user)
	. = ..()
	if (IS_HERETIC(user))
		var/datum/antagonist/heretic/her = user.mind.has_antag_datum(/datum/antagonist/heretic)
		if (her && !her.analyzed_artifacts[deity])
			//you stare intensely at SRC
			if (do_after(user,3 SECONDS))
				her.analyzed_artifacts[deity] = godname
				if (!infused)
					//the ritual is complete! you may channel the blessing of [godname] through [src]
					infused = TRUE
				else
					//you gained the favor of [godname]
				return TRUE
	if (. && do_after(user,30))
		infuse_blessing(user)
	return .
	
/obj/item/toy/artifact/proc/infuse_blessing(mob/living/carbon/human/target)
	if (!infused || !istype(target) || QDELETED(victim) || victim.stat == DEAD)
		return
	
	//tochat
	switch (deity)
		if (1)	
			target.SetSleeping(0)
		if (2)
			target.adjustOrganLoss(ORGAN_SLOT_EYES,-10)
		if (3)
			target.adjustOrganLoss(ORGAN_SLOT_BRAIN,-10)
		if (4)
			target.adjustToxLoss(-10)
		if (5)
			target.adjustFireLoss(-10)
		if (6)
			target.adjustBruteLoss(-10)	
		if (7)	
			target.adjustOrganLoss(ORGAN_SLOT_EYES,15)
		if (8)	
			target.adjustOrganLoss(ORGAN_SLOT_TONGUE,20)
		if (9)	
			target.adjustOrganLoss(ORGAN_SLOT_BRAIN,15)
		if (10)
			target.adjustBruteLoss(5)	
		if (11)	
			target.adjustFireLoss(5)
		if (12)	
			for(var/obj/item/bodypart/organ in target.bodyparts)
				if(organ.body_part == LEG_RIGHT || organ.body_part == LEG_LEFT)
					organ.receive_damage(stamina = 5)
		if (13)	
			for(var/obj/item/bodypart/organ in target.bodyparts)
				if(organ.body_part == ARM_RIGHT || organ.body_part == ARM_LEFT)
					organ.receive_damage(stamina = 5)
		if (14)	
			A.emp_act(EMP_LIGHT)
		if (15)
			if(HAS_TRAIT(target, TRAIT_PACIFISM))
				REMOVE_TRAIT(target, TRAIT_PACIFISM)

/obj/item/toy/artifact/proc/to_ashes() 	
	if (infused)
		var/god = deity
		var/name = godname	
		var/obj/item/toy/artifact/ashes/new_item = new(usr.loc)
		
		new_item.deity = god
		new_item.godname = name
		//you forge something
	else
		//the src turns to ashes
	qdel(src)

/obj/item/toy/artifact/ashes
	name = "pile ashes"
	description = "A pile of ashes."
	infused = TRUE

/obj/item/toy/artifact/ashes/Initialize()
	return
	
/obj/item/toy/artifact/ashes/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if (.)
		infuse_blessing(target)
	return .

/obj/item/toy/artifact/ashes/attack_self(mob/user)
	. = ..()
	if (.)
		infuse_blessing(user)
	return .
	
/obj/item/toy/artifact/ashes/infuse_blessing(mob/living/carbon/human/target)
	if (!istype(target) || QDELETED(victim) || victim.stat == DEAD)
		return
	//no tochat, this one is stealthy
	switch (deity)
		if (1)	
			target.SetSleeping(10 SECONDS)
		if (2)
			target.adjustOrganLoss(ORGAN_SLOT_EYES,-80)
		if (3)
			target.adjustOrganLoss(ORGAN_SLOT_BRAIN,-50)
		if (4)
			target.adjustToxLoss(-50)
		if (5)
			target.adjustFireLoss(-50)
		if (6)
			target.adjustBruteLoss(-50)	
		if (7)	
			target.adjustOrganLoss(ORGAN_SLOT_EYES,80)
		if (8)	
			target.adjustOrganLoss(ORGAN_SLOT_TONGUE,80)
		if (9)	
			target.adjustOrganLoss(ORGAN_SLOT_BRAIN,15)
		if (10)
			target.adjustBruteLoss(30)	
		if (11)	
			target.adjustFireLoss(30)
		if (12)	
			for(var/obj/item/bodypart/organ in target.bodyparts)
				if(organ.body_part == LEG_RIGHT || organ.body_part == LEG_LEFT)
					organ.receive_damage(stamina = 200)
		if (13)	
			for(var/obj/item/bodypart/organ in target.bodyparts)
				if(organ.body_part == ARM_RIGHT || organ.body_part == ARM_LEFT)
					organ.receive_damage(stamina = 200)
		if (14)	
			A.emp_act(EMP_HEAVY)
		if (15)
			var/datum/antagonist/heretic/master = user.mind.has_antag_datum(/datum/antagonist/heretic)
			if (master)
			if(length(master.followers) >= get_max_followers())
				to_chat(user,"<span class='notice'>We enslaved too many minds!</span>")
				return

			if(!victim.mind || !victim.client )
				to_chat(user,"<span class='notice'>[victim] has no mind to enslave!</span>")
			if (IS_HERETIC(victim) || IS_HERETIC_MONSTER(victim))
				to_chat(user,"<span class='warning'>Their mind belongs to someone else!</span>")
				return

			log_game("[key_name_admin(victim)] has become a follower of [user.real_name]")
			victim.faction |= "heretics"

			var/datum/antagonist/heretic_monster/heretic_monster = victim.mind.add_antag_datum(/datum/antagonist/heretic_monster)
			heretic_monster.set_owner(master)