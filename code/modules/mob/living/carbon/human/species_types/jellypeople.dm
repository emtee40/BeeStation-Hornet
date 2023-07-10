
////////////////////////////////////////////////////////SLIMEPEOPLE///////////////////////////////////////////////////////////////////

//Slime people are able to split like slimes, retaining a single mind that can swap between bodies at will, even after death.

/datum/species/oozeling/slime
	name = "Slimeperson"
	id = SPECIES_SLIMEPERSON
	default_color = "00FFFF"
	species_traits = list(MUTCOLORS,EYECOLOR,HAIR,FACEHAIR,NOBLOOD)
	hair_color = "mutcolor"
	hair_alpha = 150
	var/datum/action/innate/split_body/slime_split
	var/list/mob/living/carbon/bodies
	var/datum/action/innate/swap_body/swap_body

	species_chest = /obj/item/bodypart/chest/slime
	species_head = /obj/item/bodypart/head/slime
	species_l_arm = /obj/item/bodypart/l_arm/slime
	species_r_arm = /obj/item/bodypart/r_arm/slime
	species_l_leg = /obj/item/bodypart/l_leg/slime
	species_r_leg = /obj/item/bodypart/r_leg/slime


/datum/species/oozeling/slime/on_species_loss(mob/living/carbon/C)
	if(slime_split)
		slime_split.Remove(C)
	if(swap_body)
		swap_body.Remove(C)
	bodies -= C // This means that the other bodies maintain a link
	// so if someone mindswapped into them, they'd still be shared.
	bodies = null
	C.blood_volume = min(C.blood_volume, BLOOD_VOLUME_NORMAL)
	..()

/datum/species/oozeling/slime/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	if(ishuman(C))
		slime_split = new
		slime_split.Grant(C)
		swap_body = new
		swap_body.Grant(C)

		if(!bodies || !bodies.len)
			bodies = list(C)
		else
			bodies |= C

/datum/species/oozeling/slime/spec_death(gibbed, mob/living/carbon/human/H)
	if(slime_split)
		if(!H.mind || !H.mind.active)
			return

		var/list/available_bodies = (bodies - H)
		for(var/mob/living/L in available_bodies)
			if(!swap_body.can_swap(L))
				available_bodies -= L

		if(!LAZYLEN(available_bodies))
			return

		swap_body.swap_to_dupe(H.mind, pick(available_bodies))

//If you're cloned you get your body pool back
/datum/species/oozeling/slime/copy_properties_from(datum/species/oozeling/slime/old_species)
	bodies = old_species.bodies

/datum/species/oozeling/slime/spec_life(mob/living/carbon/human/H)
	if(H.blood_volume >= BLOOD_VOLUME_SLIME_SPLIT)
		if(prob(5))
			to_chat(H, "<span class='notice'>You feel very bloated!</span>")
	else if(H.nutrition >= NUTRITION_LEVEL_WELL_FED)
		H.blood_volume += 3
		H.adjust_nutrition(-2.5)

	..()

/datum/action/innate/split_body
	name = "Split Body"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimesplit"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/split_body/IsAvailable()
	if(..())
		var/mob/living/carbon/human/H = owner
		if(H.blood_volume >= BLOOD_VOLUME_SLIME_SPLIT)
			return 1
		return 0

/datum/action/innate/split_body/Activate()
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(H))
		return
	CHECK_DNA_AND_SPECIES(H)

	//Prevent one person from creating 100 bodies.
	var/datum/species/oozeling/slime/species = H.dna.species
	if(length(species.bodies) > CONFIG_GET(number/max_slimeperson_bodies))
		to_chat(H, "<span class='warning'>Your mind is spread too thin! You have too many bodies already.</span>")
		return

	H.visible_message("<span class='notice'>[owner] gains a look of \
		concentration while standing perfectly still.</span>",
		"<span class='notice'>You focus intently on moving your body while \
		standing perfectly still...</span>")

	H.notransform = TRUE

	if(do_after(owner, delay=60, target=owner, progress=TRUE, timed_action_flags = IGNORE_HELD_ITEM))
		if(H.blood_volume >= BLOOD_VOLUME_SLIME_SPLIT)
			make_dupe()
		else
			to_chat(H, "<span class='warning'>...but there is not enough of you to go around! You must attain more mass to split!</span>")
	else
		to_chat(H, "<span class='warning'>...but fail to stand perfectly still!</span>")

	H.notransform = FALSE

