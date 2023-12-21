/datum/preference/choiced/ethereal_color
	db_key = "feature_ethcolor"
	preference_type = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Ethereal Color"
	should_generate_icons = TRUE

/datum/preference/choiced/ethereal_color/init_possible_values()
	var/list/values = list()

	var/datum/icon_batch_entry/ethereal_base = u_icon_entry('icons/mob/human_parts_greyscale.dmi', "ethereal_head_m")
	ethereal_base.blend_icon(u_icon_entry('icons/mob/human_parts_greyscale.dmi', "ethereal_chest_m"), ICON_OVERLAY)
	ethereal_base.blend_icon(u_icon_entry('icons/mob/human_parts_greyscale.dmi', "ethereal_l_arm"), ICON_OVERLAY)
	ethereal_base.blend_icon(u_icon_entry('icons/mob/human_parts_greyscale.dmi', "ethereal_r_arm"), ICON_OVERLAY)

	var/datum/icon_batch_entry/eyes = u_icon_entry('icons/mob/human_face.dmi', "eyes")
	eyes.blend_color(COLOR_BLACK, ICON_MULTIPLY)
	ethereal_base.blend_icon(eyes, ICON_OVERLAY)

	ethereal_base.scale(64, 64)
	ethereal_base.crop(15, 64, 15 + 31, 64 - 31)

	for (var/name in GLOB.color_list_ethereal)
		var/color = GLOB.color_list_ethereal[name]

		var/datum/icon_batch_entry/icon = ethereal_base.copy()
		icon.blend_color("#[color]", ICON_MULTIPLY)
		values[name] = icon

	return values

/datum/preference/choiced/ethereal_color/deserialize(input, datum/preferences/preferences)
	if(findtext(input, GLOB.is_color_nocrunch)) // Migrate old data
		var/valid = assoc_key_for_value(GLOB.color_list_ethereal, lowertext(input))
		if(!isnull(valid))
			return valid
	return ..()

/datum/preference/choiced/ethereal_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ethcolor"] = GLOB.color_list_ethereal[value]

