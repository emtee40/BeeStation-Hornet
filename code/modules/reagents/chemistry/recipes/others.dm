


/datum/chemical_reaction/sterilizine
	name = "Sterilizine"
	id = /datum/reagent/space_cleaner/sterilizine
	results = list(/datum/reagent/space_cleaner/sterilizine = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/medicine/charcoal = 1, /datum/reagent/chlorine = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

/datum/chemical_reaction/cooking_oil
	name = "Cooking Oil"
	id = /datum/reagent/consumable/cooking_oil
	results = list(/datum/reagent/consumable/cooking_oil = 4)
	required_reagents = list(/datum/reagent/hydrogen = 1, /datum/reagent/oil = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/carbon = 1)

/datum/chemical_reaction/lube
	name = "Space Lube"
	id = /datum/reagent/lube
	results = list(/datum/reagent/lube = 4)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/silicon = 1, /datum/reagent/oxygen = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

/datum/chemical_reaction/spraytan
	name = "Spray Tan"
	id = /datum/reagent/spraytan
	results = list(/datum/reagent/spraytan = 2)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

/datum/chemical_reaction/spraytan2
	name = "Spray Tan"
	id = /datum/reagent/spraytan
	results = list(/datum/reagent/spraytan = 2)
	required_reagents = list(/datum/reagent/consumable/orangejuice = 1, /datum/reagent/consumable/cornoil = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

/datum/chemical_reaction/impedrezene
	name = "Impedrezene"
	id = /datum/reagent/impedrezene
	results = list(/datum/reagent/impedrezene = 2)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/oxygen = 1, /datum/reagent/consumable/sugar = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_ORGAN

/datum/chemical_reaction/cryptobiolin
	name = "Cryptobiolin"
	id = /datum/reagent/cryptobiolin
	results = list(/datum/reagent/cryptobiolin = 3)
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/oxygen = 1, /datum/reagent/consumable/sugar = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

/datum/chemical_reaction/glycerol
	name = "Glycerol"
	id = /datum/reagent/glycerol
	results = list(/datum/reagent/glycerol = 1)
	required_reagents = list(/datum/reagent/consumable/cornoil = 3, /datum/reagent/toxin/acid = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_EXPLOSIVE

/datum/chemical_reaction/sodiumchloride
	name = "Sodium Chloride"
	id = /datum/reagent/consumable/sodiumchloride
	results = list(/datum/reagent/consumable/sodiumchloride = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/sodium = 1, /datum/reagent/chlorine = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_FOOD

/datum/chemical_reaction/stable_plasma
	results = list(/datum/reagent/stable_plasma = 1)
	required_reagents = list(/datum/reagent/toxin/plasma = 1)
	required_catalysts = list(/datum/reagent/stabilizing_agent = 1)

/datum/chemical_reaction/plasma_solidification
	required_reagents = list(/datum/reagent/iron = 5, /datum/reagent/consumable/frostoil = 5, /datum/reagent/toxin/plasma = 20)
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/plasmasolidification/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/stack/sheet/mineral/plasma(location)

/datum/chemical_reaction/goldsolidification
	name = "Solid Gold"
	id = "solidgold"
	required_reagents = list(/datum/reagent/consumable/frostoil = 5, /datum/reagent/gold = 20, /datum/reagent/iron = 1)
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/goldsolidification/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/stack/sheet/mineral/gold(location)

/datum/chemical_reaction/adamantinesolidification
	name = "Adamantine Sheet"
	id = "solidadam"
	required_reagents = list(/datum/reagent/gold = 5, /datum/reagent/consumable/frostoil = 5, /datum/reagent/liquidadamantine = 10)
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/adamantinesolidification/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/stack/sheet/mineral/adamantine(location)

/datum/chemical_reaction/capsaicincondensation
	name = "Capsaicincondensation"
	id = "capsaicincondensation"
	results = list(/datum/reagent/consumable/condensedcapsaicin = 5)
	required_reagents = list(/datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/ethanol = 5)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

/datum/chemical_reaction/soapification
	name = "Soapification"
	id = "soapification"
	required_reagents = list(/datum/reagent/liquidgibs = 10, /datum/reagent/lye  = 10) // requires two scooped gib tiles
	required_temp = 374
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/soapification/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/soap/homemade(location)

/datum/chemical_reaction/candlefication
	name = "Candlefication"
	id = "candlefication"
	required_reagents = list(/datum/reagent/liquidgibs = 5, /datum/reagent/oxygen  = 5) //
	required_temp = 374
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

/datum/chemical_reaction/candlefication/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/candle(location)

/datum/chemical_reaction/meatification
	name = "Meatification"
	id = "meatification"
	required_reagents = list(/datum/reagent/liquidgibs = 10, /datum/reagent/consumable/nutriment = 10, /datum/reagent/carbon = 10)
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/meatification/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/reagent_containers/food/snacks/meat/slab/meatproduct(location)
	return

/datum/chemical_reaction/carbondioxide
	name = "Direct Carbon Oxidation"
	id = "burningcarbon"
	results = list(/datum/reagent/carbondioxide = 3)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/oxygen = 2)
	required_temp = 777 // pure carbon isn't especially reactive.
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/nitrous_oxide
	name = "Nitrous Oxide"
	id = /datum/reagent/nitrous_oxide
	results = list(/datum/reagent/nitrous_oxide = 5)
	required_reagents = list(/datum/reagent/ammonia = 2, /datum/reagent/nitrogen = 1, /datum/reagent/oxygen = 2)
	required_temp = 525
	optimal_temp = 550
	overheat_temp = 575
	temp_exponent_factor = 0.2
	purity_min = 0.3
	thermic_constant = 35 //gives a bonus 15C wiggle room
	rate_up_lim = 25 //Give a chance to pull back

//Technically a mutation toxin
/datum/chemical_reaction/mulligan
	name = "Mulligan"
	id = /datum/reagent/mulligan
	results = list(/datum/reagent/mulligan = 1)
	required_reagents = list(/datum/reagent/mutationtoxin/jelly = 1, /datum/reagent/toxin/mutagen = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

////////////////////////////////// VIROLOGY //////////////////////////////////////////

/datum/chemical_reaction/virus_food
	name = "Virus Food"
	id = /datum/reagent/consumable/virus_food
	results = list(/datum/reagent/consumable/virus_food = 15)
	required_reagents = list(/datum/reagent/water = 5, /datum/reagent/consumable/milk = 5)

/datum/chemical_reaction/virus_food_mutagen
	name = "mutagenic agar"
	id = /datum/reagent/toxin/mutagen/mutagenvirusfood
	results = list(/datum/reagent/toxin/mutagen/mutagenvirusfood = 1)
	required_reagents = list(/datum/reagent/toxin/mutagen = 1, /datum/reagent/consumable/virus_food = 1)

/datum/chemical_reaction/virus_food_synaptizine
	name = "virus rations"
	id = /datum/reagent/medicine/synaptizine/synaptizinevirusfood
	results = list(/datum/reagent/medicine/synaptizine/synaptizinevirusfood = 1)
	required_reagents = list(/datum/reagent/medicine/synaptizine = 1, /datum/reagent/consumable/virus_food = 1)

/datum/chemical_reaction/virus_food_plasma
	name = "virus plasma"
	id = /datum/reagent/toxin/plasma/plasmavirusfood
	results = list(/datum/reagent/toxin/plasma/plasmavirusfood = 1)
	required_reagents = list(/datum/reagent/toxin/plasma = 1, /datum/reagent/consumable/virus_food = 1)

/datum/chemical_reaction/virus_food_plasma_synaptizine
	name = "weakened virus plasma"
	id = /datum/reagent/toxin/plasma/plasmavirusfood/weak
	results = list(/datum/reagent/toxin/plasma/plasmavirusfood/weak = 2)
	required_reagents = list(/datum/reagent/medicine/synaptizine = 1, /datum/reagent/toxin/plasma/plasmavirusfood = 1)

/datum/chemical_reaction/virus_food_mutagen_sugar
	name = "sucrose agar"
	id = /datum/reagent/toxin/mutagen/mutagenvirusfood/sugar
	results = list(/datum/reagent/toxin/mutagen/mutagenvirusfood/sugar = 2)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/toxin/mutagen/mutagenvirusfood = 1)

/datum/chemical_reaction/virus_food_mutagen_salineglucose
	name = "sucrose agar"
	id = "salineglucosevirusfood"
	results = list(/datum/reagent/toxin/mutagen/mutagenvirusfood/sugar = 2)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1, /datum/reagent/toxin/mutagen/mutagenvirusfood = 1)

/datum/chemical_reaction/virus_food_uranium
	name = "Decaying uranium gel"
	id = /datum/reagent/uranium/uraniumvirusfood
	results = list(/datum/reagent/uranium/uraniumvirusfood = 1)
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/consumable/virus_food = 1)

/datum/chemical_reaction/virus_food_uranium_plasma
	name = "Unstable uranium gel"
	id = "uraniumvirusfood_plasma"
	results = list(/datum/reagent/uranium/uraniumvirusfood/unstable = 1)
	required_reagents = list(/datum/reagent/uranium = 2, /datum/reagent/toxin/plasma/plasmavirusfood = 1)

/datum/chemical_reaction/virus_food_uranium_plasma_gold
	name = "Stable uranium gel"
	id = "uraniumvirusfood_gold"
	results = list(/datum/reagent/uranium/uraniumvirusfood/stable = 1)
	required_reagents = list(/datum/reagent/uranium = 5, /datum/reagent/gold = 5, /datum/reagent/toxin/plasma = 5)

/datum/chemical_reaction/virus_food_uranium_plasma_silver
	name = "Stable uranium gel"
	id = "uraniumvirusfood_silver"
	results = list(/datum/reagent/uranium/uraniumvirusfood/stable = 1)
	required_reagents = list(/datum/reagent/uranium = 5, /datum/reagent/silver = 5, /datum/reagent/toxin/plasma = 5)

/datum/chemical_reaction/virus_food_laughter
	name = "Anomolous virus food"
	id = "virusfood_laughter"
	results = list(/datum/reagent/consumable/laughter/laughtervirusfood = 1)
	required_reagents = list(/datum/reagent/consumable/laughter = 5, /datum/reagent/consumable/virus_food = 1)

/datum/chemical_reaction/virus_food_admin
	name = "Highly unstable virus Food"
	id = "virusfood_admin"
	results = list(/datum/reagent/consumable/virus_food/advvirusfood = 1)
	required_reagents = list(/datum/reagent/consumable/virus_food/viralbase = 1, /datum/reagent/uranium = 20)
	mix_message = "The mixture turns every colour of the rainbow, soon settling on a bright white. There's no way this isn't a good idea."

//Adds a virus symptom from the level_min to level_max range
/datum/chemical_reaction/mix_virus
	name = "Mix Virus"
	id = "mixvirus"
	results = list(/datum/reagent/blood = 1)
	required_reagents = list(/datum/reagent/consumable/virus_food = 1)
	required_catalysts = list(/datum/reagent/blood = 1)
	reaction_flags = REACTION_INSTANT
	var/level_min = 1
	var/level_max = 2

/datum/chemical_reaction/mix_virus/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in holder.reagent_list
	if(B && B.data)
		var/datum/disease/advance/D = locate(/datum/disease/advance) in B.data["viruses"]
		if(D)
			D.Evolve(level_min, level_max)


/datum/chemical_reaction/mix_virus/mix_virus_2
	name = "Mix Virus 2"
	id = "mixvirus2"
	required_reagents = list(/datum/reagent/toxin/mutagen = 1)
	level_min = 2
	level_max = 4

/datum/chemical_reaction/mix_virus/mix_virus_3
	name = "Mix Virus 3"
	id = "mixvirus3"
	required_reagents = list(/datum/reagent/toxin/plasma = 1)
	level_min = 4
	level_max = 6

/datum/chemical_reaction/mix_virus/mix_virus_4
	name = "Mix Virus 4"
	id = "mixvirus4"
	required_reagents = list(/datum/reagent/uranium = 1)
	level_min = 5
	level_max = 6

/datum/chemical_reaction/mix_virus/mix_virus_5
	name = "Mix Virus 5"
	id = "mixvirus5"
	required_reagents = list(/datum/reagent/toxin/mutagen/mutagenvirusfood = 1)
	level_min = 3
	level_max = 3

/datum/chemical_reaction/mix_virus/mix_virus_6
	name = "Mix Virus 6"
	id = "mixvirus6"
	required_reagents = list(/datum/reagent/toxin/mutagen/mutagenvirusfood/sugar = 1)
	level_min = 4
	level_max = 4

/datum/chemical_reaction/mix_virus/mix_virus_7
	name = "Mix Virus 7"
	id = "mixvirus7"
	required_reagents = list(/datum/reagent/toxin/plasma/plasmavirusfood/weak = 1)
	level_min = 5
	level_max = 5

/datum/chemical_reaction/mix_virus/mix_virus_8
	name = "Mix Virus 8"
	id = "mixvirus8"
	required_reagents = list(/datum/reagent/toxin/plasma/plasmavirusfood = 1)
	level_min = 6
	level_max = 6

/datum/chemical_reaction/mix_virus/mix_virus_9
	name = "Mix Virus 9"
	id = "mixvirus9"
	required_reagents = list(/datum/reagent/medicine/synaptizine/synaptizinevirusfood = 1)
	level_min = 1
	level_max = 1

/datum/chemical_reaction/mix_virus/mix_virus_10
	name = "Mix Virus 10"
	id = "mixvirus10"
	required_reagents = list(/datum/reagent/uranium/uraniumvirusfood = 1)
	level_min = 6
	level_max = 7

/datum/chemical_reaction/mix_virus/mix_virus_11
	name = "Mix Virus 11"
	id = "mixvirus11"
	required_reagents = list(/datum/reagent/uranium/uraniumvirusfood/unstable = 1)
	level_min = 7
	level_max = 7

/datum/chemical_reaction/mix_virus/mix_virus_12
	name = "Mix Virus 12"
	id = "mixvirus12"
	required_reagents = list(/datum/reagent/uranium/uraniumvirusfood/stable = 1)
	level_min = 8
	level_max = 8

/datum/chemical_reaction/mix_virus/mix_virus_13
	name = "Mix Virus 13"
	id = "mixvirus13"
	required_reagents = list(/datum/reagent/consumable/laughter/laughtervirusfood = 1)
	level_min = 0
	level_max = 0

/datum/chemical_reaction/mix_virus/mix_virus_14
	name = "Mix Virus 14"
	id = "mixvirus14"
	required_reagents = list(/datum/reagent/consumable/virus_food/advvirusfood = 1)
	level_min = 9
	level_max = 9

//removes a random disease symptom
/datum/chemical_reaction/mix_virus/rem_virus
	name = "Devolve Virus"
	id = "remvirus"
	required_reagents = list(/datum/reagent/medicine/synaptizine = 1)
	required_catalysts = list(/datum/reagent/blood = 1)

/datum/chemical_reaction/mix_virus/rem_virus/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in holder.reagent_list
	if(B && B.data)
		var/datum/disease/advance/D = locate(/datum/disease/advance) in B.data["viruses"]
		if(D)
			D.Devolve()

//prevents a random symptom from showing while keeping the stats
/datum/chemical_reaction/mix_virus/neuter_virus
	name = "Neuter Virus"
	id = "neutervirus"
	required_reagents = list(/datum/reagent/toxin/formaldehyde = 1)
	required_catalysts = list(/datum/reagent/blood = 1)

/datum/chemical_reaction/mix_virus/neuter_virus/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)

	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in holder.reagent_list
	if(B?.data)
		var/datum/disease/advance/D = locate(/datum/disease/advance) in B.data["viruses"]
		if(D)
			D.Neuter()

