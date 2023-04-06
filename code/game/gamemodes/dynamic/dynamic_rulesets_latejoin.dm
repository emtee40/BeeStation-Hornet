//////////////////////////////////////////////
//                                          //
//            LATEJOIN RULESETS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/trim_candidates()
	for(var/mob/P in candidates)
		if (!P.client || !P.mind ) // Are they connected?
			candidates.Remove(P)
			continue
		if(!mode.check_age(P.client, minimum_required_age))
			candidates.Remove(P)
			continue
		if(antag_flag_override)
			if(!(antag_flag_override in P.client.prefs.be_special) || is_banned_from(P.ckey, list(BANCHECK_ROLE_MAJOR_ANTAGONIST, antag_flag_override)))
				candidates.Remove(P)
				continue
		else
			if(!(antag_flag in P.client.prefs.be_special) || is_banned_from(P.ckey, list(BANCHECK_ROLE_MAJOR_ANTAGONIST, antag_flag)))
				candidates.Remove(P)
				continue
		if (P.mind.get_special_role()) // NOTE (maybe TO-DO): this can disable all midround antag validation during valentine, or something else
			candidates.Remove(P) // if they're speical already, they might not be eligible for being more speical
			continue
		if (P.mind.has_job(restricted_roles)) // Does their job allow for it?
			candidates.Remove(P)
			continue
		if ((exclusive_roles.len > 0) && !P.mind.has_job(exclusive_roles)) // Is the rule exclusive to their job?
			candidates.Remove(P)
			continue

/datum/dynamic_ruleset/latejoin/ready(forced = 0)
	if (forced)
		return ..()

	var/job_check = 0
	if (enemy_roles.len > 0)
		for (var/mob/M in mode.current_players[CURRENT_LIVING_PLAYERS])
			if (M.stat == DEAD)
				continue // Dead players cannot count as opponents
			if (M.mind && (M.mind.has_job(enemy_roles)) && (!(M in candidates) || (M.mind.has_job(restricted_roles))))
				job_check++ // Checking for "enemies" (such as sec officers). To be counters, they must either not be candidates to that rule, or have a job that restricts them from it

	var/threat = round(mode.threat_level/10)

	if (job_check < required_enemies[threat])
		log_game("DYNAMIC: FAIL: [src] is not ready, because there are not enough enemies: [required_enemies[threat]] needed, [job_check] found")
		return FALSE

	if (mode.check_lowpop_lowimpact_injection())
		return FALSE

	return ..()

/datum/dynamic_ruleset/latejoin/execute()
	var/mob/M = pick(candidates)
	assigned += M.mind
	M.mind.add_antag_datum(antag_datum)
	return TRUE

//////////////////////////////////////////////
//                                          //
//           SYNDICATE TRAITORS             //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/infiltrator
	name = "Syndicate Infiltrator"
	antag_datum = /datum/antagonist/traitor
	antag_flag = ROLE_KEY_TRAITOR
	protected_roles = list(JOB_KEY_SECURITYOFFICER, JOB_KEY_WARDEN, JOB_KEY_HEADOFSECURITY, JOB_KEY_CAPTAIN, JOB_KEY_HEADOFPERSONNEL)
	restricted_roles = list(JOB_KEY_AI,JOB_KEY_CYBORG)
	required_candidates = 1
	weight = 7
	cost = 8
	requirements = list(5,5,5,5,5,5,5,5,5,5)
	repeatable = TRUE
	blocking_rules = list(
		/datum/dynamic_ruleset/roundstart/bloodcult,
		/datum/dynamic_ruleset/roundstart/clockcult,
		/datum/dynamic_ruleset/roundstart/nuclear,
		/datum/dynamic_ruleset/roundstart/wizard,
		/datum/dynamic_ruleset/roundstart/revs,
		/datum/dynamic_ruleset/roundstart/hivemind
	)

