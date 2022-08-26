GLOBAL_LIST_EMPTY(TabletMessengers) // a list of all active messengers, similar to GLOB.PDAs (used primarily with ntmessenger.dm)

// This is the base type that does all the hardware stuff.
// Other types expand it - tablets use a direct subtypes, and
// consoles and laptops use "procssor" item that is held inside machinery piece
/obj/item/modular_computer
	name = "modular microcomputer"
	desc = "A small portable microcomputer."

	var/enabled = 0											// Whether the computer is turned on.
	var/screen_on = 1										// Whether the computer is active/opened/it's screen is on.
	/// If it's bypassing the set icon state
	var/bypass_state = FALSE
	/// Whether or not the computer can be upgraded
	var/upgradable = TRUE
	/// Whether or not the computer can be deconstructed
	var/deconstructable = TRUE
	/// Sets the theme for the main menu, hardware config, and file browser apps.
	var/device_theme = "ntos-default"
	var/datum/computer_file/program/active_program = null	// A currently active program running on the computer.
	var/hardware_flag = 0									// A flag that describes this device type
	var/last_power_usage = 0
	var/last_battery_percent = 0							// Used for deciding if battery percentage has chandged
	var/last_world_time = "00:00"
	var/list/last_header_icons

	var/base_active_power_usage = 50						// Power usage when the computer is open (screen is active) and can be interacted with. Remember hardware can use power too.
	var/base_idle_power_usage = 5							// Power usage when the computer is idle and screen is off (currently only applies to laptops)

	// Modular computers can run on various devices. Each DEVICE (Laptop, Console, Tablet,..)
	// must have it's own DMI file. Icon states must be called exactly the same in all files, but may look differently
	// If you create a program which is limited to Laptops and Consoles you don't have to add it's icon_state overlay for Tablets too, for example.

	icon = 'icons/obj/computer.dmi'
	icon_state = "laptop-open"
	var/icon_state_unpowered = null							// Icon state when the computer is turned off.
	var/icon_state_powered = null							// Icon state when the computer is turned on.
	var/icon_state_menu = "menu"							// Icon state overlay when the computer is turned on, but no program is loaded that would override the screen.
	var/max_hardware_size = 0								// Maximal hardware w_class. Tablets/PDAs have 1, laptops 2, consoles 4.
	var/steel_sheet_cost = 5								// Amount of steel sheets refunded when disassembling an empty frame of this computer.

	integrity_failure = 50
	max_integrity = 100
	armor = list("melee" = 0, "bullet" = 20, "laser" = 20, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0, "stamina" = 0)

	/// List of "connection ports" in this computer and the components with which they are plugged
	var/list/all_components = list()
	/// Lazy List of extra hardware slots that can be used modularly.
	var/list/expansion_bays
	/// Number of total expansion bays this computer has available.
	var/max_bays = 0

	/// The currently imprinted ID.
	var/saved_identification = null
	/// The currently imprinted job.
	var/saved_job = null
	/// The amount of honks. honk honk honk honk honk honkh onk honkhnoohnk
	var/honk_amount = 0
	var/list/idle_threads							// Idle programs on background. They still receive process calls but can't be interacted with.
	var/obj/physical = null									// Object that represents our computer. It's used for Adjacent() and UI visibility checks.
	var/has_light = FALSE						//If the computer has a flashlight/LED light/what-have-you installed
	var/comp_light_luminosity = 3				//The brightness of that light
	var/comp_light_color			//The color of that light
	/// Override behavior from atom so flashlight button is not marked as ON
	light_on = FALSE
	/// Whether or not the tablet is invisible in messenger and other apps
	var/messenger_invisible = FALSE
	/// The saved image used for messaging purposes
	var/datum/picture/saved_image
	/// The ringtone that will be set on initialize
	var/init_ringtone = "beep"
	/// If the device starts with its ringer on
	var/init_ringer_on = TRUE

/obj/item/modular_computer/Initialize(mapload)
	. = ..()

	var/obj/item/computer_hardware/identifier/id = all_components[MC_IDENTIFY]
	START_PROCESSING(SSobj, src)
	if(!physical)
		physical = src
	comp_light_color = "#FFFFFF"
	idle_threads = list()
	if(id)
		id.UpdateDisplay()
	update_icon()
	add_messenger()

