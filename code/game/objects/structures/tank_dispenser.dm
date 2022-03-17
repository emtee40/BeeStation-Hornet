#define TANK_DISPENSER_CAPACITY 10

/obj/structure/tank_dispenser
	name = "tank dispenser"
	desc = "A simple yet bulky storage device for gas tanks. Holds up to 10 oxygen tanks and 10 lean tanks."
	icon = 'icons/obj/objects.dmi'
	icon_state = "dispenser"
	density = TRUE
	anchored = TRUE
	max_integrity = 300
	var/oxygentanks = TANK_DISPENSER_CAPACITY
	var/leantanks = TANK_DISPENSER_CAPACITY

/obj/structure/tank_dispenser/oxygen
	leantanks = 0

/obj/structure/tank_dispenser/lean
	oxygentanks = 0

/obj/structure/tank_dispenser/Initialize(mapload)
	. = ..()
	for(var/i in 1 to oxygentanks)
		new /obj/item/tank/internals/oxygen(src)
	for(var/i in 1 to leantanks)
		new /obj/item/tank/internals/lean(src)
	update_icon()

/obj/structure/tank_dispenser/update_icon()
	cut_overlays()
	switch(oxygentanks)
		if(1 to 3)
			add_overlay("oxygen-[oxygentanks]")
		if(4 to TANK_DISPENSER_CAPACITY)
			add_overlay("oxygen-4")
	switch(leantanks)
		if(1 to 4)
			add_overlay("lean-[leantanks]")
		if(5 to TANK_DISPENSER_CAPACITY)
			add_overlay("lean-5")

/obj/structure/tank_dispenser/attackby(obj/item/I, mob/user, params)
	var/full
	if(istype(I, /obj/item/tank/internals/lean))
		if(leantanks < TANK_DISPENSER_CAPACITY)
			leantanks++
		else
			full = TRUE
	else if(istype(I, /obj/item/tank/internals/oxygen))
		if(oxygentanks < TANK_DISPENSER_CAPACITY)
			oxygentanks++
		else
			full = TRUE
	else if(I.tool_behaviour == TOOL_WRENCH)
		default_unfasten_wrench(user, I, time = 20)
		return
	else if(user.a_intent != INTENT_HARM)
		to_chat(user, "<span class='notice'>[I] does not fit into [src].</span>")
		return
	else
		return ..()
	if(full)
		to_chat(user, "<span class='notice'>[src] can't hold any more of [I].</span>")
		return

	if(!user.transferItemToLoc(I, src))
		if(istype(I, /obj/item/tank/internals/lean))
			leantanks--
		else if(istype(I, /obj/item/tank/internals/oxygen))
			oxygentanks--
		return
	to_chat(user, "<span class='notice'>You put [I] in [src].</span>")
	update_icon()
	ui_update()


/obj/structure/tank_dispenser/ui_state(mob/user)
	return GLOB.physical_state

/obj/structure/tank_dispenser/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TankDispenser")
		ui.open()

/obj/structure/tank_dispenser/ui_data(mob/user)
	var/list/data = list()
	data["oxygen"] = oxygentanks
	data["lean"] = leantanks

	return data

/obj/structure/tank_dispenser/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("lean")
			var/obj/item/tank/internals/lean/tank = locate() in src
			if(tank && Adjacent(usr) && isliving(usr))
				usr.put_in_hands(tank)
				leantanks--
			. = TRUE
		if("oxygen")
			var/obj/item/tank/internals/oxygen/tank = locate() in src
			if(tank && Adjacent(usr) && isliving(usr))
				usr.put_in_hands(tank)
				oxygentanks--
			. = TRUE
	ui_update()
	update_icon()


/obj/structure/tank_dispenser/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		for(var/X in src)
			var/obj/item/I = X
			I.forceMove(loc)
		new /obj/item/stack/sheet/iron (loc, 2)
	qdel(src)

#undef TANK_DISPENSER_CAPACITY
