/**
 * Returns FALSE if we SHOULDN'T do_teleport() with the given arguments
 *
 * Arguments:
 * * teleatom: The atom to teleport
 * * destination: The destination turf for the atom to go
 * * precision: How accurate should the teleport be (in tiles), defaults to 0
 * * channel: Which teleport channel should we use (for checks), defaults to TELEPORT_CHANNEL_BLUESPACE
 * * forced: Do we ignore atom and area TRAIT_NO_TELEPORT restrictions, defaults to FALSE
 * * teleport_mode: Teleport mode which allows ONLY clockies and abductors to teleport in their area
 */
/proc/check_teleport(atom/movable/teleatom, turf/dest_turf, channel = TELEPORT_CHANNEL_BLUESPACE, forced = FALSE, teleport_mode = TELEPORT_MODE_DEFAULT)
	var/turf/cur_turf = get_turf(teleatom)

	if(!cur_turf || !dest_turf || dest_turf.is_transition_turf())
		return FALSE

	// Check for bluespace anchors
	if(channel != TELEPORT_CHANNEL_FREE && channel != TELEPORT_CHANNEL_WORMHOLE && channel != TELEPORT_CHANNEL_GATEWAY)
		for (var/obj/machinery/bluespace_anchor/anchor as() in GLOB.active_bluespace_anchors)
			var/cur_zlevel = anchor.get_virtual_z_level()
			// Current not in range
			if(cur_zlevel != cur_turf.get_virtual_z_level() && get_dist(cur_turf, anchor) > anchor.range)
				continue
			// Destination not in range
			if(cur_zlevel != dest_turf.get_virtual_z_level() && get_dist(dest_turf, anchor) > anchor.range)
				continue
			// Try to activate the anchor, this also does the effect
			if(!anchor.try_activate())
				continue
			// We're anchored, return false
			return FALSE

	// Check for NO_TELEPORT restrictions
	if(!forced)
		var/area/cur_area = cur_turf.loc
		var/area/dest_area = dest_turf.loc
		if(HAS_TRAIT(teleatom, TRAIT_NO_TELEPORT))
			return FALSE
		if(cur_area.teleport_restriction && cur_area.teleport_restriction != teleport_mode)
			return FALSE
		if(dest_area.teleport_restriction && dest_area.teleport_restriction != teleport_mode)
			return FALSE

	// Check for intercepting the teleport
	if(SEND_SIGNAL(cur_turf, COMSIG_ATOM_INTERCEPT_TELEPORT, channel, cur_turf, dest_turf))
		return FALSE
	if(SEND_SIGNAL(dest_turf, COMSIG_ATOM_INTERCEPT_TELEPORT, channel, cur_turf, dest_turf))
		return FALSE
	if(SEND_SIGNAL(teleatom, COMSIG_ATOM_INTERCEPT_TELEPORT, channel, cur_turf, dest_turf))
		return FALSE

	// Recursively check contents to prevent cheese
	for(var/atom/thing in teleatom.GetAllContents())
		if(SEND_SIGNAL(thing, COMSIG_ATOM_INTERCEPT_TELEPORT, channel, cur_turf, dest_turf))
			return FALSE

	return TRUE

/**
 * Returns TRUE if the teleport has been successful with the given arguments
 *
 * Arguments:
 * * teleatom: The atom to teleport
 * * destination: The destination turf for the atom to go
 * * precision: How accurate should the teleport be (in tiles), defaults to 0
 * * effectin: The effect played when and where the teleport starts
 * * effectout: The effect played when and where the teleport ends up
 * * asoundin: The sound played when and where the teleport starts
 * * asoundout: The sound played when and where the teleport ends up
 * * channel: Which teleport channel should we use (for checks), defaults to TELEPORT_CHANNEL_BLUESPACE
 * * forced: Do we ignore atom and area TRAIT_NO_TELEPORT restrictions, defaults to FALSE
 * * teleport_mode: Teleport mode which allows ONLY clockies and abductors to teleport in their area, and other restrictions
 * * ignore_check_teleport: Set this to true ONLY IF you already run check_teleport()
 * * no_wake: Do not produce a teleportation wake which players can follow with a handtele
 */
