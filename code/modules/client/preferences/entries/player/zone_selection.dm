/// Determines parallax, "fancy space"
/datum/preference/choiced/zone_select
	db_key = "zone_select"
	preference_type = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES

/datum/preference/choiced/zone_select/init_possible_values()
	return list(
		PREFERENCE_BODYZONE_SIMPLIFIED,
		PREFERENCE_BODYZONE_INTENT,
	)

/datum/preference/choiced/zone_select/create_default_value()
	// For the time being the default will be the standard intent system
	// until we have had some time to play with the new simplified bodyzone
	// system and determine if its good or not. If playing with it is acceptable
	// and more intuative than bodyzones, switch the default to simplified.
	return PREFERENCE_BODYZONE_INTENT

/datum/preference/choiced/zone_select/apply_to_client(client/client, value)
	// Reset zone selected to a sane value
	if (value == PREFERENCE_BODYZONE_SIMPLIFIED)
		client.mob.zone_selected = BODY_GROUP_CHEST_HEAD
	else
		client.mob.zone_selected = BODY_ZONE_CHEST