/datum/action/innate/split_body/proc/make_dupe()
	var/mob/living/carbon/human/H = owner
	CHECK_DNA_AND_SPECIES(H)

	var/mob/living/carbon/human/spare = new /mob/living/carbon/human(H.loc)

	spare.underwear = "Nude"
	H.dna.transfer_identity(spare, transfer_SE=1)
	spare.dna.features["mcolor"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	spare.real_name = spare.dna.real_name
	spare.name = spare.dna.real_name
	spare.updateappearance(mutcolor_update=1)
	spare.domutcheck()
	spare.Move(get_step(H.loc, pick(NORTH,SOUTH,EAST,WEST)))

	var/datum/component/nanites/owner_nanites = H.GetComponent(/datum/component/nanites)
	if(owner_nanites)
		//copying over nanite programs/cloud sync with 50% saturation in host and spare
		owner_nanites.nanite_volume *= 0.5
		spare.AddComponent(/datum/component/nanites, owner_nanites.nanite_volume)
		SEND_SIGNAL(spare, COMSIG_NANITE_SYNC, owner_nanites, TRUE, TRUE, TRUE) //The trues are to copy activation as well

	H.blood_volume *= 0.45
	H.notransform = 0

	var/datum/species/oozeling/slime/origin_datum = H.dna.species
	origin_datum.bodies |= spare

	var/datum/species/oozeling/slime/spare_datum = spare.dna.species
	spare_datum.bodies = origin_datum.bodies

	H.mind.transfer_to(spare)
	spare.visible_message("<span class='warning'>[H] distorts as a new body \
		\"steps out\" of [H.p_them()].</span>",
		"<span class='notice'>...and after a moment of disorentation, \
		you're besides yourself!</span>")


/datum/action/innate/swap_body
	name = "Swap Body"
	check_flags = NONE
	button_icon_state = "slimeswap"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/swap_body/Activate()
	if(!isslimeperson(owner))
		to_chat(owner, "<span class='warning'>You are not a slimeperson.</span>")
		Remove(owner)
	else
		ui_interact(owner)


/datum/action/innate/swap_body/ui_state(mob/user)
	return GLOB.always_state

/datum/action/innate/swap_body/ui_interact(mob/user, datum/tgui/ui)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SlimeBodySwapper")
		ui.open()
		ui.set_autoupdate(TRUE) // Body status (health, occupied, etc.)

/datum/action/innate/swap_body/ui_data(mob/user)
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(H))
		return

	var/datum/species/oozeling/slime/SS = H.dna.species

	var/list/data = list()
	data["bodies"] = list()
	for(var/b in SS.bodies)
		var/mob/living/carbon/human/body = b
		if(!body || QDELETED(body) || !isslimeperson(body))
			SS.bodies -= b
			continue

		var/list/L = list()
		// HTML colors need a # prefix
		L["htmlcolor"] = "#[body.dna.features["mcolor"]]"
		L["area"] = get_area_name(body, TRUE)
		var/stat = "error"
		switch(body.stat)
			if(CONSCIOUS)
				stat = "Conscious"
			if(UNCONSCIOUS)
				stat = "Unconscious"
			if(DEAD)
				stat = "Dead"
		var/occupied
		if(body == H)
			occupied = "owner"
		else if(body.mind && body.mind.active)
			occupied = "stranger"
		else
			occupied = "available"

		L["status"] = stat
		L["exoticblood"] = body.blood_volume
		L["name"] = body.name
		L["ref"] = "[REF(body)]"
		L["occupied"] = occupied
		var/button
		if(occupied == "owner")
			button = "selected"
		else if(occupied == "stranger")
			button = "danger"
		else if(can_swap(body))
			button = null
		else
			button = "disabled"

		L["swap_button_state"] = button
		L["swappable"] = (occupied == "available") && can_swap(body)

		data["bodies"] += list(L)

	return data

