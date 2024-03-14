/datum/priority_directive/deaddrop
	name = "Secure Deaddrop"
	objective_explanation = "Secure a trackable lockbox which will unlock after 10 minutes."
	details = "We have identified a deaddrop that has been placed by a rival spy agency and have maintained an accurate track on the box. \
		You have the option to track and secure the valuable items before anyone else gets to them. The items are stored in a trackable \
		box which will automatically unlock after a set period of time."
	var/obj/item/storage/deaddrop_box/target

/datum/priority_directive/deaddrop/allocate_teams(list/uplinks, list/player_minds)
	if (length(uplinks) <= 1)
		reject()
		return
	for (var/datum/component/uplink/antag in uplinks)
		// Create individual teams
		add_antagonist_team(antag)

/datum/priority_directive/deaddrop/generate(list/uplinks, list/player_minds)
	// Spawn the deaddrop package
	var/tc_count = rand(4, 3 + length(uplinks))
	// Put the deaddrop somewhere
	var/turf/selected = get_random_station_turf()
	while (!istype(selected, /turf/open/floor/plasteel))
		selected = get_random_station_turf()
	var/atom/secret_bag = new /obj/item/storage/backpack/satchel/flat/empty(selected)
	target = new(secret_bag)
	new /obj/item/stack/sheet/telecrystal(target, tc_count)
	SEND_SIGNAL(secret_bag, COMSIG_OBJ_HIDE, selected.underfloor_accessibility < UNDERFLOOR_VISIBLE)
	// Return the reward generated
	return tc_count

/datum/priority_directive/deaddrop/finish(list/uplinks, list/player_minds)
	. = ..()
	target.unlock()

/datum/priority_directive/deaddrop/get_track_atom()
	return target
