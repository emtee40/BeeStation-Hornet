//Chemist's heirloom

/obj/item/reagent_containers/glass/chem_heirloom
	name = "hard locked bottle of"
	desc = "A hard locked bottle of"
	volume = 100
	spillable = FALSE
	reagent_flags = NONE
	icon = 'icons/obj/chemical.dmi'
	icon_state = "hard_locked_closed"
	item_state = "hard_locked_closed"
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)
	var/locked = TRUE
	var/datum/callback/roundend_callback

/obj/item/reagent_containers/glass/chem_heirloom/Initialize(mapload, vol)
	..()
	update_icon()
	roundend_callback = CALLBACK(src, .proc/unlock)
	SSticker.OnRoundend(roundend_callback)

/obj/item/reagent_containers/glass/chem_heirloom/proc/update_name() //This has to be done after init, since the heirloom component is added after.
	var/datum/reagent/R = get_unrestricted_random_reagent_id()
	name ="[name] [initial(R.name)]"
	reagents.add_reagent(R, volume)
	var/datum/component/heirloom/H = GetComponent(/datum/component/heirloom)
	desc = H ? "[ishuman(H.owner) ? "The [H.family_name]" : "[H.owner.name]'s"] family's long-cherished wish is to open this bottle and get its chemical outside. Can you make that wish come true?" : "[desc] [initial(R.name)]."


/obj/item/reagent_containers/glass/chem_heirloom/afterattack(obj/target, mob/user, proximity)
	if(!locked)
		..()
	return

/obj/item/reagent_containers/glass/chem_heirloom/attackby(obj/item/I, mob/user, params)
	if(!locked)
		return
	..()

/obj/item/reagent_containers/glass/chem_heirloom/proc/unlock()
	if(isliving(loc))
		var/mob/living/M = loc
		to_chat(M, "<span class='notice'>The [src] unlocks!</span>")
	item_state = "hard_locked_open"
	icon_state = "hard_locked_open"
	locked = FALSE
	spillable = TRUE
	reagent_flags = OPENCONTAINER
