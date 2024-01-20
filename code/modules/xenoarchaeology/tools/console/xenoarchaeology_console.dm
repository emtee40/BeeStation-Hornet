///Stability lost on purchase
#define STABILITY_COST 30
///Stability gained on-tick
#define STABILITY_GAIN 5

/obj/machinery/computer/xenoarchaeology_console
	name = "research and development listing console"
	desc = "A science console used to source sellers, and buyers, for various blacklisted research objects."
	icon_screen = "xenoartifact_console"
	icon_keyboard = "rd_key"
	circuit = /obj/item/circuitboard/computer/xenoarchaeology_console

	///Which science server receives points
	var/datum/techweb/linked_techweb
	///Which department's budget receives profit
	var/datum/bank_account/budget

	///Stability - lowers as people buy artifacts, stops spam buying
	var/stability = 100

	///List of current listing sellers
	var/list/sellers = list(/datum/rnd_lister/artifact_seller/bastard, /datum/rnd_lister/artifact_seller/bastard, /datum/rnd_lister/artifact_seller/bastard)

	///radio used by the console to send messages on science channel
	var/obj/item/radio/headset/radio
	///Do we do purchase notices on the radio?
	var/radio_purchase_notice = TRUE
	///Do we do solved notices on the radio?
	var/radio_solved_notice = TRUE

	///Are we allowed to call the cargo shuttle?
	var/can_call_shuttle = TRUE

	///Generic messages we modify to match the situation
	var/safety_warning = "For safety and ethical reasons, the automated supply shuttle \
		cannot transport live organisms, human remains, classified nuclear weaponry, \
		homing beacons, mail, or machinery housing any form of artificial intelligence."
	var/blockade_warning = "Bluespace instability detected. Shuttle movement impossible."
	var/permission_warning = "Invalid access! Scan Quartermaster ID, or equivilent, to enable."

/obj/machinery/computer/xenoarchaeology_console/Initialize()
	. = ..()
	//Link relevant stuff
	linked_techweb = SSresearch.science_tech
	budget = SSeconomy.get_budget_account(ACCOUNT_SCI_ID)
	//Start processing to gain stability
	START_PROCESSING(SSobj, src)
	///Build seller list //TODO: Clear these on destroy - Racc
	var/list/new_sellers = sellers.Copy()
	sellers = list()
	for(var/datum/rnd_lister/S as() in new_sellers)
		sellers += new S()
	//Radio setup
	radio = new /obj/item/radio/headset/headset_sci(src)
	//Look for sold artifacts
	RegisterSignal(SSdcs, COMSIG_GLOB_ATOM_SOLD, PROC_REF(check_sold))

/obj/machinery/computer/xenoarchaeology_console/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(radio)

/obj/machinery/computer/xenoarchaeology_console/process()
	stability = min(100, stability + STABILITY_GAIN)
	//Update UI every 3 seconds, may be delayed
	if(world.time % 3 == 0)
		ui_update()

/obj/machinery/computer/xenoarchaeology_console/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "XenoartifactConsole")
		ui.open()

/obj/machinery/computer/xenoarchaeology_console/ui_data(mob/user)
	var/list/data = list()

	//Seller data
	data["sellers"] = list()
	for(var/datum/rnd_lister/seller as() in sellers)
		var/list/stock = list()
		for(var/atom/A as() in seller.current_stock)
			stock += list(list("name" = A?.name, "description" = A?.desc, "id" = REF(A), "cost" = seller.get_price(A) || 0))
		data["sellers"] += list(list("name" = seller.name, "dialogue" = seller.dialogue, "stock" = stock, "id" = REF(seller)))
	//Stability
	data["stability"] = stability
	//Cash available
	var/datum/bank_account/D = SSeconomy.get_budget_account(ACCOUNT_CAR_ID)
	data["money"] = D.account_balance

	return data

