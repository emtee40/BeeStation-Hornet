/obj/item/organ/stomach
	name = "stomach"
	icon_state = "stomach"
	w_class = WEIGHT_CLASS_SMALL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_STOMACH
	attack_verb = list("gored", "squished", "slapped", "digested")
	desc = "Onaka ga suite imasu."

	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY

	low_threshold_passed = "<span class='info'>Your stomach flashes with pain before subsiding. Food doesn't seem like a good idea right now.</span>"
	high_threshold_passed = "<span class='warning'>Your stomach flares up with constant pain- you can hardly stomach the idea of food right now!</span>"
	high_threshold_cleared = "<span class='info'>The pain in your stomach dies down for now, but food still seems unappealing.</span>"
	low_threshold_cleared = "<span class='info'>The last bouts of pain in your stomach have died out.</span>"

	var/disgust_metabolism = 1

/obj/item/organ/stomach/on_life()
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/datum/reagent/nutriment

	if(istype(H))
		if(!(organ_flags & ORGAN_FAILING))
			H.dna.species.handle_digestion(H)
		handle_disgust(H)

	if(damage < low_threshold)
		return

	nutriment = locate(/datum/reagent/consumable/nutriment) in H.reagents.reagent_list

	if(nutriment)
		if(prob((damage/40) * nutriment.volume * nutriment.volume))
			H.vomit(damage)
			to_chat(H, "<span class='warning'>Your stomach reels in pain as you're incapable of holding down all that food!</span>")

	else if(nutriment && damage > high_threshold)
		if(prob((damage/10) * nutriment.volume * nutriment.volume))
			H.vomit(damage)
			to_chat(H, "<span class='warning'>Your stomach reels in pain as you're incapable of holding down all that food!</span>")

/obj/item/organ/stomach/proc/handle_disgust(mob/living/carbon/human/H)
	if(H.disgust)
		var/pukeprob = 5 + 0.05 * H.disgust
		if(H.disgust >= DISGUST_LEVEL_GROSS)
			if(prob(10))
				H.stuttering += 1
				H.confused += 2
			if(prob(10) && !H.stat)
				to_chat(H, "<span class='warning'>You feel kind of iffy...</span>")
			H.jitteriness = max(H.jitteriness - 3, 0)
		if(H.disgust >= DISGUST_LEVEL_VERYGROSS)
			if(prob(pukeprob)) //iT hAndLeS mOrE ThaN PukInG
				H.confused += 2.5
				H.stuttering += 1
				H.vomit(10, 0, 1, 0, 1, 0)
			H.Dizzy(5)
		if(H.disgust >= DISGUST_LEVEL_DISGUSTED)
			if(prob(25))
				H.blur_eyes(3) //We need to add more shit down here

		H.adjust_disgust(-0.5 * disgust_metabolism)
	switch(H.disgust)
		if(0 to DISGUST_LEVEL_GROSS)
			H.clear_alert("disgust")
			SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "disgust")
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			H.throw_alert("disgust", /atom/movable/screen/alert/gross)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/gross)
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			H.throw_alert("disgust", /atom/movable/screen/alert/verygross)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/verygross)
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			H.throw_alert("disgust", /atom/movable/screen/alert/disgusted)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/disgusted)

/obj/item/organ/stomach/Remove(mob/living/carbon/M, special = 0)
	var/mob/living/carbon/human/H = owner
	if(istype(H))
		H.clear_alert("disgust")
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "disgust")
	return ..()

/obj/item/organ/stomach/fly
	name = "insectoid stomach"
	icon_state = "stomach-x" //xenomorph liver? It's just a black liver so it fits.
	desc = "A mutant stomach designed to handle the unique diet of a flyperson."

/obj/item/organ/stomach/plasmaman
	name = "digestive crystal"
	icon_state = "stomach-p"
	desc = "A strange crystal that is responsible for metabolizing the unseen energy force that feeds plasmamen."

/obj/item/organ/stomach/battery
	name = "implantable battery"
	icon_state = "implant-power"
	desc = "A battery that stores charge for species that run on electricity."
	var/max_charge = 5000 //same as upgraded+ cell
	var/charge = 5000

/obj/item/organ/stomach/battery/Insert(mob/living/carbon/M, special = 0)
	. = ..()
	RegisterSignal(owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, .proc/charge)
	update_nutrition()

/obj/item/organ/stomach/battery/Remove(mob/living/carbon/M, special = 0)
	UnregisterSignal(owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)
	if(!HAS_TRAIT(owner, TRAIT_NOHUNGER) && HAS_TRAIT(owner, TRAIT_POWERHUNGRY))
		owner.nutrition = 0
		owner.throw_alert("nutrition", /atom/movable/screen/alert/nocell)
	return ..()

/obj/item/organ/stomach/battery/proc/charge(datum/source, amount, repairs)
	SIGNAL_HANDLER
	adjust_charge(amount)

/obj/item/organ/stomach/battery/proc/adjust_charge(amount)
	if(amount > 0)
		charge = clamp((charge + amount)*(1-(damage/maxHealth)), 0, max_charge)
	else
		charge = clamp(charge + amount, 0, max_charge)
	update_nutrition()

/obj/item/organ/stomach/battery/proc/adjust_charge_scaled(amount)
	adjust_charge(amount*max_charge/NUTRITION_LEVEL_FULL)

/obj/item/organ/stomach/battery/proc/set_charge(amount)
	charge = clamp(amount*(1-(damage/maxHealth)), 0, max_charge)
	update_nutrition()

/obj/item/organ/stomach/battery/proc/set_charge_scaled(amount)
	set_charge(amount*max_charge/NUTRITION_LEVEL_FULL)