/obj/item/modular_computer/Destroy()
	kill_program(forced = TRUE)
	STOP_PROCESSING(SSobj, src)
	for(var/port in all_components)
		var/obj/item/computer_hardware/component = all_components[port]
		qdel(component)
	all_components?.Cut()
	physical = null
	remove_messenger()
	return ..()

/// From [/datum/newscaster/feed_network/proc/save_photo]
/obj/item/modular_computer/proc/save_photo(icon/photo)
	var/photo_file = copytext_char(md5("/icon[photo]"), 1, 6)
	if(!fexists("[GLOB.log_directory]/photos/[photo_file].png"))
		//Clean up repeated frames
		var/icon/clean = new /icon()
		clean.Insert(photo, "", SOUTH, 1, 0)
		fcopy(clean, "[GLOB.log_directory]/photos/[photo_file].png")
	return photo_file

/**
 * Plays a ping sound.
 *
 * Timers runtime if you try to make them call playsound. Yep.
 */
/obj/item/modular_computer/proc/play_ping()
	playsound(loc, 'sound/machines/ping.ogg', get_clamped_volume(), FALSE, -1)

/obj/item/modular_computer/AltClick(mob/user)
	if(issilicon(user) || !user.canUseTopic(src, BE_CLOSE))
		return FALSE
	var/obj/item/computer_hardware/card_slot/card_slot2 = all_components[MC_CARD2]
	var/obj/item/computer_hardware/card_slot/card_slot = all_components[MC_CARD]
	if(!card_slot2?.try_eject(user))
		return card_slot?.try_eject(user)
	return TRUE

// Gets IDs/access levels from card slot. Would be useful when/if PDAs would become modular PCs. (They are now!! you are welcome - itsmeow)
/obj/item/modular_computer/GetAccess()
	var/obj/item/computer_hardware/card_slot/card_slot = all_components[MC_CARD]
	if(card_slot)
		return card_slot.GetAccess()
	return ..()

/obj/item/modular_computer/GetID()
	var/obj/item/computer_hardware/card_slot/card_slot = all_components[MC_CARD]
	if(card_slot)
		return card_slot.GetID()
	return ..()

/obj/item/modular_computer/RemoveID()
	var/obj/item/computer_hardware/card_slot/card_slot2 = all_components[MC_CARD2]
	var/obj/item/computer_hardware/card_slot/card_slot = all_components[MC_CARD]
	return (card_slot2?.try_eject() || card_slot?.try_eject()) //Try the secondary one first.

/obj/item/modular_computer/InsertID(obj/item/inserting_item)
	var/obj/item/computer_hardware/card_slot/card_slot = all_components[MC_CARD]
	var/obj/item/computer_hardware/card_slot/card_slot2 = all_components[MC_CARD2]

	if(!(card_slot || card_slot2))
		return FALSE

	var/obj/item/card/inserting_id = inserting_item.GetID()
	if(!inserting_id)
		return FALSE

	if((card_slot?.try_insert(inserting_id)) || (card_slot2?.try_insert(inserting_id)))
		return TRUE
	return FALSE

/obj/item/modular_computer/MouseDrop(obj/over_object, src_location, over_location)
	var/mob/M = usr
	if((!istype(over_object, /atom/movable/screen)) && usr.canUseTopic(src, BE_CLOSE))
		return attack_self(M)
	return ..()

/obj/item/modular_computer/attack_ai(mob/user)
	return attack_self(user)

/obj/item/modular_computer/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(.)
		return
	if(enabled)
		ui_interact(user)
	else if(IsAdminGhost(user))
		var/response = alert(user, "This computer is turned off. Would you like to turn it on?", "Admin Override", "Yes", "No")
		if(response == "Yes")
			turn_on(user)

/obj/item/modular_computer/emag_act(mob/user)
	if(!enabled)
		to_chat(user, "<span class='warning'>You'd need to turn the [src] on first.</span>")
		return FALSE
	obj_flags |= EMAGGED //Mostly for consistancy purposes; the programs will do their own emag handling
	var/newemag = FALSE
	var/obj/item/computer_hardware/hard_drive/drive = all_components[MC_HDD]
	for(var/datum/computer_file/program/app in drive.stored_files)
		if(!istype(app))
			continue
		if(app.run_emag())
			newemag = TRUE
	if(newemag)
		to_chat(user, "<span class='notice'>You swipe \the [src]. A console window momentarily fills the screen, with white text rapidly scrolling past.</span>")
		return TRUE
	to_chat(user, "<span class='notice'>You swipe \the [src]. A console window fills the screen, but it quickly closes itself after only a few lines are written to it.</span>")
	return FALSE

