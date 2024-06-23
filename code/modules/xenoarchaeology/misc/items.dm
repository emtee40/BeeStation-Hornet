/*
	generic artifact
*/
/obj/item/xenoartifact
	name = "artifact"
	icon = 'icons/obj/xenoarchaeology/xenoartifact.dmi'
	icon_state = "map_editor"
	w_class = WEIGHT_CLASS_NORMAL
	desc = "A strange alien artifact. What could it possibly do?"
	throw_range = 3
	///What type of artifact
	var/datum/xenoartifact_material/artifact_type

/obj/item/xenoartifact/Initialize(mapload, _artifact_type)
	. = ..()
	artifact_type = _artifact_type || artifact_type
	ADD_TRAIT(src, TRAIT_IGNORE_EXPORT_SCAN, GENERIC_ITEM_TRAIT)

/obj/item/xenoartifact/ComponentInitialize()
	. = ..()
	add_artifact_component()

///Proc to add your artifact stuff, here so we can override it
/obj/item/xenoartifact/proc/add_artifact_component()
	AddComponent(/datum/component/xenoartifact, artifact_type)

/*
	Maint variant
	has a 90% chance of being bluespace, 10% of being anything else, like a regular artifact.
	Lets crew discover / play with artifacts without blowing shit up
*/
/obj/item/xenoartifact/maint/ComponentInitialize()
	artifact_type = prob(90) ? /datum/xenoartifact_material/bluespace : null
	return ..()

/*
	objective variant
	spawns with objective trait, shouldn't effect labelling.
*/
/obj/item/xenoartifact/objective/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/tracking_beacon, EXPLORATION_TRACKING, null, null, TRUE, "#eb4d4d", TRUE, TRUE)
	var/datum/component/xenoartifact/X = GetComponent(/datum/component/xenoartifact)
	X?.add_individual_trait(/datum/xenoartifact_trait/misc/objective)

/*
	No trait variant
	Spawns with no traits, helps with debug and other stuff
*/
/obj/item/xenoartifact/no_traits

/obj/item/xenoartifact/no_traits/add_artifact_component()
	return

/*
	tutorial variant
	Has set traits, is accompanied by a piece of paper in the map that uses it to explain how-to-artifact-science.
*/
/obj/item/xenoartifact/tutorial

/obj/item/xenoartifact/tutorial/Initialize(mapload, _artifact_type)
	. = ..()
	var/obj/item/sticker/sticky_note/artifact_tutorial/S = new(loc)
	S.afterattack(src, src, TRUE)
	S.pixel_y = rand(-5, 5)
	S.pixel_x = rand(-5, 5)

/obj/item/xenoartifact/tutorial/add_artifact_component()
	AddComponent(/datum/component/xenoartifact, /datum/xenoartifact_material/bluespace, list(/datum/xenoartifact_trait/activator/sturdy, /datum/xenoartifact_trait/minor/slippery, /datum/xenoartifact_trait/minor/charged, /datum/xenoartifact_trait/minor/cooling, /datum/xenoartifact_trait/major/hollow))

/*
	Pre-labeled variant
	for loots
*/
/obj/item/xenoartifact/pre_labeled

/obj/item/xenoartifact/pre_labeled/ComponentInitialize()
	. = ..()
	var/datum/component/xenoartifact/X = GetComponent(/datum/component/xenoartifact)
	var/trait_list = list()
	for(var/i in X.artifact_traits)
		for(var/datum/xenoartifact_trait/T in X.artifact_traits[i])
			trait_list += T.type
	var/obj/item/sticker/xenoartifact_label/old/P = new(get_turf(src), trait_list)
	P.afterattack(src, src, TRUE)