//prevents the altering of disease symptoms
/datum/chemical_reaction/mix_virus/preserve_virus
	name = "Preserve Virus"
	id = "preservevirus"
	required_reagents = list(/datum/reagent/cryostylane = 1)
	required_catalysts = list(/datum/reagent/blood = 1)

/datum/chemical_reaction/mix_virus/preserve_virus/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)

	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in holder.reagent_list
	if(B?.data)
		var/datum/disease/advance/D = locate(/datum/disease/advance) in B.data["viruses"]
		if(D)
			D.mutable = FALSE

//prevents the disease from spreading via symptoms
/datum/chemical_reaction/mix_virus/falter_virus
	name = "Falter Virus"
	id = "faltervirus"
	required_reagents = list(/datum/reagent/medicine/spaceacillin = 1)
	required_catalysts = list(/datum/reagent/blood = 1)

/datum/chemical_reaction/mix_virus/falter_virus/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)

	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in holder.reagent_list
	if(B?.data)
		var/datum/disease/advance/D = locate(/datum/disease/advance) in B.data["viruses"]
		if(D)
			D.faltered = TRUE
			D.spread_flags = DISEASE_SPREAD_FALTERED
			D.spread_text = "Intentional Injection"


////////////////////////////////// foam and foam precursor ///////////////////////////////////////////////////


