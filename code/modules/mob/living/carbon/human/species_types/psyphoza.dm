///The limit when the psychic timer locks you out of creating more
#define PSYCHIC_OVERLAY_UPPER 500
///Burn mod for our species, weak to fire
#define PSYPHOZA_BURNMOD 1.25

/datum/species/psyphoza
	name = "\improper Psyphoza"
	plural_form = "Psyphoza"
	id = SPECIES_PSYPHOZA
	bodyflag = FLAG_PSYPHOZA
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/psyphoza
	species_traits = list(NOEYESPRITES, AGENDER, MUTCOLORS)
	sexes = FALSE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	species_language_holder = /datum/language_holder/psyphoza
	exotic_blood = /datum/reagent/drug/mushroomhallucinogen
	allow_numbers_in_name = TRUE

	offset_features = list(OFFSET_UNIFORM = list(0,0), OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_GLASSES = list(0,-2), OFFSET_EARS = list(0,-3), OFFSET_SHOES = list(0,0), OFFSET_S_STORE = list(0,0), OFFSET_FACEMASK = list(0,-2), OFFSET_HEAD = list(0,-2), OFFSET_FACE = list(0,-2), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), OFFSET_SUIT = list(0,0), OFFSET_NECK = list(0,0))

	mutant_brain = /obj/item/organ/brain/psyphoza
	mutanteyes = /obj/item/organ/eyes/psyphoza
	mutanttongue = /obj/item/organ/tongue/psyphoza

	mutant_bodyparts = list("psyphoza_cap")
	default_features = list("psyphoza_cap" = "Portobello", "body_size" = "Normal", "mcolor" = "fff")
	hair_color = "fixedmutcolor"

	species_chest = /obj/item/bodypart/chest/psyphoza
	species_head = /obj/item/bodypart/head/psyphoza
	species_l_arm = /obj/item/bodypart/l_arm/psyphoza
	species_r_arm = /obj/item/bodypart/r_arm/psyphoza
	species_l_leg = /obj/item/bodypart/l_leg/psyphoza
	species_r_leg = /obj/item/bodypart/r_leg/psyphoza

	//Fire bad!
	burnmod = PSYPHOZA_BURNMOD

	//Reference to psychic highlight action
	var/datum/action/item_action/organ_action/psychic_highlight/PH

/datum/species/psyphoza/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	PH = locate(/datum/action/item_action/organ_action/psychic_highlight) in C.actions

/datum/species/psyphoza/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	PH = null

/datum/species/psyphoza/random_name(gender, unique, lastname, attempts)
	. = "[pick(GLOB.psyphoza_first_names)] [pick(GLOB.psyphoza_last_names)]"
	if(unique && attempts < 10 && findname(.))
		return .(gender, TRUE, null, ++attempts)

/datum/species/psyphoza/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(istype(chem, /datum/reagent/drug) && H.blood_volume < BLOOD_VOLUME_NORMAL)
		H.blood_volume += chem.volume * 15
		H.reagents.remove_reagent(chem.type, chem.volume)
		return FALSE
	return ..()

/datum/species/psyphoza/get_scream_sound(mob/living/carbon/user)
	return pick('sound/voice/psyphoza/psyphoza_scream_1.ogg', 'sound/voice/psyphoza/psyphoza_scream_2.ogg')

/datum/species/psyphoza/primary_species_action()
	. = ..()
	PH?.Trigger()

/datum/species/psyphoza/get_species_description()
	return "..."

/datum/species/psyphoza/get_species_lore()
	return list("...")

/datum/species/psyphoza/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "lightbulb",
			SPECIES_PERK_NAME = "Psychic",
			SPECIES_PERK_DESC = "Psyphoza are psychic and can sense things others can't.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "eye",
			SPECIES_PERK_NAME = "Blind",
			SPECIES_PERK_DESC = "Psyphoza are blind and can't see outside their immediate location and psychic sense.",
		),
	)

	return to_add

