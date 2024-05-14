/obj/item/stack/tile/mineral
	/// Determines what stack is gotten out of us when welded.
	var/mineralType = null

/obj/item/stack/tile/mineral/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WELDER)
		if(get_amount() < 4)
			to_chat(user, "<span class='warning'>You need at least four tiles to do this!</span>")
			return
		if(!mineralType)
			to_chat(user, "<span class='warning'>You can not reform this!</span>")
			stack_trace("A mineral tile of type [type] doesn't have its' mineralType set.")
			return
		if(W.use_tool(src, user, 0, volume=40))
			var/sheet_type = text2path("/obj/item/stack/sheet/mineral/[mineralType]")
			var/obj/item/stack/sheet/mineral/new_item = new sheet_type(user.loc)
			user.visible_message("<span class='notice'>[user] shaped [src] into [new_item] with [W].</span>", \
				"<span class='notice'>You shaped [src] into [new_item] with [W].</span>", \
				"<span class='hear'>You hear welding.</span>")
			var/holding = user.is_holding(src)
			use(4)
			if(holding && QDELETED(src))
				user.put_in_hands(new_item)
	else
		return ..()

/obj/item/stack/tile/mineral/plasma
	name = "plasma tile"
	singular_name = "plasma floor tile"
	desc = "A tile made out of highly flammable plasma. This can only end well."
	icon_state = "tile_plasma"
	item_state = "tile-plasma"
	turf_type = /turf/open/floor/mineral/plasma
	mineralType = "plasma"
	mats_per_unit = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/plasma