/datum/action/innate/swap_body/ui_act(action, params)
	if(..())
		return
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(owner))
		return
	if(!H.mind || !H.mind.active)
		return
	switch(action)
		if("swap")
			var/datum/species/oozeling/slime/SS = H.dna.species
			var/mob/living/carbon/human/selected = locate(params["ref"]) in SS.bodies
			if(!can_swap(selected))
				return
			SStgui.close_uis(src)
			swap_to_dupe(H.mind, selected)

/datum/action/innate/swap_body/proc/can_swap(mob/living/carbon/human/dupe)
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(H))
		return FALSE
	var/datum/species/oozeling/slime/SS = H.dna.species

	if(QDELETED(dupe)) 					//Is there a body?
		SS.bodies -= dupe
		return FALSE

	if(!isslimeperson(dupe)) 			//Is it a slimeperson?
		SS.bodies -= dupe
		return FALSE

	if(dupe.stat == DEAD) 				//Is it alive?
		return FALSE

	if(dupe.stat != CONSCIOUS) 			//Is it awake?
		return FALSE

	if(dupe.mind && dupe.mind.active) 	//Is it unoccupied?
		return FALSE

	if(!(dupe in SS.bodies))			//Do we actually own it?
		return FALSE

	return TRUE

/datum/action/innate/swap_body/proc/swap_to_dupe(datum/mind/M, mob/living/carbon/human/dupe)
	if(!can_swap(dupe)) //sanity check
		return
	if(M.current.stat == CONSCIOUS)
		M.current.visible_message("<span class='notice'>[M.current] \
			stops moving and starts staring vacantly into space.</span>",
			"<span class='notice'>You stop moving this body...</span>")
	else
		to_chat(M.current, "<span class='notice'>You abandon this body...</span>")
	M.transfer_to(dupe)
	dupe.visible_message("<span class='notice'>[dupe] blinks and looks \
		around.</span>",
		"<span class='notice'>...and move this one instead.</span>")


///////////////////////////////////LUMINESCENTS//////////////////////////////////////////

//Luminescents are able to consume and use slime extracts, without them decaying.

/datum/species/oozeling/luminescent
	name = "Luminescent"
	id = SPECIES_LUMINESCENT
	var/glow_intensity = LUMINESCENT_DEFAULT_GLOW
	var/obj/effect/dummy/luminescent_glow/glow
	var/obj/item/slime_extract/current_extract
	var/datum/action/innate/integrate_extract/integrate_extract
	var/datum/action/innate/use_extract/extract_minor
	var/datum/action/innate/use_extract/major/extract_major
	var/extract_cooldown = 0

	examine_limb_id = SPECIES_OOZELING

//Species datums don't normally implement destroy, but JELLIES SUCK ASS OUT OF A STEEL STRAW
/datum/species/oozeling/luminescent/Destroy(force, ...)
	current_extract = null
	QDEL_NULL(glow)
	QDEL_NULL(integrate_extract)
	QDEL_NULL(extract_major)
	QDEL_NULL(extract_minor)
	return ..()


/datum/species/oozeling/luminescent/on_species_loss(mob/living/carbon/C)
	..()
	if(current_extract)
		current_extract.forceMove(C.drop_location())
		current_extract = null
	QDEL_NULL(glow)
	QDEL_NULL(integrate_extract)
	QDEL_NULL(extract_major)
	QDEL_NULL(extract_minor)

/datum/species/oozeling/luminescent/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	glow = new(C)
	update_glow(C)
	integrate_extract = new(src)
	integrate_extract.Grant(C)
	extract_minor = new(src)
	extract_minor.Grant(C)
	extract_major = new(src)
	extract_major.Grant(C)

/datum/species/oozeling/luminescent/proc/update_slime_actions()
	integrate_extract.update_name()
	integrate_extract.UpdateButtonIcon()
	extract_minor.UpdateButtonIcon()
	extract_major.UpdateButtonIcon()