/datum/chemical_reaction/surfactant
	name = "Foam surfactant"
	id = "foam surfactant"
	results = list(/datum/reagent/fluorosurfactant = 5)
	required_reagents = list(/datum/reagent/fluorine = 2, /datum/reagent/carbon = 2, /datum/reagent/toxin/acid = 1)
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/foam
	name = "Foam"
	id = "foam"
	required_reagents = list(/datum/reagent/fluorosurfactant = 1, /datum/reagent/water = 1)
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/foam/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	holder.create_foam(/datum/effect_system/foam_spread,2*created_volume,notification="<span class='danger'>The solution spews out foam!</span>")


/datum/chemical_reaction/metalfoam
	name = "Metal Foam"
	id = "metalfoam"
	required_reagents = list(/datum/reagent/aluminium = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/toxin/acid/fluacid = 1)
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/metalfoam/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)

	for(var/mob/M as() in viewers(5, location))
		to_chat(M, "<span class='danger'>The solution spews out a metallic foam!</span>")

	var/datum/effect_system/foam_spread/metal/s = new()
	s.set_up(created_volume*5, location, holder, 1)
	s.start()
	holder.clear_reagents()

/datum/chemical_reaction/smart_foam
	name = "Smart Metal Foam"
	id = "smart_metal_foam"
	required_reagents = list(/datum/reagent/aluminium = 3, /datum/reagent/smart_foaming_agent = 1, /datum/reagent/toxin/acid/fluacid = 1)
	mob_react = TRUE
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/smart_foam/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/turf/location = get_turf(holder.my_atom)
	location.visible_message("<span class='danger'>The solution spews out metallic foam!</span>")
	var/datum/effect_system/foam_spread/metal/smart/s = new()
	s.set_up(created_volume * 5, location, holder, TRUE)
	s.start()
	holder.clear_reagents()

