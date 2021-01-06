/datum/saymode
	var/key
	var/mode

//Return FALSE if you have handled the message. Otherwise, return EF_TRUE and saycode will continue doing saycode things.
//user = whoever said the message
//message = the message
//language = the language.
/datum/saymode/proc/handle_message(mob/living/user, message, datum/language/language)
	return EF_TRUE


/datum/saymode/changeling
	key = MODE_KEY_CHANGELING
	mode = MODE_CHANGELING

/datum/saymode/changeling/handle_message(mob/living/user, message, datum/language/language)
	switch(user.lingcheck())
		if(LINGHIVE_LINK)
			var/msg = "<span class='changeling'><b>[user.mind]:</b> [message]</span>"
			for(var/_M in GLOB.player_list)
				var/mob/M = _M
				if(M in GLOB.dead_mob_list)
					var/link = FOLLOW_LINK(M, user)
					to_chat(M, "[link] [msg]")
				else
					if(M)
						switch(M.lingcheck())
							if (LINGHIVE_LING)
								var/mob/living/L = M
								if (!HAS_TRAIT(L, CHANGELING_HIVEMIND_MUTE))
									to_chat(M, msg)
							if(LINGHIVE_LINK)
								to_chat(M, msg)
							if(LINGHIVE_OUTSIDER)
								if(prob(40))
									to_chat(M, "<span class='changeling'>We can faintly sense an outsider trying to communicate through the hivemind...</span>")
		if(LINGHIVE_LING)
			if (HAS_TRAIT(user, CHANGELING_HIVEMIND_MUTE))
				to_chat(user, "<span class='warning'>The poison in the air hinders our ability to interact with the hivemind.</span>")
				return EF_FALSE
			var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
			var/msg = "<span class='changeling'><b>[changeling.changelingID]:</b> [message]</span>"
			user.log_talk(message, LOG_SAY, tag="changeling [changeling.changelingID]")
			for(var/_M in GLOB.player_list)
				var/mob/M = _M
				if(M in GLOB.dead_mob_list)
					var/link = FOLLOW_LINK(M, user)
					to_chat(M, "[link] [msg]")
				else
					if(M)
						switch(M.lingcheck())
							if(LINGHIVE_LINK)
								to_chat(M, msg)
							if(LINGHIVE_LING)
								var/mob/living/L = M
								if (!HAS_TRAIT(L, CHANGELING_HIVEMIND_MUTE))
									to_chat(M, msg)
							if(LINGHIVE_OUTSIDER)
								if(prob(40))
									to_chat(M, "<span class='changeling'>We can faintly sense another of our kind trying to communicate through the hivemind...</span>")
		if(LINGHIVE_OUTSIDER)
			to_chat(user, "<span class='changeling'>Our senses have not evolved enough to be able to communicate this way...</span>")
	return EF_FALSE


/datum/saymode/xeno
	key = "a"
	mode = MODE_ALIEN

/datum/saymode/xeno/handle_message(mob/living/user, message, datum/language/language)
	if(user.hivecheck())
		user.alien_talk(message)
	return EF_FALSE


/datum/saymode/vocalcords
	key = MODE_KEY_VOCALCORDS
	mode = MODE_VOCALCORDS

/datum/saymode/vocalcords/handle_message(mob/living/user, message, datum/language/language)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		var/obj/item/organ/vocal_cords/V = C.getorganslot(ORGAN_SLOT_VOICE)
		if(V && V.can_speak_with())
			V.handle_speech(message) //message
			V.speak_with(message) //action
	return EF_FALSE


/datum/saymode/binary //everything that uses .b (silicons, drones, swarmers)
	key = MODE_KEY_BINARY
	mode = MODE_BINARY

/datum/saymode/binary/handle_message(mob/living/user, message, datum/language/language)
	if(isswarmer(user))
		var/mob/living/simple_animal/hostile/swarmer/S = user
		S.swarmer_chat(message)
		return EF_FALSE
	if(isdrone(user))
		var/mob/living/simple_animal/drone/D = user
		D.drone_chat(message)
		return EF_FALSE
	if(user.binarycheck())
		user.robot_talk(message)
		return EF_FALSE
	return EF_FALSE


/datum/saymode/holopad
	key = "h"
	mode = MODE_HOLOPAD

/datum/saymode/holopad/handle_message(mob/living/user, message, datum/language/language)
	if(isAI(user))
		var/mob/living/silicon/ai/AI = user
		AI.holopad_talk(message, language)
		return EF_FALSE
	return EF_TRUE

/datum/saymode/monkey
	key = "k"
	mode = MODE_MONKEY

/datum/saymode/monkey/handle_message(mob/living/user, message, datum/language/language)
	var/datum/mind = user.mind
	if(!mind)
		return EF_TRUE
	if(is_monkey_leader(mind) || (ismonkey(user) && is_monkey(mind)))
		user.log_talk(message, LOG_SAY, tag="monkey")
		if(prob(75) && ismonkey(user))
			user.visible_message("<span class='notice'>\The [user] chimpers.</span>")
		var/msg = "<span class='[is_monkey_leader(mind) ? "monkeylead" : "monkeyhive"]'><b><font size=2>\[[is_monkey_leader(mind) ? "Monkey Leader" : "Monkey"]\]</font> [user]</b>: [message]</span>"
		for(var/_M in GLOB.mob_list)
			var/mob/M = _M
			if(M in GLOB.dead_mob_list)
				var/link = FOLLOW_LINK(M, user)
				to_chat(M, "[link] [msg]")
			if((is_monkey_leader(M.mind) || ismonkey(M)) && (M.mind in SSticker.mode.ape_infectees))
				to_chat(M, msg)
		return EF_FALSE