/datum/species/oozeling/luminescent/proc/update_glow(mob/living/carbon/C, intensity)
	if(intensity)
		glow_intensity = intensity
	glow.set_light(glow_intensity, glow_intensity, C.dna.features["mcolor"])

/obj/effect/dummy/luminescent_glow
	name = "luminescent glow"
	desc = "Tell a coder if you're seeing this."
	icon_state = "nothing"
	light_color = "#FFFFFF"
	light_range = LUMINESCENT_DEFAULT_GLOW
	light_system = MOVABLE_LIGHT
	light_power = 2.5

/obj/effect/dummy/luminescent_glow/Initialize(mapload)
	. = ..()
	if(!isliving(loc))
		return INITIALIZE_HINT_QDEL


/datum/action/innate/integrate_extract
	name = "Integrate Extract"
	desc = "Eat a slime extract to use its properties."
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimeconsume"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/integrate_extract/proc/update_name()
	var/datum/species/oozeling/luminescent/species = target
	if(!species || !species.current_extract)
		name = "Integrate Extract"
		desc = "Eat a slime extract to use its properties."
	else
		name = "Eject Extract"
		desc = "Eject your current slime extract."

/datum/action/innate/integrate_extract/UpdateButtonIcon(status_only, force)
	var/datum/species/oozeling/luminescent/species = target
	if(!species || !species.current_extract)
		button_icon_state = "slimeconsume"
	else
		button_icon_state = "slimeeject"
	..()

/datum/action/innate/integrate_extract/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force)
	..(current_button, TRUE)
	var/datum/species/oozeling/luminescent/species = target
	if(species?.current_extract)
		current_button.add_overlay(mutable_appearance(species.current_extract.icon, species.current_extract.icon_state))

/datum/action/innate/integrate_extract/Activate()
	var/mob/living/carbon/human/H = owner
	var/datum/species/oozeling/luminescent/species = target
	if(!is_species(H, /datum/species/oozeling/luminescent) || !species)
		return
	CHECK_DNA_AND_SPECIES(H)

	if(species.current_extract)
		var/obj/item/slime_extract/S = species.current_extract
		if(!H.put_in_active_hand(S))
			S.forceMove(H.drop_location())
		species.current_extract = null
		to_chat(H, "<span class='notice'>You eject [S].</span>")
		species.update_slime_actions()
	else
		var/obj/item/I = H.get_active_held_item()
		if(istype(I, /obj/item/slime_extract))
			var/obj/item/slime_extract/S = I
			if(!S.Uses)
				to_chat(H, "<span class='warning'>[I] is spent! You cannot integrate it.</span>")
				return
			if(!H.temporarilyRemoveItemFromInventory(S))
				return
			S.forceMove(H)
			species.current_extract = S
			to_chat(H, "<span class='notice'>You consume [I], and you feel it pulse within you...</span>")
			species.update_slime_actions()
		else
			to_chat(H, "<span class='warning'>You need to hold an unused slime extract in your active hand!</span>")

/datum/action/innate/use_extract
	name = "Extract Minor Activation"
	desc = "Pulse the slime extract with energized jelly to activate it."
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimeuse1"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"
	var/activation_type = SLIME_ACTIVATE_MINOR

/datum/action/innate/use_extract/IsAvailable()
	if(..())
		var/datum/species/oozeling/luminescent/species = target
		if(species && species.current_extract && (world.time > species.extract_cooldown))
			return TRUE
		return FALSE

/datum/action/innate/use_extract/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force)
	..(current_button, TRUE)
	var/mob/living/carbon/human/H = owner
	var/datum/species/oozeling/luminescent/species = H.dna.species
	if(species && species.current_extract)
		current_button.add_overlay(mutable_appearance(species.current_extract.icon, species.current_extract.icon_state))

/datum/action/innate/use_extract/Activate()
	var/mob/living/carbon/human/H = owner
	CHECK_DNA_AND_SPECIES(H)
	var/datum/species/oozeling/luminescent/species = H.dna.species
	if(!is_species(H, /datum/species/oozeling/luminescent) || !species)
		return

	if(species.current_extract)
		species.extract_cooldown = world.time + 10 SECONDS
		var/cooldown = species.current_extract.activate(H, species, activation_type)
		species.extract_cooldown = world.time + cooldown