/datum/chemical_reaction/ironfoam
	name = "Iron Foam"
	id = "ironlfoam"
	required_reagents = list(/datum/reagent/iron = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/toxin/acid/fluacid = 1)
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/ironfoam/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/mob/M as() in viewers(5, location))
		to_chat(M, "<span class='danger'>The solution spews out a metallic foam!</span>")
	var/datum/effect_system/foam_spread/metal/s = new()
	s.set_up(created_volume*5, location, holder, 2)
	s.start()
	holder.clear_reagents()

/datum/chemical_reaction/foaming_agent
	name = "Foaming Agent"
	id = /datum/reagent/foaming_agent
	results = list(/datum/reagent/foaming_agent = 1)
	required_reagents = list(/datum/reagent/lithium = 1, /datum/reagent/hydrogen = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/smart_foaming_agent
	name = "Smart foaming Agent"
	id = /datum/reagent/smart_foaming_agent
	results = list(/datum/reagent/smart_foaming_agent = 3)
	required_reagents = list(/datum/reagent/foaming_agent = 3, /datum/reagent/acetone = 1, /datum/reagent/iron = 1)
	mix_message = "The solution mixes into a frothy metal foam and conforms to the walls of its container."
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE


/////////////////////////////// Cleaning and hydroponics /////////////////////////////////////////////////

/datum/chemical_reaction/ammonia
	name = "Ammonia"
	id = /datum/reagent/ammonia
	results = list(/datum/reagent/ammonia = 3)
	required_reagents = list(/datum/reagent/hydrogen = 3, /datum/reagent/nitrogen = 1)
	optimal_ph_min = 1  // Lets increase our range for this basic chem
	optimal_ph_max = 12
	H_ion_release = -0.02 //handmade is more neutral
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_PLANT

/datum/chemical_reaction/diethylamine
	name = "Diethylamine"
	id = /datum/reagent/diethylamine
	results = list(/datum/reagent/diethylamine = 2)
	required_reagents = list (/datum/reagent/ammonia = 1, /datum/reagent/consumable/ethanol = 1)

/datum/chemical_reaction/space_cleaner
	name = "Space cleaner"
	id = /datum/reagent/space_cleaner
	results = list(/datum/reagent/space_cleaner = 2)
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/water = 1)
	rate_up_lim = 40

