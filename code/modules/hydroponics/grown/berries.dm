// Berries
/obj/item/seeds/berry
	name = "pack of berry seeds"
	desc = "These seeds grow into berry bushes."
	plantname = "Berry Bush"
	species = "berry"
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "berry-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "berry-dead" // Same for the dead icon
	icon_state = "seed-berry"
	product = /obj/item/reagent_containers/food/snacks/grown/berries

	lifespan = 20
	maturation = 5
	production = 5
	yield = 2
	bitesize_mod = 2
	distill_reagent = /datum/reagent/consumable/ethanol/gin

	mutatelist = list(/obj/item/seeds/berry/glow, /obj/item/seeds/berry/poison)
	genes = list(/datum/plant_gene/trait/perennial)
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(7, 15),
		/datum/reagent/consumable/nutriment/vitamin = list(4, 12))

/obj/item/reagent_containers/food/snacks/grown/berries
	seed = /obj/item/seeds/berry
	name = "bunch of berries"
	desc = "Nutritious!"
	icon_state = "berrypile"
	gender = PLURAL
	filling_color = "#FF00FF"
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/berryjuice = 0)
	tastes = list("berry" = 1)

// Poison Berries
/obj/item/seeds/berry/poison
	name = "pack of poison-berry seeds"
	desc = "These seeds grow into poison-berry bushes."
	plantname = "Poison-Berry Bush"
	species = "poisonberry"
	icon_state = "seed-poisonberry"
	product = /obj/item/reagent_containers/food/snacks/grown/berries/poison

	rarity = 10 // Mildly poisonous berries are common in reality


	mutatelist = list(/obj/item/seeds/berry/death)
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(8, 18),
		/datum/reagent/consumable/nutriment/vitamin = list(4, 12),
		/datum/reagent/toxin/cyanide = list(10, 15),
		/datum/reagent/toxin/staminatoxin = list(15, 25))

/obj/item/reagent_containers/food/snacks/grown/berries/poison
	seed = /obj/item/seeds/berry/poison
	name = "bunch of poison-berries"
	desc = "Taste so good, you might die!"
	icon_state = "poisonberrypile"
	filling_color = "#C71585"
	foodtype = FRUIT | TOXIC
	juice_results = list(/datum/reagent/consumable/poisonberryjuice = 0)
	tastes = list("poison-berry" = 1)
	distill_reagent = null
	wine_power = 35
	discovery_points = 300

// Death Berries
/obj/item/seeds/berry/death
	name = "pack of death-berry seeds"
	desc = "These seeds grow into death berries."
	icon_state = "seed-deathberry"
	species = "deathberry"
	plantname = "Death Berry Bush"
	product = /obj/item/reagent_containers/food/snacks/grown/berries/death
	lifespan = 30
	potency = 50
	mutatelist = list()
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(8, 18),
		/datum/reagent/consumable/nutriment/vitamin = list(4, 12),
		/datum/reagent/toxin/coniine = list(8, 12),
		/datum/reagent/toxin/staminatoxin = list(8, 12))
	rarity = 30

/obj/item/reagent_containers/food/snacks/grown/berries/death
	seed = /obj/item/seeds/berry/death
	name = "bunch of death-berries"
	desc = "Taste so good, you will die!"
	icon_state = "deathberrypile"
	filling_color = "#708090"
	foodtype = FRUIT | TOXIC
	tastes = list("death-berry" = 1)
	distill_reagent = null
	wine_power = 50
	discovery_points = 300

// Glow Berries
/obj/item/seeds/berry/glow
	name = "pack of glow-berry seeds"
	desc = "These seeds grow into glow-berry bushes."
	plantname = "Glow-Berry Bush"
	species = "glowberry"
	icon_state = "seed-glowberry"
	product = /obj/item/reagent_containers/food/snacks/grown/berries/glow

	lifespan = 30
	endurance = 25
	volume_mod = 10
	rarity = 20

	mutatelist = list()
	genes = list(/datum/plant_gene/trait/glow/white, /datum/plant_gene/trait/perennial, /datum/plant_gene/trait/noreact)
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(1, 18),
		/datum/reagent/consumable/nutriment/vitamin = list(0, 12),
		/datum/reagent/uranium = list(5, 30),
		/datum/reagent/iodine = list(5, 30))

/obj/item/reagent_containers/food/snacks/grown/berries/glow
	seed = /obj/item/seeds/berry/glow
	name = "bunch of glow-berries"
	desc = "Nutritious!"
	icon_state = "glowberrypile"
	filling_color = "#7CFC00"
	foodtype = FRUIT
	tastes = list("glow-berry" = 1)
	distill_reagent = null
	wine_power = 60
	discovery_points = 300

// Cherries
/obj/item/seeds/cherry
	name = "pack of cherry pits"
	desc = "Careful not to crack a tooth on one... That'd be the pits."
	icon_state = "seed-cherry"
	species = "cherry"
	plantname = "Cherry Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/cherries
	lifespan = 35
	endurance = 35
	maturation = 5
	production = 5
	growthstages = 5
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "cherry-grow"
	icon_dead = "cherry-dead"
	icon_harvest = "cherry-harvest"
	genes = list(/datum/plant_gene/trait/perennial)
	mutatelist = list(/obj/item/seeds/cherry/blue, /obj/item/seeds/cherry/bulb)
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(7, 15),
		/datum/reagent/consumable/nutriment/vitamin = list(0.5, 2),
		/datum/reagent/consumable/sugar = list(5, 10))