/obj/item/modular_computer/examine(mob/user)
	. = ..()
	if(obj_integrity <= integrity_failure)
		. += "<span class='danger'>It is heavily damaged!</span>"
	else if(obj_integrity < max_integrity)
		. += "<span class='warning'>It is damaged.</span>"

	. += get_modular_computer_parts_examine(user)

/obj/item/modular_computer/update_icon()
	cut_overlays()
	if(!bypass_state)
		icon_state = enabled ? icon_state_powered : icon_state_unpowered

	var/init_icon = initial(icon)
	if(!init_icon)
		return

	if(enabled)
		add_overlay(active_program ? mutable_appearance(init_icon, active_program.program_icon_state) : mutable_appearance(init_icon, icon_state_menu))

	if(obj_integrity <= integrity_failure)
		add_overlay(mutable_appearance(init_icon, "bsod"))
		add_overlay(mutable_appearance(init_icon, "broken"))


// On-click handling. Turns on the computer if it's off and opens the GUI.
/obj/item/modular_computer/interact(mob/user)
	if(enabled)
		ui_interact(user)
	else
		turn_on(user)

/obj/item/modular_computer/proc/turn_on(mob/user)
	var/issynth = issilicon(user) // Robots and AIs get different activation messages.
	if(obj_integrity <= integrity_failure)
		if(issynth)
			to_chat(user, "<span class='warning'>You send an activation signal to \the [src], but it responds with an error code. It must be damaged.</span>")
		else
			to_chat(user, "<span class='warning'>You press the power button, but the computer fails to boot up, displaying variety of errors before shutting down again.</span>")
		return

	// If we have a recharger, enable it automatically. Lets computer without a battery work.
	var/obj/item/computer_hardware/recharger/recharger = all_components[MC_CHARGE]
	if(recharger)
		recharger.enabled = 1

	if(all_components[MC_CPU] && use_power()) // use_power() checks if the PC is powered
		if(issynth)
			to_chat(user, "<span class='notice'>You send an activation signal to \the [src], turning it on.</span>")
		else
			to_chat(user, "<span class='notice'>You press the power button and start up \the [src].</span>")
		enabled = 1
		update_icon()
		ui_interact(user)
	else // Unpowered
		if(issynth)
			to_chat(user, "<span class='warning'>You send an activation signal to \the [src] but it does not respond.</span>")
		else
			to_chat(user, "<span class='warning'>You press the power button but \the [src] does not respond.</span>")

// Process currently calls handle_power(), may be expanded in future if more things are added.
/obj/item/modular_computer/process(delta_time)
	if(!enabled) // The computer is turned off
		last_power_usage = 0
		return 0

	if(obj_integrity <= integrity_failure)
		shutdown_computer()
		return 0

	if(active_program && active_program.requires_ntnet && !get_ntnet_status(active_program.requires_ntnet_feature))
		active_program.event_networkfailure(0) // Active program requires NTNet to run but we've just lost connection. Crash.

	for(var/I in idle_threads)
		var/datum/computer_file/program/P = I
		if(P.requires_ntnet && !get_ntnet_status(P.requires_ntnet_feature))
			P.event_networkfailure(1)

	if(active_program)
		if(active_program.program_state != PROGRAM_STATE_KILLED)
			active_program.process_tick(delta_time)
			active_program.ntnet_status = get_ntnet_status()
		else
			active_program = null

	for(var/I in idle_threads)
		var/datum/computer_file/program/P = I
		if(P.program_state != PROGRAM_STATE_KILLED)
			P.process_tick(delta_time)
			P.ntnet_status = get_ntnet_status()
		else
			idle_threads.Remove(P)

	handle_power(delta_time) // Handles all computer power interaction
	//check_update_ui_need()

/**
  * Displays notification text alongside a soundbeep when requested to by a program.
  *
  * After checking that the requesting program is allowed to send an alert, creates
  * a visible message of the requested text alongside a soundbeep. This proc adds
  * text to indicate that the message is coming from this device and the program
  * on it, so the supplied text should be the exact message and ending punctuation.
  *
  * Arguments:
  * The program calling this proc.
  * The message that the program wishes to display.
 */