/obj/item/organ/stomach/battery/proc/update_nutrition()
	if(!HAS_TRAIT(owner, TRAIT_NOHUNGER) && HAS_TRAIT(owner, TRAIT_POWERHUNGRY))
		owner.nutrition = (charge/max_charge)*NUTRITION_LEVEL_FULL

/obj/item/organ/stomach/battery/emp_act(severity)
	switch(severity)
		if(1)
			adjust_charge(-0.5 * max_charge)
			applyOrganDamage(30)
		if(2)
			adjust_charge(-0.25 * max_charge)
			applyOrganDamage(15)

/obj/item/organ/stomach/battery/ipc
	name = "micro-cell"
	icon_state = "microcell"
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("assault and battery'd")
	desc = "A micro-cell, for IPC use. Do not swallow."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	max_charge = 2750 //50 nutrition from 250 charge
	charge = 2750

/obj/item/organ/stomach/battery/ipc/emp_act(severity)
	. = ..()
	switch(severity)
		if(1)
			to_chat(owner, "<span class='warning'>Alert: Heavy EMP Detected. Rebooting power cell to prevent damage.</span>")
		if(2)
			to_chat(owner, "<span class='warning'>Alert: EMP Detected. Cycling battery.</span>")

/obj/item/organ/stomach/battery/ethereal
	name = "biological battery"
	icon_state = "stomach-p" //Welp. At least it's more unique in functionaliy.
	desc = "A crystal-like organ that stores the electric charge of ethereals."
	max_charge = 2500 //same as upgraded cell
	charge = 2500

/obj/item/organ/stomach/battery/ethereal/Insert(mob/living/carbon/M, special = 0)
	RegisterSignal(owner, COMSIG_LIVING_ELECTROCUTE_ACT, .proc/on_electrocute)
	return ..()

/obj/item/organ/stomach/battery/ethereal/Remove(mob/living/carbon/M, special = 0)
	UnregisterSignal(owner, COMSIG_LIVING_ELECTROCUTE_ACT)
	return ..()

/obj/item/organ/stomach/battery/ethereal/proc/on_electrocute(datum/source, shock_damage, shock_source, siemens_coeff = 1, safety = 0, tesla_shock = 0, illusion = 0, stun = TRUE)
	SIGNAL_HANDLER

	if(illusion)
		return
	adjust_charge(shock_damage * siemens_coeff * 20)
	to_chat(owner, "<span class='notice'>You absorb some of the shock into your body!</span>")

/obj/item/organ/stomach/cybernetic
	name = "basic cybernetic stomach"
	icon_state = "stomach-c"
	desc = "A basic device designed to mimic the functions of a human stomach"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.
	COOLDOWN_DECLARE(severe_cooldown)

/obj/item/organ/stomach/cybernetic/upgraded
	name = "cybernetic stomach"
	icon_state = "stomach-c-u"
	desc = "An electronic device designed to mimic the functions of a human stomach. Handles disgusting food a bit better."
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	disgust_metabolism = 2
	emp_vulnerability = 40

/obj/item/organ/stomach/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		owner.vomit(stun = FALSE)
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
	if(prob(emp_vulnerability/severity)) //Chance of permanent effects
		organ_flags |= ORGAN_FAILING //Starts organ failure - gonna need replacing soon.

/obj/item/organ/stomach/psyphoza
	name = "psyphoza stomach"
	desc = "Only technically a stomach."
	actions_types = list(/datum/action/item_action/organ_action/place_spores)

/datum/action/item_action/organ_action/place_spores
	name = "Deposit Spores"
	desc = "Deposit healing spores to your current location."
	///Time between uses
	var/cooldown = 120 SECONDS
	///Ref to timer
	var/cooldown_timer

/datum/action/item_action/organ_action/place_spores/Destroy()
	. = ..()
	handle_timer()

/datum/action/item_action/organ_action/place_spores/Trigger()
	. = ..()
	if(cooldown_timer || IS_DEAD_OR_INCAP(owner))
		to_chat(owner, "<span class='warning'>You can't do that right now!</span>")
		return
	var/obj/effect/psyphoza_spores/P = locate(/obj/effect/psyphoza_spores) in owner.loc
	if(P)
		if(P.upgrades < P.upgrade_limit && alert(owner, "Do you want to upgrade this spore deposit?", "Upgrade:", "Yes", "No") == "Yes")
			P.upgrade()
			to_chat(owner, "<span class='notice'>You upgrade the deposit.</span>")
		else
			to_chat(owner, "<span class='warning'>This deposit is already upgraded!</span>")
			return
	//Double up on dead check in-case people activate it before death
	else if(alert(owner, "Do you want to place a spore deposit here?", "Deposit:", "Yes", "No") == "Yes" && !IS_DEAD_OR_INCAP(owner))
		var/message = input(owner, "What message would you like to imprint on the deposit?", "Deposit message:") as text|null
		if(!message)
			return
		owner.log_message("made a new spore deposit with the message '[message]'", TRUE)
		message_admins("[key_name_admin(owner)] as [owner] made a new spore deposit with the message '[message]'. Located at [AREACOORD(owner)]")
		deadchat_broadcast("[owner] made a new spore deposit with the message '[message]'. Located at [AREACOORD(owner)]", owner)
		var/color = "#fff"
		if(iscarbon(owner))
			var/mob/living/carbon/M = owner
			color = M?.dna?.features["mcolor"]
		new /obj/effect/psyphoza_spores(get_turf(owner), message, color)
		to_chat(owner, "<span class='notice'>You create a deposit.</span>")
	else
		return
	cooldown_timer = addtimer(CALLBACK(src, .proc/handle_timer), cooldown, TIMER_STOPPABLE)

/datum/action/item_action/organ_action/place_spores/proc/handle_timer()
	if(cooldown_timer)
		deltimer(cooldown_timer)
	cooldown_timer = null