/datum/chemical_reaction/plantbgone
	name = "Plant-B-Gone"
	id = /datum/reagent/toxin/plantbgone
	results = list(/datum/reagent/toxin/plantbgone = 5)
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/water = 4)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_PLANT

/datum/chemical_reaction/weedkiller
	name = "Weed Killer"
	id = /datum/reagent/toxin/plantbgone/weedkiller
	results = list(/datum/reagent/toxin/plantbgone/weedkiller = 5)
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/ammonia = 4)
	H_ion_release = -0.05 // Push towards acidic

/datum/chemical_reaction/pestkiller
	name = "Pest Killer"
	id = /datum/reagent/toxin/pestkiller
	results = list(/datum/reagent/toxin/pestkiller = 5)
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/consumable/ethanol = 4)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_PLANT

/datum/chemical_reaction/drying_agent
	name = "Drying agent"
	id = /datum/reagent/drying_agent
	results = list(/datum/reagent/drying_agent = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 2, /datum/reagent/consumable/ethanol = 1, /datum/reagent/sodium = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

//////////////////////////////////// Other goon stuff ///////////////////////////////////////////

/datum/chemical_reaction/acetone
	name = /datum/reagent/acetone
	id = /datum/reagent/acetone
	results = list(/datum/reagent/acetone = 3)
	required_reagents = list(/datum/reagent/foaming_agent = 3, /datum/reagent/acetone = 1, /datum/reagent/iron = 1)

/datum/chemical_reaction/carpet
	name = /datum/reagent/carpet
	id = /datum/reagent/carpet
	results = list(/datum/reagent/carpet = 2)
	required_reagents = list(/datum/reagent/drug/space_drugs = 1, /datum/reagent/blood = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/oil
	name = "Oil"
	id = /datum/reagent/oil
	results = list(/datum/reagent/oil = 3)
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/carbon = 1, /datum/reagent/hydrogen = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/phenol
	name = /datum/reagent/phenol
	id = /datum/reagent/phenol
	results = list(/datum/reagent/phenol = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/chlorine = 1, /datum/reagent/oil = 1)

/datum/chemical_reaction/ash
	name = "Ash"
	id = /datum/reagent/ash
	results = list(/datum/reagent/ash = 1)
	required_reagents = list(/datum/reagent/oil = 1)
	required_temp = 480
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL | REACTION_TAG_PLANT

/datum/chemical_reaction/colorful_reagent
	name = /datum/reagent/colorful_reagent
	id = /datum/reagent/colorful_reagent
	results = list(/datum/reagent/colorful_reagent = 5)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/uranium/radium = 1, /datum/reagent/drug/space_drugs = 1, /datum/reagent/medicine/cryoxadone = 1, /datum/reagent/consumable/triple_citrus = 1)

/datum/chemical_reaction/life
	name = "Life"
	id = "life"
	required_reagents = list(/datum/reagent/medicine/strange_reagent = 1, /datum/reagent/medicine/synthflesh = 1, /datum/reagent/blood = 1)
	required_temp = 374
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/life/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	chemical_mob_spawn(holder, rand(1, round(created_volume, 1)), "Life (hostile)") //defaults to HOSTILE_SPAWN

/datum/chemical_reaction/life_friendly
	name = "Life (Friendly)"
	id = "life_friendly"
	required_reagents = list(/datum/reagent/medicine/strange_reagent = 1, /datum/reagent/medicine/synthflesh = 1, /datum/reagent/consumable/sugar = 1)
	required_temp = 374
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/life_friendly/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	chemical_mob_spawn(holder, rand(1, round(created_volume, 1)), "Life (friendly)", FRIENDLY_SPAWN)

/datum/chemical_reaction/corgium
	name = "corgium"
	id = "corgium"
	required_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/colorful_reagent = 1, /datum/reagent/medicine/strange_reagent = 1, /datum/reagent/blood = 1)
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/corgium/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	if(isliving(holder.my_atom) && !iscorgi(holder.my_atom))
		var/mob/living/L = holder
		L.reagents.add_reagent(/datum/reagent/corgium, created_volume)
	else
		var/location = get_turf(holder.my_atom)
		for(var/i in rand(1, created_volume) to created_volume) // More lulz.
			new /mob/living/simple_animal/pet/dog/corgi(location)
	..()

