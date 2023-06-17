/proc/generate_lizard_side_shots(list/sprite_accessories, key, include_snout = TRUE)
	var/list/values = list()

	var/icon/lizard = icon('icons/mob/species/lizard/bodyparts.dmi', "lizard_head_m", dir = EAST)

	var/icon/eyes = icon('icons/mob/human_face.dmi', "eyes", dir = EAST)
	eyes.Blend(COLOR_GRAY, ICON_MULTIPLY)
	lizard.Blend(eyes, ICON_OVERLAY)

	if (include_snout)
		lizard.Blend(icon('icons/mob/mutant_bodyparts.dmi', "m_snout_round_ADJ", dir = EAST), ICON_OVERLAY)

	for (var/name in sprite_accessories)
		var/datum/sprite_accessory/sprite_accessory = sprite_accessories[name]

		var/icon/final_icon = new(lizard)

		if (sprite_accessory.icon_state != "none")
			var/icon/accessory_icon = icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ", dir = EAST)
			final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(11, 20, 23, 32)
		final_icon.Scale(32, 32)
		final_icon.Blend(COLOR_LIME, ICON_MULTIPLY)

		values[name] = icon(final_icon, dir = EAST)

	return values

/datum/preference/choiced/lizard_body_markings
	db_key = "feature_lizard_body_markings"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Body markings"
	should_generate_icons = TRUE
	relevant_mutant_bodypart = "body_markings"

/datum/preference/choiced/lizard_body_markings/init_possible_values()
	var/list/values = list()

	var/icon/lizard = icon('icons/mob/species/lizard/bodyparts.dmi', "lizard_chest_m", dir = SOUTH)

	for (var/name in GLOB.body_markings_list)
		var/datum/sprite_accessory/sprite_accessory = GLOB.body_markings_list[name]

		var/icon/final_icon = icon(lizard, dir = SOUTH)

		if (sprite_accessory.icon_state != "none")
			var/icon/body_markings_icon = icon(
				'icons/mob/mutant_bodyparts.dmi',
				"m_body_markings_[sprite_accessory.icon_state]_ADJ",
				dir = SOUTH
			)

			final_icon.Blend(body_markings_icon, ICON_OVERLAY)

		final_icon.Blend(COLOR_LIME, ICON_MULTIPLY)
		final_icon.Crop(10, 8, 22, 23)
		final_icon.Scale(26, 32)
		final_icon.Crop(-2, 1, 29, 32)

		values[name] = icon(final_icon, dir = SOUTH)

	return values

/datum/preference/choiced/lizard_body_markings/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["body_markings"] = value

/datum/preference/choiced/lizard_frills
	db_key = "feature_lizard_frills"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Frills"
	should_generate_icons = TRUE
	relevant_mutant_bodypart =  "frills"

/datum/preference/choiced/lizard_frills/init_possible_values()
	return generate_lizard_side_shots(GLOB.frills_list, "frills")

/datum/preference/choiced/lizard_frills/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["frills"] = value

/datum/preference/choiced/lizard_horns
	db_key = "feature_lizard_horns"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Horns"
	should_generate_icons = TRUE
	relevant_mutant_bodypart =  "horns"

/datum/preference/choiced/lizard_horns/init_possible_values()
	return generate_lizard_side_shots(GLOB.horns_list, "horns")

/datum/preference/choiced/lizard_horns/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["horns"] = value

/datum/preference/choiced/lizard_legs
	db_key = "feature_lizard_legs"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"

/datum/preference/choiced/lizard_legs/init_possible_values()
	return assoc_to_keys(GLOB.legs_list)

/datum/preference/choiced/lizard_legs/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["legs"] = value

/datum/preference/choiced/lizard_snout
	db_key = "feature_lizard_snout"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Snout"
	should_generate_icons = TRUE
	relevant_mutant_bodypart = "snout"

/datum/preference/choiced/lizard_snout/init_possible_values()
	return generate_lizard_side_shots(GLOB.snouts_list, "snout", include_snout = FALSE)

/datum/preference/choiced/lizard_snout/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["snout"] = value

/datum/preference/choiced/lizard_spines
	db_key = "feature_lizard_spines"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Spines"
	should_generate_icons = TRUE
	relevant_mutant_bodypart = "spines"

/datum/preference/choiced/lizard_spines/init_possible_values()
	return generate_lizard_body_shots(GLOB.spines_list, "spines", show_tail = TRUE)

/datum/preference/choiced/lizard_spines/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["spines"] = value

/datum/preference/choiced/lizard_tail
	db_key = "feature_lizard_tail"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Tail"
	should_generate_icons = TRUE
	relevant_mutant_bodypart = "tail_lizard"

/datum/preference/choiced/lizard_tail/init_possible_values()
	return generate_lizard_body_shots(GLOB.tails_list_lizard, "tail")

/datum/preference/choiced/lizard_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_lizard"] = value

/proc/generate_lizard_body_shots(list/sprite_accessories, key, show_tail = FALSE, shift_x = -8)
	var/list/values = list()
	var/list/body_parts = list(
		BODY_ZONE_CHEST,
		BODY_ZONE_R_ARM,
		BODY_ZONE_PRECISE_R_HAND,
		BODY_ZONE_R_LEG,
	)
	var/icon/body_icon = icon('icons/effects/effects.dmi', "nothing")
	for (var/body_part in body_parts)
		var/gender = body_part == BODY_ZONE_CHEST ? "_m" : ""
		body_icon.Blend(icon('icons/mob/species/lizard/bodyparts.dmi', "lizard_[body_part][gender]", dir = EAST), ICON_OVERLAY)
	if(show_tail)
		body_icon.Blend(icon('icons/mob/mutant_bodyparts.dmi', "m_tail_smooth_BEHIND", dir = EAST), ICON_OVERLAY)

	for (var/sprite_name in sprite_accessories)
		var/datum/sprite_accessory/sprite = sprite_accessories[sprite_name]
		var/icon/icon_with_changes = new(body_icon)

		if (sprite_name != "None")
			var/ex = key == "spines" ? "ADJ" : "BEHIND"
			var/icon/sprite_icon = icon('icons/mob/mutant_bodyparts.dmi', "m_[key]_[sprite.icon_state]_[ex]", dir = EAST)
			icon_with_changes.Blend(sprite_icon, ICON_OVERLAY)
		icon_with_changes.Blend(COLOR_LIME, ICON_MULTIPLY)

		// Zoom in
		icon_with_changes.Scale(64, 64)
		icon_with_changes.Crop(15 + shift_x, 0, 15 + 31 + shift_x, 31)

		values[sprite_name] = icon_with_changes

	return values