/datum/action/innate/use_extract/major
	name = "Extract Major Activation"
	desc = "Pulse the slime extract with plasma jelly to activate it."
	button_icon_state = "slimeuse2"
	activation_type = SLIME_ACTIVATE_MAJOR

///////////////////////////////////STARGAZERS//////////////////////////////////////////

//Stargazers are the telepathic branch of jellypeople, able to project psychic messages and to link minds with willing participants.

/// A global list of what mind is linked with what stargazer.
/// Does not include the host stargazer.
/// [/datum/mind] = /datum/weakref -> /datum/species/oozeling/stargazer
GLOBAL_LIST_EMPTY(slime_links_by_mind)

/datum/species/oozeling/stargazer
	name = "Stargazer"
	id = SPECIES_STARGAZER
	examine_limb_id = SPECIES_OOZELING
	/// The stargazer's telepathy ability.
	var/datum/action/innate/project_thought/project_thought
	/// The stargazer's mind linking ability.
	var/datum/action/innate/link_minds/link_minds
	/// The stargazer's linked speech ability.
	var/datum/action/innate/linked_speech/linked_speech
	/// A full list of all minds linked to this stargazer's slime link.
	var/list/datum/mind/linked_minds = list()
	/// A full list of all actions linked to this stargazer's slime link.
	var/list/datum/action/innate/linked_speech/linked_actions = list()
	/// A weak reference to the body of the owner of the slime link.
	var/datum/weakref/slimelink_owner


//Species datums don't normally implement destroy, but JELLIES SUCK ASS OUT OF A STEEL STRAW
/datum/species/oozeling/stargazer/Destroy()
	for(var/datum/mind/link_to_clear as anything in linked_minds)
		unlink_mind(link_to_clear)
	linked_minds.Cut()
	QDEL_NULL(project_thought)
	QDEL_NULL(link_minds)
	QDEL_NULL(linked_speech)
	QDEL_LIST(linked_actions)
	slimelink_owner = null
	return ..()

/datum/species/oozeling/stargazer/on_species_gain(mob/living/carbon/body, datum/species/old_species)
	. = ..()
	project_thought = new(src)
	project_thought.Grant(body)
	link_minds = new(src)
	link_minds.Grant(body)
	linked_speech = new(src)
	linked_speech.Grant(body)
	slimelink_owner = WEAKREF(body)
	to_chat(body, "<span class='big notice'>You can use :[MODE_KEY_SLIMELINK] or .[MODE_KEY_SLIMELINK] to talk over your slime link!</span>")
	register_mob_signals(body)

/datum/species/oozeling/stargazer/on_species_loss(mob/living/carbon/body)
	..()
	for(var/datum/mind/link_to_clear as anything in linked_minds)
		unlink_mind(link_to_clear)
	if(project_thought)
		QDEL_NULL(project_thought)
	if(link_minds)
		QDEL_NULL(link_minds)
	slimelink_owner = null
	UnregisterSignal(body, COMSIG_MOB_LOGIN)

/datum/species/oozeling/stargazer/spec_death(gibbed, mob/living/carbon/human/body)
	. = ..()
	for(var/datum/mind/link_to_clear as anything in linked_minds)
		unlink_mind(link_to_clear)

/**
 * Notify a slime link member on login that they can use the slime link saymode.
 */
/datum/species/oozeling/stargazer/proc/login_notify()
	SIGNAL_HANDLER
	var/mob/living/user = usr
	if(!user || !istype(user))
		return
	to_chat(user, "<span class='big notice'>You can use :[MODE_KEY_SLIMELINK] or .[MODE_KEY_SLIMELINK] to talk over the slime link!</span>")

/**
 * Handle whenever a slime link member has their mind transferred, transferring the link to the new body.
 *
 * Arguments
 * * source_mind: The mind that was transferred.
 * * old_body: The body that the mind was transferred from.
 * * new_body: The body that the mind was transferred into.
 */
