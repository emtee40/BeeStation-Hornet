
/*
	Hello, friends, this is Doohl from sexylands. You may be wondering what this
	monstrous code file is. Sit down, boys and girls, while I tell you the tale.


	The telecom machines were designed to be compatible with any radio
	signals, provided they use subspace transmission. Currently they are only used for
	headsets, but they can eventually be outfitted for real COMPUTER networks. This
	is just a skeleton, ladies and gentlemen.

	Look at radio.dm for the prequel to this code.
*/

GLOBAL_LIST_EMPTY(telecomms_list)

/obj/machinery/telecomms
	icon = 'icons/obj/machines/telecomms.dmi'
	critical_machine = TRUE
	light_color = LIGHT_COLOR_CYAN
	flags_1 = SAVE_SAFE_1
	var/list/links = list() // list of machines this machine is linked to
	var/traffic = 0 // value increases as traffic increases
	var/netspeed = 2.5 // how much traffic to lose per second (50 gigabytes/second * netspeed)
	var/list/autolinkers = list() // list of text/number values to link with
	var/id = "NULL" // identification string
	var/network = "NULL" // the network of the machinery

	var/list/freq_listening = list() // list of frequencies to tune into: if none, will listen to all

	var/on = TRUE
	var/toggled = TRUE 	// Is it toggled on
	var/long_range_link = FALSE  // Can you link it across Z levels or on the otherside of the map? (Relay & Hub)
	var/hide = FALSE  // Is it a hidden machine?


/obj/machinery/telecomms/proc/relay_information(datum/signal/subspace/signal, filter, copysig, amount = 20)
	// relay signal to all linked machinery that are of type [filter]. If signal has been sent [amount] times, stop sending

	if(!on)
		return
	var/send_count = 0

	// Apply some lag based on traffic rates
	var/netlag = round(traffic / 50)
	if(netlag > signal.data["slow"])
		signal.data["slow"] = netlag

	// Loop through all linked machines and send the signal or copy.
	for(var/obj/machinery/telecomms/machine in links)
		if(filter && !istype( machine, filter ))
			continue
		if(!machine.on)
			continue
		if(amount && send_count >= amount)
			break
		if(get_virtual_z_level() != machine.loc.get_virtual_z_level() && !long_range_link && !machine.long_range_link)
			continue

		send_count++
		if(machine.is_freq_listening(signal))
			machine.traffic++

		if(copysig)
			machine.receive_information(signal.copy(), src)
		else
			machine.receive_information(signal, src)

	if(send_count > 0 && is_freq_listening(signal))
		traffic++

	return send_count

/obj/machinery/telecomms/proc/relay_direct_information(datum/signal/signal, obj/machinery/telecomms/machine)
	// send signal directly to a machine
	machine.receive_information(signal, src)

/obj/machinery/telecomms/proc/receive_information(datum/signal/signal, obj/machinery/telecomms/machine_from)
	// receive information from linked machinery

/obj/machinery/telecomms/proc/is_freq_listening(datum/signal/signal)
	// return TRUE if found, FALSE if not found
	return signal && (!freq_listening.len || (signal.frequency in freq_listening))

/obj/machinery/telecomms/Initialize(mapload)
	. = ..()
	GLOB.telecomms_list += src
	if(mapload && autolinkers.len)
		return INITIALIZE_HINT_LATELOAD

/obj/machinery/telecomms/LateInitialize()
	..()
	for(var/obj/machinery/telecomms/T in (long_range_link ? GLOB.telecomms_list : urange(20, src, 1)))
		add_link(T)

/obj/machinery/telecomms/Destroy()
	GLOB.telecomms_list -= src
	for(var/obj/machinery/telecomms/comm in GLOB.telecomms_list)
		comm.links -= src
	links = list()
	return ..()

// Used in auto linking
/obj/machinery/telecomms/proc/add_link(obj/machinery/telecomms/T)
	var/turf/position = get_turf(src)
	var/turf/T_position = get_turf(T)
	var/same_zlevel = FALSE
	if(position && T_position)	//Stops a bug with a phantom telecommunications interceptor which is spawned by circuits caching their components into nullspace
		if(position.get_virtual_z_level() == T_position.get_virtual_z_level())
			same_zlevel = TRUE
	if(same_zlevel || (long_range_link && T.long_range_link))
		if(src != T)
			for(var/x in autolinkers)
				if(x in T.autolinkers)
					links |= T
					T.links |= src


/obj/machinery/telecomms/update_icon()
	if(on)
		if(panel_open)
			icon_state = "[initial(icon_state)]_o"
		else
			icon_state = initial(icon_state)
	else
		if(panel_open)
			icon_state = "[initial(icon_state)]_o_off"
		else
			icon_state = "[initial(icon_state)]_off"

/obj/machinery/telecomms/proc/update_power()
	var/newState = on

	if(toggled)
		if(stat & (BROKEN|NOPOWER|EMPED)) // if powered, on. if not powered, off. if too damaged, off
			newState = FALSE
		else
			newState = TRUE
	else
		newState = FALSE

	if(newState != on)
		on = newState
		ui_update()
		set_light(on)

/obj/machinery/telecomms/process(delta_time)
	update_power()

	// Update the icon
	update_icon()

	if(traffic > 0)
		traffic -= netspeed * delta_time

/obj/machinery/telecomms/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(prob(100/severity) && !(stat & EMPED))
		stat |= EMPED
		var/duration = (300 * 10)/severity
		addtimer(CALLBACK(src, .proc/de_emp), rand(duration - 20, duration + 20))

/obj/machinery/telecomms/obj_break(damage_flag)
	. = ..()
	update_power()

/obj/machinery/telecomms/power_change()
	..()
	update_power()

/obj/machinery/telecomms/proc/de_emp()
	stat &= ~EMPED

//================
// TELECOMMUNICATIONS MAP SAVE
// Telecomm networks on a saved map will autolink when spawned in!
//================

/obj/machinery/telecomms/get_pre_save_key()
	return network

//Run through all machines in the group and generate autolinkers
/obj/machinery/telecomms/pre_save(list/group, pre_save_key = "")
	//Makes it very rare that 2 maps will have the same autolinkers
	var/static/per_round = 0
	var/map_key = "[GLOB.round_id]_[per_round++]"	//Will always be unique!""
	var/index = 0
	//Pre save vars so they can be reset after save
	for(var/obj/machinery/telecomms/commmachine in group)
		commmachine.pre_saved_vars = list()
		commmachine.pre_saved_vars["autolinkers"] = commmachine.autolinkers
		commmachine.autolinkers = list()
	//Don't double link machines
	var/list/linked_assoc = list()
	//For every machine in the group, calculate connections
	for(var/obj/machinery/telecomms/commmachine in group)
		linked_assoc[commmachine] = list()
		for(var/obj/machinery/telecomms/linked_machine in commmachine.links)
			//Linked machine is not saved
			if(!(linked_machine in group))
				continue
			//Mark as being linked
			linked_assoc[commmachine] += linked_machine
			//Check if the linked machine is already connected to us
			if(commmachine in linked_assoc[linked_machine])
				continue
			//Generate an autolinker
			var/link_key = "SAVEDLINK[map_key]_[index++]"
			linked_machine.autolinkers += link_key
			commmachine.autolinkers += link_key
	return TRUE

/obj/machinery/telecomms/get_save_vars(save_flag)
	. = list()
	//Save autolinkers
	var/list/autolinkers_txt = list()
	for(var/autolink in autolinkers)
		autolinkers_txt += "\"[autolink]\""
	.["autolinkers"] = "list([autolinkers_txt.Join(", ")])"