//monkey powder heehoo
/datum/chemical_reaction/monkey_powder
	results = list(/datum/reagent/monkey_powder = 5)
	required_reagents = list(/datum/reagent/consumable/banana = 1, /datum/reagent/consumable/nutriment=2,/datum/reagent/liquidgibs = 1)
	reaction_flags = REACTION_INSTANT

//water electrolysis
/datum/chemical_reaction/electrolysis
	results = list(/datum/reagent/oxygen = 1.5, /datum/reagent/hydrogen = 3)
	required_reagents = list(/datum/reagent/consumable/liquidelectricity = 1, /datum/reagent/water = 5)

//butterflium
/datum/chemical_reaction/butterflium
	required_reagents = list(/datum/reagent/colorful_reagent = 1, /datum/reagent/medicine/omnizine = 1, /datum/reagent/medicine/strange_reagent = 1, /datum/reagent/consumable/nutriment = 1)
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/butterflium/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = rand(1, created_volume), i <= created_volume, i++)
		new /mob/living/simple_animal/butterfly(location)
	..()

/datum/chemical_reaction/hair_dye
	name = /datum/reagent/hair_dye
	id = /datum/reagent/hair_dye
	results = list(/datum/reagent/hair_dye = 5)
	required_reagents = list(/datum/reagent/colorful_reagent = 1, /datum/reagent/uranium/radium = 1, /datum/reagent/drug/space_drugs = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/barbers_aid
	name = /datum/reagent/barbers_aid
	id = /datum/reagent/barbers_aid
	results = list(/datum/reagent/barbers_aid = 5)
	required_reagents = list(/datum/reagent/carpet = 1, /datum/reagent/uranium/radium = 1, /datum/reagent/drug/space_drugs = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/concentrated_barbers_aid
	name = /datum/reagent/concentrated_barbers_aid
	id = /datum/reagent/concentrated_barbers_aid
	results = list(/datum/reagent/concentrated_barbers_aid = 2)
	required_reagents = list(/datum/reagent/barbers_aid = 1, /datum/reagent/toxin/mutagen = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/saltpetre
	name = /datum/reagent/saltpetre
	id = /datum/reagent/saltpetre
	results = list(/datum/reagent/saltpetre = 3)
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/nitrogen = 1, /datum/reagent/oxygen = 3)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_PLANT

/datum/chemical_reaction/lye
	name = /datum/reagent/lye
	id = /datum/reagent/lye
	results = list(/datum/reagent/lye = 3)
	required_reagents = list(/datum/reagent/sodium = 1, /datum/reagent/hydrogen = 1, /datum/reagent/oxygen = 1)
	required_temp = 10 //So hercuri still shows life.

/datum/chemical_reaction/lye2
	name = /datum/reagent/lye
	id = /datum/reagent/lye
	results = list(/datum/reagent/lye = 2)
	required_reagents = list(/datum/reagent/ash = 1, /datum/reagent/water = 1, /datum/reagent/carbon = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/royal_bee_jelly
	name = "royal bee jelly"
	id = /datum/reagent/royal_bee_jelly
	results = list(/datum/reagent/royal_bee_jelly = 5)
	required_reagents = list(/datum/reagent/toxin/mutagen = 10, /datum/reagent/consumable/honey = 40)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_PLANT

/datum/chemical_reaction/laughter
	name = /datum/reagent/consumable/laughter
	id = /datum/reagent/consumable/laughter
	results = list(/datum/reagent/consumable/laughter = 10) // Fuck it. I'm not touching this one.
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/banana = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE

/datum/chemical_reaction/plastic_polymers
	name = "plastic polymers"
	id = /datum/reagent/plastic_polymers
	required_reagents = list(/datum/reagent/oil = 5, /datum/reagent/toxin/acid = 2, /datum/reagent/ash = 3)
	required_temp = 374 //lazily consistent with soap & other crafted objects generically created with heat.
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/plastic_polymers/on_reaction(datum/equilibrium/reaction, datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/stack/sheet/plastic(location)

/datum/chemical_reaction/pax
	name = /datum/reagent/pax
	id = /datum/reagent/pax
	results = list(/datum/reagent/pax = 3)
	required_reagents  = list(/datum/reagent/toxin/mindbreaker = 1, /datum/reagent/medicine/synaptizine = 1, /datum/reagent/water = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE | REACTION_TAG_OTHER

//////////////////EXPANDED MUTATION TOXINS/////////////////////

/datum/chemical_reaction/slime_extractification
	required_reagents = list(/datum/reagent/toxin/slimejelly = 30, /datum/reagent/consumable/frostoil = 5, /datum/reagent/toxin/plasma = 5)
	mix_message = "The mixture condenses into a ball."
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/mutationtoxin/felinid
	name = /datum/reagent/mutationtoxin/felinid
	id = /datum/reagent/mutationtoxin/felinid
	results = list(/datum/reagent/mutationtoxin/felinid = 5)
	required_reagents  = list(/datum/reagent/mutationtoxin/unstable = 5, /datum/reagent/toxin/fentanyl = 10, /datum/reagent/impedrezene = 10)

/datum/chemical_reaction/mutationtoxin/moth
	name = /datum/reagent/mutationtoxin/moth
	id = /datum/reagent/mutationtoxin/moth
	results = list(/datum/reagent/mutationtoxin/moth = 5)
	required_reagents  = list(/datum/reagent/mutationtoxin/unstable = 5, /datum/reagent/toxin/lipolicide = 10) //I know it's the opposite of what moths like, but I am out of ideas for this.

/datum/chemical_reaction/cellulose_carbonization
	results = list(/datum/reagent/carbon = 1)
	required_reagents = list(/datum/reagent/cellulose = 1)
	required_temp = 512

/datum/chemical_reaction/hydrogen_peroxide
	results = list(/datum/reagent/hydrogen_peroxide = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/oxygen = 1, /datum/reagent/chlorine = 1)

/datum/chemical_reaction/acetone_oxide
	results = list(/datum/reagent/acetone_oxide = 2)
	required_reagents = list(/datum/reagent/acetone = 2, /datum/reagent/oxygen = 1, /datum/reagent/hydrogen_peroxide = 1)

/datum/chemical_reaction/pentaerythritol
	results = list(/datum/reagent/pentaerythritol = 2)
	required_reagents = list(/datum/reagent/acetaldehyde = 1, /datum/reagent/toxin/formaldehyde = 3, /datum/reagent/water = 1 )

/datum/chemical_reaction/acetaldehyde
	results = list(/datum/reagent/acetaldehyde = 3)
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/toxin/formaldehyde = 1, /datum/reagent/water = 1)
	required_temp = 450

/datum/chemical_reaction/holywater
	results = list(/datum/reagent/water/holywater = 1)
	required_reagents = list(/datum/reagent/water/hollowwater = 1)
	required_catalysts = list(/datum/reagent/water/holywater = 1)

/datum/chemical_reaction/exotic_stabilizer
	results = list(/datum/reagent/exotic_stabilizer = 2)
	required_reagents = list(/datum/reagent/plasma_oxide = 1,/datum/reagent/stabilizing_agent = 1)

/datum/chemical_reaction/silver_solidification
	required_reagents = list(/datum/reagent/silver = 20, /datum/reagent/carbon = 10)
	required_temp = 630
	mob_react = FALSE
	reaction_flags = REACTION_INSTANT

///datum/chemical_reaction/mutationtoxin/zombie //No zombies untill holopara issue is fixed.
//	name = /datum/reagent/mutationtoxin/zombie
//	id = /datum/reagent/mutationtoxin/zombie
//	results = list(/datum/reagent/mutationtoxin/zombie = 1)
//	required_reagents  = list(/datum/reagent/aslimetoxin = 1, /datum/reagent/toxin = 1, /datum/reagent/toxin/bad_food = 1) //Because rotting

/datum/chemical_reaction/mutationtoxin/goofzombie //go on. try it with holopara
	name = /datum/reagent/mutationtoxin/goofzombie
	id = /datum/reagent/mutationtoxin/goofzombie
	results = list(/datum/reagent/mutationtoxin/goofzombie = 5)
	required_reagents  = list(/datum/reagent/aslimetoxin = 5, /datum/reagent/drug/krokodil = 10, /datum/reagent/toxin/bad_food = 10) //Because rotting
//////////////////////////////////// Water ////////////////////////////////////////////////

/datum/chemical_reaction/mutationtoxin/ash
	name = /datum/reagent/mutationtoxin/ash
	id = /datum/reagent/mutationtoxin/ash
	results = list(/datum/reagent/mutationtoxin/ash = 5)
	required_reagents  = list(/datum/reagent/aslimetoxin = 5, /datum/reagent/mutationtoxin/lizard = 1, /datum/reagent/ash = 10, /datum/reagent/consumable/entpoly = 5)

/datum/chemical_reaction/mutationtoxin/shadow
	name = /datum/reagent/mutationtoxin/shadow
	id = /datum/reagent/mutationtoxin/shadow
	results = list(/datum/reagent/mutationtoxin/shadow = 5)
	required_reagents  = list(/datum/reagent/aslimetoxin = 5, /datum/reagent/liquid_dark_matter = 30, /datum/reagent/water/holywater = 10) //You need a tiny bit of thinking how to mix it

/datum/chemical_reaction/mutationtoxin/plasma
	name = /datum/reagent/mutationtoxin/plasma
	id = /datum/reagent/mutationtoxin/plasma
	results = list(/datum/reagent/mutationtoxin/plasma = 5)
	required_reagents  = list(/datum/reagent/aslimetoxin = 5, /datum/reagent/toxin/plasma = 60, /datum/reagent/uranium = 20)