/datum/species/oozeling/stargazer/proc/mind_transfer(datum/mind/source_mind, mob/old_body, mob/new_body)
	SIGNAL_HANDLER
	var/link_id = linked_minds.Find(source_mind)
	if(!link_id)
		return
	var/datum/action/innate/linked_speech/action = linked_actions[link_id]
	if(!QDELETED(old_body))
		unregister_mob_signals(old_body, mind_transfer = FALSE)
		action.Remove(old_body)
	if(!QDELETED(new_body))
		register_mob_signals(new_body, death = TRUE)
		action.Grant(new_body)

/**
 * Register the slime link-related signals on a mob or mind.
 *
 * Arguments
 * * target: The mob or mind to register the signals on.
 * * death: Whether to register the death signal.
 * * mind_transfer: Whether to register the mind transfer signal.
 */
/datum/species/oozeling/stargazer/proc/register_mob_signals(mob/living/target, death = FALSE, mind_transfer = FALSE)
	RegisterSignal(target, COMSIG_MOB_LOGIN, PROC_REF(login_notify))
	if(death)
		RegisterSignal(target, COMSIG_MOB_DEATH, PROC_REF(link_death))
	if(mind_transfer && target.mind)
		RegisterSignal(target.mind, COMSIG_MIND_TRANSFER_TO, PROC_REF(mind_transfer))

/**
 * Unregister the slime link-related signals from a mob or mind.
 *
 * Arguments
 * * target: The mob or mind to unregister the signals from.
 * * mind_transfer: Whether to unregister the mind transfer signal.
 */
/datum/species/oozeling/stargazer/proc/unregister_mob_signals(target, mind_transfer = TRUE)
	if(istype(target, /mob/living))
		var/mob/living/living_target = target
		UnregisterSignal(living_target, list(COMSIG_MOB_LOGIN, COMSIG_MOB_DEATH), PROC_REF(login_notify))
		if(mind_transfer && living_target.mind)
			UnregisterSignal(living_target.mind, COMSIG_MIND_TRANSFER_TO)
	else if(istype(target, /datum/mind))
		var/datum/mind/mind_target = target
		if(mind_transfer)
			UnregisterSignal(mind_target, COMSIG_MIND_TRANSFER_TO)
		if(mind_target.current)
			UnregisterSignal(mind_target.current, list(COMSIG_MOB_LOGIN, COMSIG_MOB_DEATH))

/**
 * Ensures a mind is a valid candidate for being slime linked.
 *
 * Arguments
 * * mind: The mind to validate for slime linking.
 * * initial_connection: Whether or not this is the first connection attempt (rather than validating to ensure a mind is still allowed to be in the slime link).
 * * silent: Whether to display messages when validating or not.
 * Returns TRUE if the mind is a valid candidate for being slime linked, FALSE otherwise.
 */
/datum/species/oozeling/stargazer/proc/validate_mind(datum/mind/mind, initial_connection = FALSE, silent = FALSE)
	. = TRUE
	if(QDELETED(mind?.current) || mind.current.stat == DEAD)
		return FALSE
	if(initial_connection && GLOB.slime_links_by_mind[mind])
		var/datum/weakref/other_link_ref = GLOB.slime_links_by_mind[mind]
		var/datum/species/oozeling/stargazer/other_link = other_link_ref?.resolve()
		// If they're already slime linked, then we can't link to them.
		if(other_link && istype(other_link))
			return FALSE
	if(istype(mind.current.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/foilhat))
		if(!silent)
			var/mob/living/carbon/human/owner = slimelink_owner.resolve()
			if(owner)
				to_chat(mind.current, "<span class='danger'>[owner]'s no-good syndicate mind-slime is blocked by your protective headgear!</span>")
		return FALSE
	if(HAS_TRAIT_NOT_FROM(mind.current, TRAIT_MINDSHIELD, "nanites")) //mindshield implant, no dice
		return FALSE

/**
 * Handles the death of a linked mob, unlinking them from the slime link.
 *
 * Arguments
 * * source_mob: The mob that died.
 */
