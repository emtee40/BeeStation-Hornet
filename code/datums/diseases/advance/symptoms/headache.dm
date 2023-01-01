/*
//////////////////////////////////////

Headache

	Noticable.
	Highly resistant.
	Increases stage speed.
	Not transmittable.
	Low Level.

BONUS
	Displays an annoying message!
	Should be used for buffing your disease.

//////////////////////////////////////
*/

#define HEADACHE_STAGE_SPEED_1 "stage speed1"
#define HEADACHE_STAGE_SPEED_2 "stage speed2"
#define HEADACHE_STEALTH "stealth"

/datum/symptom/headache

	name = "Headache"
	desc = "The virus causes inflammation inside the brain, causing constant headaches."
	stealth = -1
	resistance = 4
	stage_speed = 2
	transmission = 0
	level = 1
	severity = 0
	base_message_chance = 100
	symptom_delay_min = 15
	symptom_delay_max = 30
	bodies = list("Skull", "Migraine")
	threshold_desc = "<b>Stage Speed 6:</b> Headaches will cause severe pain, that weakens the host.<br>\
					  <b>Stage Speed 9:</b> Headaches become less frequent but far more intense, preventing any action from the host.<br>\
					  <b>Stealth 4:</b> Reduces headache frequency until later stages."
	threshold_ranges = list(
		HEADACHE_STAGE_SPEED_1 = list(5, 7),
		HEADACHE_STAGE_SPEED_2 = list(8, 10),
		HEADACHE_STEALTH = list(3, 5)
	)

/datum/symptom/headache/severityset(datum/disease/advance/A)
	. = ..()
	if(A.stage_rate >= get_threshold(HEADACHE_STAGE_SPEED_1))
		severity += 1
		if(A.stage_rate >= get_threshold(HEADACHE_STAGE_SPEED_2))
			severity += 1

/datum/symptom/headache/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.stealth >= get_threshold(HEADACHE_STEALTH))
		base_message_chance = 50
		if(A.stage_rate >= get_threshold(HEADACHE_STAGE_SPEED_1)) //Causes severe pain and weakens host
			power = 2
	if(A.stage_rate >= get_threshold(HEADACHE_STAGE_SPEED_2)) //Less headaches but stus the host
		symptom_delay_min = 30
		symptom_delay_max = 60
		power = 3

/datum/symptom/headache/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	if(power < 2)
		if(prob(base_message_chance) || A.stage >=4)
			to_chat(M, "<span class='warning'>[pick("Your head hurts.", "Your head pounds.")]</span>")
	if(power >= 2 && A.stage >= 4)
		to_chat(M, "<span class='warning'>[pick("Your head hurts a lot.", "Your head pounds incessantly.")]</span>")
		M.adjustStaminaLoss(25)
	if(power >= 3 && A.stage >= 5)
		to_chat(M, "<span class='userdanger'>[pick("Your head hurts!", "You feel a burning knife inside your brain!", "A wave of pain fills your head!")]</span>")
		M.Stun(35)

/datum/symptom/headache/Threshold(datum/disease/advance/A)
	if(!..())
		return
	threshold_desc = "<b>Stage Speed [get_threshold(HEADACHE_STAGE_SPEED_1)]:</b> Headaches will cause severe pain, that weakens the host.<br>\
					  <b>Stage Speed [get_threshold(HEADACHE_STAGE_SPEED_2)]:</b> Headaches become less frequent but far more intense, preventing any action from the host.<br>\
					  <b>Stealth [get_threshold(HEADACHE_STEALTH)]:</b> Reduces headache frequency until later stages."
	return threshold_desc
