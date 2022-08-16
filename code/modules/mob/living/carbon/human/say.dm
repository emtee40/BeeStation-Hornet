/mob/living/carbon/human/say_mod(input, list/message_mods = list())
	var/obj/item/organ/tongue/T = getorganslot(ORGAN_SLOT_TONGUE)
	if(T)
		verb_say = T.say_mod
	if(slurring || !T)
		return "slurs"
	else
		. = ..()

/mob/living/carbon/human/GetVoice()
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/V = wear_mask
		if(V.vchange && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return real_name
		else
			return real_name
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling && changeling.mimicing )
			return changeling.mimicing
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/IsVocal()
	// how do species that don't breathe talk? magic, that's what.
	if(!HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT) && !getorganslot(ORGAN_SLOT_LUNGS))
		return FALSE
	if(src.race)
		if(!src.race.speak_no_tongue && !getorganslot(ORGAN_SLOT_TONGUE))  // candy-etherware
			return FALSE
	if(mind)
		return !mind.miming
	return TRUE

/mob/living/carbon/human/proc/SetSpecialVoice(new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

/mob/living/carbon/human/binarycheck()
	if(stat >= SOFT_CRIT || !ears)
		return FALSE
	var/obj/item/radio/headset/dongle = ears
	if(!istype(dongle))
		return FALSE
	return dongle.translate_binary

/mob/living/carbon/human/radio(message, list/message_mods = list(), list/spans, language)
	. = ..()
	if(. != FALSE)
		return .

	if(message_mods[MODE_HEADSET])
		if(ears)
			ears.talk_into(src, message, , spans, language, message_mods)
		return ITALICS | REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] == MODE_DEPARTMENT || (GLOB.radiochannels[message_mods[RADIO_EXTENSION]]))
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE

	return FALSE

/mob/living/carbon/human/get_alt_name()
	if(name != GetVoice())
		return " (as [get_id_name("Unknown")])"

/mob/living/carbon/human/proc/forcesay(list/append) //this proc is at the bottom of the file because quote fuckery makes notepad++ cri
	if(stat == CONSCIOUS)
		if(client)
			var/temp = winget(client, "input", "text")
			var/say_starter = "Say \"" //"
			if(findtextEx(temp, say_starter, 1, length(say_starter) + 1) && length(temp) > length(say_starter))	//case sensitive means

				temp = trim_left(copytext(temp, length(say_starter) + 1))
				temp = replacetext(temp, ";", "", 1, 2)	//general radio
				while(trim_left(temp)[1] == ":")	//dept radio again (necessary)
					temp = copytext_char(trim_left(temp), 3)

				if(temp[1] == "*")	//emotes
					return

				var/trimmed = trim_left(temp)
				if(length(trimmed))
					if(append)
						trimmed  += pick(append)

					say(trimmed)
				winset(client, "input", "text=[null]")
