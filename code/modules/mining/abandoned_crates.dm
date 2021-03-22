//Originally coded by ISaidNo, later modified by Kelenius. Ported from Baystation12.

/obj/structure/closet/crate/secure/loot
	name = "abandoned crate"
	desc = "What could be inside?"
	icon_state = "securecrate"
	integrity_failure = 0 //no breaking open the crate
	var/code = null
	var/lastattempt = null
	var/attempts = 10
	var/codelen = 4
	tamperproof = 90

/obj/structure/closet/crate/secure/loot/Initialize()
	. = ..()
	var/list/digits = list("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	code = ""
	for(var/i = 0, i < codelen, i++)
		var/dig = pick(digits)
		code += dig
		digits -= dig  //there are never matching digits in the answer

	var/loot = rand(1,180) //180 different crates with varying chances of spawning
	switch(loot)
		if(1 to 5) //5% chance
			new /obj/item/reagent_containers/food/drinks/bottle/rum(src)
			new /obj/item/reagent_containers/food/snacks/grown/ambrosia/deus(src)
			new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)
			new /obj/item/lighter(src)
		if(6 to 10)
			new /obj/item/bedsheet(src)
			new /obj/item/kitchen/knife(src)
			new /obj/item/wirecutters(src)
			new /obj/item/screwdriver(src)
			new /obj/item/weldingtool(src)
			new /obj/item/hatchet(src)
			new /obj/item/crowbar(src)
		if(11 to 15)
			new /obj/item/reagent_containers/glass/beaker/bluespace(src)
		if(16 to 20)
			new /obj/item/stack/ore/diamond(src, 10)
		if(21 to 25)
			for(var/i in 1 to 5)
				new /obj/item/poster/random_contraband(src)
		if(26 to 30)
			for(var/i in 1 to 3)
				new /obj/item/reagent_containers/glass/beaker/noreact(src)
		if(31 to 35)
			new /obj/item/seeds/firelemon(src)
		if(36 to 40)
			new /obj/item/melee/baton(src)
		if(41 to 45)
			new /obj/item/clothing/under/shorts/red(src)
			new /obj/item/clothing/under/shorts/blue(src)
		if(46 to 50)
			new /obj/item/clothing/under/chameleon(src)
			for(var/i in 1 to 7)
				new /obj/item/clothing/neck/tie/horrible(src)
		if(51 to 52) // 2% chance
			new /obj/item/melee/classic_baton/police(src)
		if(53 to 54)
			new /obj/item/toy/balloon(src)
		if(55 to 56)
			var/newitem = pick(subtypesof(/obj/item/toy/prize))
			new newitem(src)
		if(57 to 58)
			new /obj/item/toy/syndicateballoon(src)
		if(59 to 60)
			new /obj/item/borg/upgrade/modkit/aoe/mobs(src)
			new /obj/item/clothing/suit/space(src)
			new /obj/item/clothing/head/helmet/space(src)
		if(61 to 62)
			for(var/i in 1 to 5)
				new /obj/item/clothing/head/kitty(src)
				new /obj/item/clothing/neck/petcollar(src)
		if(63 to 64)
			for(var/i in 1 to rand(4, 7))
				var/newcoin = pick(/obj/item/coin/silver, /obj/item/coin/silver, /obj/item/coin/silver, /obj/item/coin/iron, /obj/item/coin/iron, /obj/item/coin/iron, /obj/item/coin/gold, /obj/item/coin/diamond, /obj/item/coin/plasma, /obj/item/coin/uranium)
				new newcoin(src)
		if(65 to 66)
			new /obj/item/clothing/suit/ianshirt(src)
			new /obj/item/clothing/suit/hooded/ian_costume(src)
		if(67 to 68)
			for(var/i in 1 to rand(4, 7))
				var/newitem = pick(subtypesof(/obj/item/stock_parts) - /obj/item/stock_parts/subspace)
				new newitem(src)
		if(69 to 70)
			new /obj/item/stack/ore/bluespace_crystal(src, 5)
		if(71 to 72)
			new /obj/item/pickaxe/drill(src)
		if(73 to 74)
			new /obj/item/pickaxe/drill/jackhammer(src)
		if(75 to 76)
			new /obj/item/pickaxe/diamond(src)
		if(77 to 78)
			new /obj/item/pickaxe/drill/diamonddrill(src)
		if(79 to 80)
			new /obj/item/cane(src)
			new /obj/item/clothing/head/collectable/tophat(src)
		if(81 to 82)
			new /obj/item/gun/energy/plasmacutter(src)
		if(83 to 84)
			new /obj/item/toy/katana(src)
		if(85 to 86)
			new /obj/item/defibrillator/compact(src)
		if(87) //1% chance
			new /obj/item/weed_extract(src)
		if(88)
			new /obj/item/organ/brain(src)
		if(89)
			new /obj/item/organ/brain/alien(src)
		if(90)
			new /obj/item/organ/heart(src)
		if(91)
			new /obj/item/soulstone/anybody(src)
		if(92)
			new /obj/item/katana(src)
		if(93)
			new /obj/item/dnainjector/xraymut(src)
		if(94)
			new /obj/item/storage/backpack/clown(src)
			new /obj/item/clothing/under/rank/civilian/clown(src)
			new /obj/item/clothing/shoes/clown_shoes(src)
			new /obj/item/pda/clown(src)
			new /obj/item/clothing/mask/gas/clown_hat(src)
			new /obj/item/bikehorn(src)
			new /obj/item/toy/crayon/rainbow(src)
			new /obj/item/reagent_containers/spray/waterflower(src)
		if(95)
			new /obj/item/clothing/under/rank/civilian/mime(src)
			new /obj/item/clothing/shoes/sneakers/black(src)
			new /obj/item/pda/mime(src)
			new /obj/item/clothing/gloves/color/white(src)
			new /obj/item/clothing/mask/gas/mime(src)
			new /obj/item/clothing/head/beret(src)
			new /obj/item/clothing/suit/suspenders(src)
			new /obj/item/toy/crayon/mime(src)
			new /obj/item/reagent_containers/food/drinks/bottle/bottleofnothing(src)
		if(96)
			new /obj/item/hand_tele(src)
		if(97)
			new /obj/item/clothing/mask/balaclava
			new /obj/item/gun/ballistic/automatic/pistol(src)
			new /obj/item/ammo_box/magazine/m10mm(src)
		if(98)
			new /obj/item/katana/cursed(src)
		if(99)
			new /obj/item/storage/belt/champion(src)
			new /obj/item/clothing/mask/luchador(src)
		if(100)
			new /obj/item/clothing/head/bearpelt(src)
		if(101 to 105)
			var/ctype = pick(subtypesof(/datum/supply_pack))
			var/datum/supply_pack/pack = new ctype()
			for(var/item as() in pack.contains)
				new item(src)
			qdel(pack)
		if(106)
			new /obj/item/reagent_containers/glass/bottle/mannitol(src)
			new /obj/item/storage/pill_bottle/neurine(src)
			new /obj/item/organ/brain(src)
		if(107)
			new /obj/item/reagent_containers/glass/bottle/brainrot(src)
			new /obj/item/reagent_containers/glass/bottle/fake_gbs(src)
			new /obj/item/reagent_containers/glass/bottle/cold(src)
			new /obj/item/reagent_containers/glass/bottle/random_virus(src)
			new /obj/item/clothing/head/bio_hood/virology(src)
			new /obj/item/clothing/suit/bio_suit/virology(src)
			new /obj/item/tank/internals/oxygen/yellow(src)
			new /obj/item/clothing/gloves/color/latex/nitrile(src)
		if(108)
			new /obj/item/circuitboard/machine/protolathe(src)
		if(109)
			var/chosen_circuit = pick(subtypesof(/obj/item/circuitboard) - /obj/item/circuitboard)
			new chosen_circuit(src)
		if(110)
			new /obj/item/clothing/head/bronze(src)
			new /obj/item/clothing/shoes/bronze(src)
			new /obj/item/clothing/suit/bronze(src)
			new /obj/item/stack/tile/bronze/thirty(src)
		if(111)
			new /obj/item/clothing/accessory/medal/bronze_heart(src)
			new /obj/item/clothing/accessory/medal/conduct(src)
			new /obj/item/clothing/accessory/medal/plasma(src)
			new /obj/item/clothing/accessory/medal/plasma/nobel_science(src)
			new /obj/item/clothing/accessory/medal/ribbon/cargo(src)
			new /obj/item/clothing/accessory/medal/silver/excellence(src)
			new /obj/item/clothing/accessory/medal/silver/security(src)
			new /obj/item/clothing/accessory/medal/silver/valor(src)
		if(112)
			new /obj/item/instrument/violin/golden(src)
			new /obj/item/seeds/apple/gold(src)
			new /obj/item/reagent_containers/food/drinks/trophy/gold_cup(src)
			new /obj/item/reagent_containers/food/snacks/grown/apple/gold(src)
		if(113)//Lite, mid and heavy are Snowndin lootdrops. Putting a spawner into the chest result things spawn on top of it instead of inside.
			switch(pickweight(list("heavystuff1" = 4, "heavystuff2" = 3, "heavystuff3" = 1, "heavystuff4" = 4, "heavystuff5" = 2, "heavystuff6" = 1, "heavystuff7" = 2, "heavystuff8" = 1)))
				if("heavystuff1")
					new /obj/item/banhammer(src)
					new /obj/item/clothing/head/helmet/riot(src)
					new /obj/item/banhammer(src)
					new /obj/item/clothing/head/helmet/riot(src)
					new /obj/item/banhammer(src)
					new /obj/item/clothing/head/helmet/riot(src)
					new /obj/item/banhammer(src)
					new /obj/item/clothing/head/helmet/riot(src)
					new /obj/item/banhammer(src)
					new /obj/item/clothing/head/helmet/riot(src)
				if("heavystuff2")
					new /obj/item/clothing/head/helmet/roman/legionnaire(src)
					new /obj/item/clothing/shoes/roman(src)
					new /obj/item/clothing/under/costume/roman(src)
					new /obj/item/shield/riot/roman(src)
					new /obj/item/kitchen/knife(src)
				if("heavystuff3")
					new /obj/item/twohanded/fireaxe(src)
					new /obj/item/organ/brain/alien(src)
				if("heavystuff4")
					new /obj/item/modular_computer/tablet/preset/advanced(src)
				if("heavystuff5")
					new /obj/item/stack/spacecash/c1000(src)
					new /obj/item/stack/spacecash/c1000(src)
					new /obj/item/clothing/head/collectable/tophat(src)
					new /obj/item/storage/fancy/cigarettes/cigars/cohiba(src)
				if("heavystuff6")
					new /obj/item/borg/upgrade/hypospray/expanded(src)
				if("heavystuff7")
					new /obj/item/borg/upgrade/selfrepair(src)
				if("heavystuff8")
					new /obj/item/clothing/suit/armor/riot/knight/red(src)
					new /obj/item/clothing/gloves/plate/red(src)
					new /obj/item/clothing/shoes/plate/red(src)
					new /obj/item/clothing/head/helmet/knight/red(src)
					new /obj/item/kitchen/knife/butcher(src)
		if(114)
			for(var/food in 5)
				food = pick(subtypesof(/obj/item/reagent_containers/food/snacks) - /obj/item/reagent_containers/food/snacks)
				new food(src)
		if(115)
			var/knife = pick(subtypesof(/obj/item/kitchen/knife) - (/obj/item/kitchen/knife/combat/cyborg + /obj/item/kitchen/knife/envy + /obj/item/kitchen/knife/rainbowknife + /obj/item/kitchen/knife/poison))
			new knife(src)
		if(116)
			switch(pickweight(list("litestuff" = 3, "litestuff2" = 2, "litestuff3" = 1, "litestuff4" = 4, "litestuff5" = 1)))
				if("litestuff")
					new /obj/item/melee/classic_baton/police(src)
					new /obj/item/storage/firstaid/regular(src)
					new /obj/item/storage/toolbox/mechanical/old/clean(src)
				if("litestuff2")
					new /obj/item/melee/classic_baton/police/telescopic(src)
					new /obj/item/storage/firstaid/toxin(src)
					new /obj/item/grenade/clusterbuster/smoke(src)
				if("litestuff3")
					for(var/scarf in 5)
						scarf = pick(subtypesof(/obj/item/clothing/neck/scarf))
						new scarf(src)
				if("litestuff4")
					new /obj/item/storage/firstaid/regular(src)
					new /obj/item/storage/firstaid/toxin(src)
					new /obj/item/storage/firstaid/brute(src)
					new /obj/item/storage/firstaid/fire(src)
					new /obj/item/borg/upgrade/ddrill(src)
					new /obj/item/borg/upgrade/soh(src)
				if("litestuff5")
					new /obj/item/grenade/clusterbuster/smoke(src)
		if(117 to 120)
			new /obj/item/tank/jetpack/void(src)
			new /obj/item/clothing/mask/breath(src)
			new /obj/item/clothing/head/helmet/space/nasavoid(src)
			new /obj/item/clothing/suit/space/nasavoid(src)
			new /obj/item/crowbar(src)
			new /obj/item/stock_parts/cell(src)
			new /obj/item/multitool(src)
		if(121)
			new /obj/item/clothing/gloves/chameleon/combat(src)
			for(var/gloves in 6)
				gloves = pick(subtypesof(/obj/item/clothing/gloves/color) - /obj/item/clothing/gloves/color)
				new gloves(src)
		if(122)
			new /obj/item/clothing/gloves/gang(src)
		if(123)
			for(var/pizza in 5)
				pizza = pick(subtypesof(/obj/item/pizzabox))
				new pizza(src)
		if(124)
			new /obj/item/clothing/shoes/gang(src)
			new /obj/item/reagent_containers/spray/waterflower(src)
		if(125)
			new /obj/item/clothing/shoes/clown_shoes/combat(src)
			new /obj/item/storage/backpack/duffelbag/clown/syndie(src)
			new /obj/item/pda/clown(src)
			new /obj/item/megaphone/clown(src)
			new /obj/item/clothing/mask/gas/clown_hat(src)
		if(126)
			new /obj/item/reagent_containers/spray/chemsprayer/janitor/clown(src)
		if(127)
			new /obj/item/clothing/head/crown/fancy(src)           //monke king
			new /obj/item/storage/box/monkeycubes(src)
			new /obj/item/storage/box/monkeycubes(src)
			new /obj/item/storage/box/monkeycubes(src)
		if(128)
			switch(pickweight(list("midstuff1" = 1, "midstuff2" = 4, "midstuff3" = 3, "midstuff4" = 4, "midstuff5" = 5, "midstuff6" = 3, "midstuff7" = 2, "midstuff8" = 1, "midstuff9" = 1)))
				if("midstuff1")
					new /obj/item/shield/riot/tele(src)
					new /obj/item/pickaxe/drill/diamonddrill(src)
					new /obj/item/storage/firstaid/tactical(src)
				if("midstuff2")
					new /obj/item/shield/riot/buckler(src)
					new /obj/item/melee/baseball_bat/ablative(src)
				if("midstuff3")
					new /obj/item/dnainjector/geladikinesis(src)
				if("midstuff4")
					new /obj/item/storage/backpack/duffelbag/syndie(src)
					new /obj/item/lipstick(src)
					new /obj/item/flashlight/glowstick/red(src)
				if("midstuff5")
					new /obj/item/stack/sheet/mineral/diamond{amount = 15}(src)
					new /obj/item/stack/sheet/mineral/uranium{amount = 15}(src)
					new /obj/item/stack/sheet/mineral/plasma{amount = 15}(src)
					new /obj/item/stack/sheet/mineral/gold{amount = 15}(src)
				if("midstuff6")
					new /obj/item/book/granter/crafting_recipe/cooking_sweets_101(src)
				if("midstuff7")
					new /obj/item/borg/upgrade/vtec(src)
					new /obj/item/borg/upgrade/disablercooler(src)
				if("midstuff8")
					new /obj/item/book/manual/wiki/telescience(src)
					new /obj/item/stack/ore/bluespace_crystal(src)
				if("midstuff9")
					new /obj/item/book/granter/crafting_recipe/cooking_sweets_101(src)
					new /obj/item/reagent_containers/food/snacks/cakeslice/trumpet(src)
					new /obj/item/reagent_containers/food/snacks/cakeslice/vanilla_slice(src)
					new /obj/item/reagent_containers/food/snacks/cakeslice/plain(src)
		if(129)
			new /obj/item/stack/sheet/mineral/snow{amount = 25}(src)
			new /obj/item/toy/snowball(src)
			new /obj/item/twohanded/spear(src)
		if(130)
			new /mob/living/simple_animal/bot/medbot(src)
			new /mob/living/simple_animal/bot/floorbot(src)
			new /mob/living/simple_animal/bot/cleanbot(src)
		if(131)
			new /obj/item/card/emagfake(src)
			new /obj/item/ammo_box/magazine/toy/pistol/riot(src)
			new /obj/item/gun/ballistic/automatic/toy/pistol/riot(src)
			new /obj/item/toy/sword(src)
			new /obj/item/toy/cards/deck/syndicate(src)
			new /obj/item/toy/syndicateballoon(src)
			new /obj/item/bedsheet/syndie(src)
			new /obj/item/toy/plush/nukeplushie(src)
			new /obj/item/toy/nuke(src)
			new /obj/item/disk/nuclear/fake(src)
		if(132)
			new /obj/item/pneumatic_cannon(src)
		if(133)
			new /obj/item/dnainjector/elvismut(src)
			new /obj/item/dnainjector/firemut(src)
			new /obj/item/dnainjector/glow(src)
			new /obj/item/dnainjector/spastic(src)
			new /obj/item/dnainjector/epimut(src)
			new /obj/item/handmirror(src)
			new /obj/item/razor(src)
		if(134 to 138)
			for(var/stick in 7)
				stick = pick(subtypesof(/obj/item/flashlight/glowstick))
				new stick(src)
		if(139 to 141)
			new /obj/item/clothing/suit/xenos(src)
			new /obj/item/toy/toy_xeno(src)
			new /obj/item/clothing/head/xenos(src)
			if(prob(10))
				new /obj/item/clothing/mask/facehugger/toy(src)
		if(142 to 146)
			new /mob/living/simple_animal/cluwne(src)
			new /mob/living/simple_animal/cluwne(src)
			new /mob/living/simple_animal/cluwne(src)
			new /mob/living/simple_animal/cluwne(src)
			new /obj/item/dnainjector/clumsymut(src)
			new /obj/item/dnainjector/cluwnemut(src)
		if(147)
			new /obj/item/clothing/head/helmet/swat/nanotrasen(src)
			new /obj/item/clothing/under/rank/security/officer(src)
			new /obj/item/clothing/suit/armor/vest(src)
			new /obj/item/clothing/shoes/combat/swat(src)
			new /obj/item/clothing/gloves/combat(src)
		if(148)
			for(var/ears in 4)
				ears = pick(subtypesof(/obj/item/organ/ears))
				new ears
		if(149)
			for(var/soda in 8)
				soda = pick(subtypesof(/obj/item/reagent_containers/food/drinks/soda_cans) - /obj/item/reagent_containers/food/drinks/soda_cans)
				new soda(src)
		if(150)
			new /obj/item/bedsheet/centcom(src)
			new /obj/item/clothing/under/rank/centcom/commander(src)
			new /obj/item/card/id/centcom(src)
			new /obj/item/clothing/head/centhat(src)
			new /obj/effect/decal/remains/human(src)
			new /obj/item/gun/energy/e_gun(src)
			new /obj/item/paper/fluff/awaymissions/centcom/gateway_memo(src)
		if(151)
			new /obj/item/reagent_containers/glass/waterbottle/large(src)
			new /obj/item/reagent_containers/glass/waterbottle/large(src)
			new /obj/item/reagent_containers/glass/waterbottle/large(src)
			new /obj/item/reagent_containers/glass/waterbottle/large(src)
			new /obj/item/reagent_containers/glass/waterbottle/large(src)
			new /obj/item/reagent_containers/glass/waterbottle/large(src)
			new /obj/item/reagent_containers/glass/waterbottle/large(src)
		if(152 to 155)
			for(var/backpack in 1 to rand(3, 8))
				backpack = pick(subtypesof(/obj/item/storage/backpack/satchel) - /obj/item/storage/backpack/satchel/flat/with_tools)
				new backpack(src)
		if(156)
			new /obj/item/clothing/head/chefhat(src)
			new /obj/item/grenade/chem_grenade/teargas/moustache(src)
			new /obj/item/grenade/chem_grenade/teargas/moustache(src)
		if(157)
			new /obj/item/storage/belt/janitor/full(src)
			new /obj/item/reagent_containers/spray/chemsprayer/janitor(src)
			new /obj/item/clothing/suit/bio_suit/janitor(src)
			new /obj/item/clothing/head/bio_hood/janitor(src)
			new /obj/item/clothing/under/rank/civilian/janitor(src)
			new /obj/item/toy/gun(src)
		if(158)
			new /obj/item/golem_shell/servant(src)
			new /obj/item/golem_shell/servant(src)
			new /obj/item/bedsheet/patriot(src)
			new /obj/item/bedsheet/patriot(src)
			new /obj/item/bedsheet/rd/royal_cape(src)
		if(159)
			new /obj/item/paper/fluff/ruins/oldstation/protosuit(src)
			new /obj/item/clothing/suit/space/hardsuit/ancient(src)
		if(160)
			new /mob/living/simple_animal/pet/gondola(src)
			new /mob/living/simple_animal/pet/gondola(src)
			new /mob/living/simple_animal/pet/gondola(src)
			new /mob/living/simple_animal/pet/gondola(src)
			new /mob/living/simple_animal/pet/gondola(src)
			new /mob/living/simple_animal/pet/gondola(src)
			new /obj/item/clothing/mask/gondola(src)
			new /obj/item/stack/sheet/animalhide/gondola(src)
			new /obj/item/clothing/under/costume/gondola(src)
			new /obj/item/storage/box/donkpockets/donkpocketgondola(src)
		if(161)
			for(var/injector in 1 to rand(1, 2))
				injector = pick(subtypesof(/obj/item/dnainjector) - /obj/item/dnainjector)
				new injector(src)
		if(162 to 165)
			for(var/seed in 1 to rand(4, 8))
				seed = pick(subtypesof(/obj/item/seeds) - /obj/item/seeds)
				new seed(src)
			new /obj/item/clothing/gloves/botanic_leather(src)
			new /obj/item/toy/figure/botanist(src)
		if(166)
			new /obj/item/clothing/head/hardhat/pumpkinhead(src)
			new /obj/item/scythe(src)
			new /obj/item/clothing/shoes/sandal(src)
			new /obj/item/clothing/under/costume/skeleton(src)
			new /obj/item/clothing/suit/jacket/leather/overcoat(src)
		if(167 to 169)
			new /obj/item/clothing/suit/ghost_sheet(src)
			new /obj/item/clothing/suit/ghost_sheet(src)
			new /obj/item/clothing/suit/ghost_sheet(src)
			new /obj/item/clothing/suit/ghost_sheet(src)
			new /obj/item/clothing/shoes/sandal(src)
			new /obj/item/clothing/shoes/sandal(src)
			new /obj/item/clothing/shoes/sandal(src)
			new /obj/item/clothing/shoes/sandal(src)
		if(170)
			for(var/shotgunstuff in 1 to rand(3, 6))
				var/list/shotlist = list(/obj/item/ammo_casing/shotgun/breacher, /obj/item/ammo_casing/shotgun/beanbag, /obj/item/ammo_casing/shotgun/rubbershot)
				shotgunstuff = pick(shotlist)
				new shotgunstuff(src)
			new /obj/item/storage/belt/bandolier(src)
			if(prob(20))
				new /obj/item/gun/ballistic/shotgun/sc_pump(src)
		if(171)
			for(var/shotcasings in 2 to rand(5, 9))
				shotcasings = pick(subtypesof(/obj/item/ammo_casing/shotgun) - (/obj/item/ammo_casing/shotgun/techshell + /obj/item/ammo_casing/shotgun/dart/bioterror))
				new shotcasings(src)
		if(172)
			for(var/arrows in 3 to rand(4, 6))
				arrows = pick(subtypesof(/obj/item/ammo_casing/caseless/arrow) - /obj/item/ammo_casing/caseless/arrow)
				new arrows(src)
			var/bow = pick(subtypesof(/obj/item/gun/ballistic/bow))
			new bow(src)
			new /obj/item/clothing/shoes/sandal(src)
			new /obj/item/clothing/under/pants/black(src)
			new /obj/item/storage/belt/quiver(src)
			new /obj/item/clothing/head/helmet/skull(src)
		if(173)
			new /obj/item/clothing/head/franks_hat(src)
		if(174)
			new /obj/item/clothing/shoes/galoshes/dry(src)//jannie moment
			new /obj/item/watertank/janitor(src)
			new /obj/item/grenade/clusterbuster/cleaner(src)
			new /obj/item/mop/advanced(src)
			new /obj/item/storage/bag/trash/bluespace(src)
		if(175)
			new /obj/item/grenade/clusterbuster/metalfoam(src)
			new /obj/item/grenade/chem_grenade/metalfoam(src)
			new /obj/item/grenade/chem_grenade/metalfoam(src)
			new /obj/item/grenade/chem_grenade/metalfoam(src)
			new /obj/item/pickaxe/diamond(src)
		if(176 to 177)
			new /obj/item/stack/conveyor/thirty(src)
			new /obj/machinery/gibber(src)
			new /obj/item/circuitboard/machine/recycler(src)
		if(178)
			var/key = pick(subtypesof(/obj/item/encryptionkey) - (/obj/item/encryptionkey + /obj/item/encryptionkey/headset_cent + /obj/item/encryptionkey/ai + /obj/item/encryptionkey/secbot + /obj/item/encryptionkey/syndicate))
			new key(src)
		if(179)
			new /obj/vehicle/ridden/wheelchair/motorized(src)
			new /obj/vehicle/ridden/wheelchair/motorized(src)
			new /obj/vehicle/ridden/atv(src)
			new /obj/item/key(src)
		if(180)
			new /obj/item/clothing/head/helmet/chaplain/witchunter_hat(src)
			new /obj/item/gun/syringe/rapidsyringe(src)
			new /obj/item/storage/box/syringes(src)
			new /obj/item/clothing/under/misc/assistantformal(src)
			new /obj/item/clothing/suit/gothcoat(src)

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/closet/crate/secure/loot/attack_hand(mob/user)
	if(locked)
		to_chat(user, "<span class='notice'>The crate is locked with a Deca-code lock.</span>")
		var/input = capped_input(usr, "Enter [codelen] digits. All digits must be unique.", "Deca-Code Lock")
		if(user.canUseTopic(src, BE_CLOSE))
			var/list/sanitised = list()
			var/sanitycheck = TRUE
			var/char = ""
			var/length_input = length(input)
			for(var/i = 1, i <= length_input, i += length(char)) //put the guess into a list
				char = input[i]
				sanitised += text2num(char)
			for(var/i = 1, i <= length(sanitised) - 1, i++) //compare each digit in the guess to all those following it
				for(var/j = i + 1, j <= length(sanitised), j++)
					if(sanitised[i] == sanitised[j])
						sanitycheck = FALSE //if a digit is repeated, reject the input
			if(input == code)
				to_chat(user, "<span class='notice'>The crate unlocks!</span>")
				locked = FALSE
				cut_overlays()
				add_overlay("securecrateg")
				add_overlay("[icon_state]_door") //needs to put the door overlayer back cause of this snowflake code
				tamperproof = 0 // set explosion chance to zero, so we dont accidently hit it with a multitool and instantly die
			else if(!input || !sanitycheck || length(sanitised) != codelen)
				to_chat(user, "<span class='notice'>You leave the crate alone.</span>")
			else
				to_chat(user, "<span class='warning'>A red light flashes.</span>")
				lastattempt = input
				attempts--
				if(attempts == 0)
					boom(user)
	else
		return ..()

