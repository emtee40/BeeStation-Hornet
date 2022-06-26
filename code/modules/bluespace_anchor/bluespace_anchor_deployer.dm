/obj/item/bluespace_anchor
	name = "bluespace anchor"
	desc = "A portable device that, once deployed, will stablise the volatile bluespace instabilities around it, preventing bluespace teleportation. Consumes a large amount of power."

	icon = 'icons/obj/device.dmi'
	icon_state = "memorizer2"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

	var/obj/item/stock_parts/cell/power_cell

/obj/item/bluespace_anchor/Initialize(mapload, obj/item/stock_parts/cell/cell)
	. = ..()
	insert_cell(cell)

/obj/item/bluespace_anchor/Destroy()
	. = ..()
	//Delete the power cell
	if(power_cell)
		QDEL_NULL(power_cell)

/obj/item/bluespace_anchor/proc/insert_cell(cell)
	if(power_cell)
		power_cell.forceMove(get_turf(src))
		UnregisterSignal(power_cell, COMSIG_PARENT_QDELETING)
		power_cell = null
	power_cell = cell
	if(power_cell)
		power_cell.forceMove(src)

/obj/item/bluespace_anchor/screwdriver_act(mob/living/user, obj/item/I)
	if(!power_cell)
		to_chat(user, "<span class='notice'>There is no cell inside [src].</span>")
		return
	to_chat(user, "<span class='notice'>You remove the cell inside [src].</span>")
	insert_cell(null)

/obj/item/bluespace_anchor/attack_self(mob/user)
	to_chat(user, "<span class='notice'>You begin deploying [src]...</span>")
	if(!do_after(user, 4 SECONDS, target = src))
		return
	new /obj/machinery/bluespace_anchor(get_turf(user), power_cell)
	qdel(src)

/obj/item/bluespace_anchor/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/stock_parts/cell/cell = I
	if(!istype(I))
		return ..()
	if(power_cell)
		to_chat(user, "<span class='notice'>Remove the power cell inside [src] first!</span>")
		return
	insert_cell(cell)
	to_chat(user, "<span class='notice'>You insert [cell] into [src].</span>")
