//Parent types

/area/ruin
	name = "\improper Unexplored Location"
	icon_state = "away"
	has_gravity = STANDARD_GRAVITY
	area_flags = HIDDEN_AREA | BLOBS_ALLOWED
	static_lighting = TRUE
	ambience_index = AMBIENCE_RUINS
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	airlock_hack_difficulty = AIRLOCK_WIRE_SECURITY_ELITE

/area/ruin/unpowered
	always_unpowered = FALSE

/area/ruin/unpowered/no_grav
	has_gravity = FALSE

/area/ruin/powered
	requires_power = FALSE
