/datum/keybinding/living
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/datum/keybinding/living/can_use(client/user)
	return isliving(user.mob)


/datum/keybinding/living/resist
	key = "B"
	name = "resist"
	full_name = "Resist"
	description = "Break free of your current state. Handcuffs, on fire, being trapped in an alien nest? Resist!"
	keybind_signal = COMSIG_KB_LIVING_RESIST_DOWN

/datum/keybinding/living/resist/down(client/user)
	. = ..()
	if(.)
		return
	if (!isliving(user.mob)) return
	var/mob/living/L = user.mob
	L.resist()
	return TRUE


/datum/keybinding/living/rest
	key = "V"
	name = "rest"
	full_name = "Rest"
	description = "Lay down, or get up."
	keybind_signal = COMSIG_KB_LIVING_REST_DOWN

/datum/keybinding/living/rest/down(client/user)
	. = ..()
	if(.)
		return
	if(!isliving(user.mob))
		return
	var/mob/living/L = user.mob
	L.lay_down()
	return TRUE

/datum/keybinding/living/look_up
	key = "L"
	name = "look up"
	full_name = "Look Up"
	description = "Look up at the next z-level. Only works if directly below open space."

/datum/keybinding/living/look_up/down(client/user)
	var/mob/living/L = user.mob
	L.look_up()
	return TRUE

/datum/keybinding/living/look_up/up(client/user)
	var/mob/living/L = user.mob
	L.stop_look_up()
	return TRUE
