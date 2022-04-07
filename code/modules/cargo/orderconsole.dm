/obj/machinery/computer/cargo
	name = "supply console"
	desc = "Used to order supplies, approve requests, and control the shuttle."
	icon_screen = "supply"
	circuit = /obj/item/circuitboard/computer/cargo

	//Can the supply console send the shuttle back and forth? Used in the UI backend.
	var/can_send = TRUE
	var/requestonly = FALSE
	//Can you approve requests placed for cargo? Works differently between the app and the computer.
	var/can_approve_requests = TRUE
	var/contraband = FALSE
	var/self_paid = FALSE
	var/safety_warning = "For safety reasons, the automated supply shuttle \
		cannot transport live organisms, human remains, classified nuclear weaponry, \
		homing beacons or machinery housing any form of artificial intelligence."
	var/blockade_warning = "Bluespace instability detected. Shuttle movement impossible."
	/// radio used by the console to send messages on supply channel
	var/obj/item/radio/headset/radio
	/// var that tracks message cooldown
	var/message_cooldown
	COOLDOWN_DECLARE(order_cooldown)

	var/managing_autopilot = FALSE

	light_color = "#E2853D"//orange

/obj/machinery/computer/cargo/request
	name = "supply request console"
	desc = "Used to request supplies from cargo."
	icon_screen = "request"
	circuit = /obj/item/circuitboard/computer/cargo/request
	can_send = FALSE
	can_approve_requests = FALSE
	requestonly = TRUE

/obj/machinery/computer/cargo/Initialize(mapload)
	. = ..()
	radio = new /obj/item/radio/headset/headset_cargo(src)
	var/obj/item/circuitboard/computer/cargo/board = circuit
	contraband = board.contraband
	if (board.obj_flags & EMAGGED)
		obj_flags |= EMAGGED
	else
		obj_flags &= ~EMAGGED

/obj/machinery/computer/cargo/Destroy()
	QDEL_NULL(radio)
	return ..()

/obj/machinery/computer/cargo/proc/get_export_categories()
	. = EXPORT_CARGO
	if(contraband)
		. |= EXPORT_CONTRABAND
	if(obj_flags & EMAGGED)
		. |= EXPORT_EMAG

/obj/machinery/computer/cargo/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	user.visible_message("<span class='warning'>[user] swipes a suspicious card through [src]!</span>",
	"<span class='notice'>You adjust [src]'s routing and receiver spectrum, unlocking special supplies and contraband.</span>")

	obj_flags |= EMAGGED
	contraband = TRUE

	// This also permamently sets this on the circuit board
	var/obj/item/circuitboard/computer/cargo/board = circuit
	board.contraband = TRUE
	board.obj_flags |= EMAGGED
	update_static_data(user)


/obj/machinery/computer/cargo/ui_state(mob/user)
	return GLOB.default_state

/obj/machinery/computer/cargo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Cargo")
		ui.open()
		ui.set_autoupdate(TRUE) // Account balance, shuttle status

/obj/machinery/computer/cargo/ui_data()
	var/list/data = list()
	data["location"] = SSshuttle.supply.getStatusText()
	var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(D)
		data["points"] = D.account_balance
	data["away"] = SSshuttle.supply.getDockedId() != "supply_home"
	data["self_paid"] = self_paid
	data["requestable"] = !managing_autopilot
	data["at_merchant"] = SSshuttle.supply.can_recieve_goods()
	data["loan"] = !!SSshuttle.shuttle_loan
	data["loan_dispatched"] = SSshuttle.shuttle_loan && SSshuttle.shuttle_loan.dispatched
	data["can_send"] = can_send
	data["can_approve_requests"] = can_approve_requests
	data["loaded"] = SSshuttle.supply.loaded
	var/message = "Remember to stamp and send back the supply manifests."
	if(SSshuttle.centcom_message)
		message = SSshuttle.centcom_message
	if(SSshuttle.supplyBlocked)
		message = blockade_warning
	data["message"] = message
	data["cart"] = list()
	for(var/datum/supply_order/SO in SSshuttle.shoppinglist)
		data["cart"] += list(list(
			"object" = SO.pack.name,
			"cost" = SO.pack.get_cost(),
			"id" = SO.id,
			"orderer" = SO.orderer,
			"paid" = !isnull(SO.paying_account) //paid by requester
		))

	data["requests"] = list()
	for(var/datum/supply_order/SO in SSshuttle.requestlist)
		data["requests"] += list(list(
			"object" = SO.pack.name,
			"cost" = SO.pack.get_cost(),
			"orderer" = SO.orderer,
			"reason" = SO.reason,
			"id" = SO.id
		))

	return data

