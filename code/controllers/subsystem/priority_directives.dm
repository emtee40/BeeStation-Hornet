SUBSYSTEM_DEF(directives)
	name = "Priority Directives"
	wait = 10 SECONDS
	var/datum/priority_directive/active_directive = null
	var/next_directive_time
	var/list/directives = list()

/datum/controller/subsystem/directives/Initialize(start_timeofday)
	. = ..()
	next_directive_time = world.time + rand(20 MINUTES, 30 MINUTES)
	for (var/directive_type in subtypesof(/datum/priority_directive))
		directives += new directive_type()

/datum/controller/subsystem/directives/fire(resumed)
	if (active_directive)
		// Are we completed or ended?
		if (active_directive.is_completed() || world.time > active_directive.end_at)
			active_directive.finish()
		return
	// Check if we are ready to spawn our next active_directive
	if (world.time < next_directive_time)
		return
	// Find all the antags
	var/list/antag_datums = list()
	for (var/mob/antag in GLOB.alive_mob_list)
		var/datum/component/uplink/uplink = antag.mind.find_syndicate_uplink()
		if (!uplink || length(antag.mind.antag_datums) == 0)
			continue
		antag_datums += antag.mind.antag_datums[1]
	// Find all the minds
	var/list/player_minds = list()
	for (var/mob/player in GLOB.alive_mob_list)
		if (!ishuman(player) || !is_station_level(player.z) || !player.mind)
			continue
		player_minds += player.mind
	// Bring on the mission
	var/list/valid_directives = list()
	for (var/datum/priority_directive/directive in directives)
		if (!directive.check(antag_datums, player_minds))
			continue
		valid_directives += directive
	if (!length(valid_directives))
		// Try again in a minute
		next_directive_time = world.time + 1 MINUTES
		return
	var/datum/priority_directive/selected = pick(valid_directives)
	selected.generate(antag_datums, player_minds)
	next_directive_time = INFINITY
	active_directive = selected

/datum/controller/subsystem/directives/proc/get_uplink_data(datum/component/uplink/uplink)
	var/data = list()
	data["time"] = world.time
	var/atom/uplink_owner = uplink.parent
	if (istype(uplink_owner))
		data["pos_x"] = uplink_owner?.x
		data["pos_y"] = uplink_owner?.y
		data["pos_z"] = uplink_owner?.z
	// The uplink can only detect syndicate assigned objectives of the owner
	if (uplink.owner)
		var/list/known_objectives = list()
		for (var/datum/antagonist/antagonist_type in uplink.owner.antag_datums)
			// The syndicate uplink is only aware of syndicate-given objectives.
			if (antagonist_type.faction != FACTION_SYNDICATE)
				continue
			for (var/datum/objective/objective in antagonist_type.objectives)
				var/atom/tracking_target = objective.get_tracking_target(uplink_owner)
				known_objectives += list(list(
					"name" = objective.name,
					"tasks" = list(objective.explanation_text),
					"track_x" = tracking_target?.x,
					"track_y" = tracking_target?.y,
					"track_z" = tracking_target?.z,
				))
		// Add the priority directive
		if (active_directive)
			known_objectives += list(list(
				"name" = active_directive.name,
				"tasks" = list(active_directive.objective_explanation),
				"time" = active_directive.end_at,
				"details" = active_directive.details,
				"reward" = active_directive.tc_reward
			))
		data["objectives"] =  known_objectives
	return data