/datum/species/oozeling/stargazer/proc/link_death(mob/living/source_mob)
	SIGNAL_HANDLER
	if(!source_mob.mind || !(source_mob.mind in linked_minds))
		return
	var/datum/weakref/owner_ref = GLOB.slime_links_by_mind[source_mob.mind]
	var/datum/species/oozeling/stargazer/stargazer = owner_ref?.resolve()
	var/mob/living/carbon/human/link_owner = stargazer?.slimelink_owner?.resolve()
	if(!link_owner || !istype(link_owner))
		return
	to_chat("<span class='danger'>As you die, you feel your link to [link_owner.real_name] fizzle out!</span>")
	unlink_mind(source_mob.mind)

/**
 * Links the mind of another mob to this stargazer's slime link.
 *
 * Arguments
 * * mind: The mind to link to the slime link.
 * Returns TRUE if the mind was successfully linked, FALSE otherwise.
 */
/datum/species/oozeling/stargazer/proc/link_mind(datum/mind/mind)
	if(!validate_mind(mind, initial_connection = TRUE))
		return FALSE
	var/mob/living/carbon/human/owner = slimelink_owner.resolve()
	if(mind in linked_minds)
		return FALSE
	if(!owner)
		return FALSE
	linked_minds.Add(mind)
	var/datum/action/innate/linked_speech/action = new(src)
	linked_actions.Add(action)
	action.Grant(mind.current)
	to_chat(mind.current, "<span class='notice'>You are now connected to [owner.real_name]'s Slime Link.</span>")
	GLOB.slime_links_by_mind[mind] = WEAKREF(src)
	register_mob_signals(mind.current, death = TRUE, mind_transfer = TRUE)
	to_chat(mind.current, "<span class='big notice'>You can use :[MODE_KEY_SLIMELINK] or .[MODE_KEY_SLIMELINK] to talk over the slime link!</span>")
	return TRUE

/**
 * Unlinks a mind from this stargazer's slime link.
 *
 * Arguments
 * * mind: The mind to unlink from the slime link.
 */
/datum/species/oozeling/stargazer/proc/unlink_mind(datum/mind/mind)
	var/link_id = linked_minds.Find(mind)
	if(!link_id)
		return
	var/mob/living/carbon/human/owner = slimelink_owner.resolve()
	var/datum/action/innate/linked_speech/action = linked_actions[link_id]
	unregister_mob_signals(mind)
	if(mind.current)
		action.Remove(mind.current)
		to_chat(mind.current, "<span class='notice'>You are no longer connected to [owner.real_name]'s Slime Link.</span>")
	linked_actions -= action
	linked_minds -= mind
	if(GLOB.slime_links_by_mind[mind])
		var/datum/weakref/owner_ref = GLOB.slime_links_by_mind[mind]
		if(owner_ref?.resolve() == src)
			GLOB.slime_links_by_mind -= mind

/**
 * Sends a chat message over the slime link.
 * Anything calling this proc should ensure to filter and sanitize the message beforehand!
 *
 * Arguments
 * * user: The mob sending the message.
 * * message: The message to send.
 */