/proc/do_teleport(atom/movable/teleatom, atom/destination, precision = null, datum/effect_system/effectin = null, datum/effect_system/effectout = null, asoundin = null, asoundout = null, no_effects = FALSE, channel = TELEPORT_CHANNEL_BLUESPACE, forced = FALSE, teleport_mode = TELEPORT_MODE_DEFAULT, ignore_check_teleport = FALSE, no_wake = FALSE)
	// teleporting most effects just deletes them
	var/static/list/delete_atoms = typecacheof(list(
		/obj/effect,
		)) - typecacheof(list(
		/obj/effect/dummy/chameleon,
		/obj/effect/wisp,
		/obj/effect/mob_spawn,
		/obj/effect/warp_cube,
		/obj/effect/extraction_holder,
		))
	if(delete_atoms[teleatom.type])
		qdel(teleatom)
		return FALSE

	// argument handling
	// if the precision is not specified, default to 0, but apply BoH penalties
	if (isnull(precision))
		precision = 0
	switch(channel)
		if(TELEPORT_CHANNEL_BLUESPACE)
			if(istype(teleatom, /obj/item/storage/backpack/holding))
				precision = rand(1,100)

			var/static/list/bag_cache = typecacheof(/obj/item/storage/backpack/holding)
			var/list/bagholding = typecache_filter_list(teleatom.GetAllContents(), bag_cache)
			if(bagholding.len)
				precision = max(rand(1,100)*bagholding.len,100)
				if(isliving(teleatom))
					var/mob/living/MM = teleatom
					to_chat(MM, "<span class='warning'>The bluespace interface on your bag of holding interferes with the teleport!</span>")

	// if effects are not specified and not explicitly disabled, sparks
	if ((!effectin || !effectout) && !no_effects)
		var/datum/effect_system/spark_spread/sparks = new
		sparks.set_up(5, 1, teleatom)
		if (!effectin)
			effectin = sparks
		if (!effectout)
			effectout = sparks

	// perform the teleport
	var/turf/cur_turf = get_turf(teleatom)
	var/turf/dest_turf = get_teleport_turf(get_turf(destination), precision)

	// ghosts get a free pass
	if(isobserver(teleatom))
		teleatom.abstract_move(dest_turf)
		return TRUE

	if(!ignore_check_teleport) // If we've already done it let's not check again
		if(!check_teleport(teleatom, dest_turf, channel, forced, teleport_mode))
			return FALSE

	teleport_play_specials(teleatom, cur_turf, effectin, asoundin)

	// Actually teleport them
	var/success = teleatom.forceMove(dest_turf)
	if (!success)
		return FALSE

	log_game("[key_name(teleatom)] has teleported from [loc_name(cur_turf)] to [loc_name(dest_turf)]")
	teleport_play_specials(teleatom, dest_turf, effectout, asoundout)

	// If we leave behind a wake, then create that here.
	// Only leave a wake if we are going to a location that we can actually teleport to.
	if(!no_wake && (channel == TELEPORT_CHANNEL_BLUESPACE || channel == TELEPORT_CHANNEL_CULT || channel == TELEPORT_CHANNEL_MAGIC))
		var/area/cur_area = cur_turf.loc
		var/area/dest_area = dest_turf.loc
		if(cur_area.teleport_restriction == TELEPORT_MODE_DEFAULT && dest_area.teleport_restriction == TELEPORT_MODE_DEFAULT && teleport_mode == TELEPORT_MODE_DEFAULT)
			new /obj/effect/temp_visual/teleportation_wake(cur_turf, dest_turf)

	if(ismegafauna(teleatom))
		message_admins("[teleatom] [ADMIN_FLW(teleatom)] has teleported from [ADMIN_VERBOSEJMP(cur_turf)] to [ADMIN_VERBOSEJMP(dest_turf)].")

	if(ismob(teleatom))
		var/mob/M = teleatom
		M.cancel_camera()

	SEND_SIGNAL(teleatom, COMSIG_ATOM_TELEPORT_ACT)

	return TRUE

/proc/teleport_play_specials(atom/movable/teleatom, turf/location, datum/effect_system/effect, sound)
	if(isobserver(teleatom))
		return
	if(sound)
		playsound(location, sound, 60, 1)
	if(effect)
		effect.attach(location)
		effect.start()

// Safe location finder
/proc/find_safe_turf(zlevel, list/zlevels, extended_safety_checks = FALSE, dense_atoms = TRUE)
	if(!zlevels)
		if (zlevel)
			zlevels = list(zlevel)
		else
			zlevels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	var/cycles = 1000
	for(var/cycle in 1 to cycles)
		// DRUNK DIALLING WOOOOOOOOO
		var/x = rand(1, world.maxx)
		var/y = rand(1, world.maxy)
		var/z = pick(zlevels)
		var/random_location = locate(x,y,z)

		if(!isfloorturf(random_location))
			continue
		var/turf/open/floor/F = random_location
		if(!F.air)
			continue

		var/datum/gas_mixture/A = F.air
		var/trace_gases
		for(var/id in A.get_gases())
			if(id in GLOB.hardcoded_gases)
				continue
			trace_gases = TRUE
			break

		// Can most things breathe?
		if(trace_gases)
			continue
		if(A.get_moles(GAS_O2) < 16)
			continue
		if(A.get_moles(GAS_PLASMA))
			continue
		if(A.get_moles(GAS_CO2) >= 10)
			continue

		// Aim for goldilocks temperatures and pressure
		if((A.return_temperature() <= 270) || (A.return_temperature() >= 360))
			continue
		var/pressure = A.return_pressure()
		if((pressure <= 20) || (pressure >= 550))
			continue

		if(extended_safety_checks)
			if(islava(F)) //chasms aren't /floor, and so are pre-filtered
				var/turf/open/lava/L = F
				if(!L.is_safe())
					continue

		// Check that we're not warping onto a table or window
		if(!dense_atoms)
			var/density_found = FALSE
			for(var/atom/movable/found_movable in F)
				if(found_movable.density)
					density_found = TRUE
					break
			if(density_found)
				continue

		// DING! You have passed the gauntlet, and are "probably" safe.
		return F

