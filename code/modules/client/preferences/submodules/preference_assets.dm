/// Assets generated from `/datum/preference` icons
/datum/asset/spritesheet_batched/preferences
	name = PREFERENCE_SHEET_NORMAL
	early = TRUE

/datum/asset/spritesheet_batched/preferences/create_spritesheets()
	create_preferences_spritesheet(src, name)

/proc/create_preferences_spritesheet(datum/asset/spritesheet_batched/sheet, sheet_key)
	for (var/preference_key in GLOB.preference_entries_by_key)
		var/datum/preference/choiced/preference = GLOB.preference_entries_by_key[preference_key]
		if (!istype(preference))
			continue

		if (!preference.should_generate_icons)
			continue

		if(preference.preference_spritesheet != sheet_key)
			continue

		var/list/choices = preference.get_choices_serialized()
		for (var/preference_value in choices)
			var/create_icon_of = choices[preference_value]
			var/datum/icon_batch_entry/icon
			if (ispath(create_icon_of, /atom))
				var/atom/atom_icon_source = create_icon_of
				icon = u_icon_entry(initial(atom_icon_source.icon), initial(atom_icon_source.icon_state))
			else if (istype(create_icon_of, /datum/icon_batch_entry))
				icon = create_icon_of
			else if (isicon(create_icon_of))
				CRASH("Icon given for preference [preference_key]:[preference_value]. This is not supported anymore, provide a /datum/icon_batch_entry instead.")
			else
				CRASH("[create_icon_of] is an invalid preference value (from [preference_key]:[preference_value]).")
			icon.sprite_name = preference.get_spritesheet_key(preference_value)
			sheet.insert_icon(icon)

/// This "large" spritesheet helps reduce mount lag from large PNG files.
/datum/asset/spritesheet_batched/preferences_large
	name = PREFERENCE_SHEET_LARGE
	early = TRUE

/datum/asset/spritesheet_batched/preferences_large/create_spritesheets()
	create_preferences_spritesheet(src, name)

/// This "huge" spritesheet helps reduce mount lag from huge PNG files.
/datum/asset/spritesheet_batched/preferences_huge
	name = PREFERENCE_SHEET_HUGE
	early = TRUE


/datum/asset/spritesheet_batched/preferences_huge/create_spritesheets()
	// if someone ever hits this limit, you need to delete the game
	// just delete it, it's too big. It needs to end (the year is probably 2053 or something)
	create_preferences_spritesheet(src, name)

/// Returns the key that will be used in the spritesheet for a given value.
/datum/preference/proc/get_spritesheet_key(value)
	return "[db_key]___[sanitize_css_class_name(value)]"

/datum/asset/spritesheet_batched/preferences_loadout
	name = "preferences_loadout"
	early = TRUE

/datum/asset/spritesheet_batched/preferences_loadout/create_spritesheets()
	for(var/gear_id in GLOB.gear_datums)
		var/datum/gear/G = GLOB.gear_datums[gear_id]
		var/regular_icon = get_display_icon_for("loadout_gear___[gear_id]", G.path)
		if(!regular_icon)
			continue
		insert_icon(regular_icon)
		var/skirt_icon = get_display_icon_for("loadout_gear___[gear_id]_skirt", G.skirt_path)
		if(!skirt_icon)
			continue
		insert_icon(skirt_icon)

/// Sends information needed for shared details on individual preferences
/datum/asset/json/preferences
	name = "preferences"

/datum/asset/json/preferences/generate()
	var/list/preference_data = list()

	for (var/middleware_type in subtypesof(/datum/preference_middleware))
		var/datum/preference_middleware/middleware = new middleware_type
		var/data = middleware.get_constant_data()
		if (!isnull(data))
			preference_data[middleware.key] = data

		qdel(middleware)

	for (var/preference_type in GLOB.preference_entries)
		var/datum/preference/preference_entry = GLOB.preference_entries[preference_type]
		var/data = preference_entry.compile_constant_data()
		if (!isnull(data))
			preference_data[preference_entry.db_key] = data

	return preference_data
