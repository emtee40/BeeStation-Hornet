
/*

	All telecommunications interactions:

*/

/obj/machinery/telecomms
	var/temp = "" // output message
	var/tempfreq = FREQ_COMMON
	emp_disable_time = 5 MINUTES

/obj/machinery/telecomms/attackby(obj/item/P, mob/user, params)

	var/icon_closed = initial(icon_state)
	var/icon_open = "[initial(icon_state)]_o"
	if(!on)
		icon_closed = "[initial(icon_state)]_off"
		icon_open = "[initial(icon_state)]_o_off"

	if(default_deconstruction_screwdriver(user, icon_open, icon_closed, P))
		return
	// Using a multitool lets you access the receiver's interface
	else if(P.tool_behaviour == TOOL_MULTITOOL)
		attack_hand(user)

	else if(default_deconstruction_crowbar(P))
		return
	else
		return ..()

/obj/machinery/telecomms/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Telecomms")
		ui.open()

/obj/machinery/telecomms/ui_data(mob/user)
	var/list/data = list()

	data += add_option()

	data["minfreq"] = MIN_FREE_FREQ
	data["maxfreq"] = MAX_FREE_FREQ
	data["frequency"] = tempfreq

	var/datum/component/buffer/heldmultitool = get_held_buffer_item(user)
	data["multitool"] = heldmultitool?.parent

	if(heldmultitool?.parent)
		data["multibuff"] = heldmultitool.target

	data["toggled"] = toggled
	data["id"] = id
	data["network"] = network
	data["prefab"] = autolinkers.len ? TRUE : FALSE

	var/list/linked = list()
	var/i = 0
	data["linked"] = list()
	for(var/obj/machinery/telecomms/machine in links)
		if(machine.hide && !hide)
			continue
		i++			//Original was above the check if machine is hidden, index revealed there are more machines
		var/list/entry = list()
		entry["index"] = i
		entry["name"] = machine.name
		entry["id"] = machine.id
		linked += list(entry)
	data["linked"] = linked

	var/list/frequencies = list()
	data["frequencies"] = list()
	for(var/x in freq_listening)
		frequencies += list(x)
	data["frequencies"] = frequencies

	return data

/obj/machinery/telecomms/ui_act(action, params)
	if(..())
		return

	if(!issilicon(usr) && !istype(usr.get_active_held_item(), /obj/item/multitool))
		return

	var/datum/component/buffer/heldmultitool = get_held_buffer_item(usr)

	switch(action)
		if("toggle")
			toggled = !toggled
			update_power()
			update_icon_state()
			log_game("[key_name(usr)] toggled [toggled ? "On" : "Off"] [src] at [AREACOORD(src)].")
			. = TRUE
		if("id")
			if(params["value"])
				if(length(params["value"]) > 32)
					to_chat(usr, "<span class='warning'>Error: Machine ID too long!</span>")
					playsound(src, 'sound/machines/buzz-sigh.ogg', 50, TRUE)
					return
				else
					id = params["value"]
					log_game("[key_name(usr)] has changed the ID for [src] at [AREACOORD(src)] to [id].")
					. = TRUE
		if("network")
			if(params["value"])
				if(length(params["value"]) > 15)
					to_chat(usr, "<span class='warning'>Error: Network name too long!</span>")
					playsound(src, 'sound/machines/buzz-sigh.ogg', 50, TRUE)
					return
				else
					for(var/obj/machinery/telecomms/T in links)
						T.links.Remove(src)
						T.ui_update()
					network = params["value"]
					links = list()
					log_game("[key_name(usr)] has changed the network for [src] at [AREACOORD(src)] to [network].")
					. = TRUE
		if("tempfreq")
			if(params["value"])
				tempfreq = text2num(params["value"]) * 10
				. = TRUE
		if("freq")
			var/newfreq = tempfreq			//* 10 was in original pr here but makes out of tempfreq something like 14590
			if(newfreq == FREQ_SYNDICATE)
				to_chat(usr, "<span class='warning'>Error: Interference preventing filtering frequency: \"[newfreq / 10] GHz\"</span>")
				playsound(src, 'sound/machines/buzz-sigh.ogg', 50, TRUE)
			else
				if(!(newfreq in freq_listening) && newfreq < 10000)
					freq_listening.Add(newfreq)
					log_game("[key_name(usr)] added frequency [newfreq] for [src] at [AREACOORD(src)].")
					. = TRUE
		if("delete")
			freq_listening.Remove(params["value"])
			log_game("[key_name(usr)] removed frequency [params["value"]] for [src] at [AREACOORD(src)].")
			. = TRUE
		if("unlink")
			var/obj/machinery/telecomms/T = links[text2num(params["value"])]
			if(T)
				// Remove link entries from both T and src.
				if(T.links)
					T.links.Remove(src)
					T.ui_update()
				links.Remove(T)
				log_game("[key_name(usr)] unlinked [src] and [T] at [AREACOORD(src)].")
				. = TRUE
		if("link")
			if(heldmultitool)
				var/obj/machinery/telecomms/T = heldmultitool.target
				if(istype(T) && T != src)
					if(!(src in T.links))
						T.links += src
						T.ui_update()
					if(!(T in links))
						links += T
						log_game("[key_name(usr)] linked [src] for [T] at [AREACOORD(src)].")
						. = TRUE
		if("buffer")
			STORE_IN_BUFFER(heldmultitool.parent, src)
			. = TRUE
		if("flush")
			FLUSH_BUFFER(heldmultitool.parent)
			. = TRUE

	if(add_act(action, params))
		. = TRUE

/obj/machinery/telecomms/proc/add_option()
	return

/obj/machinery/telecomms/bus/add_option()
	var/list/data = list()
	data["type"] = "bus"
	data["changefrequency"] = change_frequency
	return data

/obj/machinery/telecomms/relay/add_option()
	var/list/data = list()
	data["type"] = "relay"
	data["broadcasting"] = broadcasting
	data["receiving"] = receiving
	return data

/obj/machinery/telecomms/proc/add_act(action, params)

/obj/machinery/telecomms/relay/add_act(action, params)
	switch(action)
		if("broadcast")
			broadcasting = !broadcasting
			. = TRUE
		if("receive")
			receiving = !receiving
			. = TRUE

/obj/machinery/telecomms/bus/add_act(action, params)
	switch(action)
		if("change_freq")
			var/newfreq = text2num(params["value"]) * 10
			if(newfreq)
				if(newfreq < 10000)
					change_frequency = newfreq
					. = TRUE
				else
					change_frequency = 0
					. = TRUE

// Returns a multitool from a user depending on their mobtype.

/obj/machinery/telecomms/proc/get_held_buffer_item(mob/user)
	// Let's double check
	var/obj/item/held_item = user.get_active_held_item()
	if(!issilicon(user) && held_item?.GetComponent(/datum/component/buffer))
		return held_item?.GetComponent(/datum/component/buffer)
	else if(isAI(user))
		var/mob/living/silicon/ai/U = user
		return U.aiMulti.GetComponent(/datum/component/buffer)
	else if(iscyborg(user) && in_range(user, src))
		if(held_item?.GetComponent(/datum/component/buffer))
			return held_item?.GetComponent(/datum/component/buffer)
	return null

/obj/machinery/telecomms/proc/canAccess(mob/user)
	if(issilicon(user) || in_range(user, src))
		return TRUE
	return FALSE
