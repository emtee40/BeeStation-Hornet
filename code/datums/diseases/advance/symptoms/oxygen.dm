/*
//////////////////////////////////////

Self-Respiration

	Slightly hidden.
	Lowers resistance significantly.
	Decreases stage speed significantly.
	Decreases transmittablity tremendously.
	Fatal Level.

Bonus
	The body generates salbutamol.

//////////////////////////////////////
*/

/datum/symptom/oxygen

	name = "Self-Respiration"
	desc = "The virus rapidly synthesizes oxygen, effectively removing the need for breathing."
	stealth = 1
	resistance = -3
	stage_speed = -3
	transmission = -4
	severity = -1
	level = 8
	base_message_chance = 5
	symptom_delay_min = 1
	symptom_delay_max = 1
	prefixes = list("Breathless ", "Anaerobic ")
	var/regenerate_blood = FALSE
	threshold_desc = "<b>Resistance 8:</b> Additionally regenerates lost blood."
	threshold_ranges = list(
		"resistance" = list(6, 10)
	)

/datum/symptom/oxygen/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.resistance >= get_threshold("resistance")) //blood regeneration
		regenerate_blood = TRUE

/datum/symptom/oxygen/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	switch(A.stage)
		if(4, 5)
			ADD_TRAIT(M, TRAIT_NOBREATH, DISEASE_TRAIT)
			M.adjustOxyLoss(-7, 0)
			M.losebreath = max(0, M.losebreath - 4)
			if(regenerate_blood && M.blood_volume < BLOOD_VOLUME_NORMAL)
				M.blood_volume += 8 //it takes 4 seconds to lose one point of bleed_rate. this is exactly sufficient to counter autophageocytosis' Heparin production. Theoretically.
		else
			if(prob(base_message_chance))
				to_chat(M, "<span class='notice'>[pick("Your lungs feel great.", "You realize you haven't been breathing.", "You don't feel the need to breathe.", "Something smells rotten.", "You feel peckish.")]</span>")
	return

/datum/symptom/oxygen/on_stage_change(new_stage, datum/disease/advance/A)
	if(!..())
		return FALSE
	var/mob/living/carbon/M = A.affected_mob
	if(A.stage <= 3)
		REMOVE_TRAIT(M, TRAIT_NOBREATH, DISEASE_TRAIT)
	return TRUE

/datum/symptom/oxygen/End(datum/disease/advance/A)
	if(!..())
		return
	REMOVE_TRAIT(A.affected_mob, TRAIT_NOBREATH, DISEASE_TRAIT)

/datum/symptom/oxygen/Threshold(datum/disease/advance/A)
	if(!..())
		return
	threshold_desc = "<b>Resistance [get_threshold("resistance")]:</b> Additionally regenerates lost blood."
	return threshold_desc
