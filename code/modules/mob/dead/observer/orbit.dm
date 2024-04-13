/datum/orbit_menu
	var/mob/dead/observer/owner

/datum/orbit_menu/New(mob/dead/observer/new_owner)
	if(!istype(new_owner))
		qdel(src)
	owner = new_owner


/datum/orbit_menu/ui_state(mob/user)
	return GLOB.observer_state

/datum/orbit_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Orbit", "Orbit")
		ui.open()
		ui.set_autoupdate(TRUE)

/datum/orbit_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if (..())
		return

	if (action == "orbit")
		var/ref = params["ref"]
		var/atom/movable/poi = (locate(ref) in GLOB.mob_list) || (locate(ref) in GLOB.poi_list)
		if (poi != null)
			owner.check_orbitable(poi)
		else
			return TRUE

/datum/orbit_menu/ui_data(mob/user)
	var/list/data = list()

	var/list/alive = list()
	var/list/antagonists = list()
	var/list/dead = list()
	var/list/ghosts = list()
	var/list/misc = list()
	var/list/npcs = list()

	var/list/pois = getpois(skip_mindless = 1)
	for (var/name in pois)
		var/list/serialized = list()
		serialized["name"] = name

		var/poi = pois[name]

		serialized["ref"] = REF(poi)

		var/mob/M = poi
		if (istype(M))
			if (isobserver(M))
				ghosts += list(serialized)
			else if (M.stat == DEAD)
				dead += list(serialized)
			else if (M.mind == null)
				npcs += list(serialized)
			else
				var/number_of_orbiters = M.orbit_datum?.current_orbiters?.len
				if (number_of_orbiters)
					serialized["orbiters"] = number_of_orbiters

				var/datum/mind/mind = M.mind
				var/was_antagonist = FALSE

				//If we have an ID, use that
				var/obj/item/card/id/identification_card = M.get_idcard()
				if (identification_card)
					serialized["role_icon"] = "hud[ckey(identification_card.GetJobIcon())]"
				else if(SSjob.name_occupations[mind.assigned_role])
					//If we have no ID, use the mind job
					var/located_job_hud = get_hud_by_jobname(mind.assigned_role, returns_unknown=FALSE)
					if (located_job_hud)
						serialized["role_icon"] = "hud[ckey(located_job_hud)]"

				for (var/_A in mind.antag_datums)
					var/datum/antagonist/A = _A
					if (A.show_to_ghosts)
						was_antagonist = TRUE
						var/datum/team/antag_team = A.get_team()
						if(antag_team)
							serialized["antag"] = antag_team.get_team_name()
						else
							serialized["antag"] = A.get_antag_name()
						if(mind.antag_hud_icon_state)
							serialized["antag_icon"] = mind.antag_hud_icon_state
						antagonists += list(serialized)
						break

				if (!was_antagonist)
					alive += list(serialized)
		else
			misc += list(serialized)

	data["alive"] = alive
	data["antagonists"] = antagonists
	data["dead"] = dead
	data["ghosts"] = ghosts
	data["misc"] = misc
	data["npcs"] = npcs

	return data

/datum/orbit_menu/ui_assets()
	return list(
		get_asset_datum(/datum/asset/simple/orbit),
		get_asset_datum(/datum/asset/spritesheet_batched/job_icons),
		get_asset_datum(/datum/asset/spritesheet_batched/antag_hud)
	)

/datum/asset/spritesheet_batched/job_icons
	name = "job-icon"

/datum/asset/spritesheet_batched/job_icons/create_spritesheets()
	var/datum/icon_transformer/transform = new()
	// Get the job hud part
	transform.crop(1, 17, 8, 24)
	// Scale it up
	transform.scale(16, 16)

	for (var/icon_state_name in icon_states('icons/mob/hud.dmi'))
		insert_icon("job-icon-[icon_state_name]", uni_icon('icons/mob/hud.dmi', icon_state_name, transform=transform))