/obj/structure/closet/crate/secure/loot/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	return attack_hand(user) //this helps you not blow up so easily by overriding unlocking which results in an immediate boom.

/obj/structure/closet/crate/secure/loot/attackby(obj/item/W, mob/user)
	if(locked)
		if(W.tool_behaviour == TOOL_MULTITOOL)
			to_chat(user, "<span class='notice'>DECA-CODE LOCK REPORT:</span>")
			if(attempts == 1)
				to_chat(user, "<span class='warning'>* Anti-Tamper Bomb will activate on next failed access attempt.</span>")
			else
				to_chat(user, "<span class='notice'>* Anti-Tamper Bomb will activate after [attempts] failed access attempts.</span>")
			if(lastattempt != null)
				var/bulls = 0 //right position, right number
				var/cows = 0 //wrong position but in the puzzle

				var/lastattempt_char = ""
				var/length_lastattempt = length(lastattempt)
				var/lastattempt_it = 1

				var/code_char = ""
				var/length_code = length(code)
				var/code_it = 1

				while(lastattempt_it <= length_lastattempt && code_it <= length_code) // Go through list and count matches
					lastattempt_char = lastattempt[lastattempt_it]
					code_char = code[code_it]
					if(lastattempt_char == code_char)
						++bulls
					else if(findtext(code, lastattempt_char))
						++cows

					lastattempt_it += length(lastattempt_char)
					code_it += length(code_char)

				to_chat(user, "<span class='notice'>Last code attempt, [lastattempt], had [bulls] correct digits at correct positions and [cows] correct digits at incorrect positions.</span>")
			return
	return ..()

/obj/structure/closet/secure/loot/dive_into(mob/living/user)
	if(!locked)
		return ..()
	to_chat(user, "<span class='notice'>That seems like a stupid idea.</span>")
	return FALSE

/obj/structure/closet/crate/secure/loot/emag_act(mob/user)
	if(locked)
		boom(user)

/obj/structure/closet/crate/secure/loot/togglelock(mob/user)
	if(locked)
		boom(user)
	else
		..()

/obj/structure/closet/crate/secure/loot/deconstruct(disassembled = TRUE)
	boom()
