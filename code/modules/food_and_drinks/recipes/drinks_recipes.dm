////////////////////////////////////////// COCKTAILS //////////////////////////////////////
/datum/chemical_reaction/drink //for reagent lookup reasons
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY

/datum/chemical_reaction/drink/goldschlager
	name = "Goldschlager"
	id = /datum/reagent/consumable/ethanol/goldschlager
	results = list(/datum/reagent/consumable/ethanol/goldschlager = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 10, /datum/reagent/gold = 1)

/datum/chemical_reaction/drink/patron
	name = "Patron"
	id = /datum/reagent/consumable/ethanol/patron
	results = list(/datum/reagent/consumable/ethanol/patron = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/tequila = 10, /datum/reagent/silver = 1)

/datum/chemical_reaction/drink/bilk
	name = "Bilk"
	id = /datum/reagent/consumable/ethanol/bilk
	results = list(/datum/reagent/consumable/ethanol/bilk = 2)
	required_reagents = list(/datum/reagent/consumable/milk = 1, /datum/reagent/consumable/ethanol/beer = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_BRUTE

/datum/chemical_reaction/drink/icetea
	name = "Iced Tea"
	id = /datum/reagent/consumable/icetea
	results = list(/datum/reagent/consumable/icetea = 4)
	required_reagents = list(/datum/reagent/consumable/ice = 1, /datum/reagent/consumable/tea = 3)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_TOXIN

/datum/chemical_reaction/drink/icecoffee
	name = "Iced Coffee"
	id = /datum/reagent/consumable/icecoffee
	results = list(/datum/reagent/consumable/icecoffee = 4)
	required_reagents = list(/datum/reagent/consumable/ice = 1, /datum/reagent/consumable/coffee = 3)

/datum/chemical_reaction/drink/nuka_cola
	name = "Nuka Cola"
	id = /datum/reagent/consumable/nuka_cola
	results = list(/datum/reagent/consumable/nuka_cola = 6)
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/consumable/space_cola = 6)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_MODERATE

/datum/chemical_reaction/drink/moonshine
	name = "Moonshine"
	id = /datum/reagent/consumable/ethanol/moonshine
	results = list(/datum/reagent/consumable/ethanol/moonshine = 10)
	required_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 5)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)

/datum/chemical_reaction/drink/wine
	name = "Wine"
	id = /datum/reagent/consumable/ethanol/wine
	results = list(/datum/reagent/consumable/ethanol/wine = 10)
	required_reagents = list(/datum/reagent/consumable/grapejuice = 10)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)

/datum/chemical_reaction/drink/spacebeer
	name = "Space Beer"
	id = "spacebeer"
	results = list(/datum/reagent/consumable/ethanol/beer = 10)
	required_reagents = list(/datum/reagent/consumable/flour = 10)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)

/datum/chemical_reaction/drink/vodka
	name = "Vodka"
	id = /datum/reagent/consumable/ethanol/vodka
	results = list(/datum/reagent/consumable/ethanol/vodka = 10)
	required_reagents = list(/datum/reagent/consumable/potato_juice = 10)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/kahlua
	name = "Kahlua"
	id = /datum/reagent/consumable/ethanol/kahlua
	results = list(/datum/reagent/consumable/ethanol/kahlua = 5)
	required_reagents = list(/datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/sugar = 5)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)

/datum/chemical_reaction/drink/gin_tonic
	name = "Gin and Tonic"
	id = /datum/reagent/consumable/ethanol/gintonic
	results = list(/datum/reagent/consumable/ethanol/gintonic = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/gin = 2, /datum/reagent/consumable/tonic = 1)

/datum/chemical_reaction/drink/rum_coke
	name = "Rum and Coke"
	id = /datum/reagent/consumable/ethanol/rum_coke
	results = list(/datum/reagent/consumable/ethanol/rum_coke = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/space_cola = 1)

