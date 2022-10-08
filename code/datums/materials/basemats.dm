///Has no special properties.
/datum/material/iron
	name = "iron"
	id = "iron"
	desc = "Common iron ore often found in sedimentary and igneous layers of the crust."
	color = "#878687"
	greyscale_colors = "#878687"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/iron
	coin_type = /obj/item/coin/iron

///Breaks extremely easily but is transparent.
/datum/material/glass
	name = "glass"
	id = "glass"
	desc = "Glass forged by melting sand."
	color = "#dae6f0"
	greyscale_colors = "#dae6f0"
	alpha = 210
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	integrity_modifier = 0.1
	sheet_type = /obj/item/stack/sheet/glass


///Has no special properties. Could be good against vampires in the future perhaps.
/datum/material/silver
	name = "silver"
	id = "silver"
	desc = "A shiny ingot of silver. It's commonly found in the crust."
	color = "#bdbebf"
	greyscale_colors = "#bdbebf"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/silver
	coin_type = /obj/item/coin/silver

///Slight force increase
/datum/material/gold  // butter
	name = "gold"
	id = "gold"
	desc = "A very malleable ore, found in rocks, veins, and alluvial deposits. It kinda looks like butter, too."
	color = "#f0972b"
	greyscale_colors = "#f0972b"
	strength_modifier = 1.2
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/gold
	coin_type = /obj/item/coin/gold

///Has no special properties
/datum/material/diamond
	name = "diamond"
	id = "diamond"
	desc = "Highly pressurized carbon"
	color = "#22c2d4"
	greyscale_colors = "#22c2d4"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/diamond
	coin_type = /obj/item/coin/diamond

///Is slightly radioactive
/datum/material/uranium
	name = "uranium"
	id = "uranium"
	desc = "A weaker, but still deadly, radioactive isotope. Be careful when handling."
	color = "#1fb83b"
	greyscale_colors = "#1fb83b"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/uranium
	coin_type = /obj/item/coin/uranium

/datum/material/uranium/on_applied(atom/source, amount, material_flags)
	. = ..()
	source.AddComponent(/datum/component/radioactive, amount / 10, source, 0) //half-life of 0 because we keep on going.

/datum/material/uranium/on_removed(atom/source, material_flags)
	. = ..()
	qdel(source.GetComponent(/datum/component/radioactive))


///Adds firestacks on hit (Still needs support to turn into gas on destruction)
/datum/material/plasma
	name = "plasma"
	id = "plasma"
	desc = "Isn't plasma a state of matter? Oh, whatever. This is what Nanotrasen sent you to get."
	color = "#c716b8"
	greyscale_colors = "#c716b8"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/plasma
	coin_type = /obj/item/coin/plasma

/datum/material/plasma/on_applied(atom/source, amount, material_flags)
	. = ..()
	if(ismovableatom(source))
		source.AddElement(/datum/element/firestacker, amount=1)
		source.AddComponent(/datum/component/explodable, 0, 0, amount / 1000, amount / 500)

/datum/material/plasma/on_removed(atom/source, material_flags)
	. = ..()
	source.RemoveElement(/datum/element/firestacker, amount=1)
	qdel(source.GetComponent(/datum/component/explodable))

///Can cause bluespace effects on use. (Teleportation) (Not yet implemented)
/datum/material/bluespace
	name = "bluespace crystal"
	id = "bluespace_crystal"
	desc = "A strange, translucent-blue crystal that radiates a strong cosmic energy."
	color = "#506bc7"
	greyscale_colors = "#506bc7"
	categories = list(MAT_CATEGORY_ORE = TRUE)
	sheet_type = /obj/item/stack/ore/bluespace_crystal/refined

///Honks and slips
/datum/material/bananium
	name = "bananium"
	id = "bananium"
	desc = "A crystallized...banana? It doesn't seem slippery, at least."
	color = "#fff263"
	greyscale_colors = "#fff263"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/bananium
	coin_type = /obj/item/coin/bananium

/datum/material/bananium/on_applied(atom/source, amount, material_flags)
	. = ..()
	source.LoadComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg'=1), 50)
	source.AddComponent(/datum/component/slippery, min(amount / 10, 80))

/datum/material/bananium/on_removed(atom/source, amount, material_flags)
	. = ..()
	qdel(source.GetComponent(/datum/component/slippery))
	qdel(source.GetComponent(/datum/component/squeak))


///Mediocre force increase
/datum/material/titanium
	name = "titanium"
	id = "titanium"
	desc = "A piece of titanium, no way you're breaking this. Its quite shiny."
	color = "#b3c0c7"
	greyscale_colors = "#b3c0c7"
	strength_modifier = 1.3
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/titanium

///Force decrease
/datum/material/plastic
	name = "plastic"
	id = "plastic"
	desc = "The most flexible of materials, though somehow not insulated..."
	color = "#caccd9"
	greyscale_colors = "#caccd9"
	strength_modifier = 0.85
	sheet_type = /obj/item/stack/sheet/plastic

///Force decrease and mushy sound effect. (Not yet implemented)
/datum/material/biomass
	name = "biomass"
	id = "biomass"
	desc = "Organic matter"
	color = "#735b4d"
	greyscale_colors = "#735b4d"
	strength_modifier = 0.8


/datum/material/copper
	name = "copper"
	id = "copper"
	desc = "Copper is a soft, malleable, and ductile metal with very high thermal and electrical conductivity."
	color = "#d95802"
	greyscale_colors = "#d95802"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/copper
