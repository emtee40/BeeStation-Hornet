/*
Reproductive extracts:
	When fed three monkey cubes, produces between
	1 and 4 normal slime extracts of the same colour.
*/
/obj/item/slimecross/reproductive
	name = "reproductive extract"
	desc = "It pulses with a strange hunger."
	icon_state = "reproductive"
	effect = "reproductive"
	effect_desc = "When fed monkey cubes it produces more extracts. Bio bag compatible as well."
	var/extract_type = /obj/item/slime_extract/
	var/last_produce = 0
	var/cooldown = 3 SECONDS
	var/feedAmount = 3
	var/datum/component/storage/concrete/extract_inventory/slimeStorage

/obj/item/slimecross/reproductive/examine()
	. = ..()
	. += "<span class='danger'>It appears to have eaten [length(contents)] Monkey Cube[p_s()]</span>"

/obj/item/slimecross/reproductive/Initialize()
	. = ..()
	slimeStorage = AddComponent(/datum/component/storage/concrete/extract_inventory)

/obj/item/slimecross/reproductive/attackby(obj/item/O, mob/user)
	if((last_produce + cooldown) > world.time)
		to_chat(user, "<span class='warning'>[src] is still digesting!</span>")
		return

	if(length(contents) >= feedAmount) //if for some reason the contents are full, but it didnt digest, attempt to digest again
		to_chat(user,"<span class='warning'>[src] appears to be full but is not digesting! Maybe poking it stimulated it to digest.</span>")
		slimeStorage.processCubes(src, user)
		return

	if(istype(O, /obj/item/storage/bag/bio))
		var/list/inserted = list()
		SEND_SIGNAL(O, COMSIG_TRY_STORAGE_TAKE_TYPE, /obj/item/reagent_containers/food/snacks/monkeycube, src, feedAmount - length(contents), TRUE, FALSE, user, inserted)
		if(inserted.len)
			to_chat(user, "<span class='warning'>You feed [length(inserted)] Monkey Cube[p_s()] to [src], and it pulses gently.</span>")
			playsound(src, 'sound/items/eatfood.ogg', 20, TRUE)
			slimeStorage.processCubes(src, user)
		else
			to_chat(user, "<span class='notice'>There are no monkey cubes in the bio bag!</span>")
		return

	else if(istype(O, /obj/item/reagent_containers/food/snacks/monkeycube))
		slimeStorage.locked = FALSE //This weird unlock-then-lock nonsense brought to you courtesy of storage jank
		if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, O, user, TRUE))
			to_chat(user, "<span class='notice'>You feed 1 Monkey Cube to [src], and it pulses gently.</span>")
			slimeStorage.processCubes(src, user)
			playsound(src, 'sound/items/eatfood.ogg', 20, TRUE)
			slimeStorage.locked = TRUE //relock once its done inserting
			return
		else
			slimeStorage.locked = TRUE //it couldnt insert for some reason, relock it
			to_chat(user, "<span class='notice'>The [src] rejects the Monkey Cube!</span>") //in case it fails to insert for whatever reason you get feedback

/obj/item/slimecross/reproductive/Destroy()
	slimeStorage = null
	return ..()

/obj/item/slimecross/reproductive/grey
	extract_type = /obj/item/slime_extract/grey
	colour = "grey"

/obj/item/slimecross/reproductive/orange
	extract_type = /obj/item/slime_extract/orange
	colour = "orange"

/obj/item/slimecross/reproductive/purple
	extract_type = /obj/item/slime_extract/purple
	colour = "purple"

/obj/item/slimecross/reproductive/blue
	extract_type = /obj/item/slime_extract/blue
	colour = "blue"

/obj/item/slimecross/reproductive/metal
	extract_type = /obj/item/slime_extract/metal
	colour = "metal"

/obj/item/slimecross/reproductive/yellow
	extract_type = /obj/item/slime_extract/yellow
	colour = "yellow"

/obj/item/slimecross/reproductive/darkpurple
	extract_type = /obj/item/slime_extract/darkpurple
	colour = "dark purple"

/obj/item/slimecross/reproductive/darkblue
	extract_type = /obj/item/slime_extract/darkblue
	colour = "dark blue"

/obj/item/slimecross/reproductive/silver
	extract_type = /obj/item/slime_extract/silver
	colour = "silver"

/obj/item/slimecross/reproductive/bluespace
	extract_type = /obj/item/slime_extract/bluespace
	colour = "bluespace"

/obj/item/slimecross/reproductive/sepia
	extract_type = /obj/item/slime_extract/sepia
	colour = "sepia"

/obj/item/slimecross/reproductive/cerulean
	extract_type = /obj/item/slime_extract/cerulean
	colour = "cerulean"

/obj/item/slimecross/reproductive/pyrite
	extract_type = /obj/item/slime_extract/pyrite
	colour = "pyrite"

/obj/item/slimecross/reproductive/red
	extract_type = /obj/item/slime_extract/red
	colour = "red"

/obj/item/slimecross/reproductive/green
	extract_type = /obj/item/slime_extract/green
	colour = "green"

/obj/item/slimecross/reproductive/pink
	extract_type = /obj/item/slime_extract/pink
	colour = "pink"

/obj/item/slimecross/reproductive/gold
	extract_type = /obj/item/slime_extract/gold
	colour = "gold"

/obj/item/slimecross/reproductive/oil
	extract_type = /obj/item/slime_extract/oil
	colour = "oil"

/obj/item/slimecross/reproductive/black
	extract_type = /obj/item/slime_extract/black
	colour = "black"

/obj/item/slimecross/reproductive/lightpink
	extract_type = /obj/item/slime_extract/lightpink
	colour = "light pink"

/obj/item/slimecross/reproductive/adamantine
	extract_type = /obj/item/slime_extract/adamantine
	colour = "adamantine"

/obj/item/slimecross/reproductive/rainbow
	extract_type = /obj/item/slime_extract/rainbow
	colour = "rainbow"
