/obj/item/seeds/rainbow_bunch
	name = "pack of rainbow bunch seeds"
	desc = "A pack of seeds that'll grow into a beautiful bush of various colored flowers."
	icon_state = "seed-rainbowbunch"
	species = "rainbowbunch"
	plantname = "Rainbow Bunch"
	icon_harvest = "rainbowbunch-harvest"
	product = /obj/item/reagent_containers/food/snacks/grown/rainbow_flower
	lifespan = 25
	endurance = 10
	maturation = 6
	production = 3
	yield = 5
	potency = 20
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	icon_dead = "rainbowbunch-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05)

/obj/item/reagent_containers/food/snacks/grown/rainbow_flower
	seed = /obj/item/seeds/rainbow_bunch
	name = "rainbow flower"
	desc = "A beautiful flower capable of being used for most dyeing processes."
	icon_state = "map_flower"
	slot_flags = ITEM_SLOT_HEAD
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 2
	throw_range = 3
	attack_verb = list("pompfed")
	greyscale_config = /datum/greyscale_config/rainbow_bunch
	greyscale_config_worn = /datum/greyscale_config/rainbow_bunch_worn

/obj/item/reagent_containers/food/snacks/grown/rainbow_flower/Initialize()
	. = ..()
	if(greyscale_colors)
		return

	var/flower_color = rand(1,8)
	switch(flower_color)
		if(1)
			item_color = "red"
			set_greyscale("#DA0000")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/red, 3)
			desc += " This one is in a fiery red color."
		if(2)
			item_color = "orange"
			set_greyscale("#FF9300")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/orange, 3)
			desc += " This one is in a citrus orange color."
		if(3)
			item_color = "yellow"
			set_greyscale("#FFF200")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/yellow, 3)
			desc += " This one is in a bright yellow color."
		if(4)
			item_color = "green"
			set_greyscale("#A8E61D")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/green, 3)
			desc += " This one is in a grassy green color."
		if(5)
			item_color = "blue"
			set_greyscale("#00B7EF)"
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/blue, 3)
			desc += " This one is in a soothing blue color."
		if(6)
			item_color = "purple"
			set_greyscale("#DA00FF")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/purple, 3)
			desc += " This one is in a vibrant purple color."
		if(7)
			item_color = "black"
			set_greyscale("#1C1C1C")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/black, 3)
			desc += " This one is in a midnight black color."
		if(8)
			item_color = "white"
			set_greyscale("#FFFFFF")
			reagents.add_reagent(/datum/reagent/colorful_reagent/powder/white, 3)
			desc += " This one is in a pure white color."
