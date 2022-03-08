/*
//////////////////////////////////////

Fever

	No change to hidden.
	Increases resistance.
	Increases stage speed.
	Little transmission.
	Low level.

Bonus
	Heats up your body.

//////////////////////////////////////
*/

/datum/symptom/fever
	name = "Fever"
	desc = "The virus causes a febrile response from the host, raising its body temperature."
	stealth = -1
	resistance = 3
	stage_speed = 3
	transmission = 2
	level = 2
	severity = 0
	base_message_chance = 20
	symptom_delay_min = 10
	symptom_delay_max = 30
	bodies = list("Fever")
	suffixes = list(" Fever")
	var/unsafe = FALSE //over the heat threshold
	threshold_desc = "<b>Resistance 5:</b> Increases fever intensity, fever can overheat and harm the host.<br>\
					  <b>Resistance 10:</b> Further increases fever intensity."

/datum/symptom/fever/severityset(datum/disease/advance/A)
	. = ..()
	if(A.resistance >= 5)
		severity += 1
		prefixes = list("Desert")
		if(A.resistance >= 10)
			severity += 1
			prefixes = list("Volcanic")

/datum/symptom/fever/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.resistance >= 5) //dangerous fever
		power = 1.5
		unsafe = TRUE
		if(A.resistance >= 10)
			power = 2.5

/datum/symptom/fever/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	if(!unsafe || A.stage < 4)
		to_chat(M, "<span class='warning'>[pick("You feel hot.", "You feel like you're burning.")]</span>")
	else
		to_chat(M, "<span class='userdanger'>[pick("You feel too hot.", "You feel like your blood is boiling.")]</span>")

	if(M.bodytemperature < M.dna.species.bodytemp_heat_damage_limit || unsafe)
		Heat(M, A)

/datum/symptom/fever/proc/Heat(mob/living/M, datum/disease/advance/A)
	var/get_heat = 6 * power
	var/damage_limit = 0
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		damage_limit = C.dna.species.bodytemp_heat_damage_limit

	damage_limit ||= HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT

	if(!unsafe)
		M.adjust_bodytemperature(get_heat * A.stage, 0, damage_limit - 1)
	else
		M.adjust_bodytemperature(get_heat * A.stage)
	return 1