/proc/get_teleport_turfs(turf/center, precision = 0)
	if(!precision)
		return list(center)
	//Return only open turfs unless none are available
	var/list/safe_turfs = list()
	var/list/posturfs = list()
	for(var/turf/T as() in RANGE_TURFS(precision, center))
		if(T.is_transition_turf())
			continue // Avoid picking these.
		var/area/A = T.loc
		if(!A.teleport_restriction)
			posturfs.Add(T)
			if(isopenturf(T))
				safe_turfs += T
	if(length(safe_turfs))
		return safe_turfs
	return posturfs

/proc/get_teleport_turf(turf/center, precision = 0)
	return safepick(get_teleport_turfs(center, precision))

/proc/wizarditis_teleport(mob/living/carbon/affected_mob)
	var/list/theareas = get_areas_in_range(80, affected_mob)
	for(var/area/space/S in theareas)
		theareas -= S

	if(!length(theareas))
		return

	var/area/thearea = pick(theareas)

	var/list/L = list()
	for(var/turf/T in get_area_turfs(thearea.type))
		if(T.get_virtual_z_level() != affected_mob.get_virtual_z_level())
			continue
		if(isspaceturf(T))
			continue
		if(T.density)
			continue

		var/clear = TRUE
		for(var/obj/O in T)
			if(O.density)
				clear = FALSE
				break
		if(clear)
			L+=T

	if(!L)
		return

	if(do_teleport(affected_mob, pick(L), channel = TELEPORT_CHANNEL_MAGIC, no_effects = TRUE))
		affected_mob.say("SCYAR NILA [uppertext(thearea.name)]!", forced = "wizarditis teleport")

// This is here because I believe it makes the most sense here.
/mob/living/proc/handle_teleport_interception(datum/source, channel, turf/origin, turf/destination)
	SIGNAL_HANDLER

	if(channel != TELEPORT_CHANNEL_GATEWAY)
		return

	//Checking that there is an exile implant
	if(!isnull(implants))
		for(var/obj/item/implant/exile/E in implants)
			visible_message("<span class='warning'>The portal rejects [src]!</span>", "<span class='warning'>The portal has detected your exile implant and is blocking your entry!</span>")
			return COMPONENT_BLOCK_TELEPORT

	// Ashwalker check
	if(is_species(src, /datum/species/lizard/ashwalker))
		visible_message("<span class='warning'>The portal rejects [src]!</span>", "<span class='warning'>The portal has blocked your entry!</span>")
		return COMPONENT_BLOCK_TELEPORT

	return

/obj/effect/temp_visual/teleportation_wake
	name = "slipspace wake"
	duration = 30 SECONDS
	randomdir = FALSE
	icon = 'icons/effects/effects.dmi'
	icon_state = null
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	hud_possible = list(DIAG_WAKE_HUD)
	var/turf/destination
	var/has_hud_icon = FALSE

/obj/effect/temp_visual/teleportation_wake/Initialize(mapload, turf/destination)
	// Replace any portals on the current turf
	for (var/obj/effect/temp_visual/teleportation_wake/conflicting_portal in loc)
		if (conflicting_portal == src)
			continue
		conflicting_portal.destination = destination
		return INITIALIZE_HINT_QDEL
	. = ..()
	src.destination = destination
	prepare_huds()
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_to_hud(src)
	var/image/holder = hud_list[DIAG_WAKE_HUD]
	var/mutable_appearance/MA = new /mutable_appearance()
	MA.icon = 'icons/effects/effects.dmi'
	MA.icon_state = "bluestream"
	MA.layer = ABOVE_OPEN_TURF_LAYER
	MA.plane = GAME_PLANE
	holder.appearance = MA
	has_hud_icon = TRUE

/obj/effect/temp_visual/teleportation_wake/Destroy()
	if (has_hud_icon)
		for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
			diag_hud.remove_from_hud(src)
	return ..()

/obj/effect/temp_visual/portal_opening
	name = "Portal Opening"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "portal"
	alpha = 0
	duration = 11 SECONDS

/obj/effect/temp_visual/portal_opening/Initialize(mapload)
	. = ..()
	transform = matrix() * 0
	animate(src, time = 10 SECONDS, transform = matrix(), alpha = 255)
	animate(time = 0.5 SECONDS, transform = matrix() * 0, alpha = 0)
