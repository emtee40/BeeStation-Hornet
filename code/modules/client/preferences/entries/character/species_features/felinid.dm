/datum/preference/choiced/tail_human
	db_key = "feature_human_tail"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	can_randomize = FALSE
	relevant_mutant_bodypart = "tail_human"

/datum/preference/choiced/tail_human/init_possible_values()
	return assoc_to_keys(GLOB.tails_roundstart_list_human)

/datum/preference/choiced/tail_human/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_human"] = value

/datum/preference/choiced/tail_human/create_default_value()
	var/datum/sprite_accessory/tails/human/cat/tail = /datum/sprite_accessory/tails/human/cat
	return initial(tail.name)

/datum/preference/choiced/ears
	db_key = "feature_human_ears"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	can_randomize = FALSE
	relevant_mutant_bodypart = "ears"

/datum/preference/choiced/ears/init_possible_values()
	return assoc_to_keys(GLOB.ears_list)

/datum/preference/choiced/ears/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ears"] = value

/datum/preference/choiced/ears/create_default_value()
	var/datum/sprite_accessory/ears/cat/ears = /datum/sprite_accessory/ears/cat
	return initial(ears.name)

/datum/preference/choiced/xenotype
	db_key = "feature_human_xenotype"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	can_randomize = FALSE
	relevant_mutant_bodypart = "xenotype"

/datum/preference/choiced/xenotype/init_possible_values()
	return assoc_to_keys(GLOB.xenotype_list)

/datum/preference/choiced/xenotype/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["xenotype"] = value

/datum/preference/choiced/xenotype/create_default_value()
	var/datum/sprite_accessory/xenotype/homo/xenotype = /datum/sprite_accessory/xenotype/homo
	return initial(xenotype.name)

