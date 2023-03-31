/obj/machinery/button
	name = "button"
	desc = "A remote control switch."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "doorctrl"
	var/skin = "doorctrl"
	layer = ABOVE_WINDOW_LAYER
	power_channel = AREA_USAGE_ENVIRON
	var/obj/item/assembly/device
	var/obj/item/electronics/airlock/board
	var/device_type = null
	var/id = null
	var/initialized_button = 0
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 70, "stamina" = 0)
	use_power = IDLE_POWER_USE
	idle_power_usage = 200
	resistance_flags = LAVA_PROOF | FIRE_PROOF

/obj/machinery/button/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/Initialize(mapload, ndir = 0, built = 0)
	. = ..()
	if(built)
		setDir(ndir)
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -24 : 24)
		pixel_y = (dir & 3)? (dir ==1 ? -24 : 24) : 0
		panel_open = TRUE
		update_icon()


	if(!built && !device && device_type)
		device = new device_type(src)

	src.check_access(null)

	if(req_access.len || req_one_access.len)
		board = new(src)
		if(req_access.len)
			board.accesses = req_access
		else
			board.one_access = 1
			board.accesses = req_one_access
		var/area/A = get_area(src)
		if(istype(A, /area/shuttle))
			var/area/shuttle/AS = A
			req_ship_access = AS.mobile_port?.id

/obj/machinery/button/update_icon()
	cut_overlays()
	if(panel_open)
		icon_state = "button-open"
		if(device)
			add_overlay("button-device")
		if(board)
			add_overlay("button-board")

	else
		if(machine_stat & (NOPOWER|BROKEN))
			icon_state = "[skin]-p"
		else
			icon_state = skin

/obj/machinery/button/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		if(panel_open || allowed(user))
			default_deconstruction_screwdriver(user, "button-open", "[skin]",W)
			update_icon()
		else
			to_chat(user, "<span class='danger'>Maintenance Access Denied.</span>")
			flick("[skin]-denied", src)
		return

	if(panel_open)
		if(!device && istype(W, /obj/item/assembly))
			if(!user.transferItemToLoc(W, src))
				to_chat(user, "<span class='warning'>\The [W] is stuck to you!</span>")
				return
			device = W
			to_chat(user, "<span class='notice'>You add [W] to the button.</span>")

		if(!board && istype(W, /obj/item/electronics/airlock))
			if(!user.transferItemToLoc(W, src))
				to_chat(user, "<span class='warning'>\The [W] is stuck to you!</span>")
				return
			board = W
			if(board.one_access)
				req_one_access = board.accesses
			else
				req_access = board.accesses
			to_chat(user, "<span class='notice'>You add [W] to the button.</span>")

		if(!device && !board && W.tool_behaviour == TOOL_WRENCH)
			to_chat(user, "<span class='notice'>You start unsecuring the button frame...</span>")
			W.play_tool_sound(src)
			if(W.use_tool(src, user, 40))
				to_chat(user, "<span class='notice'>You unsecure the button frame.</span>")
				transfer_fingerprints_to(new /obj/item/wallframe/button(get_turf(src)))
				playsound(loc, 'sound/items/deconstruct.ogg', 50, 1)
				qdel(src)

		update_icon()
		return

	if(user.a_intent != INTENT_HARM && !(W.item_flags & NOBLUDGEON))
		return attack_hand(user)
	else
		return ..()

/obj/machinery/button/on_emag(mob/user)
	..()
	req_access = list()
	req_one_access = list()
	playsound(src, "sparks", 100, 1)

/obj/machinery/button/eminence_act(mob/living/simple_animal/eminence/eminence)
	. = ..()
	to_chat(usr, "<span class='brass'>You begin manipulating [src]!</span>")
	if(do_after(eminence, 20, target=get_turf(eminence)))
		attack_hand(eminence)

/obj/machinery/button/attack_ai(mob/user)
	if(!panel_open)
		return attack_hand(user)

/obj/machinery/button/attack_robot(mob/user)
	return attack_ai(user)

/obj/machinery/button/proc/setup_device()
	if(id && istype(device, /obj/item/assembly/control))
		var/obj/item/assembly/control/A = device
		A.id = id
	initialized_button = 1

