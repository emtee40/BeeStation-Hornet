// Icewalkers made for Spooktober 2023

/datum/species/twistedmen

	name = "\improper Twisted man"
	plural_form = "Twisted men"
	id = SPECIES_TWISTED
	sexes = 0
	species_traits = list(NOBLOOD,NOHUSK,NOREAGENTS,NO_UNDERWEAR,NOEYESPRITES,REVIVESBYHEALING)
	inherent_traits = list(TRAIT_NOBREATH,TRAIT_RESISTCOLD,TRAIT_NOMETABOLISM,TRAIT_NOGUNS)
	inherent_biotypes = list(MOB_UNDEAD,MOB_HUMANOID)
	no_equip = list(ITEM_SLOT_HEAD, //All of them
					ITEM_SLOT_MASK,
					ITEM_SLOT_EYES,
					ITEM_SLOT_EARS,
					ITEM_SLOT_NECK,
					ITEM_SLOT_OCLOTHING,
					ITEM_SLOT_ICLOTHING,
					ITEM_SLOT_ID,
					ITEM_SLOT_BACK,
					ITEM_SLOT_BELT,
					ITEM_SLOT_HANDS,
					ITEM_SLOT_LPOCKET,
					ITEM_SLOT_RPOCKET,
					ITEM_SLOT_GLOVES,
					ITEM_SLOT_FEET,
					ITEM_SLOT_ICLOTHING,
					ITEM_SLOT_SUITSTORE)
	damage_overlay_type = "" //normal sprite already shows wounds, likely to remain empty
	changesource_flags = MIRROR_BADMIN //The species is not balanced for normal rounds, considering leaving this empty
	species_language_holder = /datum/language_holder/construct

	species_chest = /obj/item/bodypart/head/twisted
	species_head = /obj/item/bodypart/chest/twisted
	species_l_arm = /obj/item/bodypart/l_arm/twisted
	species_r_arm = /obj/item/bodypart/r_arm/twisted
	species_l_leg = /obj/item/bodypart/l_leg/twisted
	species_r_leg = /obj/item/bodypart/r_leg/twisted
	var/datum/action/innate/dispenser/dispenser

	mutanteyes = /obj/item/organ/eyes/twisted

/mob/living/carbon/human/species/twistedmen
    race = /datum/species/twistedmen

/mob/living/carbon/human/species/twistedmen/Initialize()
  ..()
  deathsound = pick('sound/voice/twisted/twisteddeath_1.ogg',
                    'sound/voice/twisted/twisteddeath_2.ogg',
                    'sound/voice/twisted/twisteddeath_3.ogg')

/datum/species/twistedmen/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	if(ishuman(C))
		dispenser = new
		dispenser.Grant(C)

/datum/species/twistedmen/get_scream_sound(mob/living/carbon/user)
	return pick(
		'sound/voice/twisted/twistedscream_1.ogg',
		'sound/voice/twisted/twistedscream_2.ogg',
		'sound/voice/twisted/twistedscream_3.ogg',
		'sound/voice/twisted/twistedscream_4.ogg',
	)

/datum/species/twistedmen/get_laugh_sound(mob/living/carbon/user)
	return pick(
		'sound/voice/twisted/twistedlaugh_1.ogg',
		'sound/voice/twisted/twistedlaugh_2.ogg',
		'sound/voice/twisted/twistedlaugh_3.ogg',
		'sound/voice/twisted/twistedlaugh_4.ogg',
	)

/datum/species/twistedmen/get_species_description()
	return "A twisted husk of flesh and metal, haunting the wastes of Iceland in search of sacrifices to offer to the Unshaped."

/datum/species/twistedmen/get_species_lore()
	return list("Shapeless shadows roaming the wastes of Iceland, these ominous creatures bear strange ressemblances to humans and are highly aggressive. They seem to be in a state of constant agony, their defiled bodies made of a twisted metal and flesh, a trickle of blood pouring out of what seems to be wounds. They band together in settlements and organize hunting parties to find victims to brutally sacrifice in honor of their terrible god.")

/datum/species/twistedmen/spec_revival(mob/living/carbon/human/H)
	H.notify_ghost_cloning("Your mangled body has been repaired!")
	H.grab_ghost()
	INVOKE_ASYNC(src, PROC_REF(declare_revival), H)
	H.update_body()

/datum/species/twistedmen/proc/declare_revival(mob/living/carbon/human/H)
	H.set_resting(TRUE, TRUE)
	H.say("...")
	sleep(4 SECONDS)
	if(H.stat == DEAD)
		return
	H.emote("laugh")
	H.set_resting(FALSE, TRUE)

/obj/item/organ/eyes/twisted
	name = "twisted eyes"
	desc = "Shields the twisted from the bright lights their arc-welders emit."
	flash_protect = 2
	var/obj/item/weldingtool/infinite/welder