/obj/item/modular_computer/proc/alert_call(datum/computer_file/program/caller, alerttext, sound = 'sound/machines/twobeep_high.ogg')
	if(!caller || !caller.alert_able || caller.alert_silenced || !alerttext) //Yeah, we're checking alert_able. No, you don't get to make alerts that the user can't silence.
		return
	playsound(src, sound, 50, TRUE)
	visible_message("<span class='notice'>The [src] displays a [caller.filedesc] notification: [alerttext]</span>")
	var/mob/living/holder = loc
	if(istype(holder))
		to_chat(holder, "[icon2html(src)] <span class='notice'>The [src] displays a [caller.filedesc] notification: [alerttext]</span>")

/obj/item/modular_computer/proc/ring(ringtone) // bring bring
	if(HAS_TRAIT(SSstation, STATION_TRAIT_PDA_GLITCHED))
		playsound(src, pick('sound/machines/twobeep_voice1.ogg', 'sound/machines/twobeep_voice2.ogg'), 50, TRUE)
	else
		playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
	visible_message("*[ringtone]*")

/obj/item/modular_computer/proc/send_sound()
	playsound(src, 'sound/machines/terminal_success.ogg', 15, TRUE)

// Function used by NanoUI's to obtain data for header. All relevant entries begin with "PC_"
/obj/item/modular_computer/proc/get_header_data()
	var/list/data = list()

	data["PC_device_theme"] = device_theme

	var/obj/item/computer_hardware/battery/battery_module = all_components[MC_CELL]
	var/obj/item/computer_hardware/recharger/recharger = all_components[MC_CHARGE]

	if(battery_module?.battery)
		switch(battery_module.battery.percent())
			if(80 to 200) // 100 should be maximal but just in case..
				data["PC_batteryicon"] = "batt_100.gif"
			if(60 to 80)
				data["PC_batteryicon"] = "batt_80.gif"
			if(40 to 60)
				data["PC_batteryicon"] = "batt_60.gif"
			if(20 to 40)
				data["PC_batteryicon"] = "batt_40.gif"
			if(5 to 20)
				data["PC_batteryicon"] = "batt_20.gif"
			else
				data["PC_batteryicon"] = "batt_5.gif"
		data["PC_batterypercent"] = "[round(battery_module.battery.percent())]%"
		data["PC_showbatteryicon"] = 1
	else
		data["PC_batteryicon"] = "batt_5.gif"
		data["PC_batterypercent"] = "N/C"
		data["PC_showbatteryicon"] = battery_module ? 1 : 0

	if(recharger && recharger.enabled && recharger.check_functionality() && recharger.use_power(0))
		data["PC_apclinkicon"] = "charging.gif"

	switch(get_ntnet_status())
		if(0)
			data["PC_ntneticon"] = "sig_none.gif"
		if(1)
			data["PC_ntneticon"] = "sig_low.gif"
		if(2)
			data["PC_ntneticon"] = "sig_high.gif"
		if(3)
			data["PC_ntneticon"] = "sig_lan.gif"

	if(length(idle_threads))
		var/list/program_headers = list()
		for(var/I in idle_threads)
			var/datum/computer_file/program/P = I
			if(!P.ui_header)
				continue
			program_headers.Add(list(list(
				"icon" = P.ui_header
			)))

		data["PC_programheaders"] = program_headers

	data["PC_stationtime"] = station_time_timestamp()
	data["PC_hasheader"] = 1
	data["PC_showexitprogram"] = active_program ? 1 : 0 // Hides "Exit Program" button on mainscreen
	return data

// Relays kill program request to currently active program. Use this to quit current program.
/obj/item/modular_computer/proc/kill_program(forced = FALSE)
	if(active_program)
		active_program.kill_program(forced)
		active_program = null
	var/mob/user = usr
	if(user && istype(user))
		ui_interact(user) // Re-open the UI on this computer. It should show the main screen now.
	update_icon()

// Returns 0 for No Signal, 1 for Low Signal and 2 for Good Signal. 3 is for wired connection (always-on)
/obj/item/modular_computer/proc/get_ntnet_status(specific_action = 0)
	var/obj/item/computer_hardware/network_card/network_card = all_components[MC_NET]
	if(network_card)
		return network_card.get_signal(specific_action)
	else
		return 0

/obj/item/modular_computer/proc/add_log(text)
	if(!get_ntnet_status())
		return FALSE
	var/obj/item/computer_hardware/network_card/network_card = all_components[MC_NET]
	return SSnetworks.add_log(text, network_card.GetComponent(/datum/component/ntnet_interface).network, network_card.hardware_id)