//This originally held the psychic action until I moved it to the eyes, keep it please.
/obj/item/organ/brain/psyphoza
	name = "psyphoza brain"
	desc = "Bubbling with psychic energy...no wait...that's blood."
	color = "#ff00ee"

// PSYCHIC ECHOLOCATION
/datum/action/item_action/organ_action/psychic_highlight
	name = "Psychic Sense"
	desc = "Sense your surroundings psychically."
	transparent_when_unavailable = TRUE
	///The distant our psychic sense works
	var/psychic_scale = 2.28
	///The range we can hear-ping things from
	var/hear_range = 8
	///List of things we can't sense
	var/list/sense_blacklist
	///The amount of time you can sense things for
	var/sense_time = 10 SECONDS
	///Reference to the users eyes - we use this to toggle xray vision for scans
	var/obj/item/organ/eyes/eyes
	///The eyes original sight flags - used between toggles
	var/sight_flags
	///Time between uses
	var/cooldown = 2 SECONDS
	///Reference to 'kill these overlays' timer
	var/psychic_timer
	///Ref to change action
	var/datum/action/change_psychic_visual/overlay_change
	///The amount of time between auto uses
	var/auto_cooldown = 2 SECONDS
	///Do we have auto sense toggled?
	var/auto_sense = FALSE
	///Ref to sense auto toggle action
	var/datum/action/change_psychic_auto/auto_action

/datum/action/item_action/organ_action/psychic_highlight/Destroy()
	QDEL_NULL(auto_action)
	QDEL_NULL(overlay_change)
	return ..()

/datum/action/item_action/organ_action/psychic_highlight/Grant(mob/M)
	. = ..()
	//Overlay used to highlight objects
	M.overlay_fullscreen("psychic_highlight", /atom/movable/screen/fullscreen/blind/psychic_highlight)
	M.overlay_fullscreen("psychic_hsighlight_mask", /atom/movable/screen/fullscreen/blind/psychic/mask)
	//Add option to change visuals
	if(!(locate(/datum/action/change_psychic_visual) in owner.actions))
		overlay_change = new(src)
		overlay_change.Grant(owner)
	///Give owner auto action
	if(!(locate(/datum/action/change_psychic_auto) in owner.actions))
		auto_action = new(src)
		auto_action.Grant(M)
	///Start auto timer
	addtimer(CALLBACK(src, PROC_REF(auto_sense)), auto_cooldown)

/datum/action/item_action/organ_action/psychic_highlight/IsAvailable()
	if(has_cooldown_timer)
		return FALSE
	return ..()

/datum/action/item_action/organ_action/psychic_highlight/Trigger()
	. = ..()
	if(has_cooldown_timer || !owner || !check_head())
		return
	dim_overlay()
	has_cooldown_timer = TRUE
	UpdateButtonIcon()
	addtimer(CALLBACK(src, PROC_REF(finish_cooldown)), cooldown + sense_time)

/datum/action/item_action/organ_action/psychic_highlight/UpdateButtonIcon(status_only = FALSE, force = FALSE)
	. = ..()
	if(!IsAvailable())
		button.color = transparent_when_unavailable ? rgb(128,0,0,128) : rgb(128,0,0) //Overwrite this line from the original to support my fucked up use

/datum/action/item_action/organ_action/psychic_highlight/proc/auto_sense()
	if(auto_sense)
		Trigger()
	addtimer(CALLBACK(src, PROC_REF(auto_sense)), auto_cooldown)

/datum/action/item_action/organ_action/psychic_highlight/proc/finish_cooldown()
	has_cooldown_timer = FALSE
	UpdateButtonIcon()

