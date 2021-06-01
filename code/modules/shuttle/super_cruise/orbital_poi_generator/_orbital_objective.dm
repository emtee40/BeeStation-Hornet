/datum/orbital_objective
	var/name = "Null Objective"
	var/datum/orbital_object/z_linked/beacon/ruin/linked_beacon
	var/payout = 0
	var/completed = FALSE
	var/min_payout = 0
	var/max_payout = 0

/datum/orbital_objective/proc/generate_objective_stuff(turf/chosen_turf)
	return

/datum/orbital_objective/proc/check_failed()
	return TRUE

/datum/orbital_objective/proc/get_text()
	return ""

/datum/orbital_objective/proc/announce()
	priority_announce(get_text(), "Central Command Report", SSstation.announcer.get_rand_report_sound())

/datum/orbital_objective/proc/generate_payout()
	payout = rand(min_payout, max_payout)

/datum/orbital_objective/proc/generate_attached_beacon()
	linked_beacon = new
	linked_beacon.name = "(OBJECTIVE) [linked_beacon.name]"
	linked_beacon.linked_objective = src

/datum/orbital_objective/proc/complete_objective()
	if(completed)
		//Delete
		QDEL_NULL(SSorbits.current_objective)
		return
	completed = TRUE
	//Handle payout
	SSeconomy.distribute_funds(payout)
	//Announcement
	priority_announce("Central Command priority objective completed. [payout] credits have been \
		distributed across departmental budgets.", "Central Command Report", SSstation.announcer.get_rand_report_sound())
	//Delete
	QDEL_NULL(SSorbits.current_objective)
