TIMER_SUBSYSTEM_DEF(runechat)
	name = "Runechat"
	priority = FIRE_PRIORITY_RUNECHAT
	/// Each token indicates that a call to client's MeasureText() was made and is pending
	var/initialize_tokens = list()
	/// List of most characters in the font. Do not varedit it in game.
	/// Format of it is as follows: ckey, characters, size when normal, size when small, size when big.
	var/list/letters = list()
	/// Additional letters that will be cached for each new client
	var/list/additional_letters = list()

/datum/controller/subsystem/timer/runechat/PreInit()
	. = ..()
	for(var/client/client in GLOB.clients)
		init_runechat_list(client)

/datum/controller/subsystem/timer/runechat/proc/preinit_runechat_list(client/actor)
	if(SSrunechat.letters[actor.ckey] == null)
		init_runechat_list(actor)
	else
		init_additional_letters(actor)

/datum/controller/subsystem/timer/runechat/proc/init_runechat_list(client/actor)
	var/ckey = actor.ckey
	letters[ckey] = EMPTY_CHARACTERS_LIST
	initialize_tokens[ckey] = 0

	for(var/key in (letters[ckey] | additional_letters))
		if(key == MAX_CHAR_WIDTH)
			continue
		letters[ckey][key] = list(null, null, null)
		initialize_tokens[ckey] += 3
		handle_single_letter(key, actor, NORMAL_FONT_INDEX)
		handle_single_letter(key, actor, SMALL_FONT_INDEX)
		handle_single_letter(key, actor, BIG_FONT_INDEX)

	while(initialize_tokens[ckey] > 0)
		sleep(world.tick_lag)

	if(!actor)
		//something went wrong, we'll try again when he reconnects
		letters[ckey] = null
	else
		letters[ckey][" "] = list(2, 2, 2)

	initialize_tokens -= ckey

/datum/controller/subsystem/timer/runechat/proc/init_additional_letters(client/actor)
	var/ckey = actor.ckey

	for(var/key in additional_letters)
		var/list/values = letters[ckey][key]
		if(length(values) == 3 && !values.Find(null))
			continue
		letters[ckey][key] = list(null, null, null)
		handle_single_letter(key, actor, NORMAL_FONT_INDEX)
		handle_single_letter(key, actor, SMALL_FONT_INDEX)
		handle_single_letter(key, actor, BIG_FONT_INDEX)

/// If the character is not found in precoded list, it'll be calculated for each client and added to their respective list
/datum/controller/subsystem/timer/runechat/proc/add_new_character_globally(character)
	if(additional_letters[character] == TRUE)
		return

	additional_letters[character] = TRUE
	for(var/client/actor in GLOB.clients)
		add_new_character_for_client(actor, character)

/datum/controller/subsystem/timer/runechat/proc/add_new_character_for_client(client/actor, character)
	set waitfor = FALSE

	if(!actor)
		return
	var/ckey = actor.ckey

	//We're already initializing the list for this user or it wasn't yet initialized
	if(initialize_tokens[ckey] != null || letters[ckey] == null)
		return

	initialize_tokens[ckey] = 3
	letters[ckey][character] = list(null, null, null)
	handle_single_letter(character, actor, NORMAL_FONT_INDEX)
	handle_single_letter(character, actor, SMALL_FONT_INDEX)
	handle_single_letter(character, actor, BIG_FONT_INDEX)

	while(initialize_tokens[ckey] > 0)
		sleep(world.tick_lag)

	for(var/value in letters[ckey][character])
		//We failed, client logged out mid measuring
		if(isnull(value))
			letters[ckey] = null

	initialize_tokens[ckey] = null

/datum/controller/subsystem/timer/runechat/proc/handle_single_letter(letter, client/measured_client, font_index)
	set waitfor = FALSE
	var/font_class
	if(font_index == NORMAL_FONT_INDEX)
		font_class = ""
	else if(font_index == SMALL_FONT_INDEX)
		font_class = "small"
	else
		font_class = "big"
	if(!measured_client)
		return FALSE
	var/response = WXH_TO_WIDTH(measured_client.MeasureText("<span class='[font_class]'>[letter]</span>"))
	letters[measured_client.ckey][letter][font_index] = response
	if(response > letters[measured_client.ckey][MAX_CHAR_WIDTH][font_index])
		letters[measured_client.ckey][MAX_CHAR_WIDTH][font_index] = response
	initialize_tokens[measured_client.ckey]--
	return TRUE
