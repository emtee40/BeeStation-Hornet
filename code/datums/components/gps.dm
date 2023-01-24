///Global GPS_list. All  GPS components get saved in here for easy reference.
GLOBAL_LIST_EMPTY(GPS_list)
///GPS component. Atoms that have this show up on gps. Pretty simple stuff.
/datum/component/gps
	var/gpstag = "COM0"
	var/tracking = TRUE
	var/emped = FALSE
	var/distress_beacon = FALSE //If enabled, will create a signal that can be detected on orbital maps

/datum/component/gps/Initialize(_gpstag = "COM0")
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	gpstag = _gpstag
	GLOB.GPS_list += src

/datum/component/gps/Destroy()
	GLOB.GPS_list -= src
	return ..()

///GPS component subtype. Only gps/item's can be used to open the UI.
/datum/component/gps/item
	var/updating = TRUE //Automatic updating of GPS list. Can be set to manual by user.
	var/global_mode = TRUE //If disabled, only GPS signals of the same Z level are shown
	var/distress_virtual_z
	var/distress_activated_at
	// The beacon sound
	var/datum/looping_sound/beacon/beacon_sound
	var/state

/datum/component/gps/item/Initialize(_gpstag = "COM0", emp_proof = FALSE, state = null, distress = FALSE)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE || !isitem(parent))
		return COMPONENT_INCOMPATIBLE

	beacon_sound = new(parent)

	if(isnull(state))
		state = GLOB.default_state
	src.state = state

	var/atom/A = parent
	A.add_overlay("working")
	A.name = "[initial(A.name)] ([gpstag])"
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, .proc/interact)
	if(!emp_proof)
		RegisterSignal(parent, COMSIG_ATOM_EMP_ACT, .proc/on_emp_act)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	RegisterSignal(parent, COMSIG_CLICK_ALT, .proc/on_AltClick)
	RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/parent_destroyed)
	if(distress)
		enable_distress_signal()

/datum/component/gps/item/Destroy()
	. = ..()
	//In case we haven't already (Removed from parent), disable distress
	disable_distress_signal()
	if(beacon_sound)
		QDEL_NULL(beacon_sound)

/datum/component/gps/item/proc/parent_destroyed(datum/source, force)
	disable_distress_signal()
	if(beacon_sound)
		QDEL_NULL(beacon_sound)

///Called on COMSIG_ITEM_ATTACK_SELF
/datum/component/gps/item/proc/interact(datum/source, mob/user)
	SIGNAL_HANDLER

	if(user)
		INVOKE_ASYNC(src, .proc/ui_interact, user)

///Called on COMSIG_PARENT_EXAMINE
/datum/component/gps/item/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += "<span class='notice'>Alt-click to switch it [tracking ? "off":"on"].</span>"

///Called on COMSIG_ATOM_EMP_ACT
/datum/component/gps/item/proc/on_emp_act(datum/source, severity)
	SIGNAL_HANDLER

	emped = TRUE
	var/atom/A = parent
	A.cut_overlay("working")
	A.add_overlay("emp")
	addtimer(CALLBACK(src, .proc/reboot), 300, TIMER_UNIQUE|TIMER_OVERRIDE) //if a new EMP happens, remove the old timer so it doesn't reactivate early
	SStgui.close_uis(src) //Close the UI control if it is open.
	disable_distress_signal()

/datum/component/gps/item/proc/enable_distress_signal()
	//Prevent enabling while in the process of QDELing
	if(emped || QDELETED(parent) || distress_beacon)
		return
	//Enable the beacon
	beacon_sound?.start()
	distress_beacon = TRUE
	//Enable beacon
	var/turf/current_location = get_turf(parent)
	if(current_location)
		var/virtual_location = current_location.get_virtual_z_level()
		if(!SSorbits.assoc_distress_beacons.Find("[virtual_location]"))
			SSorbits.assoc_distress_beacons["[virtual_location]"] = 0
		SSorbits.assoc_distress_beacons["[virtual_location]"] ++
		distress_virtual_z = virtual_location
	//Add a cooldown to prevent spamming radio messages
	if (world.time < distress_activated_at + 30 SECONDS)
		//Trigger a radio message on the station
		addtimer(src, CALLBACK(src, .proc/detect_signal), 20 SECONDS)
		distress_activated_at = world.time
	//Start Processing
	START_PROCESSING(SSprocessing, src)

/datum/component/gps/item/proc/detect_signal()
	//Distress beacon disabled
	if(emped || QDELETED(parent) || !distress_beacon)
		return

	// Determine the identity information which will be attached to the signal.
	var/atom/movable/virtualspeaker/speaker = new(null, src, src)

	// Construct the signal
	var/datum/signal/subspace/vocal/signal = new(src, FREQ_COMMON, speaker, /datum/language/common, scramble_message_replace_chars("Emergency distress signal activated, location displayed on orbital maps.", 10), list(), list())

	signal.data["compression"] = 0
	signal.transmission_method = TRANSMISSION_SUPERSPACE
	signal.levels = list(0)  // reaches all Z-levels
	signal.broadcast()

