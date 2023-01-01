/*
//////////////////////////////////////

Hallucigen

	Very noticable.
	Lowers resistance considerably.
	Decreases stage speed.
	Reduced transmission.
	Critical Level.

Bonus
	Makes the affected mob be hallucinated for short periods of time.

//////////////////////////////////////
*/

#define HALLUCIGEN_STAGE_SPEED "stage speed"
#define HALLUCIGEN_STEALTH "stealth"

/datum/symptom/hallucigen
	name = "Hallucigen"
	desc = "The virus stimulates the brain, causing occasional hallucinations."
	stealth = 1
	resistance = -1
	stage_speed = 1
	transmission = 1
	level = 3
	severity = 1
	base_message_chance = 25
	symptom_delay_min = 10
	symptom_delay_max = 70
	prefixes = list("Narcotic ", "Narco", "Psycho-")
	suffixes = list(" Psychosis")
	var/fake_healthy = FALSE
	threshold_desc = "<b>Stage Speed 7:</b> Increases the amount of hallucinations.<br>\
					  <b>Stealth 2:</b> The virus mimics positive symptoms."
	threshold_ranges = list(
		HALLUCIGEN_STAGE_SPEED = list(5, 9),
		HALLUCIGEN_STEALTH = list(0, 4)
	)

/datum/symptom/hallucigen/severityset(datum/disease/advance/A)
	. = ..()
	if(A.stage_rate >= get_threshold(HALLUCIGEN_STAGE_SPEED))
		severity += 1

/datum/symptom/hallucigen/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.stealth >= get_threshold(HALLUCIGEN_STEALTH)) //fake good symptom messages
		fake_healthy = TRUE
		base_message_chance = 50
	if(A.stage_rate >= get_threshold(HALLUCIGEN_STAGE_SPEED)) //stronger hallucinations
		power = 2

/datum/symptom/hallucigen/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	var/list/healthy_messages = list("Your lungs feel great.", "You realize you haven't been breathing.", "You don't feel the need to breathe.",\
					"Your eyes feel great.", "You are now blinking manually.", "You don't feel the need to blink.")
	switch(A.stage)
		if(1, 2)
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, "<span class='notice'>[pick("Something appears in your peripheral vision, then winks out.", "You hear a faint whisper with no source.", "Your head aches.")]</span>")
				else
					to_chat(M, "<span class='notice'>[pick(healthy_messages)]</span>")
		if(3, 4)
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, "<span class='danger'>[pick("Something is following you.", "You are being watched.", "You hear a whisper in your ear.", "Thumping footsteps slam toward you from nowhere.")]</span>")
				else
					to_chat(M, "<span class='notice'>[pick(healthy_messages)]</span>")
		else
			if(prob(base_message_chance))
				to_chat(M, "<span class='userdanger'>[pick("Oh, your head...", "Your head pounds.", "They're everywhere! Run!", "Something in the shadows...")]</span>")
			M.hallucination += (45 * power)

/datum/symptom/hallucigen/Threshold(datum/disease/advance/A)
	if(!..())
		return
	threshold_desc = "<b>Stage Speed [get_threshold(HALLUCIGEN_STAGE_SPEED)]:</b> Increases the amount of hallucinations.<br>\
					  <b>Stealth [get_threshold(HALLUCIGEN_STEALTH)]:</b> The virus mimics positive symptoms."
	return threshold_desc