/obj/item/stack/tile/mineral/uranium
	name = "uranium tile"
	singular_name = "uranium floor tile"
	desc = "A tile made out of uranium. You feel a bit woozy."
	icon_state = "tile_uranium"
	item_state = "tile-uranium"
	turf_type = /turf/open/floor/mineral/uranium
	mineralType = "uranium"
	mats_per_unit = list(/datum/material/uranium=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/uranium

/obj/item/stack/tile/mineral/gold
	name = "gold tile"
	singular_name = "gold floor tile"
	desc = "A tile made out of gold, the swag seems strong here."
	icon_state = "tile_gold"
	item_state = "tile-gold"
	turf_type = /turf/open/floor/mineral/gold
	mineralType = "gold"
	mats_per_unit = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/gold

/obj/item/stack/tile/mineral/silver
	name = "silver tile"
	singular_name = "silver floor tile"
	desc = "A tile made out of silver, the light shining from it is blinding."
	icon_state = "tile_silver"
	item_state = "tile-silver"
	turf_type = /turf/open/floor/mineral/silver
	mineralType = "silver"
	mats_per_unit = list(/datum/material/silver=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/silver

/obj/item/stack/tile/mineral/copper
	name = "copper tile"
	singular_name = "copper floor tile"
	desc = "A tile made out of copper, so shiny!"
	icon_state = "tile_copper"
	turf_type = /turf/open/floor/mineral/copper
	mineralType = "copper"
	mats_per_unit = list(/datum/material/copper=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/copper

/obj/item/stack/tile/mineral/diamond
	name = "diamond tile"
	singular_name = "diamond floor tile"
	desc = "A tile made out of diamond. Wow, just, wow."
	icon_state = "tile_diamond"
	item_state = "tile-diamond"
	turf_type = /turf/open/floor/mineral/diamond
	mineralType = "diamond"
	mats_per_unit = list(/datum/material/diamond=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/diamond

/obj/item/stack/tile/mineral/bananium
	name = "bananium tile"
	singular_name = "bananium floor tile"
	desc = "A tile made out of bananium, HOOOOOOOOONK!"
	icon_state = "tile_bananium"
	item_state = "tile-bananium"
	turf_type = /turf/open/floor/mineral/bananium
	mineralType = "bananium"
	mats_per_unit = list(/datum/material/bananium=MINERAL_MATERIAL_AMOUNT*0.25)
	material_flags = NONE //The slippery comp makes it unpractical for good clown decor. The material tiles should still slip.
	merge_type = /obj/item/stack/tile/mineral/bananium

/obj/item/stack/tile/mineral/abductor
	name = "alien floor tile"
	singular_name = "alien floor tile"
	desc = "A tile made out of alien alloy."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "tile_abductor"
	item_state = "tile-abductor"
	turf_type = /turf/open/floor/mineral/abductor
	mineralType = "abductor"
	merge_type = /obj/item/stack/tile/mineral/abductor

/obj/item/stack/tile/mineral/titanium
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "Sleek titanium tiles, used for shuttles."
	icon_state = "tile_titanium"
	item_state = "tile-shuttle"
	turf_type = /turf/open/floor/mineral/titanium
	mineralType = "titanium"
	mats_per_unit = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/titanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/titanium,
		/obj/item/stack/tile/mineral/titanium/yellow,
		/obj/item/stack/tile/mineral/titanium/blue,
		/obj/item/stack/tile/mineral/titanium/white,
		/obj/item/stack/tile/mineral/titanium/purple,
		/obj/item/stack/tile/mineral/titanium/tiled,
		/obj/item/stack/tile/mineral/titanium/tiled/yellow,
		/obj/item/stack/tile/mineral/titanium/tiled/blue,
		/obj/item/stack/tile/mineral/titanium/tiled/white,
		/obj/item/stack/tile/mineral/titanium/tiled/purple,
		)

/obj/item/stack/tile/mineral/titanium/yellow
	name = "yellow titanium tile"
	singular_name = "yellow titanium floor tile"
	desc = "Sleek yellow titanium tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/yellow
	icon_state = "tile_titanium_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/yellow

/obj/item/stack/tile/mineral/titanium/blue
	name = "blue titanium tile"
	singular_name = "blue titanium floor tile"
	desc = "Sleek blue titanium tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/blue
	icon_state = "tile_titanium_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/blue

/obj/item/stack/tile/mineral/titanium/white
	name = "white titanium tile"
	singular_name = "white titanium floor tile"
	desc = "Sleek white titanium tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/white
	icon_state = "tile_titanium_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/white

/obj/item/stack/tile/mineral/titanium/purple
	name = "purple titanium tile"
	singular_name = "purple titanium floor tile"
	desc = "Sleek purple titanium tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/purple
	icon_state = "tile_titanium_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/purple

/obj/item/stack/tile/mineral/titanium/tiled
	name = "tiled titanium tile"
	singular_name = "tiled titanium floor tile"
	desc = "Titanium floor tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/tiled
	icon_state = "tile_titanium_tiled"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled

/obj/item/stack/tile/mineral/titanium/tiled/yellow
	name = "yellow titanium tile"
	singular_name = "yellow titanium floor tile"
	desc = "Yellow titanium floor tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/tiled/yellow
	icon_state = "tile_titanium_tiled_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/yellow

/obj/item/stack/tile/mineral/titanium/tiled/blue
	name = "blue titanium tile"
	singular_name = "blue titanium floor tile"
	desc = "Blue titanium floor tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/tiled/blue
	icon_state = "tile_titanium_tiled_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/blue

/obj/item/stack/tile/mineral/titanium/tiled/white
	name = "white titanium tile"
	singular_name = "white titanium floor tile"
	desc = "White titanium floor tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/tiled/white
	icon_state = "tile_titanium_tiled_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/white

/obj/item/stack/tile/mineral/titanium/tiled/purple
	name = "purple titanium tile"
	singular_name = "purple titanium floor tile"
	desc = "Purple titanium floor tiles, used for shuttles."
	turf_type = /turf/open/floor/mineral/titanium/tiled/purple
	icon_state = "tile_titanium_tiled_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/purple

/obj/item/stack/tile/mineral/plastitanium
	name = "plastitanium tile"
	singular_name = "plastitanium floor tile"
	desc = "A tile made of plastitanium, used for very evil shuttles."
	icon_state = "tile_plastitanium"
	item_state = "tile-darkshuttle"
	turf_type = /turf/open/floor/mineral/plastitanium
	mineralType = "plastitanium"
	mats_per_unit = list(/datum/material/titanium=500, /datum/material/plasma=500)
	merge_type = /obj/item/stack/tile/mineral/plastitanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/plastitanium,
		/obj/item/stack/tile/mineral/plastitanium/red,
		)

/obj/item/stack/tile/mineral/plastitanium/red
	name = "red plastitanium tile"
	singular_name = "red plastitanium floor tile"
	desc = "A tile made of plastitanium, used for very red shuttles."
	turf_type = /turf/open/floor/mineral/plastitanium/red
	icon_state = "tile_plastitanium_red"
	merge_type = /obj/item/stack/tile/mineral/plastitanium/red

/obj/item/stack/tile/mineral/snow
	name = "snow tile"
	singular_name = "snow tile"
	desc = "A layer of snow."
	icon_state = "tile_snow"
	item_state = "tile-silver"
	turf_type = /turf/open/floor/grass/snow/safe
	mineralType = "snow"
	merge_type = /obj/item/stack/tile/mineral/snow

/obj/item/stack/tile/mineral/wax
	name = "wax tile"
	singular_name = "wax tile"
	desc = "A large, flat sheet of wax."
	icon_state = "tile_wax"
	item_state = "tile-wax"
	turf_type = /turf/open/floor/wax
	mineralType = "wax"
	merge_type = /obj/item/stack/tile/mineral/wax

/obj/item/stack/tile/mineral/brass
	name = "brass tiles"
	desc = "An ornante tile made out of brass."
	icon_state = "tile_brass"
	item_state = "tile_brass"
	turf_type = /turf/open/floor/clockwork
	mineralType = "brass"
	merge_type = /obj/item/stack/tile/mineral/brass

/obj/item/stack/tile/mineral/bronze
	name = "bronze tiles"
	desc = "An ornate tile made out of... wait this is bronze!"
	icon_state = "tile_brass"
	item_state = "tile_brass"
	turf_type = /turf/open/floor/bronze
	mineralType = "bronze"
	merge_type = /obj/item/stack/tile/mineral/bronze
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/bronze,
		/obj/item/stack/tile/mineral/bronze/flat,
		/obj/item/stack/tile/mineral/bronze/filled,
		)

/obj/item/stack/tile/mineral/bronze/flat
	name = "flat bronze tile"
	singular_name = "flat bronze floor tile"
	icon_state = "tile_reebe"
	turf_type = /turf/open/floor/bronze/flat
	merge_type = /obj/item/stack/tile/mineral/bronze/flat

/obj/item/stack/tile/mineral/bronze/filled
	name = "filled bronze tile"
	singular_name = "filled bronze floor tile"
	icon_state = "tile_brass_filled"
	turf_type = /turf/open/floor/bronze/filled
	merge_type = /obj/item/stack/tile/mineral/bronze/filled

/obj/item/stack/tile/cult
	name = "engraved tile"
	singular_name = "engraved floor tile"
	desc = "A strange tile made from runed metal. Doesn't seem to actually have any paranormal powers."
	icon_state = "tile_cult"
	turf_type = /turf/open/floor/cult
	//mats_per_unit = list(/datum/material/runedmetal=500)
	merge_type = /obj/item/stack/tile/cult