/obj/item/organ/eyes/twisted/Insert(mob/living/carbon/M, special = 0, pref_load = FALSE)
	..()
	if(M.dna.species.id != SPECIES_TWISTED)
		return
	welder = new/obj/item/weldingtool/infinite
	M.put_in_hands(welder)

/datum/action/innate/dispenser
	name = "Flesh craft"
	desc = "Craft tools using chunks of your body"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "transmute"
	icon_icon = 'icons/mob/actions/actions_cult.dmi'//NEEDS ICON
	background_icon_state = "bg_cult"
	COOLDOWN_DECLARE(dispense_cooldown)

/datum/action/innate/dispenser/Activate()
	if(!COOLDOWN_FINISHED(src,dispense_cooldown))
		return
	var/list/dispense_list = list(
		"Zipties" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "cuff_blood"),//NEEDS ICON (?)
		"Bola" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "bola"),//NEEDS ICON (?)
		"Shield" = image(icon = 'icons/obj/shields.dmi', icon_state = "twisted"),)//NEEDS ICON (?)
	var/choice = show_radial_menu(owner, owner, dispense_list, radius = 42)
	switch(choice)
		if("Zipties")
			choice = new /obj/item/restraints/handcuffs/cable/zipties/blood/twisted
		if("Bola")
			choice = new /obj/item/restraints/legcuffs/bola/watcher/twisted
		if("Shield")
			choice = new /obj/item/shield/riot/twisted
	if(!choice)
		return
	if(!owner.put_in_active_hand(choice))
		to_chat(owner, "<span class='warning'>Your hand is full!</span>")//NEEDS LOCALIZATION
		qdel(choice)
		return
	to_chat(owner, "<span class='warning'>You fabricate [choice]!</span>")//NEEDS LOCALIZATION
	COOLDOWN_START(src,dispense_cooldown,10 SECONDS)

/obj/item/restraints/handcuffs/cable/zipties/blood/twisted
	trashtype = /obj/item/restraints/handcuffs/cable/zipties/blood/twisted_used

/obj/item/restraints/handcuffs/cable/zipties/blood/twisted/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(crumble), src)

/obj/item/restraints/handcuffs/cable/zipties/blood/twisted/proc/crumble()
	visible_message("<span class='warning'>the [src] crumbles away!</span>")
	UnregisterSignal(src, COMSIG_ITEM_DROPPED)
	qdel(src)

/obj/item/restraints/handcuffs/cable/zipties/blood/twisted_used/Initialize()
	visible_message("<span class='warning'>the restraints crumbles away!</span>")
	qdel(src) //hacky, but we don't actually want these to stick around after use.

/obj/item/restraints/legcuffs/bola/watcher/twisted
	name = "twisted bola"
	desc = "A Bola made from inside of one of the twisted"
	icon_state = "bola_watcher"
	item_state = "bola_watcher"
	knockdown = 2 SECONDS
	breakouttime = 4 SECONDS //The bola crumbles in this same time period anyway

/obj/item/restraints/legcuffs/bola/watcher/twisted/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(crumble_timed), src)

/obj/item/restraints/legcuffs/bola/watcher/twisted/proc/crumble_timed()
	addtimer(CALLBACK(src, PROC_REF(crumble)), breakouttime + 1 SECONDS) //Flight will not last more than a second anyway

/obj/item/restraints/legcuffs/bola/watcher/twisted/ensnare(mob/living/carbon/C)
	..()
	addtimer(CALLBACK(src, PROC_REF(crumble)), breakouttime)

/obj/item/restraints/legcuffs/bola/watcher/twisted/proc/crumble()
	visible_message("<span class='warning'>the [src] crumbles away!</span>")
	UnregisterSignal(src, COMSIG_ITEM_DROPPED)
	qdel(src)

/obj/item/shield/riot/twisted
	name = "twisted shield"
	desc = "an amalgamation of metal and flesh mashed with one another to serve as a shield. Sturdy, blood drips from it."
	icon_state = "twisted"
	item_state = "twisted"
	lefthand_file = 'icons/mob/inhands/halloween/twistedl.dmi'
	righthand_file = 'icons/mob/inhands/halloween/twistedr.dmi'
	transparent = FALSE
	max_integrity =  25 //can block three lasers or two-ish melee attacks.
	block_power = 0

/obj/item/shield/riot/twisted/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(crumble), src)

/obj/item/shield/riot/twisted/on_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, damage, attack_type)
	if(..())
		return
	else

/obj/item/shield/riot/twisted/shatter(mob/living/carbon/human/owner)
	crumble()

/obj/item/shield/riot/twisted/proc/crumble()
	visible_message("<span class='warning'>the [src] crumbles away!</span>")
	UnregisterSignal(src, COMSIG_ITEM_DROPPED)
	qdel(src)