//Allows user to see images through walls
/datum/action/item_action/organ_action/psychic_highlight/proc/toggle_eyes_fowards()
	//Grab organs - we do this here becuase of fuckery :tm:
	if(!eyes && istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		//eyes
		eyes = locate(/obj/item/organ/eyes) in H.internal_organs
		sight_flags = eyes?.sight_flags
		//Register signal for losing our eyes
		if(eyes)
			RegisterSignal(eyes, COMSIG_PARENT_QDELETING, PROC_REF(handle_eyes))

	//handle eyes - make them xray so we can see all the things
	eyes?.sight_flags = SEE_MOBS | SEE_OBJS | SEE_TURFS
	owner.update_sight()

//Handle images deleting, stops hardel - also does eyes stuff
/datum/action/item_action/organ_action/psychic_highlight/proc/toggle_eyes_backwards()
	//Timer steps
	if(psychic_timer)
		deltimer(psychic_timer)
		psychic_timer = null
	//Set eyes back to normal
	eyes?.sight_flags = sight_flags
	owner.update_sight()

//Dims blind overlay - Lightens highlight layer
/datum/action/item_action/organ_action/psychic_highlight/proc/dim_overlay()
	//Blind layer
	var/atom/movable/screen/fullscreen/blind/psychic/P = locate(/atom/movable/screen/fullscreen/blind/psychic) in owner.client?.screen
	if(P)
		//We change the color instead of alpha, otherwise we'd reveal our actual surroundings!
		animate(P, color = "#000") //This is a fix for a bug with ``animate()`` breaking
		animate(P, color = P.origin_color, time = sense_time, easing = SINE_EASING, flags = EASE_IN)
	//Highlight layer
	var/atom/movable/screen/fullscreen/blind/psychic/mask/B = locate(/atom/movable/screen/fullscreen/blind/psychic/mask) in owner.client?.screen
	if(B)
		var/matrix/ntransform = matrix(B.transform) //new scale
		ntransform.Scale(psychic_scale)
		var/matrix/otransform = matrix(B.transform) //old scale
		animate(B, transform = ntransform)
		animate(B, transform = otransform, time = sense_time, easing = SINE_EASING, flags = EASE_IN)
	//Setup timer to delete image
	if(psychic_timer)
		deltimer(psychic_timer)
	psychic_timer = addtimer(CALLBACK(src, PROC_REF(toggle_eyes_backwards)), sense_time, TIMER_STOPPABLE)

//Get a list of nearby things & run 'em through a typecache
/datum/action/item_action/organ_action/psychic_highlight/proc/check_head()
	if(istype(owner?.get_item_by_slot(ITEM_SLOT_HEAD), /obj/item/clothing/head/helmet))
		to_chat(owner, "<span class='warning'>You can't use your senses while wearing helmets!</span>")
		return FALSE
	return TRUE

//Handles eyes being deleted
/datum/action/item_action/organ_action/psychic_highlight/proc/handle_eyes()
	SIGNAL_HANDLER

	eyes = null

//keep this type-
/atom/movable/screen/fullscreen/blind/psychic
	icon_state = "trip"
	icon = 'icons/mob/psychic.dmi'
	render_target = "blind_psychic"
	//The color we return to after going black & back.
	var/origin_color = "#111"

/atom/movable/screen/fullscreen/blind/psychic/Initialize(mapload)
	. = ..()
	unique_filters()
	color = origin_color

/atom/movable/screen/fullscreen/blind/psychic/proc/unique_filters()
	filters += filter(type = "radial_blur", size = 0.012)
	filters += filter(type = "bloom", size = 5, threshold = rgb(85,85,85))

/atom/movable/screen/fullscreen/blind/psychic/mask
	icon_state = "mask_small"
	render_target = "psychic_mask"

/atom/movable/screen/fullscreen/blind/psychic/mask/unique_filters()
	filters += filter(type = "alpha", render_source = "blind_psychic")

//And this type as a seperate type-path to avoid issues with animations & locate()
/atom/movable/screen/fullscreen/blind/psychic_highlight
	icon_state = "trip"
	icon = 'icons/mob/psychic.dmi'
	plane = FULLSCREEN_PLANE
	layer = 4.1
	///Index for visual setting - Useful if we add more presets
	var/visual_index = 0

/atom/movable/screen/fullscreen/blind/psychic_highlight/Initialize(mapload)
	. = ..()
	//filters += filter(type = "bloom", size = 1, threshold = rgb(85,85,85))
	filters += filter(type = "radial_blur", size = 0.012)
	filters += filter(type = "alpha", render_source = GAME_PLANE_RENDER_TARGET)
	filters += filter(type = "alpha", render_source = "psychic_mask")
	filters += filter(type = "outline", size = 1, color = "#fff")
	cycle_visuals()

/atom/movable/screen/fullscreen/blind/psychic_highlight/proc/cycle_visuals(new_color)
	++visual_index
	//Reset animations
	animate(src, color = "#fff")
	if(new_color)
		color = new_color
	else
		//Set animation
		switch(visual_index)
			if(1) //Rainbow
				color = "#f00" // start at red
				animate(src, color = "#ff0", time = 0.3 SECONDS, loop = -1)
				animate(color = "#0f0", time = 0.3 SECONDS)
				animate(color = "#0ff", time = 0.3 SECONDS)
				animate(color = "#00f", time = 0.3 SECONDS)
				animate(color = "#f0f", time = 0.3 SECONDS)
				animate(color = "#f00", time = 0.3 SECONDS)
			if(2) //Custom
				color = input(usr,"","Choose Color","#fff") as color|null
				. = color
	//Wrap index back around
	visual_index = visual_index >= 2 ? 0 :  visual_index

//Action for changing screen color
/datum/action/change_psychic_visual
	name = "Change Psychic Sense"
	desc = "Change the visual style of your psychic sense."
	icon_icon = 'icons/mob/actions.dmi'
	button_icon_state = "unknown"
	///Ref to the overlay - hard del edition
	var/atom/movable/screen/fullscreen/blind/psychic_highlight/psychic_overlay

/datum/action/change_psychic_visual/New(Target)
	. = ..()
	RegisterSignal(psychic_overlay, COMSIG_PARENT_QDELETING, PROC_REF(parent_destroy))

/datum/action/change_psychic_visual/Destroy()
	QDEL_NULL(psychic_overlay)
	return ..()

/datum/action/change_psychic_visual/proc/parent_destroy()
	SIGNAL_HANDLER

	qdel(src)

/datum/action/change_psychic_visual/Trigger()
	. = ..()
	if(!psychic_overlay)
		psychic_overlay = locate(/atom/movable/screen/fullscreen/blind/psychic_highlight) in owner?.client?.screen
	psychic_overlay?.cycle_visuals()

//Action for toggling auto sense
/datum/action/change_psychic_auto
	name = "Auto Psychic Sense"
	desc = "Change your psychic sense to auto."
	icon_icon = 'icons/mob/actions.dmi'
	button_icon_state = "unknown"
	///Ref to the action
	var/datum/action/item_action/organ_action/psychic_highlight/psychic_action

/datum/action/change_psychic_auto/New(Target)
	. = ..()
	psychic_action = Target
	RegisterSignal(psychic_action, COMSIG_PARENT_QDELETING, PROC_REF(parent_destroy))

/datum/action/change_psychic_auto/Destroy()
	QDEL_NULL(psychic_action)
	return ..()

/datum/action/change_psychic_auto/proc/parent_destroy()
	SIGNAL_HANDLER

	qdel(src)

/datum/action/change_psychic_auto/Trigger()
	. = ..()
	psychic_action?.auto_sense = !psychic_action?.auto_sense
	UpdateButtonIcon()

/datum/action/change_psychic_auto/IsAvailable()
	. = ..()
	if(psychic_action?.auto_sense)
		return FALSE

#undef PSYCHIC_OVERLAY_UPPER
#undef PSYPHOZA_BURNMOD