/datum/chemical_reaction/drink/cuba_libre
	name = "Cuba Libre"
	id = /datum/reagent/consumable/ethanol/cuba_libre
	results = list(/datum/reagent/consumable/ethanol/cuba_libre = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum_coke = 3, /datum/reagent/consumable/limejuice = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/martini
	name = "Classic Martini"
	id = /datum/reagent/consumable/ethanol/martini
	results = list(/datum/reagent/consumable/ethanol/martini = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/gin = 2, /datum/reagent/consumable/ethanol/vermouth = 1)

/datum/chemical_reaction/drink/vodkamartini
	name = "Vodka Martini"
	id = /datum/reagent/consumable/ethanol/vodkamartini
	results = list(/datum/reagent/consumable/ethanol/vodkamartini = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/ethanol/vermouth = 1)

/datum/chemical_reaction/drink/white_russian
	name = "White Russian"
	id = /datum/reagent/consumable/ethanol/white_russian
	results = list(/datum/reagent/consumable/ethanol/white_russian = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/black_russian = 3, /datum/reagent/consumable/cream = 2)

/datum/chemical_reaction/drink/whiskey_cola
	name = "Whiskey Cola"
	id = /datum/reagent/consumable/ethanol/whiskey_cola
	results = list(/datum/reagent/consumable/ethanol/whiskey_cola = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 2, /datum/reagent/consumable/space_cola = 1)

/datum/chemical_reaction/drink/screwdriver
	name = "Screwdriver"
	id = /datum/reagent/consumable/ethanol/screwdrivercocktail
	results = list(/datum/reagent/consumable/ethanol/screwdrivercocktail = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/orangejuice = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/bloody_mary
	name = "Bloody Mary"
	id = /datum/reagent/consumable/ethanol/bloody_mary
	results = list(/datum/reagent/consumable/ethanol/bloody_mary = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/limejuice = 1)
reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_ORGAN | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/gargle_blaster
	name = "Pan-Galactic Gargle Blaster"
	id = /datum/reagent/consumable/ethanol/gargle_blaster
	results = list(/datum/reagent/consumable/ethanol/gargle_blaster = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/gin = 1, /datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/ethanol/cognac = 1, /datum/reagent/consumable/limejuice = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/brave_bull
	name = "Brave Bull"
	id = /datum/reagent/consumable/ethanol/brave_bull
	results = list(/datum/reagent/consumable/ethanol/brave_bull = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/tequila = 2, /datum/reagent/consumable/ethanol/kahlua = 1)

/datum/chemical_reaction/drink/tequila_sunrise
	name = "Tequila Sunrise"
	id = /datum/reagent/consumable/ethanol/tequila_sunrise
	results = list(/datum/reagent/consumable/ethanol/tequila_sunrise = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/tequila = 2, /datum/reagent/consumable/orangejuice = 2, /datum/reagent/consumable/grenadine = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/toxins_special
	name = "Toxins Special"
	id = /datum/chemical_reaction/drink/toxins_special
	results = list(/datum/reagent/consumable/ethanol/toxins_special = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/ethanol/vermouth = 1, /datum/reagent/toxin/plasma = 2)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/beepsky_smash
	name = "Beepksy Smash"
	id = "beepksysmash"
	results = list(/datum/reagent/consumable/ethanol/beepsky_smash = 5)
	required_reagents = list(/datum/reagent/consumable/limejuice = 2, /datum/reagent/consumable/ethanol/quadruple_sec = 2, /datum/reagent/iron = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/doctor_delight
	name = "The Doctor's Delight"
	id = "doctordelight"
	results = list(/datum/reagent/consumable/doctor_delight = 5)
	required_reagents = list(/datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/tomatojuice = 1, /datum/reagent/consumable/orangejuice = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/medicine/cryoxadone = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_BRUTE | REACTION_TAG_BURN | REACTION_TAG_TOXIN | REACTION_TAG_OXY

/datum/chemical_reaction/drink/irish_cream
	name = "Irish Cream"
	id = /datum/reagent/consumable/ethanol/irish_cream
	results = list(/datum/reagent/consumable/ethanol/irish_cream = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 2, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/manly_dorf
	name = "The Manly Dorf"
	id = /datum/reagent/consumable/ethanol/manly_dorf
	results = list(/datum/reagent/consumable/ethanol/manly_dorf = 3)
	required_reagents = list (/datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/ethanol/ale = 2)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/greenbeer
	name = "Green Beer"
	id = /datum/reagent/consumable/ethanol/beer/green
	results = list(/datum/reagent/consumable/ethanol/beer/green = 10)
	required_reagents = list(/datum/reagent/colorful_reagent/powder/green = 1, /datum/reagent/consumable/ethanol/beer = 10)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/greenbeer2 //apparently there's no other way to do this
	name = "Green Beer"
	id = /datum/reagent/consumable/ethanol/beer/green
	results = list(/datum/reagent/consumable/ethanol/beer/green = 10)
	required_reagents = list(/datum/reagent/colorful_reagent/powder/green/crayon = 1, /datum/reagent/consumable/ethanol/beer = 10)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/hooch
	name = "Hooch"
	id = /datum/reagent/consumable/ethanol/hooch
	results = list(/datum/reagent/consumable/ethanol/hooch = 3)
	required_reagents = list (/datum/reagent/consumable/ethanol = 2, /datum/reagent/fuel = 1)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 1)

/datum/chemical_reaction/drink/irish_coffee
	name = "Irish Coffee"
	id = /datum/reagent/consumable/ethanol/irishcoffee
	results = list(/datum/reagent/consumable/ethanol/irishcoffee = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/irish_cream = 1, /datum/reagent/consumable/coffee = 1)

/datum/chemical_reaction/drink/b52
	name = "B-52"
	id = /datum/reagent/consumable/ethanol/b52
	results = list(/datum/reagent/consumable/ethanol/b52 = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/irish_cream = 1, /datum/reagent/consumable/ethanol/kahlua = 1, /datum/reagent/consumable/ethanol/cognac = 1)

/datum/chemical_reaction/drink/atomicbomb
	name = "Atomic Bomb"
	id = /datum/reagent/consumable/ethanol/atomicbomb
	results = list(/datum/reagent/consumable/ethanol/atomicbomb = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/b52 = 10, /datum/reagent/uranium = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/margarita
	name = "Margarita"
	id = /datum/reagent/consumable/ethanol/margarita
	results = list(/datum/reagent/consumable/ethanol/margarita = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/tequila = 2, /datum/reagent/consumable/limejuice = 1)

/datum/chemical_reaction/drink/longislandicedtea
	name = "Long Island Iced Tea"
	id = /datum/reagent/consumable/ethanol/longislandicedtea
	results = list(/datum/reagent/consumable/ethanol/longislandicedtea = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/gin = 1, /datum/reagent/consumable/ethanol/tequila = 1, /datum/reagent/consumable/ethanol/cuba_libre = 1)

/datum/chemical_reaction/drink/threemileisland
	name = "Three Mile Island Iced Tea"
	id = /datum/reagent/consumable/ethanol/threemileisland
	results = list(/datum/reagent/consumable/ethanol/threemileisland = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/longislandicedtea = 10, /datum/reagent/uranium = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/whiskeysoda
	name = "Whiskey Soda"
	id = /datum/reagent/consumable/ethanol/whiskeysoda
	results = list(/datum/reagent/consumable/ethanol/whiskeysoda = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 2, /datum/reagent/consumable/sodawater = 1)

/datum/chemical_reaction/drink/black_russian
	name = "Black Russian"
	id = /datum/reagent/consumable/ethanol/black_russian
	results = list(/datum/reagent/consumable/ethanol/black_russian = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 3, /datum/reagent/consumable/ethanol/kahlua = 2)

/datum/chemical_reaction/drink/manhattan
	name = "Manhattan"
	id = /datum/reagent/consumable/ethanol/manhattan
	results = list(/datum/reagent/consumable/ethanol/manhattan = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 2, /datum/reagent/consumable/ethanol/vermouth = 1)

/datum/chemical_reaction/drink/manhattan_proj
	name = "Manhattan Project"
	id = /datum/reagent/consumable/ethanol/manhattan_proj
	results = list(/datum/reagent/consumable/ethanol/manhattan_proj = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/manhattan = 10, /datum/reagent/uranium = 1)

/datum/chemical_reaction/drink/vodka_tonic
	name = "Vodka and Tonic"
	id = /datum/reagent/consumable/ethanol/vodkatonic
	results = list(/datum/reagent/consumable/ethanol/vodkatonic = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/tonic = 1)

/datum/chemical_reaction/drink/gin_fizz
	name = "Gin Fizz"
	id = /datum/reagent/consumable/ethanol/ginfizz
	results = list(/datum/reagent/consumable/ethanol/ginfizz = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/gin = 2, /datum/reagent/consumable/sodawater = 1, /datum/reagent/consumable/limejuice = 1)

/datum/chemical_reaction/drink/bahama_mama
	name = "Bahama Mama"
	id = /datum/reagent/consumable/ethanol/bahama_mama
	results = list(/datum/reagent/consumable/ethanol/bahama_mama = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/creme_de_coconut = 1, /datum/reagent/consumable/ethanol/kahlua = 1, /datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/pineapplejuice = 1)

/datum/chemical_reaction/drink/painkiller
	name = "Painkiller"
	id = /datum/reagent/consumable/ethanol/painkiller
	results = list(/datum/reagent/consumable/ethanol/painkiller = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/creme_de_coconut = 5, /datum/reagent/consumable/pineapplejuice = 4, /datum/reagent/consumable/orangejuice = 1)

/datum/chemical_reaction/drink/pina_colada
	name = "Pina Colada"
	id = /datum/reagent/consumable/ethanol/pina_colada
	results = list(/datum/reagent/consumable/ethanol/pina_colada = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/creme_de_coconut = 1, /datum/reagent/consumable/pineapplejuice = 3, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/limejuice = 1)

/datum/chemical_reaction/drink/singulo
	name = "Singulo"
	id = /datum/reagent/consumable/ethanol/singulo
	results = list(/datum/reagent/consumable/ethanol/singulo = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 5, /datum/reagent/uranium/radium = 1, /datum/reagent/consumable/ethanol/wine = 5)

/datum/chemical_reaction/drink/alliescocktail
	name = "Allies Cocktail"
	id = /datum/reagent/consumable/ethanol/alliescocktail
	results = list(/datum/reagent/consumable/ethanol/alliescocktail = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/martini = 1, /datum/reagent/consumable/ethanol/vodka = 1)

/datum/chemical_reaction/drink/demonsblood
	name = "Demons Blood"
	id = /datum/reagent/consumable/ethanol/demonsblood
	results = list(/datum/reagent/consumable/ethanol/demonsblood = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/spacemountainwind = 1, /datum/reagent/blood = 1, /datum/reagent/consumable/dr_gibb = 1)

/datum/chemical_reaction/drink/booger
	name = "Booger"
	id = /datum/reagent/consumable/ethanol/booger
	results = list(/datum/reagent/consumable/ethanol/booger = 4)
	required_reagents = list(/datum/reagent/consumable/cream = 1, /datum/reagent/consumable/banana = 1, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/watermelonjuice = 1)

/datum/chemical_reaction/drink/antifreeze
	name = "Anti-freeze"
	id = /datum/reagent/consumable/ethanol/antifreeze
	results = list(/datum/reagent/consumable/ethanol/antifreeze = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/barefoot
	name = "Barefoot"
	id = /datum/reagent/consumable/ethanol/barefoot
	results = list(/datum/reagent/consumable/ethanol/barefoot = 3)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/ethanol/vermouth = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/ftliver
	name = "Faster-Than-Liver"
	id = /datum/reagent/consumable/ethanol/ftliver
	results = list(/datum/reagent/consumable/ethanol/ftliver = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/stable_plasma = 1, /datum/reagent/consumable/ethanol/screwdrivercocktail = 1)


////DRINKS THAT REQUIRED IMPROVED SPRITES BELOW:: -Agouri/////

/datum/chemical_reaction/drink/sbiten
	name = "Sbiten"
	id = /datum/reagent/consumable/ethanol/sbiten
	results = list(/datum/reagent/consumable/ethanol/sbiten = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 10, /datum/reagent/consumable/capsaicin = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/red_mead
	name = "Red Mead"
	id = /datum/reagent/consumable/ethanol/red_mead
	results = list(/datum/reagent/consumable/ethanol/red_mead = 2)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/consumable/ethanol/mead = 1)

/datum/chemical_reaction/drink/mead
	name = "Mead"
	id = /datum/reagent/consumable/ethanol/mead
	results = list(/datum/reagent/consumable/ethanol/mead = 2)
	required_reagents = list(/datum/reagent/consumable/honey = 2)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)

/datum/chemical_reaction/drink/iced_beer
	name = "Iced Beer"
	id = /datum/reagent/consumable/ethanol/iced_beer
	results = list(/datum/reagent/consumable/ethanol/iced_beer = 6)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer = 5, /datum/reagent/consumable/ice = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/grog
	name = "Grog"
	id = /datum/reagent/consumable/ethanol/grog
	results = list(/datum/reagent/consumable/ethanol/grog = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/drink/soy_latte
	name = "Soy Latte"
	id = /datum/reagent/consumable/soy_latte
	results = list(/datum/reagent/consumable/soy_latte = 2)
	required_reagents = list(/datum/reagent/consumable/coffee = 1, /datum/reagent/consumable/soymilk = 1)

/datum/chemical_reaction/drink/cafe_latte
	name = "Cafe Latte"
	id = /datum/reagent/consumable/cafe_latte
	results = list(/datum/reagent/consumable/cafe_latte = 2)
	required_reagents = list(/datum/reagent/consumable/coffee = 1, /datum/reagent/consumable/milk = 1)

/datum/chemical_reaction/drink/acidspit
	name = "Acid Spit"
	id = /datum/reagent/consumable/ethanol/acid_spit
	results = list(/datum/reagent/consumable/ethanol/acid_spit = 6)
	required_reagents = list(/datum/reagent/toxin/acid = 1, /datum/reagent/consumable/ethanol/wine = 5)

/datum/chemical_reaction/drink/amasec
	name = "Amasec"
	id = /datum/reagent/consumable/ethanol/amasec
	results = list(/datum/reagent/consumable/ethanol/amasec = 10)
	required_reagents = list(/datum/reagent/iron = 1, /datum/reagent/consumable/ethanol/wine = 5, /datum/reagent/consumable/ethanol/vodka = 5)

/datum/chemical_reaction/drink/changelingsting
	name = "Changeling Sting"
	id = /datum/reagent/consumable/ethanol/changelingsting
	results = list(/datum/reagent/consumable/ethanol/changelingsting = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/screwdrivercocktail = 1, /datum/reagent/consumable/lemon_lime = 2)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/aloe
	name = "Aloe"
	id = /datum/reagent/consumable/ethanol/aloe
	results = list(/datum/reagent/consumable/ethanol/aloe = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/irish_cream = 1, /datum/reagent/consumable/watermelonjuice = 1)

/datum/chemical_reaction/drink/andalusia
	name = "Andalusia"
	id = /datum/reagent/consumable/ethanol/andalusia
	results = list(/datum/reagent/consumable/ethanol/andalusia = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/lemonjuice = 1)

/datum/chemical_reaction/drink/neurotoxin
	name = "Neurotoxin"
	id = /datum/reagent/consumable/ethanol/neurotoxin
	results = list(/datum/reagent/consumable/ethanol/neurotoxin = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/gargle_blaster = 1, /datum/reagent/medicine/morphine = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_MODERATE | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/snowwhite
	name = "Snow White"
	id = /datum/reagent/consumable/ethanol/snowwhite
	results = list(/datum/reagent/consumable/ethanol/snowwhite = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/lemon_lime = 1)

/datum/chemical_reaction/drink/irishcarbomb
	name = "Irish Car Bomb"
	id = /datum/reagent/consumable/ethanol/irishcarbomb
	results = list(/datum/reagent/consumable/ethanol/irishcarbomb = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/ale = 1, /datum/reagent/consumable/ethanol/irish_cream = 1)

/datum/chemical_reaction/drink/syndicatebomb
	name = "Syndicate Bomb"
	id = /datum/reagent/consumable/ethanol/syndicatebomb
	results = list(/datum/reagent/consumable/ethanol/syndicatebomb = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/ethanol/whiskey_cola = 1)

/datum/chemical_reaction/drink/erikasurprise
	name = "Erika Surprise"
	id = /datum/reagent/consumable/ethanol/erikasurprise
	results = list(/datum/reagent/consumable/ethanol/erikasurprise = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/ale = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/banana = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/devilskiss
	name = "Devils Kiss"
	id = /datum/reagent/consumable/ethanol/devilskiss
	results = list(/datum/reagent/consumable/ethanol/devilskiss = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/consumable/ethanol/kahlua = 1, /datum/reagent/consumable/ethanol/rum = 1)

/datum/chemical_reaction/drink/hippiesdelight
	name = "Hippies Delight"
	id = /datum/reagent/consumable/ethanol/hippies_delight
	results = list(/datum/reagent/consumable/ethanol/hippies_delight = 2)
	required_reagents = list(/datum/reagent/drug/mushroomhallucinogen = 1, /datum/reagent/consumable/ethanol/gargle_blaster = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/bananahonk
	name = "Banana Honk"
	id = /datum/reagent/consumable/ethanol/bananahonk
	results = list(/datum/reagent/consumable/ethanol/bananahonk = 2)
	required_reagents = list(/datum/reagent/consumable/laughter = 1, /datum/reagent/consumable/cream = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/silencer
	name = "Silencer"
	id = /datum/reagent/consumable/ethanol/silencer
	results = list(/datum/reagent/consumable/ethanol/silencer = 3)
	required_reagents = list(/datum/reagent/consumable/nothing = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/sugar = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/driestmartini
	name = "Driest Martini"
	id = /datum/reagent/consumable/ethanol/driestmartini
	results = list(/datum/reagent/consumable/ethanol/driestmartini = 2)
	required_reagents = list(/datum/reagent/consumable/nothing = 1, /datum/reagent/consumable/ethanol/gin = 1)

/datum/chemical_reaction/drink/thirteenloko
	name = "Thirteen Loko"
	id = /datum/reagent/consumable/ethanol/thirteenloko
	results = list(/datum/reagent/consumable/ethanol/thirteenloko = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/coffee = 1, /datum/reagent/consumable/limejuice = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/chocolatepudding
	name = "Chocolate Pudding"
	id = /datum/reagent/consumable/chocolatepudding
	results = list(/datum/reagent/consumable/chocolatepudding = 20)
	required_reagents = list(/datum/reagent/consumable/milk/chocolate_milk = 10, /datum/reagent/consumable/eggyolk = 5)

/datum/chemical_reaction/drink/vanillapudding
	name = "Vanilla Pudding"
	id = /datum/reagent/consumable/vanillapudding
	results = list(/datum/reagent/consumable/vanillapudding = 20)
	required_reagents = list(/datum/reagent/consumable/vanilla = 5, /datum/reagent/consumable/milk = 5, /datum/reagent/consumable/eggyolk = 5)

/datum/chemical_reaction/drink/cherryshake
	name = "Cherry Shake"
	id = /datum/reagent/consumable/cherryshake
	results = list(/datum/reagent/consumable/cherryshake = 5)
	required_reagents = list(/datum/reagent/consumable/cherryjelly = 1, /datum/reagent/consumable/milk = 3, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/bluecherryshake
	name = "Blue Cherry Shake"
	id = /datum/reagent/consumable/bluecherryshake
	results = list(/datum/reagent/consumable/bluecherryshake = 5)
	required_reagents = list(/datum/reagent/consumable/bluecherryjelly = 1, /datum/reagent/consumable/milk = 3, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/vanillashake
	results = list(/datum/reagent/consumable/vanillashake = 5)
	required_reagents = list(/datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/milk = 3, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/caramelshake
	results = list(/datum/reagent/consumable/caramelshake = 5)
	required_reagents = list(/datum/reagent/consumable/caramel = 1, /datum/reagent/consumable/milk = 3, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/sodiumchloride = 1)

/datum/chemical_reaction/drink/choccyshake
	results = list(/datum/reagent/consumable/choccyshake = 5)
	required_reagents = list(/datum/reagent/consumable/milk/chocolate_milk = 4, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/strawberryshake
	results = list(/datum/reagent/consumable/strawberryshake = 5)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/milk = 3, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/bananashake
	results = list(/datum/reagent/consumable/bananashake = 5)
	required_reagents = list(/datum/reagent/consumable/banana = 1, /datum/reagent/consumable/milk = 3, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/drunkenblumpkin
	name = "Drunken Blumpkin"
	id = /datum/reagent/consumable/ethanol/drunkenblumpkin
	results = list(/datum/reagent/consumable/ethanol/drunkenblumpkin = 4)
	required_reagents = list(/datum/reagent/consumable/blumpkinjuice = 1, /datum/reagent/consumable/ethanol/irish_cream = 2, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/pumpkin_latte
	name = "Pumpkin space latte"
	id = /datum/reagent/consumable/pumpkin_latte
	results = list(/datum/reagent/consumable/pumpkin_latte = 15)
	required_reagents = list(/datum/reagent/consumable/pumpkinjuice = 5, /datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/cream = 5)

/datum/chemical_reaction/drink/gibbfloats
	name = "Gibb Floats"
	id = /datum/reagent/consumable/gibbfloats
	results = list(/datum/reagent/consumable/gibbfloats = 15)
	required_reagents = list(/datum/reagent/consumable/dr_gibb = 5, /datum/reagent/consumable/ice = 5, /datum/reagent/consumable/cream = 5)

/datum/chemical_reaction/drink/triple_citrus
	name = /datum/reagent/consumable/triple_citrus
	id = /datum/reagent/consumable/triple_citrus
	results = list(/datum/reagent/consumable/triple_citrus = 5)
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/orangejuice = 1)

/datum/chemical_reaction/drink/grape_soda
	name = "grape soda"
	id = /datum/reagent/consumable/grape_soda
	results = list(/datum/reagent/consumable/grape_soda = 2)
	required_reagents = list(/datum/reagent/consumable/grapejuice = 1, /datum/reagent/consumable/sodawater = 1)

/datum/chemical_reaction/drink/grappa
	name = /datum/reagent/consumable/ethanol/grappa
	id = /datum/reagent/consumable/ethanol/grappa
	results = list(/datum/reagent/consumable/ethanol/grappa = 10)
	required_reagents = list (/datum/reagent/consumable/ethanol/wine = 10)
	required_catalysts = list (/datum/reagent/consumable/enzyme = 5)

/datum/chemical_reaction/drink/whiskey_sour
	name = "Whiskey Sour"
	id = /datum/reagent/consumable/ethanol/whiskey_sour
	results = list(/datum/reagent/consumable/ethanol/whiskey_sour = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/lemonjuice = 1, /datum/reagent/consumable/sugar = 1)
	mix_message = "The mixture darkens to a rich gold hue."

/datum/chemical_reaction/drink/fetching_fizz
	name = "Fetching Fizz"
	id = /datum/reagent/consumable/ethanol/fetching_fizz
	results = list(/datum/reagent/consumable/ethanol/fetching_fizz = 3)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/iron = 1) //Manufacturable from only the mining station
	mix_message = "The mixture slightly vibrates before settling."

/datum/chemical_reaction/drink/hearty_punch
	name = "Hearty Punch"
	id = /datum/reagent/consumable/ethanol/hearty_punch
	results = list(/datum/reagent/consumable/ethanol/hearty_punch = 1)  //Very little, for balance reasons
	required_reagents = list(/datum/reagent/consumable/ethanol/brave_bull = 5, /datum/reagent/consumable/ethanol/syndicatebomb = 5, /datum/reagent/consumable/ethanol/absinthe = 5)
	mix_message = "The mixture darkens to a healthy crimson."
	required_temp = 315 //Piping hot!
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_BRUTE | REACTION_TAG_BURN | REACTION_TAG_TOXIN | REACTION_TAG_OXY | REACTION_TAG_CLONE

/datum/chemical_reaction/drink/bacchus_blessing
	name = "Bacchus' Blessing"
	id = /datum/reagent/consumable/ethanol/bacchus_blessing
	results = list(/datum/reagent/consumable/ethanol/bacchus_blessing = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/hooch = 1, /datum/reagent/consumable/ethanol/absinthe = 1, /datum/reagent/consumable/ethanol/manly_dorf = 1, /datum/reagent/consumable/ethanol/syndicatebomb = 1)
	mix_message = "<span class='warning'>The mixture turns to a sickening froth.</span>"

/datum/chemical_reaction/drink/lemonade
	name = "Lemonade"
	id = /datum/reagent/consumable/lemonade
	results = list(/datum/reagent/consumable/lemonade = 5)
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 2, /datum/reagent/water = 2, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/ice = 1)
	mix_message = "You're suddenly reminded of home."

/datum/chemical_reaction/drink/arnold_palmer
	name = "Arnold Palmer"
	id = /datum/reagent/consumable/tea/arnold_palmer
	results = list(/datum/reagent/consumable/tea/arnold_palmer = 2)
	required_reagents = list(/datum/reagent/consumable/tea = 1, /datum/reagent/consumable/lemonade = 1)
	mix_message = "The smells of fresh green grass and sand traps waft through the air as the mixture turns a friendly yellow-orange."

/datum/chemical_reaction/drink/chocolate_milk
	name = "chocolate milk"
	id = /datum/reagent/consumable/milk/chocolate_milk
	results = list(/datum/reagent/consumable/milk/chocolate_milk = 2)
	required_reagents = list(/datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cocoa = 1)
	mix_message = "The color changes as the mixture blends smoothly."

/datum/chemical_reaction/drink/eggnog
	name = /datum/reagent/consumable/ethanol/eggnog
	id = /datum/reagent/consumable/ethanol/eggnog
	results = list(/datum/reagent/consumable/ethanol/eggnog = 15)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 5, /datum/reagent/consumable/cream = 5, /datum/reagent/consumable/eggyolk = 5)

/datum/chemical_reaction/drink/narsour
	name = "Nar'sour"
	id = /datum/reagent/consumable/ethanol/narsour
	results = list(/datum/reagent/consumable/ethanol/narsour = 1)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/consumable/lemonjuice = 1, /datum/reagent/consumable/ethanol/demonsblood = 1)
	mix_message = "The mixture develops a sinister glow."
	mix_sound = 'sound/effects/singlebeat.ogg'
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/quadruplesec
	name = "Quadruple Sec"
	id = /datum/reagent/consumable/ethanol/quadruple_sec
	results = list(/datum/reagent/consumable/ethanol/quadruple_sec = 15)
	required_reagents = list(/datum/reagent/consumable/ethanol/triple_sec = 5, /datum/reagent/consumable/triple_citrus = 5, /datum/reagent/consumable/ethanol/creme_de_menthe = 5)
	mix_message = "The snap of a taser emanates clearly from the mixture as it settles."
	mix_sound = 'sound/weapons/taser.ogg'
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/grasshopper
	name = "Grasshopper"
	id = /datum/reagent/consumable/ethanol/grasshopper
	results = list(/datum/reagent/consumable/ethanol/grasshopper = 15)
	required_reagents = list(/datum/reagent/consumable/cream = 5, /datum/reagent/consumable/ethanol/creme_de_menthe = 5, /datum/reagent/consumable/ethanol/creme_de_cacao = 5)
	mix_message = "A vibrant green bubbles forth as the mixture emulsifies."

/datum/chemical_reaction/drink/stinger
	name = "Stinger"
	id = /datum/reagent/consumable/ethanol/stinger
	results = list(/datum/reagent/consumable/ethanol/stinger = 15)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 10, /datum/reagent/consumable/ethanol/creme_de_menthe = 5 )

/datum/chemical_reaction/drink/quintuplesec
	name = "Quintuple Sec"
	id = /datum/reagent/consumable/ethanol/quintuple_sec
	results = list(/datum/reagent/consumable/ethanol/quintuple_sec = 15)
	required_reagents = list(/datum/reagent/consumable/ethanol/quadruple_sec = 5, /datum/reagent/consumable/clownstears = 5, /datum/reagent/consumable/ethanol/syndicatebomb = 5)
	mix_message = "Judgment is upon you."
	mix_sound = 'sound/items/airhorn2.ogg'
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/bastion_bourbon
	name = "Bastion Bourbon"
	id = /datum/reagent/consumable/ethanol/bastion_bourbon
	results = list(/datum/reagent/consumable/ethanol/bastion_bourbon = 2)
	required_reagents = list(/datum/reagent/consumable/tea = 1, /datum/reagent/consumable/ethanol/creme_de_menthe = 1, /datum/reagent/consumable/triple_citrus = 1, /datum/reagent/consumable/berryjuice = 1) //herbal and minty, with a hint of citrus and berry
	mix_message = "You catch an aroma of hot tea and fruits as the mix blends into a blue-green color."
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_BRUTE | REACTION_TAG_BURN | REACTION_TAG_TOXIN | REACTION_TAG_OXY

/datum/chemical_reaction/drink/squirt_cider
	name = "Squirt Cider"
	id = /datum/reagent/consumable/ethanol/squirt_cider
	results = list(/datum/reagent/consumable/ethanol/squirt_cider = 1)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/consumable/tomatojuice = 1, /datum/reagent/consumable/nutriment = 1)
	mix_message = "The mix swirls and turns a bright red that reminds you of an apple's skin."
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/fringe_weaver
	name = "Fringe Weaver"
	id = /datum/reagent/consumable/ethanol/fringe_weaver
	results = list(/datum/reagent/consumable/ethanol/fringe_weaver = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol = 9, /datum/reagent/consumable/sugar = 1) //9 karmotrine, 1 adelhyde
	mix_message = "The mix turns a pleasant cream color and foams up."

/datum/chemical_reaction/drink/sugar_rush
	name = "Sugar Rush"
	id = /datum/reagent/consumable/ethanol/sugar_rush
	results = list(/datum/reagent/consumable/ethanol/sugar_rush = 4)
	required_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/lemonjuice = 1, /datum/reagent/consumable/ethanol/wine = 1) //2 adelhyde (sweet), 1 powdered delta (sour), 1 karmotrine (alcohol)
	mix_message = "The mixture bubbles and brightens into a girly pink."
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/crevice_spike
	name = "Crevice Spike"
	id = /datum/reagent/consumable/ethanol/crevice_spike
	results = list(/datum/reagent/consumable/ethanol/crevice_spike = 6)
	required_reagents = list(/datum/reagent/consumable/limejuice = 2, /datum/reagent/consumable/capsaicin = 4) //2 powdered delta (sour), 4 flanergide (spicy)
	mix_message = "The mixture stings your eyes as it settles."
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/sake
	name = /datum/reagent/consumable/ethanol/sake
	id = /datum/reagent/consumable/ethanol/sake
	results = list(/datum/reagent/consumable/ethanol/sake = 10)
	required_reagents = list(/datum/reagent/consumable/rice = 10)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)
	mix_message = "The rice grains ferment into a clear, sweet-smelling liquid."

/datum/chemical_reaction/drink/peppermint_patty
	name = "Peppermint Patty"
	id = /datum/reagent/consumable/ethanol/peppermint_patty
	results = list(/datum/reagent/consumable/ethanol/peppermint_patty = 10)
	required_reagents = list(/datum/reagent/consumable/cocoa/hot_cocoa = 6, /datum/reagent/consumable/ethanol/creme_de_cacao = 1, /datum/reagent/consumable/ethanol/creme_de_menthe = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/menthol = 1)
	mix_message = "The cocoa turns mint green just as the strong scent hits your nose."
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/alexander
	name = "Alexander"
	id = /datum/reagent/consumable/ethanol/alexander
	results = list(/datum/reagent/consumable/ethanol/alexander = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/cognac = 1, /datum/reagent/consumable/ethanol/creme_de_cacao = 1, /datum/reagent/consumable/cream = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/sidecar
	name = "Sidecar"
	id = /datum/reagent/consumable/ethanol/sidecar
	results = list(/datum/reagent/consumable/ethanol/sidecar = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/cognac = 2, /datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/lemonjuice = 1)

/datum/chemical_reaction/drink/between_the_sheets
	name = "Between the Sheets"
	id = /datum/reagent/consumable/ethanol/between_the_sheets
	results = list(/datum/reagent/consumable/ethanol/between_the_sheets = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/ethanol/sidecar = 4)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/kamikaze
	name = "Kamikaze"
	id = /datum/reagent/consumable/ethanol/kamikaze
	results = list(/datum/reagent/consumable/ethanol/kamikaze = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/limejuice = 1)

/datum/chemical_reaction/drink/mojito
	name = "Mojito"
	id = /datum/reagent/consumable/ethanol/mojito
	results = list(/datum/reagent/consumable/ethanol/mojito = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/sodawater = 1, /datum/reagent/consumable/menthol = 1)

/datum/chemical_reaction/drink/fernet_cola
	name = "Fernet Cola"
	id = /datum/reagent/consumable/ethanol/fernet_cola
	results = list(/datum/reagent/consumable/ethanol/fernet_cola = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/fernet = 1, /datum/reagent/consumable/space_cola = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_TOXIN

/datum/chemical_reaction/drink/fanciulli
	name = "Fanciulli"
	id = /datum/reagent/consumable/ethanol/fanciulli
	results = list(/datum/reagent/consumable/ethanol/fanciulli = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/manhattan = 1, /datum/reagent/consumable/ethanol/fernet = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/branca_menta
	name = "Branca Menta"
	id = /datum/reagent/consumable/ethanol/branca_menta
	results = list(/datum/reagent/consumable/ethanol/branca_menta = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/fernet = 1, /datum/reagent/consumable/ethanol/creme_de_menthe = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/blank_paper
	name = "Blank Paper"
	id = /datum/reagent/consumable/ethanol/blank_paper
	results = list(/datum/reagent/consumable/ethanol/blank_paper = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/silencer = 1, /datum/reagent/consumable/nothing = 1, /datum/reagent/consumable/nuka_cola = 1)


/datum/chemical_reaction/drink/wizz_fizz
	name = "Wizz Fizz"
	id = /datum/reagent/consumable/ethanol/wizz_fizz
	results = list(/datum/reagent/consumable/ethanol/wizz_fizz = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/sodawater = 1, /datum/reagent/consumable/ethanol/champagne = 1)
	mix_message = "The beverage starts to froth with an almost mystical zeal!"
	mix_sound = 'sound/effects/bubbles2.ogg'


/datum/chemical_reaction/drink/bug_spray
	name = "Bug Spray"
	id = /datum/reagent/consumable/ethanol/bug_spray
	results = list(/datum/reagent/consumable/ethanol/bug_spray = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/triple_sec = 2, /datum/reagent/consumable/lemon_lime = 1, /datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/ethanol/vodka = 1)
	mix_message = "The faint aroma of summer camping trips wafts through the air; but what's that buzzing noise?"
	mix_sound = 'sound/creatures/bee.ogg'
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/jack_rose
	name = "Jack Rose"
	id = /datum/reagent/consumable/ethanol/jack_rose
	results = list(/datum/reagent/consumable/ethanol/jack_rose = 4)
	required_reagents = list(/datum/reagent/consumable/grenadine = 1, /datum/reagent/consumable/ethanol/applejack = 2, /datum/reagent/consumable/limejuice = 1)
	mix_message = "As the grenadine incorporates, the beverage takes on a mellow, red-orange glow."

/datum/chemical_reaction/drink/turbo
	name = "Turbo"
	id = /datum/reagent/consumable/ethanol/turbo
	results = list(/datum/reagent/consumable/ethanol/turbo = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/moonshine = 2, /datum/reagent/nitrous_oxide = 1, /datum/reagent/consumable/ethanol/sugar_rush = 1, /datum/reagent/consumable/pwr_game = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/old_timer
	name = "Old Timer"
	id = /datum/reagent/consumable/ethanol/old_timer
	results = list(/datum/reagent/consumable/ethanol/old_timer = 6)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskeysoda = 3, /datum/reagent/consumable/parsnipjuice = 2, /datum/reagent/consumable/ethanol/alexander = 1)

/datum/chemical_reaction/drink/rubberneck
	name = "Rubberneck"
	id = /datum/reagent/consumable/ethanol/rubberneck
	results = list(/datum/reagent/consumable/ethanol/rubberneck = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol = 4, /datum/reagent/consumable/grey_bull = 5, /datum/reagent/consumable/astrotame = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/duplex
	name = "Duplex"
	id = /datum/reagent/consumable/ethanol/duplex
	results = list(/datum/reagent/consumable/ethanol/duplex = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/hcider = 2, /datum/reagent/consumable/applejuice = 1, /datum/reagent/consumable/berryjuice = 1)

/datum/chemical_reaction/drink/trappist
	name = "Trappist"
	id = /datum/reagent/consumable/ethanol/trappist
	results = list(/datum/reagent/consumable/ethanol/trappist = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/ale = 2, /datum/reagent/water/holywater = 2, /datum/reagent/consumable/sugar = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/cream_soda
	name = "Cream Soda"
	id = /datum/reagent/consumable/cream_soda
	results = list(/datum/reagent/consumable/cream_soda = 4)
	required_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/sodawater = 2, /datum/reagent/consumable/vanilla = 1)

/datum/chemical_reaction/drink/blazaam
	name = "Blazaam"
	id = /datum/reagent/consumable/ethanol/blazaam
	results = list(/datum/reagent/consumable/ethanol/blazaam = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/gin = 2, /datum/reagent/consumable/peachjuice = 1, /datum/reagent/bluespace = 1)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/planet_cracker
	name = "Planet Cracker"
	id = /datum/reagent/consumable/ethanol/planet_cracker
	results = list(/datum/reagent/consumable/ethanol/planet_cracker = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/champagne = 2, /datum/reagent/consumable/ethanol/lizardwine = 2, /datum/reagent/consumable/eggyolk = 1, /datum/reagent/gold = 1)
	mix_message = "The liquid's color starts shifting as the nanogold is alternately corroded and redeposited."

/datum/chemical_reaction/drink/red_queen
	name = "Red Queen"
	id = /datum/reagent/consumable/red_queen
	results = list(/datum/reagent/consumable/red_queen = 10)
	required_reagents = list(/datum/reagent/consumable/tea = 6, /datum/reagent/mercury = 2, /datum/reagent/consumable/blackpepper = 1, /datum/reagent/growthserum = 1)

/datum/chemical_reaction/drink/mauna_loa
	name = "Mauna Loa"
	id = /datum/reagent/consumable/ethanol/mauna_loa
	results = list(/datum/reagent/consumable/ethanol/mauna_loa = 5)
	required_reagents = list(/datum/reagent/consumable/capsaicin = 2, /datum/reagent/consumable/ethanol/kahlua = 1, /datum/reagent/consumable/ethanol/bahama_mama = 2)
	reaction_tags = REACTION_TAG_DRINK | REACTION_TAG_EASY | REACTION_TAG_OTHER

/datum/chemical_reaction/drink/plasmaflood
	name = "Plasma Flood"
	id = /datum/reagent/consumable/ethanol/plasmaflood
	results = list(/datum/reagent/consumable/ethanol/plasmaflood = 4)
	required_reagents = list(/datum/reagent/toxin/plasma = 1, /datum/reagent/napalm = 1, /datum/reagent/consumable/ethanol/tequila = 1, /datum/reagent/consumable/ethanol/demonsblood = 1)

/datum/chemical_reaction/drink/fourthwall
	name = "Fourth Wall"
	id = /datum/reagent/consumable/ethanol/fourthwall
	results = list(/datum/reagent/consumable/ethanol/fourthwall = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/gargle_blaster = 10, /datum/reagent/bluespace = 1)

/datum/chemical_reaction/drink/ratvander
	name = "Rat'vander Cocktail"
	id = /datum/reagent/consumable/ethanol/ratvander
	results = list(/datum/reagent/consumable/ethanol/ratvander = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/wine = 5, /datum/reagent/consumable/ethanol/triple_sec = 5, /datum/reagent/consumable/sugar = 1, /datum/reagent/iron = 1, /datum/reagent/copper = 0.6)
	mix_message = "The mixture develops a golden glow."
	mix_sound = 'sound/magic/clockwork/scripture_tier_up.ogg'

/datum/chemical_reaction/drink/icewing
	name = "Icewing"
	id = /datum/reagent/consumable/ethanol/icewing
	results = list(/datum/reagent/consumable/ethanol/icewing = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/antifreeze = 1, /datum/reagent/medicine/mine_salve = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/sarsaparilliansunset
	name = "Sarsaparillian Sunset"
	id = /datum/reagent/consumable/ethanol/sarsaparilliansunset
	results = list(/datum/reagent/consumable/ethanol/sarsaparilliansunset = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/tequila_sunrise = 5, /datum/reagent/consumable/nuka_cola = 1, /datum/reagent/napalm = 1)
	required_temp = 320
	mix_message = "The mixture ignites."
	mix_sound = 'sound/items/lighter_on.ogg'

/datum/chemical_reaction/drink/beesknees
	name = "Bee's Knees"
	id = /datum/reagent/consumable/ethanol/beesknees
	results = list(/datum/reagent/consumable/ethanol/beesknees = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/mead = 1, /datum/reagent/consumable/honey = 1, /datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/lemonjuice = 1)

/datum/chemical_reaction/drink/beeffizz
	name = "Beef Fizz"
	id = /datum/reagent/consumable/ethanol/beeffizz
	results = list(/datum/reagent/consumable/ethanol/beeffizz = 10)
	required_reagents = list(/datum/reagent/consumable/beefbroth = 7, /datum/reagent/consumable/ice = 2, /datum/reagent/consumable/lemonjuice = 1 )
