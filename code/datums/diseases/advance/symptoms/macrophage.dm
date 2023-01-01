#define MACROPHAGE_TRANSMISSION_1 "transmission1"
#define MACROPHAGE_TRANSMISSION_2 "transmission2"

/datum/symptom/macrophage
	name = "Macrophage"
	desc = "The virus grows within the host, ceasing to be microscopic and causing severe bodily harm. These Phages will seek out, attack, and infect more viable hosts."
	stealth = -4
	resistance = 1
	stage_speed = -2
	transmission = 2
	level = 9
	severity = 2
	symptom_delay_min = 30
	symptom_delay_max = 60
	prefixes = list("Ambulant ", "Macro")
	bodies = list("Phage")
	var/gigagerms = FALSE
	var/netspeed = 0
	var/phagecounter = 10
	threshold_desc = "<b>Stage Speed:</b> The higher the stage speed, the more frequently phages will burst from the host.<br>\
                      <b>Resistance:</b> The higher the resistance, the more health phages will have, and the more damage they will do.<br>\
					  <b>Transmission 10:</b> Phages can be larger, more aggressive, and able to pierce thick clothing, with some effort.<br>\
                      <b>Transmission 12:</b> Phages will carry all diseases within the host, instead of only diseases containing their own symptom."
	threshold_ranges = list(
		MACROPHAGE_TRANSMISSION_1 = list(9, 11),
		MACROPHAGE_TRANSMISSION_2 = list(12, 13)
	)

/datum/symptom/macrophage/severityset(datum/disease/advance/A)
	. = ..()
	if(A.transmission >= get_threshold(MACROPHAGE_TRANSMISSION_1)) // Phages go through armor infecting new hosts
		severity += 2

/datum/symptom/macrophage/Start(datum/disease/advance/A)
	if(!..())
		return
	netspeed = max(1, A.stage_rate)
	if(A.transmission >= get_threshold(MACROPHAGE_TRANSMISSION_1))
		gigagerms = TRUE

/datum/symptom/macrophage/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1-3)
			to_chat(M, "<span class='notice'>Your skin crawls.</span>")
		if(4)
			M.visible_message("<span class='danger'>Lumps form on [M]'s skin!</span>", \
								  "<span class='userdanger'>You cringe in pain as lumps form and move around on your skin!</span>")
		if(5)
			phagecounter -= max(2, A.stage_rate)
			if(gigagerms && phagecounter <= 0) //only ever spawn one big germ
				Burst(A, M, TRUE)
				phagecounter += 10
			while(phagecounter <= 0)
				phagecounter += 5
				Burst(A, M)

/datum/symptom/macrophage/proc/Burst(datum/disease/advance/A, var/mob/living/M, var/gigagerms = FALSE)
	var/mob/living/simple_animal/hostile/macrophage/phage
	if(gigagerms)
		phage = new /mob/living/simple_animal/hostile/macrophage/aggro(M.loc)
		phage.melee_damage = max(5, A.resistance)
		M.apply_damage(rand(10, 20))
		playsound(M, 'sound/effects/splat.ogg', 50, 1)
		M.emote("scream")
	else
		phage = new(M.loc)
		M.apply_damage(rand(1, 7))
	phage.health += A.resistance
	phage.maxHealth += A.resistance
	phage.infections += A
	phage.basedisease = A
	if(A.transmission >= get_threshold(MACROPHAGE_TRANSMISSION_2)) // Phages will have all diseases from the host it came from
		for(var/datum/disease/D in M.diseases)
			if((D.spread_flags & DISEASE_SPREAD_SPECIAL) || (D.spread_flags & DISEASE_SPREAD_NON_CONTAGIOUS) || (D.spread_flags & DISEASE_SPREAD_FALTERED))
				continue
			if(D == A)
				continue
			phage.infections += D
	M.visible_message("<span class='danger'>A strange creature bursts out of [M]!</span>", \
	  "<span class='userdanger'>A slimy creature bursts forth from your flesh!</span>")
	addtimer(CALLBACK(phage, /mob/living/simple_animal/hostile/macrophage.proc/shrivel), 3000)

/datum/symptom/macrophage/Threshold(datum/disease/advance/A)
	if(!..())
		return
	threshold_desc = "<b>Stage Speed:</b> The higher the stage speed, the more frequently phages will burst from the host.<br>\
                      <b>Resistance:</b> The higher the resistance, the more health phages will have, and the more damage they will do.<br>\
					  <b>Transmission [get_threshold(MACROPHAGE_TRANSMISSION_1)]:</b> Phages can be larger, more aggressive, and able to pierce thick clothing, with some effort.<br>\
                      <b>Transmission [get_threshold(MACROPHAGE_TRANSMISSION_2)]:</b> Phages will carry all diseases within the host, instead of only diseases containing their own symptom."
	return threshold_desc
