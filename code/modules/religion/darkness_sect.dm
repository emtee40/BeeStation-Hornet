/**** Darkness Sect ***/

/datum/religion_sect/darkness_sect
	name = "Dark City"
	desc = "A sect dedicated to the darkness."
	convert_opener = "Turn out the lights, acolyte, and let the darkness cover the world!<br>The altar and manifested obelisks will generate favor from being in darkness."
	alignment = ALIGNMENT_NEUT
	favor = 100 //Starts off with enough favor to make an obelisk
	//No desired items, favor is gained through obelisks and the altar in darkness
	rites_list = list(/datum/religion_rites/extend_darkness,/datum/religion_rites/darkobelisk, /datum/religion_rites/darkconversion)
	altar_icon_state = "convertaltar-dark"
	var/light_reach = 1
	var/light_power = 0
	var/list/obelisks

/datum/religion_sect/darkness_sect/sect_bless(mob/living/blessed, mob/living/user)
	return TRUE

/datum/religion_sect/darkness_sect/on_select(atom/religious_tool, mob/living/user)
	. = ..()
	if(!religious_tool || !user)
		return
	religious_tool.AddComponent(/datum/component/dark_favor, user)

/**** Rites ****/

#define DARKNESS_INVERSE_COLOR "#88ff88" //The color of light has to be inverse, since we're using negative light power

/datum/religion_rites/darkconversion
	name = "Shadowperson Conversion"
	desc = "Converts a humanoid into a shadowperson, a race blessed by darkness."
	ritual_length = 1 MINUTES
	ritual_invocations = list("Let the darkness seep into you...",
						"... And cover you, envelope you ...",
						"... And make you one with it ...")
	invoke_msg = "... And let you be born again!"
	favor_cost = 500

/datum/religion_rites/darkconversion/perform_rite(mob/living/user, atom/religious_tool)
	if(!ismovable(religious_tool))
		to_chat(user, "<span class='warning'>This rite requires a religious device that individuals can be buckled to.</span>")
		return FALSE
	var/atom/movable/movable_reltool = religious_tool
	if(!movable_reltool)
		return FALSE
	if(!LAZYLEN(movable_reltool.buckled_mobs))
		if(!movable_reltool.can_buckle) //yes, if you have somehow managed to have someone buckled to something that now cannot buckle, we will still let you perform the rite!
			to_chat(user, "<span class='warning'>This rite requires a religious device that individuals can be buckled to.</span>")
			return FALSE
		to_chat(user, "<span class='warning'>This rite requires an individual to be buckled to [movable_reltool].</span>")
		return FALSE
	return ..()

/datum/religion_rites/darkconversion/invoke_effect(mob/living/user, atom/religious_tool)
	if(!ismovable(religious_tool))
		CRASH("[name]'s perform_rite had a movable atom that has somehow turned into a non-movable!")
	var/atom/movable/movable_reltool = religious_tool
	if(!movable_reltool?.buckled_mobs?.len)
		return FALSE
	var/mob/living/carbon/human/human2darken = locate() in movable_reltool.buckled_mobs
	if(!human2darken)
		return FALSE
	human2darken.set_species(/datum/species/shadow)
	human2darken.visible_message("<span class='notice'>[human2darken] has been converted by the rite of [name]!</span>")
	return ..()

/datum/religion_rites/darkobelisk
	name = "Obelisk Manifestation"
	desc = "Creates an obelisk that generates favor when in a dark area."
	ritual_length = 15 SECONDS
	invoke_msg = "I summon forth an obelisk, to appease the darkness."
	favor_cost = 100 //Sect starts with 100 favor to begin

/datum/religion_rites/darkobelisk/invoke_effect(mob/living/user, atom/religious_tool)
	var/altar_turf = get_turf(religious_tool)
	var/obj/structure/darkobelisk/obelisk = new(altar_turf)
	var/datum/religion_sect/darkness_sect/sect = GLOB.religious_sect
	sect.obelisks += obelisk
	obelisk.AddComponent(/datum/component/dark_favor, user)
	obelisk.set_light(sect.light_reach, sect.light_power, DARKNESS_INVERSE_COLOR)
	playsound(altar_turf, 'sound/magic/fireball.ogg', 50, TRUE)
	return ..()

/obj/structure/darkobelisk
	name = "obelisk of darkness"
	desc = "Grants favor from being shrouded in darkness."
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "darkness-obelisk"
	density = TRUE

/datum/religion_rites/extend_darkness
	name = "Extend Darkness"
	desc = "Grow the reach of darkness extending from the altar, and any obelisks."
	ritual_length = 10 SECONDS
	invoke_msg = "Darkness, reach your tendrils from my altar, and extend thy domain."
	favor_cost = 75

/datum/religion_rites/extend_darkness/invoke_effect(mob/living/user, atom/religious_tool)
	. = ..()
	var/datum/religion_sect/darkness_sect/sect = GLOB.religious_sect
	if(!sect)
		return
	sect.light_reach += 2
	sect.light_power -= 1
	religious_tool.set_light(sect.light_reach, sect.light_power, DARKNESS_INVERSE_COLOR)
	for(var/obj/structure/darkobelisk/D in sect.obelisks)
		D.set_light(sect.light_reach, sect.light_power, DARKNESS_INVERSE_COLOR)

// Favor generator component. Used on the altar and obelisks
/datum/component/dark_favor
	var/mob/living/creator

/datum/component/dark_favor/Initialize(mob/living/L)
	. = ..()
	if(!L)
		return
	creator = L
	START_PROCESSING(SSobj, src)

/datum/component/dark_favor/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/datum/component/dark_favor/process()
	if(!istype(parent, /atom) || !istype(creator))
		return
	var/atom/P = parent
	var/turf/T = P.loc
	if(!istype(T))
		return
	var/light_amount = T.get_lumcount()
	var/favor_gained = max(1 - light_amount, 0)
	GLOB.religious_sect?.adjust_favor(favor_gained, creator)
