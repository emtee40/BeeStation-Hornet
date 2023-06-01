GLOBAL_VAR_INIT(brain_curse, FALSE)
GLOBAL_LIST_EMPTY(curse_of_twisted_reality_messages)

/proc/brain_curse(mob/user, message)
	if(user) //in this case either someone holding a spellbook or a badmin
		to_chat(user, "<span class='warning'>You sent a brain curse to everyone!</span>")
		message_admins("[ADMIN_LOOKUPFLW(user)] sent a brain curse to everyone!")
		log_game("[key_name(user)] sent a brain curse to everyone!")

	GLOB.brain_curse = TRUE // latejoiners are also afflicted.

	deadchat_broadcast("<span class='deadsay'>A <span class='name'>Brain Curse</span> has stricken the station, shattering their minds.</span>")

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat == DEAD)
			continue
		var/turf/T = get_turf(H)
		if(T && !is_station_level(T.z))
			continue
		if(H.anti_magic_check(TRUE, FALSE) || HAS_TRAIT(H, TRAIT_WARDED))
			to_chat(H, "<span class='notice'>You have a strange feeling for a moment, but then it passes.</span>")
			continue
		if(istype(H.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/foilhat))
			to_chat(H, "<span class='warning'>Your protective headgear successfully deflects mind controlling brainwaves!</span>")
			continue
		apply_brain_curse(H, message)

/proc/apply_brain_curse(mob/living/carbon/human/H)
	H.playsound_local(H,'sound/magic/curse.ogg',40,1)
	to_chat(H, "<span class='warning'>Your mind shatters!</span>")
	switch(rand(1,10))
		if(1 to 8)
			H.gain_trauma_type(BRAIN_TRAUMA_MAGIC, TRAUMA_RESILIENCE_SURGERY)
		if(9 to 10)
			H.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_SURGERY)

/proc/curse_of_twisted_reality(mob/user, message)
	if(user)
		to_chat(user, "<span class='warning'>You sent a curse of twisted reality with the message \"[message]\"!</span>")
		message_admins("[ADMIN_LOOKUPFLW(user)] sent a curse of reality with the message \"[message]\"!")
		log_game("[key_name(user)] sent a curse of reality with the message \"[message]\"!")

	var/static/idx = 0
	GLOB.curse_of_twisted_reality_messages["[++idx]"] = message

	deadchat_broadcast("<span class='deadsay'>A <span class='name'>Curse of Twisted Reality</span> has stricken the station, twisting their minds with the new reality: \"<span class='big hypnophrase'>[message]</span>\"</span>")

	for(var/mob/living/M in GLOB.player_list)
		M.playsound_local(M,'sound/magic/curse.ogg',40,1)
		to_chat(M, "<span class='reallybig hypnophrase'>[message]</span>")
		to_chat(M, "<span class='warning'>Your mind twists!</span>")

/proc/announce_twisted_reality_to_new_user(mob/M)
	if(length(GLOB.curse_of_twisted_reality_messages))
		M.playsound_local(M,'sound/magic/curse.ogg',40,1)
		for(var/each in GLOB.curse_of_twisted_reality_messages)
			to_chat(M, "<span class='reallybig hypnophrase'>[GLOB.curse_of_twisted_reality_messages[each]]</span>")
		to_chat(M, "<span class='warning'>Your mind twists!</span>")