/obj/machinery/computer/cargo/ui_static_data(mob/user)
	var/list/data = list()
	data["requestonly"] = requestonly
	data["supplies"] = list()
	for(var/pack in SSshuttle.supply_packs)
		var/datum/supply_pack/P = SSshuttle.supply_packs[pack]
		if(!data["supplies"][P.group])
			data["supplies"][P.group] = list(
				"name" = P.group,
				"packs" = list()
			)
		if((P.hidden && !(obj_flags & EMAGGED)) || (P.contraband && !contraband) || (P.special && !P.special_enabled) || P.DropPodOnly)
			continue
		data["supplies"][P.group]["packs"] += list(list(
			"name" = P.name,
			"cost" = P.get_cost(),
			"id" = pack,
			"desc" = P.desc || P.name, // If there is a description, use it. Otherwise use the pack's name.
			"small_item" = P.small_item,
			"access" = P.access
		))
	return data

/obj/machinery/computer/cargo/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("send")
			if(!SSshuttle.supply.canMove())
				say(safety_warning)
				return
			if(SSshuttle.supplyBlocked)
				say(blockade_warning)
				return
			if(SSshuttle.supply.loaded)
				//Purchase anything when leaving
				if(SSshuttle.supply.can_recieve_goods())
					//Purchase cargo items
					SSshuttle.supply.buy()
				//Locate the home dock
				var/obj/docking_port/home_port = SSshuttle.getDock("supply_home")
				var/datum/orbital_map/viewing_map = SSorbits.orbital_maps[PRIMARY_ORBITAL_MAP]
				for(var/map_key in viewing_map.collision_zone_bodies)
					//Locate and pilot to home
					for(var/datum/orbital_object/z_linked/z_linked in viewing_map.collision_zone_bodies[map_key])
						if(z_linked.z_in_contents(home_port.z))
							autopilot_shuttle_to(z_linked)
							post_signal("supply")
							say("The supply shuttle is returning with the requested cargo.")
							return TRUE
			else
				//Locate the away location
				var/datum/orbital_map/viewing_map = SSorbits.orbital_maps[PRIMARY_ORBITAL_MAP]
				for(var/map_key in viewing_map.collision_zone_bodies)
					//Locate and pilot to Centcom
					for(var/datum/orbital_object/z_linked/phobos/centcom in viewing_map.collision_zone_bodies[map_key])
						autopilot_shuttle_to(centcom)
						post_signal("supply")
						say("The supply shuttle is departing for Central Command.")
						return TRUE
			say("Error, unable to locate autopilot target. Please assume manual control of the cargo shuttle.")
			return
		if("loan")
			if(!SSshuttle.shuttle_loan)
				return
			if(SSshuttle.supplyBlocked)
				say(blockade_warning)
				return
			else if(SSshuttle.supply.mode != SHUTTLE_IDLE)
				return
			else if(SSshuttle.supply.getDockedId() != "supply_away")
				return
			else
				SSshuttle.shuttle_loan.loan_shuttle()
				say("The supply shuttle has been loaned to CentCom.")
				. = TRUE
		if("add")
			if(!COOLDOWN_FINISHED(src, order_cooldown))
				return
			var/id = text2path(params["id"])
			var/datum/supply_pack/pack = SSshuttle.supply_packs[id]
			if(!istype(pack))
				return
			if((pack.hidden && !(obj_flags & EMAGGED)) || (pack.contraband && !contraband) || pack.DropPodOnly)
				return

			var/name = "*None Provided*"
			var/rank = "*None Provided*"
			var/ckey = usr.ckey
			if(ishuman(usr))
				var/mob/living/carbon/human/H = usr
				name = H.get_authentification_name()
				rank = H.get_assignment(hand_first = TRUE)
			else if(issilicon(usr))
				name = usr.real_name
				rank = "Silicon"

			var/datum/bank_account/account
			if(self_paid && ishuman(usr))
				var/mob/living/carbon/human/H = usr
				var/obj/item/card/id/id_card = H.get_idcard(TRUE)
				if(!istype(id_card))
					say("No ID card detected.")
					return
				account = id_card.registered_account
				if(!istype(account))
					say("Invalid bank account.")
					return

			var/reason = ""
			if(requestonly && !self_paid)
				reason = stripped_input(usr, "Reason:", name, "")
				if(!reason)
					return
				if(CHAT_FILTER_CHECK(reason))
					to_chat(usr, "<span class='warning'>You cannot send a message that contains a word prohibited in IC chat!</span>")
					return

			var/turf/T = get_turf(src)
			var/datum/supply_order/SO = new(pack, name, rank, ckey, reason, account)
			SO.generateRequisition(T)
			if(requestonly && !self_paid)
				SSshuttle.requestlist += SO
			else
				SSshuttle.shoppinglist += SO
				if(self_paid)
					say("Order processed. The price will be charged to [account.account_holder]'s bank account on delivery.")
			if(requestonly && message_cooldown < world.time)
				radio.talk_into(src, "A new order has been requested.", RADIO_CHANNEL_SUPPLY)
				message_cooldown = world.time + 30 SECONDS
			. = TRUE
		if("remove")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.shoppinglist)
				if(SO.id == id)
					SSshuttle.shoppinglist -= SO
					. = TRUE
					break
		if("clear")
			SSshuttle.shoppinglist.Cut()
			. = TRUE
		if("approve")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.requestlist)
				if(SO.id == id)
					SSshuttle.requestlist -= SO
					SSshuttle.shoppinglist += SO
					. = TRUE
					break
		if("deny")
			var/id = text2num(params["id"])
			for(var/datum/supply_order/SO in SSshuttle.requestlist)
				if(SO.id == id)
					SSshuttle.requestlist -= SO
					. = TRUE
					break
		if("denyall")
			SSshuttle.requestlist.Cut()
			. = TRUE
		if("toggleprivate")
			self_paid = !self_paid
			. = TRUE
	if(.)
		post_signal("supply")

