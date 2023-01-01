/*
//////////////////////////////////////

Coughing

	Noticable.
	Little Resistance.
	Doesn't increase stage speed much.
	Transmissibile.
	Low Level.

BONUS
	Will force the affected mob to drop small items!

//////////////////////////////////////
*/

/datum/symptom/cough

	name = "Cough"
	desc = "The virus irritates the throat of the host, causing occasional coughing."
	stealth = -1
	resistance = 3
	stage_speed = 1
	transmission = 2
	level = 1
	severity = 0
	base_message_chance = 15
	symptom_delay_min = 2
	symptom_delay_max = 15
	bodies = list("Cough")
	var/infective = FALSE
	threshold_desc = "<b>Resistance 3:</b> Host will drop small items when coughing.<br>\
					  <b>Resistance 10:</b> Occasionally causes coughing fits that stun the host.<br>\
					  <b>Stage Speed 6:</b> Increases cough frequency.<br>\
					  <b>Stealth 4:</b> The symptom remains hidden until active.<br>\
					  <b>Transmission 11:</b> The host's coughing will occasionally spread the virus."
	threshold_ranges = list(
		"resistance1" = list(2, 4),
		"resistance2" = list(9, 11),
		"stage speed" = list(4, 8),
		"stealth" = list(3, 5),
		"transmission" = list(10, 12)
	)

/datum/symptom/cough/severityset(datum/disease/advance/A)
	. = ..()
	if(A.resistance >= get_threshold("resistance1"))
		severity += 1
		if(A.resistance >= get_threshold("resistance2"))
			severity += 1

/datum/symptom/cough/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.stealth >= get_threshold("stealth"))
		suppress_warning = TRUE
	if(A.resistance >= get_threshold("resistance1")) //strong enough to drop items
		power = 1.5
		if(A.resistance >= get_threshold("resistance2")) //strong enough to stun (rarely)
			power = 2
	if(A.stage_rate >= get_threshold("stage speed")) //cough more often
		symptom_delay_max = 10
	if(A.transmission >= get_threshold("transmission")) //spread virus
		infective =TRUE

/datum/symptom/cough/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, "<span notice='warning'>[pick("You swallow excess mucus.", "You lightly cough.")]</span>")
		else
			M.emote("cough")
			if(power >= 1.5)
				var/obj/item/I = M.get_active_held_item()
				if(I?.w_class == WEIGHT_CLASS_TINY)
					M.dropItemToGround(I)
			if(power >= 2 && prob(10))
				to_chat(M, "<span notice='userdanger'>[pick("You have a coughing fit!", "You can't stop coughing!")]</span>")
				M.Immobilize(20)
				M.emote("cough")
				addtimer(CALLBACK(M, /mob/.proc/emote, "cough"), 6)
				addtimer(CALLBACK(M, /mob/.proc/emote, "cough"), 12)
				addtimer(CALLBACK(M, /mob/.proc/emote, "cough"), 18)
			if(infective && !(A.spread_flags & DISEASE_SPREAD_FALTERED) && prob(50))
				addtimer(CALLBACK(A, /datum/disease/.proc/spread, 2), 20)

/datum/symptom/cough/Threshold(datum/disease/advance/A)
	if(!..())
		return
	threshold_desc = "<b>Resistance [get_threshold("resistance1")]:</b> Host will drop small items when coughing.<br>\
					  <b>Resistance [get_threshold("resistance2")]:</b> Occasionally causes coughing fits that stun the host.<br>\
					  <b>Stage Speed [get_threshold("stage speed")]:</b> Increases cough frequency.<br>\
					  <b>Stealth [get_threshold("stealth")]:</b> The symptom remains hidden until active.<br>\
					  <b>Transmission [get_threshold("transmission")]:</b> The host's coughing will occasionally spread the virus."
	return threshold_desc