/datum/species/oozeling/stargazer/proc/slime_chat(mob/living/user, message)
	var/mob/living/carbon/human/link_owner = slimelink_owner.resolve()
	if(!link_owner || !istype(link_owner))
		return
	if(!user || !user.mind)
		return
	if(!user == link_owner && !(user.mind in linked_minds))
		to_chat(user, "<span class='warning'>The link seems to have been severed...</span>")
		return
	if(!length(message))
		return
	message = user.treat_message_min(trim(message, MAX_MESSAGE_LEN))
	var/msg = "<i><font color=#008CA2>\[[link_owner.real_name]'s Slime Link\] <b>[user.real_name]:</b> [message]</font></i>"
	log_directed_talk(user, link_owner, msg, LOG_SAY, "slime link")
	var/list/targets = linked_minds.Copy()
	if(link_owner.mind)
		targets += link_owner.mind
	for(var/datum/mind/linked_mind as anything in targets)
		if(linked_mind != link_owner.mind && !validate_mind(linked_mind, silent = TRUE))
			unlink_mind(linked_mind)
			continue
		to_chat(linked_mind.current, msg)

	for(var/mob/target as anything in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(target, user)
		to_chat(target, "[link] [msg]")

/datum/action/innate/linked_speech
	name = "Slimelink"
	desc = "Send a psychic message to everyone connected to your slime link."
	button_icon_state = "link_speech"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/linked_speech/Activate()
	var/message = tgui_input_text(usr, "Message:", "Slime Telepathy")
	if(!message || !length(message))
		return
	if(CHAT_FILTER_CHECK(message))
		to_chat(usr, "<span class='warning'>Your message contains forbidden words.</span>")
		return
	usr.say(".[MODE_KEY_SLIMELINK] [message]")

/datum/action/innate/project_thought
	name = "Send Thought"
	desc = "Send a private psychic message to someone you can see."
	button_icon_state = "send_mind"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/project_thought/Activate()
	var/mob/living/carbon/human/human_owner = owner
	if(human_owner.stat == DEAD)
		return
	CHECK_DNA_AND_SPECIES(human_owner)
	if(!isstargazer(human_owner))
		return

	var/list/options = list()
	for(var/mob/living/potential_target in oview(human_owner))
		options += potential_target
	var/mob/living/target = tgui_input_list(usr, "Select who to send your message to:", "Send thought to?", items = sort_names(options))
	if(!target)
		return
	var/msg = tgui_input_text(usr, "Message:", "Telepathy")
	if(!msg)
		return
	if(CHAT_FILTER_CHECK(msg))
		to_chat(usr, "<span class='warning'>Your message contains forbidden words.</span>")
		return
	msg = human_owner.treat_message_min(trim(msg, MAX_MESSAGE_LEN))
	log_directed_talk(human_owner, target, msg, LOG_SAY, "slime telepathy")
	to_chat(target, "<span class='notice'>You hear an alien voice in your head... </span><font color=#008CA2>[msg]</font>")
	to_chat(human_owner, "<span class='notice'>You telepathically said: \"[msg]\" to [target].</span>")
	for(var/mob/dead as anything in GLOB.dead_mob_list)
		var/follow_link_user = FOLLOW_LINK(dead, human_owner)
		var/follow_link_target = FOLLOW_LINK(dead, target)
		to_chat(dead, "[follow_link_user] <span class='name'>[human_owner]</span> <span class='alertalien'>Slime Telepathy --> </span> [follow_link_target] <span class='name'>[target]</span> <span class='noticealien'>[msg]</span>")

/datum/action/innate/link_minds
	name = "Link Minds"
	desc = "Link someone's mind to your Slime Link, allowing them to communicate telepathically with other linked minds."
	button_icon_state = "mindlink"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/link_minds/Activate()
	var/mob/living/carbon/human/human_owner = owner
	CHECK_DNA_AND_SPECIES(human_owner)
	if(!isstargazer(human_owner))
		return

	if(!human_owner.pulling || !isliving(human_owner.pulling) || human_owner.grab_state < GRAB_AGGRESSIVE)
		to_chat(human_owner, "<span class='warning'>You need to aggressively grab someone to link minds!</span>")
		return

	var/mob/living/target = human_owner.pulling
	var/datum/species/oozeling/stargazer/species = human_owner.dna.species

	if(!target.mind)
		to_chat(human_owner, "<span class='warning'>[target] has no mind to link!</span>")
		return

	to_chat(human_owner, "<span class='notice'>You begin linking [target]'s mind to yours...</span>")
	to_chat(target, "<span class='warning'>You feel a foreign presence within your mind...</span>")
	if(do_after(human_owner, 6 SECONDS, target = target))
		if(human_owner.pulling != target || human_owner.grab_state < GRAB_AGGRESSIVE)
			return
		if(species.link_mind(target.mind))
			to_chat(human_owner, "<span class='notice'>You connect [target]'s mind to your slime link!</span>")
		else
			to_chat(human_owner, "<span class='warning'>You can't seem to link [target]'s mind...</span>")
			to_chat(target, "<span class='warning'>The foreign presence leaves your mind.</span>")