//////////////////////////////////////////////
//                                          //
//       REVOLUTIONARY PROVOCATEUR          //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/provocateur
	name = "Provocateur"
	persistent = TRUE
	antag_datum = /datum/antagonist/rev/head
	antag_flag = BANCHECK_ROLE_REV_HEAD
	antag_flag_override = ROLE_KEY_REVOLUTION
	restricted_roles = list(JOB_KEY_AI, JOB_KEY_CYBORG, JOB_KEY_SECURITYOFFICER, JOB_KEY_WARDEN, JOB_KEY_DETECTIVE, JOB_KEY_HEADOFSECURITY, JOB_KEY_CAPTAIN, JOB_KEY_HEADOFPERSONNEL, JOB_KEY_CHIEFENGINEER, JOB_KEY_CHIEFMEDICALOFFICER, JOB_KEY_RESEARCHDIRECTOR)
	enemy_roles = list(JOB_KEY_AI, JOB_KEY_CYBORG, JOB_KEY_SECURITYOFFICER,JOB_KEY_DETECTIVE,JOB_KEY_HEADOFSECURITY, JOB_KEY_CAPTAIN, JOB_KEY_WARDEN)
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 1
	weight = 2
	delay = 1 MINUTES // Prevents rule start while head is offstation.
	cost = 13
	requirements = list(101,101,70,40,30,20,20,20,20,20)
	flags = HIGH_IMPACT_RULESET
	blocking_rules = list(/datum/dynamic_ruleset/roundstart/revs)
	var/required_heads_of_staff = 3
	var/finished = FALSE
	/// How much threat should be injected when the revolution wins?
	var/revs_win_threat_injection = 20
	var/datum/team/revolution/revolution

/datum/dynamic_ruleset/latejoin/provocateur/ready(forced=FALSE)
	if (forced)
		required_heads_of_staff = 1
	if(!..())
		return FALSE
	var/head_check = 0
	for(var/mob/player in mode.current_players[CURRENT_LIVING_PLAYERS])
		if (player.mind.has_job(GLOB.command_positions))
			head_check++
	return (head_check >= required_heads_of_staff)

/datum/dynamic_ruleset/latejoin/provocateur/execute()
	var/mob/M = pick(candidates)	// This should contain a single player, but in case.
	if(check_eligible(M.mind))	// Didnt die/run off z-level/get implanted since leaving shuttle.
		assigned += M.mind
		revolution = new()
		var/datum/antagonist/rev/head/new_head = new()
		new_head.give_flash = TRUE
		new_head.give_hud = TRUE
		new_head.remove_clumsy = TRUE
		new_head = M.mind.add_antag_datum(new_head, revolution)
		revolution.update_objectives()
		revolution.update_heads()
		SSshuttle.registerHostileEnvironment(revolution)
		return TRUE
	else
		log_game("DYNAMIC: [ruletype] [name] discarded [M.name] from head revolutionary due to ineligibility.")
		log_game("DYNAMIC: [ruletype] [name] failed to get any eligible headrevs. Refunding [cost] threat.")
		return FALSE

/datum/dynamic_ruleset/latejoin/provocateur/rule_process()
	var/winner = revolution.process_victory(revs_win_threat_injection)
	if (isnull(winner))
		return

	finished = winner
	return RULESET_STOP_PROCESSING

/// Checks for revhead loss conditions and other antag datums.
/datum/dynamic_ruleset/latejoin/provocateur/proc/check_eligible(var/datum/mind/M)
	var/turf/T = get_turf(M.current)
	if(!considered_afk(M) && considered_alive(M) && is_station_level(T.z) && !M.antag_datums?.len && !HAS_TRAIT(M, TRAIT_MINDSHIELD))
		return TRUE
	return FALSE

/datum/dynamic_ruleset/latejoin/provocateur/round_result()
	revolution.round_result(finished)

//////////////////////////////////////////////
//                                          //
//           HERETIC SMUGGLER          		//
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/heretic_smuggler
	name = "Heretic Smuggler"
	antag_datum = /datum/antagonist/heretic
	antag_flag = ROLE_KEY_HERETIC
	protected_roles = list(JOB_KEY_SECURITYOFFICER, JOB_KEY_WARDEN, JOB_KEY_HEADOFPERSONNEL, JOB_KEY_DETECTIVE, JOB_KEY_HEADOFSECURITY, JOB_KEY_CAPTAIN)
	restricted_roles = list(JOB_KEY_AI,JOB_KEY_CYBORG)
	required_candidates = 1
	weight = 4
	cost = 10
	requirements = list(101,101,101,10,10,10,10,10,10,10)
	repeatable = TRUE
	blocking_rules = list(
		/datum/dynamic_ruleset/roundstart/bloodcult,
		/datum/dynamic_ruleset/roundstart/clockcult,
		/datum/dynamic_ruleset/roundstart/nuclear,
		/datum/dynamic_ruleset/roundstart/wizard,
		/datum/dynamic_ruleset/roundstart/revs,
		/datum/dynamic_ruleset/roundstart/hivemind
	)
