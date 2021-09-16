GLOBAL_DATUM_INIT(human_typing_indicator, /mutable_appearance, mutable_appearance('icons/mob/talk.dmi', "default0", -TYPING_LAYER))

/mob/proc/create_typing_indicator()
	return

/mob/proc/remove_typing_indicator()
	return

/mob/set_stat(new_stat)
	. = ..()
	if(.)
		remove_typing_indicator()

/mob/Logout()
	remove_typing_indicator()
	. = ..()

/mob/verb/start_typing()
	set name = ".start_typing"
	set hidden = 1

	create_typing_indicator()

/mob/verb/cancel_typing()
	set name = ".cancel_typing"
	set hidden = 1

	remove_typing_indicator()

/mob/verb/say_wrapper(message as text)
	set name = ".Say"
	set hidden = 1

	winshow(usr, "saywindow", FALSE)
	remove_typing_indicator()
	if(message)
		say_verb(message)

////Wrappers////
//Keybindings were updated to change to use these wrappers. If you ever remove this file, revert those keybind changes

/mob/verb/me_wrapper()
	set name = ".Me"
	set hidden = 1

	create_typing_indicator()
	var/message = input("","me (text)") as text|null
	remove_typing_indicator()
	if(message)
		me_verb(message)

///Human Typing Indicators///
/mob/living/carbon/human/create_typing_indicator()
	if(!overlays_standing[TYPING_LAYER] && stat == CONSCIOUS) //Prevents sticky overlays and typing while in any state besides conscious
		overlays_standing[TYPING_LAYER] = GLOB.human_typing_indicator
		apply_overlay(TYPING_LAYER)

/mob/living/carbon/human/remove_typing_indicator()
	remove_overlay(TYPING_LAYER)