/obj/item/modular_computer/proc/shutdown_computer(loud = 1)
	kill_program(forced = TRUE)
	for(var/datum/computer_file/program/P in idle_threads)
		P.kill_program(forced = TRUE)
		idle_threads.Remove(P)
	if(loud)
		physical.visible_message("<span class='notice'>\The [src] shuts down.</span>")
	enabled = 0
	update_icon()

/**
  * Toggles the computer's flashlight, if it has one.
  *
  * Called from ui_act(), does as the name implies.
  * It is seperated from ui_act() to be overwritten as needed.
*/
/obj/item/modular_computer/proc/toggle_flashlight()
	if(!has_light)
		return FALSE
	set_light_on(!light_on)
	if(light_on)
		set_light(comp_light_luminosity, 1, comp_light_color)
	else
		set_light(0)
	update_icon()
	return TRUE

/**
  * Sets the computer's light color, if it has a light.
  *
  * Called from ui_act(), this proc takes a color string and applies it.
  * It is seperated from ui_act() to be overwritten as needed.
  * Arguments:
  ** color is the string that holds the color value that we should use. Proc auto-fails if this is null.
*/
/obj/item/modular_computer/proc/set_flashlight_color(color)
	if(!has_light || !color)
		return FALSE
	comp_light_color = color
	set_light_color(color)
	update_light()
	return TRUE

/obj/item/modular_computer/screwdriver_act(mob/user, obj/item/tool)
	if(!deconstructable)
		return
	if(!length(all_components))
		balloon_alert(user, "no components installed!")
		return
	var/list/component_names = list()
	for(var/h in all_components)
		var/obj/item/computer_hardware/H = all_components[h]
		component_names.Add(H.name)

	var/choice = input(user, "Which component do you want to uninstall?", "Computer maintenance", null) as null|anything in sortList(component_names)

	if(!choice)
		return

	if(!Adjacent(user))
		return

	var/obj/item/computer_hardware/H = find_hardware_by_name(choice)

	if(!H)
		return

	tool.play_tool_sound(user, volume=20)
	uninstall_component(H, user)
	return

/obj/item/modular_computer/attackby(obj/item/W as obj, mob/user as mob)
	// Check for ID first
	if(istype(W, /obj/item/card/id) && InsertID(W))
		return

	// Scan a photo.
	if(istype(W, /obj/item/photo))
		var/obj/item/computer_hardware/hard_drive/hdd = all_components[MC_HDD]
		var/obj/item/photo/pic = W
		if(hdd)
			for(var/datum/computer_file/program/messenger/messenger in hdd.stored_files)
				saved_image = pic.picture
				messenger.ProcessPhoto()
		return

	// Insert items into the components
	for(var/h in all_components)
		var/obj/item/computer_hardware/H = all_components[h]
		if(H.try_insert(W, user))
			return

	// Insert new hardware
	if(istype(W, /obj/item/computer_hardware) && upgradable)
		if(install_component(W, user))
			return

	if(W.tool_behaviour == TOOL_WRENCH)
		if(length(all_components))
			balloon_alert(user, "remove the other components!")
			return
		W.play_tool_sound(src, user, 20, volume=20)
		new /obj/item/stack/sheet/iron( get_turf(src.loc), steel_sheet_cost )
		user.balloon_alert(user, "disassembled")
		relay_qdel()
		qdel(src)
		return

	if(W.tool_behaviour == TOOL_WELDER)
		if(obj_integrity == max_integrity)
			to_chat(user, "<span class='warning'>\The [src] does not require repairs.</span>")
			return

		if(!W.tool_start_check(user, amount=1))
			return

		to_chat(user, "<span class='notice'>You begin repairing damage to \the [src]...</span>")
		if(W.use_tool(src, user, 20, volume=50, amount=1))
			obj_integrity = max_integrity
			to_chat(user, "<span class='notice'>You repair \the [src].</span>")
			update_icon()
		return

	..()

// Used by processor to relay qdel() to machinery type.
/obj/item/modular_computer/proc/relay_qdel()
	return

// Perform adjacency checks on our physical counterpart, if any.
/obj/item/modular_computer/Adjacent(atom/neighbor)
	if(physical && physical != src)
		return physical.Adjacent(neighbor)
	return ..()

/obj/item/modular_computer/proc/add_messenger()
	GLOB.TabletMessengers += src

/obj/item/modular_computer/proc/remove_messenger()
	GLOB.TabletMessengers -= src