/obj/item/reagent_containers/food/snacks/grown/cherries
	seed = /obj/item/seeds/cherry
	name = "cherries"
	desc = "Great for toppings!"
	icon_state = "cherry"
	gender = PLURAL
	filling_color = "#FF0000"
	bitesize_mod = 2
	foodtype = FRUIT
	grind_results = list(/datum/reagent/consumable/cherryjelly = 0)
	tastes = list("cherry" = 1)
	wine_power = 30

// Blue Cherries
/obj/item/seeds/cherry/blue
	name = "pack of blue cherry pits"
	desc = "The blue kind of cherries."
	icon_state = "seed-bluecherry"
	species = "bluecherry"
	plantname = "Blue Cherry Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/bluecherries
	mutatelist = list()
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(7, 15),
		/datum/reagent/consumable/nutriment/vitamin = list(1, 5),
		/datum/reagent/consumable/sugar = list(7, 12))
	rarity = 10

/obj/item/reagent_containers/food/snacks/grown/bluecherries
	seed = /obj/item/seeds/cherry/blue
	name = "blue cherries"
	desc = "They're cherries that are blue."
	icon_state = "bluecherry"
	filling_color = "#6495ED"
	bitesize_mod = 2
	foodtype = FRUIT
	grind_results = list(/datum/reagent/consumable/bluecherryjelly = 0)
	tastes = list("blue cherry" = 1)
	wine_power = 50
	discovery_points = 300

//Cherry Bulbs
/obj/item/seeds/cherry/bulb
	name = "pack of cherry bulb pits"
	desc = "The glowy kind of cherries."
	icon_state = "seed-cherrybulb"
	species = "cherrybulb"
	plantname = "Cherry Bulb Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/cherrybulbs
	genes = list(/datum/plant_gene/trait/perennial, /datum/plant_gene/trait/glow/pink)
	mutatelist = list()
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(7, 15),
		/datum/reagent/consumable/nutriment/vitamin = list(1, 5),
		/datum/reagent/consumable/sugar = list(7, 12))
	rarity = 10

/obj/item/reagent_containers/food/snacks/grown/cherrybulbs
	seed = /obj/item/seeds/cherry/bulb
	name = "cherry bulbs"
	desc = "They're like little Space Christmas lights!"
	icon_state = "cherry_bulb"
	filling_color = "#FF0000"
	bitesize_mod = 2
	foodtype = FRUIT
	grind_results = list(/datum/reagent/consumable/cherryjelly = 0)
	tastes = list("cherry" = 1)
	wine_power = 50
	discovery_points = 300

// Grapes
/obj/item/seeds/grape
	name = "pack of grape seeds"
	desc = "These seeds grow into grape vines."
	icon_state = "seed-grapes"
	species = "grape"
	plantname = "Grape Vine"
	product = /obj/item/reagent_containers/food/snacks/grown/grapes
	lifespan = 50
	endurance = 25
	maturation = 3
	production = 5
	yield = 4
	growthstages = 2
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "grape-grow"
	icon_dead = "grape-dead"
	genes = list(/datum/plant_gene/trait/perennial)
	mutatelist = list(/obj/item/seeds/grape/green)
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(8, 18),
		/datum/reagent/consumable/nutriment/vitamin = list(4, 12),
		/datum/reagent/consumable/sugar = list(5, 10))

/obj/item/reagent_containers/food/snacks/grown/grapes
	seed = /obj/item/seeds/grape
	name = "bunch of grapes"
	desc = "Nutritious!"
	icon_state = "grapes"
	dried_type = /obj/item/reagent_containers/food/snacks/no_raisin/healthy
	filling_color = "#FF1493"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/grapejuice = 0)
	tastes = list("grape" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/wine

// Green Grapes
/obj/item/seeds/grape/green
	name = "pack of green grape seeds"
	desc = "These seeds grow into green-grape vines."
	icon_state = "seed-greengrapes"
	species = "greengrape"
	plantname = "Green-Grape Vine"
	product = /obj/item/reagent_containers/food/snacks/grown/grapes/green
	reagents_set = list(
		/datum/reagent/consumable/nutriment = list(8, 18),
		/datum/reagent/consumable/nutriment/vitamin = list(4, 12),
		/datum/reagent/consumable/sugar = list(5, 10),
		/datum/reagent/medicine/kelotane = list(20, 35))
	// No rarity: technically it's a beneficial mutant, but it's not exactly "new"...
	mutatelist = list()

/obj/item/reagent_containers/food/snacks/grown/grapes/green
	seed = /obj/item/seeds/grape/green
	name = "bunch of green grapes"
	icon_state = "greengrapes"
	filling_color = "#7FFF00"
	tastes = list("green grape" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/cognac
	discovery_points = 300