/datum/component/gps/item/proc/disable_distress_signal()
	if(!distress_beacon)
		return
	beacon_sound?.stop()
	distress_beacon = FALSE
	//Disable the beacon
	var/turf/current_location = get_turf(parent)
	if(current_location)
		var/virtual_location = current_location.get_virtual_z_level()
		if(SSorbits.assoc_distress_beacons.Find("[virtual_location]"))
			SSorbits.assoc_distress_beacons["[virtual_location]"] --
	//Stop processing
	STOP_PROCESSING(SSprocessing, src)

/datum/component/gps/item/process(delta_time)
	var/turf/current_location = get_turf(parent)
	var/new_virtual_z = current_location.get_virtual_z_level()
	if(new_virtual_z == distress_virtual_z)
		return
	if(distress_virtual_z)
		if(SSorbits.assoc_distress_beacons.Find("[distress_virtual_z]"))
			SSorbits.assoc_distress_beacons["[distress_virtual_z]"] --
	distress_virtual_z = new_virtual_z
	if(new_virtual_z)
		if(!SSorbits.assoc_distress_beacons.Find("[new_virtual_z]"))
			SSorbits.assoc_distress_beacons["[new_virtual_z]"] = 0
		SSorbits.assoc_distress_beacons["[new_virtual_z]"] ++

///Restarts the GPS after getting turned off by an EMP.
/datum/component/gps/item/proc/reboot()
	emped = FALSE
	var/atom/A = parent
	A.cut_overlay("emp")
	A.add_overlay("working")

///Calls toggletracking
/datum/component/gps/item/proc/on_AltClick(datum/source, mob/user)
	SIGNAL_HANDLER

	toggletracking(user)
	ui_update()
	return COMPONENT_INTERCEPT_ALT

///Toggles the tracking for the gps
/datum/component/gps/item/proc/toggletracking(mob/user)
	if(!user.canUseTopic(parent, BE_CLOSE))
		return //user not valid to use gps
	if(emped)
		to_chat(user, "<span class='warning'>It's busted!</span>")
		return
	var/atom/A = parent
	if(tracking)
		A.cut_overlay("working")
		to_chat(user, "<span class='notice'>[parent] is no longer tracking, or visible to other GPS devices.</span>")
		tracking = FALSE
	else
		A.add_overlay("working")
		to_chat(user, "<span class='notice'>[parent] is now tracking, and visible to other GPS devices.</span>")
		tracking = TRUE


/datum/component/gps/item/ui_state(mob/user)
	return GLOB.default_state

/datum/component/gps/item/ui_interact(mob/user, datum/tgui/ui) // Remember to use the appropriate state.
	if(emped)
		to_chat(user, "<span class='hear'>[parent] fizzles weakly.</span>")
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Gps") //width, height
		ui.open()

	ui.set_autoupdate(updating)

/datum/component/gps/item/ui_state(mob/user)
	return state

/datum/component/gps/item/ui_data(mob/user)
	var/list/data = list()
	data["power"] = tracking
	data["tag"] = gpstag
	data["updating"] = updating
	data["globalmode"] = global_mode
	data["distress"] = distress_beacon
	if(!tracking || emped) //Do not bother scanning if the GPS is off or EMPed
		return data

	var/turf/curr = get_turf(parent)
	data["currentArea"] = "[get_area_name(curr, TRUE)]"
	data["currentCoords"] = "[curr.x], [curr.y], [curr.get_virtual_z_level()]"

	var/list/signals = list()

	for(var/gps in GLOB.GPS_list)
		var/datum/component/gps/G = gps
		if(G.emped || !G.tracking || G == src)
			continue
		var/turf/pos = get_turf(G.parent)
		if(!pos || !global_mode && pos.get_virtual_z_level() != curr.get_virtual_z_level())
			continue
		var/list/signal = list()
		signal["entrytag"] = "[G.gpstag][G.distress_beacon ? " **DISTRESS**" : ""]" //Name or 'tag' of the GPS
		signal["coords"] = "[pos.x], [pos.y], [pos.get_virtual_z_level()]"
		if(pos.get_virtual_z_level() == curr.get_virtual_z_level()) //Distance/Direction calculations for same z-level only
			signal["dist"] = max(get_dist(curr, pos), 0) //Distance between the src and remote GPS turfs
			signal["degrees"] = round(get_angle(curr, pos)) //0-360 degree directional bearing, for more precision.
		signals += list(signal) //Add this signal to the list of signals
	data["signals"] = signals
	return data

/datum/component/gps/item/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("rename")
			var/atom/parentasatom = parent
			var/a = stripped_input(usr, "Please enter desired tag.", parentasatom.name, gpstag, 20)

			if (!a)
				return

			gpstag = a
			. = TRUE
			parentasatom.name = "global positioning system ([gpstag])"

		if("power")
			toggletracking(usr)
			. = TRUE
		if("updating")
			updating = !updating
			. = TRUE
		if("globalmode")
			global_mode = !global_mode
			. = TRUE
		if("distress")
			if(distress_beacon)
				disable_distress_signal()
			else
				enable_distress_signal()
			. = TRUE