/obj/machinery/button/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!initialized_button)
		setup_device()
	add_fingerprint(user)
	play_click_sound("button")
	if(panel_open)
		if(device || board)
			if(device)
				device.forceMove(drop_location())
				device = null
			if(board)
				board.forceMove(drop_location())
				req_access = list()
				req_one_access = list()
				board = null
			update_icon()
			to_chat(user, "<span class='notice'>You remove electronics from the button frame.</span>")

		else
			if(skin == "doorctrl")
				skin = "launcher"
			else
				skin = "doorctrl"
			to_chat(user, "<span class='notice'>You change the button frame's front panel.</span>")
		return

	if((machine_stat & (NOPOWER|BROKEN)))
		return

	if(device && device.next_activate > world.time)
		return

	if(!allowed(user) && !istype(user, /mob/living/simple_animal/eminence))
		to_chat(user, "<span class='danger'>Access Denied.</span>")
		flick("[skin]-denied", src)
		return

	use_power(5)
	icon_state = "[skin]1"

	if(device)
		device.pulsed()

	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_icon)), 15)

/obj/machinery/button/power_change()
	..()
	update_icon()

/obj/machinery/button/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock, idnum, override)
	. = ..()
	id = "[id]@[port.id]"
	setup_device()

/obj/machinery/button/door
	name = "door button"
	desc = "A door remote control switch."
	var/normaldoorcontrol = FALSE
	var/specialfunctions = OPEN // Bitflag, see assembly file
	var/sync_doors = TRUE

/obj/machinery/button/door/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/door/setup_device()
	if(!device)
		if(normaldoorcontrol)
			var/obj/item/assembly/control/airlock/A = new(src)
			A.specialfunctions = specialfunctions
			device = A
		else
			var/obj/item/assembly/control/C = new(src)
			C.sync_doors = sync_doors
			device = C
	..()

/obj/machinery/button/door/incinerator_vent_toxmix
	name = "combustion chamber vent control"
	id = INCINERATOR_TOXMIX_VENT
	req_access = list(ACCESS_TOX)

/obj/machinery/button/door/incinerator_vent_atmos_main
	name = "turbine vent control"
	id = INCINERATOR_ATMOS_MAINVENT
	req_one_access = list(ACCESS_ATMOSPHERICS, ACCESS_MAINT_TUNNELS)

/obj/machinery/button/door/incinerator_vent_atmos_aux
	name = "combustion chamber vent control"
	id = INCINERATOR_ATMOS_AUXVENT
	req_one_access = list(ACCESS_ATMOSPHERICS, ACCESS_MAINT_TUNNELS)

/obj/machinery/button/door/incinerator_vent_syndicatelava_main
	name = "turbine vent control"
	id = INCINERATOR_SYNDICATELAVA_MAINVENT
	req_access = list(ACCESS_SYNDICATE)

/obj/machinery/button/door/incinerator_vent_syndicatelava_aux
	name = "combustion chamber vent control"
	id = INCINERATOR_SYNDICATELAVA_AUXVENT
	req_access = list(ACCESS_SYNDICATE)

/obj/machinery/button/massdriver
	name = "mass driver button"
	desc = "A remote control switch for a mass driver."
	icon_state = "launcher"
	skin = "launcher"
	device_type = /obj/item/assembly/control/massdriver

/obj/machinery/button/massdriver/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/ignition
	name = "ignition switch"
	desc = "A remote control switch for a mounted igniter."
	icon_state = "launcher"
	skin = "launcher"
	device_type = /obj/item/assembly/control/igniter

/obj/machinery/button/ignition/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/ignition/incinerator
	name = "combustion chamber ignition switch"
	desc = "A remote control switch for the combustion chamber's igniter."

/obj/machinery/button/ignition/incinerator/toxmix
	id = INCINERATOR_TOXMIX_IGNITER

/obj/machinery/button/ignition/incinerator/atmos
	id = INCINERATOR_ATMOS_IGNITER

/obj/machinery/button/ignition/incinerator/syndicatelava
	id = INCINERATOR_SYNDICATELAVA_IGNITER

/obj/machinery/button/flasher
	name = "flasher button"
	desc = "A remote control switch for a mounted flasher."
	icon_state = "launcher"
	skin = "launcher"
	device_type = /obj/item/assembly/control/flasher

/obj/machinery/button/flasher/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/crematorium
	name = "crematorium igniter"
	desc = "Burn baby burn!"
	icon_state = "launcher"
	skin = "launcher"
	device_type = /obj/item/assembly/control/crematorium
	id = 1

/obj/machinery/button/crematorium/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/wallframe/button
	name = "button frame"
	desc = "Used for building buttons."
	icon_state = "button"
	result_path = /obj/machinery/button
	materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