// Handle autopilot
/obj/machinery/computer/cargo/process()
	. = ..()

	if(!managing_autopilot)
		return

	var/datum/orbital_object/shuttle/shuttleObject = SSorbits.assoc_shuttles["supply"]
	if(!shuttleObject)
		managing_autopilot = FALSE
		return

	//Shuttle was taken out of autopilot, or control was transfered elsewhere
	if(shuttleObject.controlling_computer != src)
		managing_autopilot = FALSE
		shuttleObject.controlling_computer = null
		say("Autopilot control overriden.")
		return

	if(SSshuttle.supply.loaded)
		if(shuttleObject.shuttleTarget == shuttleObject.docking_target)
			switch(SSshuttle.moveShuttle("supply", "supply_home", 1))
				if(0)
					say("Shuttle has arrived at destination.")
					QDEL_NULL(shuttleObject)
					//Tell the cargo shuttle to fly to centcom next
					SSshuttle.supply.loaded = FALSE
					managing_autopilot = FALSE
					shuttleObject.controlling_computer = null
					return
				if(1)
					to_chat(usr, "<span class='warning'>Invalid shuttle requested.</span>")
				else
					to_chat(usr, "<span class='notice'>Unable to comply.</span>")
	else
		if(SSshuttle.supplyBlocked)
			say(blockade_warning)
			shuttleObject.shuttleTarget = null
			shuttleObject.autopilot = FALSE
			shuttleObject.controlling_computer = null
			managing_autopilot = FALSE
			return
		//Reached merchant location
		if(SSshuttle.supply.can_recieve_goods())
			//Purchase cargo items
			SSshuttle.supply.buy()
			//Say something
			say("The supply shuttle has reached its destination and the requested cargo has been loaded.")
			//Disable autopilot
			shuttleObject.shuttleTarget = null
			shuttleObject.autopilot = FALSE
			shuttleObject.controlling_computer = null
			managing_autopilot = FALSE
			return

	if(!shuttleObject.autopilot)
		managing_autopilot = FALSE
		shuttleObject.controlling_computer = null
		say("Autopilot control disabled.")

/obj/machinery/computer/cargo/proc/autopilot_shuttle_to(datum/orbital_object/z_linked/target)
	if(!SSorbits.assoc_shuttles.Find("supply"))
		if(!launch_shuttle())
			return
	var/datum/orbital_object/shuttle/shuttleObject = SSorbits.assoc_shuttles["supply"]
	if(shuttleObject.shuttleTarget == target && shuttleObject.controlling_computer == src)
		return
	//Undock the shuttle
	shuttleObject.docking_target = null
	shuttleObject.shuttleTarget = target
	shuttleObject.autopilot = TRUE
	shuttleObject.controlling_computer = src
	managing_autopilot = TRUE

// Kind of a shameless rip off of the shuttle console
/obj/machinery/computer/cargo/proc/launch_shuttle()
	if(SSorbits.interdicted_shuttles.Find("supply"))
		if(world.time < SSorbits.interdicted_shuttles["supply"])
			var/time_left = (SSorbits.interdicted_shuttles["supply"] - world.time) * 0.1
			say("Supercruise Warning: Engines have been interdicted and will be recharged in [time_left] seconds.")
			return
	var/obj/docking_port/mobile/mobile_port = SSshuttle.getShuttle("supply")
	if(!mobile_port)
		return
	var/datum/orbital_object/shuttle/shuttleObject
	if(SSorbits.assoc_shuttles.Find("supply"))
		say("Shuttle is controlled from another location, updating telemetry.")
		shuttleObject = SSorbits.assoc_shuttles["supply"]
		return shuttleObject
	shuttleObject = mobile_port.enter_supercruise()
	shuttleObject.valid_docks = list("supply_home")
	return shuttleObject

/obj/machinery/computer/cargo/proc/post_signal(command)

	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)

	if(!frequency)
		return

	var/datum/signal/status_signal = new(list("command" = command))
	frequency.post_signal(src, status_signal)
