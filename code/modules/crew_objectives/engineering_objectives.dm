/*				ENGINEERING OBJECTIVES				*/

/datum/objective/crew/integrity //ported from old Hippie
	explanation_text = "Ensure the station's integrity rating is at least (Something broke, yell on GitHub)% when the shift ends."
	jobs = "chiefengineer,stationengineer"

/datum/objective/crew/integrity/New()
	. = ..()
	target_amount = rand(60,95)
	update_explanation_text()

/datum/objective/crew/integrity/update_explanation_text()
	. = ..()
	explanation_text = "Ensure the station's integrity rating is at least [target_amount]% when the shift ends."

/datum/objective/crew/integrity/check_completion()
	var/datum/station_state/end_state = new /datum/station_state()
	end_state.count()
	var/station_integrity = min(PERCENT(GLOB.start_state.score(end_state)), 100)
	if(!SSticker.mode.station_was_nuked && station_integrity >= target_amount)
		return TRUE
	else
		return ..()

/datum/objective/crew/poly
	explanation_text = "Make sure Poly keeps his headset, and stays alive until the end of the shift."
	jobs = "chiefengineer"

/datum/objective/crew/poly/check_completion()
	for(var/mob/living/simple_animal/parrot/Poly/dumbbird in GLOB.mob_list)
		if(!(dumbbird.stat == DEAD) && dumbbird.ears)
			if(istype(dumbbird.ears, /obj/item/radio/headset))
				return TRUE
	return ..()

/datum/objective/crew/supermatter_survive
	explanation_text = "Prevent the primary Supermatter engine from fully delaminating. Additional Supermatter shards ordered from cargo do not count for this"
	jobs = "chiefengineer,stationengineer"

/datum/objective/crew/supermatter_survive/check_completion()
	if(GLOB.main_supermatter_engine)  // handy it qdel's itself
		return TRUE
	return ..()


/datum/objective/crew/apc
	explanation_text = "Make sure the station has above (something broke message us)kW in the powernet."
	jobs = "chiefengineer,stationengineer,atmospherictechnician"

/datum/objective/crew/apc/New()
	. = ..()
	target_amount = rand(100,500)  // no i dont know how much a normal amount is :>
	explanation_text = "Make sure the station has above [target_amount]kW in the powernet."

/datum/objective/crew/apc/check_completion()
	var/total_power = 0
	var/list/powermonitors = list()

	for(var/obj/machinery/computer/monitor/pMon in GLOB.machines)
		if(pMon.stat & (NOPOWER | BROKEN)) //check to make sure the computer is functional
			continue
		if(pMon.is_secret_monitor) //make sure it isn't a secret one (ie located on a ruin), allowing people to metagame that the location exists
			continue
		powermonitors += pMon

	for(var/obj/machinery/computer/monitor/pMon in powermonitors)
		var/datum/powernet/connected_powernet = pMon.get_powernet()
		total_power += connected_powernet.viewavail

	if(total_power >= target_amount)
		return TRUE
	return ..()