/obj/machinery/computer/xenoarchaeology_console/ui_act(action, params)
	if(..())
		return
	
	switch(action)
		//Purchase items
		if("stock_purchase")
			//If we got no instability
			if(!stability)
				say("Insufficient straythread stability!")
				return
			//Locate seller and purchase our item from them
			var/datum/rnd_lister/seller = locate(params["seller_id"])
			//If we got no cash
			var/datum/bank_account/D = SSeconomy.get_budget_account(ACCOUNT_SCI_ID)
			if(seller.get_price(locate(params["item_id"])) > D.account_balance)
				say("Insufficient funds!")
				return
			//Annouce it - TODO: Adjust this / flesh it out - Racc
			if(radio_purchase_notice)
				radio?.talk_into(src, "[locate(params["item_id"])] was requested for purchase, for [seller.get_price(locate(params["item_id"]))] credits, at [station_time_timestamp()].", RADIO_CHANNEL_SCIENCE)
			//handle ID and such
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
			//Ship the pack
			var/datum/supply_pack/SP = seller?.buy_stock(locate(params["item_id"]))
			var/datum/supply_order/SO = new(SP, name, rank, ckey, "Research Material Requisition", D)
			SO.generateRequisition(get_turf(src))
			SSsupply.shoppinglist += SO
			//Take our toll
			stability = clamp(stability-STABILITY_COST, 0, 100)
		if("send")
			if(!can_call_shuttle)
				say(permission_warning)
				return
			if(!SSshuttle.supply.canMove())
				say(safety_warning)
				return
			if(SSshuttle.supplyBlocked)
				say(blockade_warning)
				return
			if(SSshuttle.supply.getDockedId() == "supply_home")
				SSshuttle.supply.export_categories = EXPORT_CARGO
				SSshuttle.moveShuttle("supply", "supply_away", TRUE)
				say("The supply shuttle is departing.")
				usr.investigate_log(" sent the supply shuttle away.", INVESTIGATE_RESEARCH)
			else
				usr.investigate_log(" called the supply shuttle.", INVESTIGATE_RESEARCH)
				say("The supply shuttle has been called and will arrive in [SSshuttle.supply.timeLeft(600)] minutes.")
				SSshuttle.moveShuttle("supply", "supply_home", TRUE)
			. = TRUE

	ui_update()

/obj/machinery/computer/xenoarchaeology_console/attackby(obj/item/C, mob/user)
	. = ..()
	var/obj/item/card/id/I = C
	if(istype(I) && (ACCESS_HEADS in I.access))
		can_call_shuttle = !can_call_shuttle
		say("Toggled shuttle permission. Shuttle permission [can_call_shuttle ? "enabled" : "disabled"].")

/obj/machinery/computer/xenoarchaeology_console/proc/check_sold(datum/source, atom/movable/AM, sold)
	SIGNAL_HANDLER

	var/obj/item/sticker/xenoartifact_label/L = locate(/obj/item/sticker/xenoartifact_label) in AM.contents
	var/datum/component/xenoartifact/X = AM.GetComponent(/datum/component/xenoartifact)
	if(X && L)
		//Calculate success rate
		var/score = 0
		var/max_score = 0
		for(var/i in X.artifact_traits)
			for(var/datum/xenoartifact_trait/T in X.artifact_traits[i])
				if(T.contribute_calibration)
					if(locate(T) in L.traits)
						score += 1
					else 
						score -= 1
			max_score += 1
		var/success_rate = score / max_score
		//Rewards
		var/dp_reward = max(0, AM.custom_price*X.artifact_type.dp_rate)
		var/rnd_reward = max(0, AM.custom_price*X.artifact_type.rnd_rate)
		linked_techweb?.add_point_type(TECHWEB_POINT_TYPE_DISCOVERY, dp_reward)
		linked_techweb?.add_point_type(TECHWEB_POINT_TYPE_GENERIC, rnd_reward)
		//Announce victory or fuck up
		if(radio_solved_notice)
			var/success_type
			switch(success_rate)
				if(0.99 to INFINITY)
					success_type = "incredible discovery!"
				if(0.9 to 0.79)
					success_type = "admirable research."
				if(0.7 to 0.3)
					success_type = "sufficient research."
				else
					success_type = "scientific failure."
			radio?.talk_into(src, "[AM] has been submitted with a success rate of [100*success_rate]% '[success_type]', at [station_time_timestamp()].\nAwarded [dp_reward] Discovery Points, and [rnd_reward] Research Points!", RADIO_CHANNEL_SCIENCE)
			//TODO: Add monetary reward, cargo already reaps the benehfits of selling it - Racc

//Circuitboard for this console
/obj/item/circuitboard/computer/xenoarchaeology_console
	name = "research and development listing console (Computer Board)"
	icon_state = "science"
	build_path = /obj/machinery/computer/xenoarchaeology_console
