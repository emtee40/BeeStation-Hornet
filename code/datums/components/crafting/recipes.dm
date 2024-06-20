
/datum/crafting_recipe
	var/name = "" //in-game display name
	var/reqs[] = list() //type paths of items consumed associated with how many are needed
	var/blacklist[] = list() //type paths of items explicitly not allowed as an ingredient
	var/result //type path of item resulting from this craft
	var/tools[] = list() //type paths of items needed but not consumed
	var/time = 30 //time in deciseconds
	var/parts[] = list() //type paths of items that will be placed in the result
	var/chem_catalysts[] = list() //like tools but for reagents
	var/category = CAT_NONE //where it shows up in the crafting UI
	var/subcategory = CAT_NONE
	var/always_available = TRUE //Set to FALSE if it needs to be learned first.
	var/one_per_turf = FALSE ///Should only one object exist on the same turf?
	var/dangerous_craft = FALSE /// Should admins be notified about this getting created by a non-antagonist?

/datum/crafting_recipe/New()
	if(!(result in reqs))
		blacklist += result

/**
  * Run custom pre-craft checks for this recipe
  *
  * user: the /mob that initiated the crafting
  * collected_requirements: A list of lists of /obj/item instances that satisfy reqs. Top level list is keyed by requirement path.
  */
/datum/crafting_recipe/proc/check_requirements(mob/user, list/collected_requirements)
	return TRUE

/datum/crafting_recipe/IED
	name = "IED"
	result = /obj/item/grenade/iedcasing
	reqs = list(/datum/reagent/fuel = 50,
				/obj/item/stack/cable_coil = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/reagent_containers/food/drinks/soda_cans = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/soda_cans = 1)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/lance
	name = "Explosive Lance (Grenade)"
	result = /obj/item/spear/explosive
	reqs = list(/obj/item/spear = 1,
				/obj/item/grenade = 1)
	blacklist = list(/obj/item/spear/bonespear)
	parts = list(/obj/item/spear = 1,
				/obj/item/grenade = 1)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/strobeshield
	name = "Strobe Shield"
	result = /obj/item/shield/riot/flash
	reqs = list(/obj/item/wallframe/flasher = 1,
				/obj/item/assembly/flash/handheld = 1,
				/obj/item/shield/riot = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/molotov
	name = "Molotov"
	result = /obj/item/reagent_containers/food/drinks/bottle/molotov
	reqs = list(/obj/item/reagent_containers/glass/rag = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/stunprod
	name = "Stunprod"
	result = /obj/item/melee/baton/cattleprod
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/rods = 1,
				/obj/item/assembly/igniter = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/teleprod
	name = "Teleprod"
	result = /obj/item/melee/baton/cattleprod/teleprod
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/rods = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/ore/bluespace_crystal = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/bola
	name = "Bola"
	result = /obj/item/restraints/legcuffs/bola
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/sheet/iron = 6)
	time = 20//15 faster than crafting them by hand!
	category= CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/gonbola
	name = "Gonbola"
	result = /obj/item/restraints/legcuffs/bola/gonbola
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/sheet/iron = 6,
				/obj/item/stack/sheet/animalhide/gondola = 1)
	time = 40
	category= CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/tailclub
	name = "Tail Club"
	result = /obj/item/club/tailclub
	reqs = list(/obj/item/organ/tail/lizard = 1,
	            /obj/item/stack/sheet/iron = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/club
	name = "improvised maul"
	result = /obj/item/club/ghettoclub
	reqs = list(/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/rods = 1,
				/obj/item/restraints/handcuffs/cable = 2,
				/obj/item/stack/sheet/cotton/cloth = 3)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/tailwhip
	name = "Liz O' Nine Tails"
	result = /obj/item/melee/chainofcommand/tailwhip
	reqs = list(/obj/item/organ/tail/lizard = 1,
	            /obj/item/stack/cable_coil = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/catwhip
	name = "Cat O' Nine Tails"
	result = /obj/item/melee/chainofcommand/tailwhip/kitty
	reqs = list(/obj/item/organ/tail/cat = 1,
	            /obj/item/stack/cable_coil = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/ed209
	name = "ED209"
	result = /mob/living/simple_animal/bot/ed209
	reqs = list(/obj/item/robot_suit = 1,
				/obj/item/clothing/head/helmet = 1,
				/obj/item/clothing/suit/armor/vest = 1,
				/obj/item/bodypart/l_leg/robot = 1,
				/obj/item/bodypart/r_leg/robot = 1,
				/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/cable_coil = 1,
				/obj/item/gun/energy/disabler = 1,
				/obj/item/stock_parts/cell = 1,
				/obj/item/assembly/prox_sensor = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 60
	category = CAT_ROBOT

/datum/crafting_recipe/secbot
	name = "Secbot"
	result = /mob/living/simple_animal/bot/secbot
	reqs = list(/obj/item/assembly/signaler = 1,
				/obj/item/clothing/head/helmet/sec = 1,
				/obj/item/melee/baton = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bodypart/r_arm/robot = 1)
	tools = list(TOOL_WELDER)
	time = 60
	category = CAT_ROBOT

/datum/crafting_recipe/cleanbot
	name = "Cleanbot"
	result = /mob/living/simple_animal/bot/cleanbot
	reqs = list(/obj/item/reagent_containers/glass/bucket = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bodypart/r_arm/robot = 1)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/cleanbot/larry
	name = "Larry"
	result = /mob/living/simple_animal/bot/cleanbot/larry
	reqs = list(/obj/item/larryframe = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bodypart/r_arm/robot = 1)


/datum/crafting_recipe/floorbot
	name = "Floorbot"
	result = /mob/living/simple_animal/bot/floorbot
	reqs = list(/obj/item/storage/toolbox = 1,
				/obj/item/stack/tile/iron = 10,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bodypart/r_arm/robot = 1)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/medbot
	name = "Medbot"
	result = /mob/living/simple_animal/bot/medbot
	reqs = list(/obj/item/healthanalyzer = 1,
				/obj/item/storage/firstaid = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bodypart/r_arm/robot = 1)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/honkbot
	name = "Honkbot"
	result = /mob/living/simple_animal/bot/honkbot
	reqs = list(/obj/item/storage/box/clown = 1,
				/obj/item/bodypart/r_arm/robot = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/bikehorn/ = 1)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/Firebot
	name = "Firebot"
	result = /mob/living/simple_animal/bot/firebot
	reqs = list(/obj/item/extinguisher = 1,
				/obj/item/bodypart/r_arm/robot = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/clothing/head/utility/hardhat/red = 1)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/Atmosbot
	name = "Atmosbot"
	result = /mob/living/simple_animal/bot/atmosbot
	reqs = list(/obj/item/analyzer = 1,
				/obj/item/bodypart/r_arm/robot = 1,
				/obj/item/assembly/prox_sensor = 1,
				/obj/item/tank/internals = 1)
	time = 40
	category = CAT_ROBOT

/datum/crafting_recipe/improvised_pneumatic_cannon //Pretty easy to obtain but
	name = "Pneumatic Cannon"
	result = /obj/item/pneumatic_cannon/ghetto
	tools = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(/obj/item/stack/sheet/iron = 4,
				/obj/item/stack/package_wrap = 8,
				/obj/item/pipe = 2)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/flamethrower
	name = "Flamethrower"
	result = /obj/item/flamethrower
	reqs = list(/obj/item/weldingtool = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/rods = 1)
	parts = list(/obj/item/assembly/igniter = 1,
				/obj/item/weldingtool = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/pipebow
	name = "Pipe Bow"
	result = /obj/item/gun/ballistic/bow/pipe
	reqs = list(/obj/item/pipe = 5,
				/obj/item/stack/sheet/plastic = 15,
				/obj/item/weaponcrafting/silkstring = 4)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/woodenbow
	name = "Wooden Bow"
	result = /obj/item/gun/ballistic/bow
	reqs = list(/obj/item/stack/sheet/wood = 8,
				/obj/item/stack/sheet/iron = 2,
				/obj/item/weaponcrafting/silkstring = 4)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/meteorslug
	name = "Meteorslug Shell"
	result = /obj/item/ammo_casing/shotgun/meteorslug
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/rcd_ammo = 1,
				/obj/item/stock_parts/manipulator = 2)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/pulseslug
	name = "Pulse Slug Shell"
	result = /obj/item/ammo_casing/shotgun/pulseslug
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stock_parts/capacitor/adv = 2,
				/obj/item/stock_parts/micro_laser/ultra = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/dragonsbreath
	name = "Dragonsbreath Shell"
	result = /obj/item/ammo_casing/shotgun/dragonsbreath
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1, /datum/reagent/phosphorus = 5)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/frag12
	name = "FRAG-12 Shell"
	result = /obj/item/ammo_casing/shotgun/frag12
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/datum/reagent/glycerol = 5,
				/datum/reagent/toxin/acid = 5,
				/datum/reagent/toxin/acid/fluacid = 5)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/ionslug
	name = "Ion Scatter Shell"
	result = /obj/item/ammo_casing/shotgun/ion
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stock_parts/micro_laser/ultra = 1,
				/obj/item/stock_parts/subspace/crystal = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/improvisedslug
	name = "Improvised Shotgun Shell"
	result = /obj/item/ammo_casing/shotgun/improvised
	reqs = list(/obj/item/grenade/chem_grenade = 1,
				/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/cable_coil = 1,
				/datum/reagent/fuel = 10)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/improvisedglassslug
	name = "Glasspack Shotgun Shell"
	result = /obj/item/ammo_casing/shotgun/improvised/glasspack
	reqs = list(/obj/item/grenade/chem_grenade = 1,
				/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/cable_coil = 1,
				/datum/reagent/fuel = 10)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/laserslug
	name = "Scatter Laser Shell"
	result = /obj/item/ammo_casing/shotgun/laserslug
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stock_parts/capacitor/adv = 1,
				/obj/item/stock_parts/micro_laser/high = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/a762improv
	name = "Improvised 7.62 Cartridge"
	result = /obj/item/ammo_casing/a762/improv
	reqs = list(/obj/item/grenade/chem_grenade = 1,
				/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/cable_coil = 1,
				/datum/reagent/fuel = 10)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/a762hotload
	name = "Hot-Loaded 7.62 Cartridge"
	result = /obj/item/ammo_casing/a762/improv/hotload
	reqs = list(/obj/item/grenade/chem_grenade = 1,
				/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/cable_coil = 1,
				/datum/reagent/blackpowder = 10)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/improv9mm_pack
	name = "Improvised 9mm Ammo Pack"
	result = /obj/item/ammo_box/pouch/c9mm/improv
	reqs = list(/obj/item/grenade/chem_grenade = 2,
				/obj/item/stack/rods = 3,
				/obj/item/stack/cable_coil = 3,
				/datum/reagent/fuel = 20,
				/obj/item/paper = 1)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/improv10mm_pack
	name = "Improvised 10mm Ammo Pack"
	result = /obj/item/ammo_box/pouch/c10mm/improv
	reqs = list(/obj/item/grenade/chem_grenade = 2,
				/obj/item/stack/sheet/iron = 2,
				/obj/item/stack/cable_coil = 2,
				/datum/reagent/fuel = 20,
				/obj/item/paper = 1)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/improv38_pack
	name = "Improvised .38 Ammo Pack"
	result = /obj/item/ammo_box/pouch/c38/improv
	reqs = list(/obj/item/grenade/chem_grenade = 2,
				/obj/item/stack/rods = 2,
				/obj/item/stack/cable_coil = 2,
				/datum/reagent/fuel = 20,
				/obj/item/paper = 1)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/improv357
	name = "Improvised .357 Cartridge"
	result = /obj/item/ammo_casing/a357/improv
	reqs = list(/obj/item/grenade/chem_grenade = 1,
				/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/cable_coil = 2,
				/datum/reagent/blackpowder = 10)
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
	dangerous_craft = TRUE

/datum/crafting_recipe/pipesmg_mag
	name = "Pipe Repeater Magazine"
	result = /obj/item/ammo_box/magazine/pipem9mm
	reqs = list(/obj/item/grenade/chem_grenade = 1,
				/obj/item/stock_parts/matter_bin = 1,
				/obj/item/stack/cable_coil = 3,
				/obj/item/stack/package_wrap = 3)
	tools = list(TOOL_WELDER, TOOL_WIRECUTTER)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/arrow
	name = "Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/wood
	time = 30
	reqs = list(/obj/item/stack/sheet/wood = 1,
				/obj/item/stack/sheet/silk = 1,
				/obj/item/stack/rods = 1) //1 metal sheet = 2 rods= 2 arrows
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/bone_arrow
	name = "Bone Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/sinew = 1,
				/obj/item/ammo_casing/caseless/arrow/ash = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/ashen_arrow
	name = "Ashen arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ash
	tools = list(TOOL_WELDER)
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow/wood = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/bronze_arrow
	name = "Bronze arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bronze
	time = 30
	reqs = list(/obj/item/stack/sheet/wood = 1,
				/obj/item/stack/sheet/bronze = 1,
				/obj/item/stack/sheet/silk = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/ishotgun
	name = "Improvised Shotgun"
	result = /obj/item/gun/ballistic/shotgun/doublebarrel/improvised
	reqs = list(/obj/item/weaponcrafting/receiver = 1,
				/obj/item/pipe = 1,
				/obj/item/weaponcrafting/stock = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/package_wrap = 5)
	tools = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/piperifle
	name = "Singleshot Pipe Rifle"
	result = /obj/item/gun/ballistic/rifle/pipe
	reqs = list(/obj/item/weaponcrafting/receiver = 1,
				/obj/item/pipe = 1,
				/obj/item/weaponcrafting/stock = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/package_wrap = 5)
	tools = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/pipesmg
	name = "Mag-Fed Pipe Repeater"
	result = /obj/item/gun/ballistic/automatic/pipe_smg
	reqs = list(/obj/item/weaponcrafting/receiver = 1,
				/obj/item/pipe = 2,
				/obj/item/stack/rods = 2,
				/obj/item/stack/sheet/wood = 2,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/package_wrap = 5)
	tools = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/chainsaw
	name = "Chainsaw"
	result = /obj/item/chainsaw
	reqs = list(/obj/item/circular_saw = 1,
				/obj/item/stack/cable_coil = 3,
				/obj/item/stack/sheet/plasteel = 5)
	tools = list(TOOL_WELDER)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/spear
	name = "Spear"
	result = /obj/item/spear
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/shard = 1,
				/obj/item/stack/rods = 1)
	parts = list(/obj/item/shard = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/switchblade_kitchen
	name = "Iron Switchblade"
	result = /obj/item/switchblade/kitchen
	reqs = list(/obj/item/stack/sheet/iron = 2,
				/obj/item/weaponcrafting/receiver = 1,
				/obj/item/knife = 1,
				/obj/item/stack/cable_coil = 2)
	tools = list(TOOL_WELDER)
	time = 45
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/switchblade_kitchenupgrade
	name = "Plastitanium Switchblade"
	result = /obj/item/switchblade/plastitanium
	reqs = list(/obj/item/switchblade/kitchen = 1,
				/obj/item/stack/sheet/mineral/plastitanium = 2)
	tools = list(TOOL_WELDER)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/switchblade_plastitanium
	name = "Plastitanium Switchblade"
	result = /obj/item/switchblade/plastitanium
	reqs = list(/obj/item/weaponcrafting/stock = 1,
				/obj/item/weaponcrafting/receiver = 1,
				/obj/item/knife = 1,
				/obj/item/stack/cable_coil = 2,
				/obj/item/stack/sheet/mineral/plastitanium = 2)
	tools = list(TOOL_WELDER)
	time = 65
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/spooky_camera
	name = "Camera Obscura"
	result = /obj/item/camera/spooky
	time = 15
	reqs = list(/obj/item/camera = 1,
				/datum/reagent/water/holywater = 10)
	parts = list(/obj/item/camera = 1)
	category = CAT_MISC

/datum/crafting_recipe/lizardhat
	name = "Lizard Cloche Hat"
	result = /obj/item/clothing/head/costume/lizard
	time = 10
	reqs = list(/obj/item/organ/tail/lizard = 1)
	category = CAT_MISC

/datum/crafting_recipe/lizardhat_alternate
	name = "Lizard Cloche Hat"
	result = /obj/item/clothing/head/costume/lizard
	time = 10
	reqs = list(/obj/item/stack/sheet/animalhide/lizard = 1)
	category = CAT_MISC

/datum/crafting_recipe/kittyears
	name = "Kitty Ears"
	result = /obj/item/clothing/head/costume/kitty/genuine
	time = 10
	reqs = list(/obj/item/organ/tail/cat = 1,
				/obj/item/organ/ears/cat = 1)
	category = CAT_MISC

/datum/crafting_recipe/skateboard
	name = "Skateboard"
	result = /obj/item/melee/skateboard
	time = 60
	reqs = list(/obj/item/stack/sheet/iron = 5,
				/obj/item/stack/rods = 10)
	category = CAT_MISC

/datum/crafting_recipe/scooter
	name = "Scooter"
	result = /obj/vehicle/ridden/scooter
	time = 65
	reqs = list(/obj/item/stack/sheet/iron = 5,
				/obj/item/stack/rods = 12)
	category = CAT_MISC

/datum/crafting_recipe/wheelchair
	name = "Wheelchair"
	result = /obj/vehicle/ridden/wheelchair
	reqs = list(/obj/item/stack/sheet/iron = 4,
				/obj/item/stack/rods = 6)
	time = 100
	category = CAT_MISC

/datum/crafting_recipe/motorized_wheelchair
	name = "Motorized Wheelchair"
	result = /obj/vehicle/ridden/wheelchair/motorized
	reqs = list(/obj/item/stack/sheet/iron = 10,
		/obj/item/stack/rods = 8,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/capacitor = 1)
	parts = list(/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/capacitor = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WRENCH)
	time = 200
	category = CAT_MISC

/datum/crafting_recipe/mousetrap
	name = "Mouse Trap"
	result = /obj/item/assembly/mousetrap
	time = 10
	reqs = list(/obj/item/stack/sheet/cardboard = 1,
				/obj/item/stack/rods = 1)
	category = CAT_MISC

/datum/crafting_recipe/papersack
	name = "Paper Sack"
	result = /obj/item/storage/box/papersack
	time = 10
	reqs = list(/obj/item/paper = 5)
	category = CAT_MISC


/datum/crafting_recipe/flashlight_eyes
	name = "Flashlight Eyes"
	result = /obj/item/organ/eyes/robotic/flashlight
	time = 10
	reqs = list(
		/obj/item/flashlight = 2,
		/obj/item/restraints/handcuffs/cable = 1
	)
	category = CAT_MISC

/datum/crafting_recipe/paperframes
	name = "Paper Frames"
	result = /obj/item/stack/sheet/paperframes/five
	time = 10
	reqs = list(/obj/item/stack/sheet/wood = 5, /obj/item/paper = 20)
	category = CAT_MISC

/datum/crafting_recipe/naturalpaper
	name = "Hand-Pressed Paper"
	time = 30
	reqs = list(/datum/reagent/water = 50, /obj/item/stack/sheet/wood = 1)
	tools = list(/obj/item/hatchet)
	result = /obj/item/paper_bin/bundlenatural
	category = CAT_MISC

/datum/crafting_recipe/toysword
	name = "Toy Sword"
	reqs = list(/obj/item/light/bulb = 1, /obj/item/stack/cable_coil = 1, /obj/item/stack/sheet/plastic = 4)
	result = /obj/item/toy/sword
	category = CAT_MISC

/datum/crafting_recipe/blackcarpet
	name = "Black Carpet"
	reqs = list(/obj/item/stack/tile/carpet = 50, /obj/item/toy/crayon/black = 1)
	result = /obj/item/stack/tile/carpet/black/fifty
	category = CAT_MISC

/datum/crafting_recipe/extendohand
	name = "Extendo-Hand"
	reqs = list(/obj/item/bodypart/r_arm/robot = 1, /obj/item/clothing/gloves/boxing = 1)
	result = /obj/item/extendohand
	category = CAT_MISC

/datum/crafting_recipe/mothplush
	name = "Moth Plushie"
	result = /obj/item/toy/plush/moth
	reqs = list(/obj/item/stack/sheet/animalhide/mothroach = 1,
				/obj/item/stack/sheet/cotton/cloth = 3)
	category = CAT_MISC

/datum/crafting_recipe/chemical_payload
	name = "Chemical Payload (C4)"
	result = /obj/item/bombcore/chemical
	reqs = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/grenade/plastic/c4 = 1,
		/obj/item/grenade/chem_grenade = 2
	)
	parts = list(/obj/item/stock_parts/matter_bin = 1, /obj/item/grenade/chem_grenade = 2)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/chemical_payload2
	name = "Chemical Payload (Gibtonite)"
	result = /obj/item/bombcore/chemical
	reqs = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/gibtonite = 1,
		/obj/item/grenade/chem_grenade = 2
	)
	parts = list(/obj/item/stock_parts/matter_bin = 1, /obj/item/grenade/chem_grenade = 2)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	dangerous_craft = TRUE

/datum/crafting_recipe/bonearmor
	name = "Bone Armor"
	result = /obj/item/clothing/suit/armor/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 6)
	category = CAT_PRIMAL

/datum/crafting_recipe/heavybonearmor
	name = "Heavy Bone Armor"
	result = /obj/item/clothing/suit/hooded/cloak/bone
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonetalisman
	name = "Bone Talisman"
	result = /obj/item/clothing/accessory/talisman
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				 /obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonecodpiece
	name = "Skull Codpiece"
	result = /obj/item/clothing/accessory/skullcodpiece
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				 /obj/item/stack/sheet/animalhide/goliath_hide = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bracers
	name = "Bone Bracers"
	result = /obj/item/clothing/gloves/bracer
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				 /obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/skullhelm
	name = "Skull Helmet"
	result = /obj/item/clothing/head/helmet/skull
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/goliathcloak
	name = "Goliath Cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 2) //it takes 4 goliaths to make 1 cloak if the plates are skinned
	category = CAT_PRIMAL

/datum/crafting_recipe/drakecloak
	name = "Ash Drake Armour"
	result = /obj/item/clothing/suit/hooded/cloak/drake
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 10,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/ashdrake = 5)
	always_available = FALSE
	category = CAT_PRIMAL

/datum/crafting_recipe/watcherbola
	name = "Watcher Bola"
	result = /obj/item/restraints/legcuffs/bola/watcher
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 2,
				/obj/item/restraints/handcuffs/cable/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/goliathshield
	name = "Goliath shield"
	result = /obj/item/shield/riot/goliath
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonesword
	name = "Bone Sword"
	result = /obj/item/claymore/bone
	time = 40
	reqs = list(/obj/item/stack/sheet/bone = 3,
				/obj/item/stack/sheet/sinew = 2)
	category = CAT_PRIMAL
	dangerous_craft = TRUE

/datum/crafting_recipe/hunterbelt
	name = "Hunters Belt"
	result = /obj/item/storage/belt/mining/primitive
	time = 20
	reqs = list(/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/quiver
	name = "Quiver"
	result = /obj/item/storage/belt/quiver
	time = 80
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/sinew = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/bone_bow
	name = "Bone Bow"
	result = /obj/item/gun/ballistic/bow/ashen
	time = 200
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/sinew = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/firebrand
	name = "Firebrand"
	result = /obj/item/match/firebrand
	time = 100 //Long construction time. Making fire is hard work.
	reqs = list(/obj/item/stack/sheet/wood = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/gold_horn
	name = "Golden Bike Horn"
	result = /obj/item/bikehorn/golden
	time = 20
	reqs = list(/obj/item/stack/sheet/mineral/bananium = 5,
				/obj/item/bikehorn = 1)
	category = CAT_MISC

/datum/crafting_recipe/flash_ducky
	name = "Toy Rubber Duck Mine"
	result = /obj/item/deployablemine/traitor/toy
	time = 20
	reqs = list(/obj/item/bikehorn/rubberducky = 1,
				/obj/item/assembly/flash/handheld = 1,
				/obj/item/stack/cable_coil = 2,
				/obj/item/assembly/prox_sensor)
	blacklist = list(/obj/item/assembly/flash/handheld/strong)
	category = CAT_MISC

/datum/crafting_recipe/bonedagger
	name = "Bone Dagger"
	result = /obj/item/knife/combat/bone
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonespear
	name = "Bone Spear"
	result = /obj/item/spear/bonespear
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4,
				 /obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	dangerous_craft = TRUE

/datum/crafting_recipe/boneaxe
	name = "Bone Axe"
	result = /obj/item/fireaxe/boneaxe
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 6,
				 /obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL
	dangerous_craft = TRUE

/datum/crafting_recipe/bonfire
	name = "Bonfire"
	time = 60
	reqs = list(/obj/item/grown/log = 5)
	result = /obj/structure/bonfire
	category = CAT_PRIMAL

/datum/crafting_recipe/skeleton_key
	name = "Skeleton Key"
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 5)
	result = /obj/item/skeleton_key
	always_available = FALSE
	category = CAT_PRIMAL

/datum/crafting_recipe/headpike
	name = "Spike Head (Glass Spear)"
	time = 65
	reqs = list(/obj/item/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/spear = 1)
	blacklist = list(/obj/item/spear/explosive, /obj/item/spear/bonespear, /obj/item/spear/bamboospear)
	result = /obj/structure/headpike/glass
	category = CAT_PRIMAL
	dangerous_craft = TRUE

/datum/crafting_recipe/headpikebone
	name = "Spike Head (Bone Spear)"
	time = 65
	reqs = list(/obj/item/spear/bonespear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/spear/bonespear = 1)
	result = /obj/structure/headpike/bone
	category = CAT_PRIMAL
	dangerous_craft = TRUE

/datum/crafting_recipe/headpikebamboo
	name = "Spike Head (Bamboo Spear)"
	time = 65
	reqs = list(/obj/item/spear/bamboospear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/spear/bamboospear = 1)
	result = /obj/structure/headpike/bamboo
	category = CAT_PRIMAL
	dangerous_craft = TRUE

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/iron = 1,
				  /obj/item/stack/tile/iron = 1,
				  /obj/item/stack/cable_coil = 2,
				  /obj/item/assembly/igniter = 1)
	category = CAT_MISC


/datum/crafting_recipe/rcl
	name = "Makeshift Rapid Cable Layer"
	result = /obj/item/rcl/ghetto
	time = 40
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WRENCH)
	reqs = list(/obj/item/stack/sheet/iron = 15)
	category = CAT_MISC

/datum/crafting_recipe/mummy
	name = "Mummification Bandages (Mask)"
	result = /obj/item/clothing/mask/mummy
	time = 10
	tools = list(/obj/item/nullrod/egyptian)
	reqs = list(/obj/item/stack/sheet/cotton/cloth = 2)
	category = CAT_CLOTHING

/datum/crafting_recipe/mummy/body
	name = "Mummification Bandages (Body)"
	result = /obj/item/clothing/under/costume/mummy
	reqs = list(/obj/item/stack/sheet/cotton/cloth = 5)


/datum/crafting_recipe/chaplain_hood
	name = "Follower Hoodie"
	result = /obj/item/clothing/suit/hooded/chaplain_hoodie
	time = 10
	tools = list(/obj/item/clothing/suit/hooded/chaplain_hoodie, /obj/item/storage/book/bible)
	reqs = list(/obj/item/stack/sheet/cotton/cloth = 4)
	category = CAT_CLOTHING

/datum/crafting_recipe/aitater
	name = "intelliTater"
	result = /obj/item/aicard/aitater
	time = 30
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/aicard = 1,
					/obj/item/food/grown/potato = 1,
					/obj/item/stack/cable_coil = 5)
	category = CAT_MISC

/datum/crafting_recipe/aispook
	name = "intelliLantern"
	result = /obj/item/aicard/aispook
	time = 30
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/aicard = 1,
					/obj/item/food/grown/pumpkin = 1,
					/obj/item/stack/cable_coil = 5)
	category = CAT_MISC

/datum/crafting_recipe/ghettojetpack
	name = "Improvised Jetpack"
	result = /obj/item/tank/jetpack/improvised
	time = 30
	reqs = list(/obj/item/tank/internals/oxygen/red = 2, /obj/item/extinguisher = 1, /obj/item/pipe = 3, /obj/item/stack/cable_coil = 30)//red oxygen tank so it looks right
	category = CAT_MISC
	tools = list(TOOL_WRENCH, TOOL_WELDER, TOOL_WIRECUTTER)

/datum/crafting_recipe/multiduct
	name = "Multi-layer duct"
	result = /obj/machinery/duct/multilayered
	time = 5
	reqs = list(/obj/item/stack/ducts = 5)
	category = CAT_MISC
	tools = list(TOOL_WELDER)

/datum/crafting_recipe/upgraded_gauze
	name = "Improved Gauze"
	result = /obj/item/stack/medical/gauze/adv/one
	time = 1
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/space_cleaner/sterilizine = 10)
	category = CAT_MISC

/datum/crafting_recipe/bruise_pack
	name = "Bruise Pack"
	result = /obj/item/stack/medical/bruise_pack/one
	time = 1
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/medicine/styptic_powder = 20)
	category = CAT_MISC

/datum/crafting_recipe/burn_pack
	name = "Burn Ointment"
	result = /obj/item/stack/medical/ointment/one
	time = 1
	reqs = list(/obj/item/stack/medical/gauze = 1,
				/datum/reagent/medicine/silver_sulfadiazine = 20)
	category = CAT_MISC

// Shank - Makeshift weapon that can embed on throw
/datum/crafting_recipe/shank
	name = "Shank"
	reqs = list(/obj/item/shard = 1,
					/obj/item/stack/cable_coil = 10) // 1 glass shard + 10 cable; needs a wirecutter to snip the cable.
	result = /obj/item/knife/shank
	tools = list(TOOL_WIRECUTTER)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_available = TRUE
	dangerous_craft = TRUE

/datum/crafting_recipe/sharpmop
	name = "Sharpened Mop"
	result = /obj/item/mop/sharp
	time = 30
	reqs = list(/obj/item/mop = 1,
				/obj/item/shard = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	tools = list(TOOL_WIRECUTTER)
	dangerous_craft = TRUE

/datum/crafting_recipe/poppy_pin
	name = "Poppy Pin"
	result = /obj/item/clothing/accessory/poppy_pin
	time = 5
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/food/grown/flower/poppy = 1)
	category = CAT_MISC

/datum/crafting_recipe/poppy_pin_removal
	name = "Poppy Pin Removal"
	result = /obj/item/food/grown/flower/poppy
	time = 5
	reqs = list(/obj/item/clothing/accessory/poppy_pin = 1)

	category = CAT_MISC

/datum/crafting_recipe/insulated_boxing_gloves
	name = "Insulated Boxing Gloves"
	result = /obj/item/clothing/gloves/boxing/yellow/insulated
	time = 60
	reqs = list(/obj/item/clothing/gloves/boxing = 1,
				/obj/item/clothing/gloves/color/yellow = 1)

	category = CAT_CLOTHING

/datum/crafting_recipe/paper_cup
	name= "Paper Cup"
	result = /obj/item/reagent_containers/food/drinks/sillycup
	time = 10
	reqs = list(/obj/item/paper = 1)
	category = CAT_MISC
	tools = list(TOOL_WIRECUTTER)

/datum/crafting_recipe/paperslip
	name = "Paper Slip"
	result = /obj/item/card/id/paper
	time = 1 SECONDS
	reqs = list(/obj/item/paper  = 5)
	category = CAT_MISC
	tools = list(TOOL_WIRECUTTER)

/datum/crafting_recipe/basic_lasso
	name= "Basic Lasso"
	result = /obj/item/mob_lasso
	time = 20
	reqs = list(/obj/item/stack/sheet/leather = 5)
	category = CAT_MISC

/datum/crafting_recipe/primal_lasso
	name= "Primal Lasso"
	result = /obj/item/mob_lasso/primal
	always_available = FALSE
	time = 20
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 3,
				/obj/item/stack/sheet/sinew = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/dragon_lasso
	name = "Ash Drake Lasso"
	result = /obj/item/mob_lasso/drake
	always_available = FALSE
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 10,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/ashdrake = 5)
	category = CAT_PRIMAL

/datum/crafting_recipe/foldable
	name = "Foldable Chair"
	result = /obj/item/chair/foldable
	time = 40
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/sheet/plastic = 1
				)
	tools = list(TOOL_WRENCH, TOOL_WIRECUTTER)
	category = CAT_MISC

/datum/crafting_recipe/chair_fancy
	name = "Fancy Chair"
	result = /obj/item/chair/fancy
	time = 60
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/chair = 1
				)
	tools = list(TOOL_WRENCH, TOOL_WIRECUTTER)
	category = CAT_MISC

/datum/crafting_recipe/shutters
	name = "Shutters"
	reqs = list(/obj/item/stack/sheet/plasteel = 5,
				/obj/item/stack/cable_coil = 5,
				/obj/item/electronics/airlock = 1
				)
	result = /obj/machinery/door/poddoor/shutters/preopen
	tools = list(TOOL_SCREWDRIVER, TOOL_MULTITOOL, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 10 SECONDS
	category = CAT_STRUCTURE
	one_per_turf = TRUE

/datum/crafting_recipe/glassshutters
	name = "Windowed Shutters"
	reqs = list(/obj/item/stack/sheet/plasteel = 5,
				/obj/item/stack/sheet/rglass = 2,
				/obj/item/stack/cable_coil = 5,
				/obj/item/electronics/airlock = 1
				)
	result = /obj/machinery/door/poddoor/shutters/window/preopen
	tools = list(TOOL_SCREWDRIVER, TOOL_MULTITOOL, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 10 SECONDS
	category = CAT_STRUCTURE
	one_per_turf = TRUE

/datum/crafting_recipe/radshutters
	name = "Radiation Shutters"
	reqs = list(/obj/item/stack/sheet/plasteel = 5,
				/obj/item/stack/cable_coil = 5,
				/obj/item/electronics/airlock = 1,
				/obj/item/stack/sheet/mineral/uranium = 2
				)
	result = /obj/machinery/door/poddoor/shutters/radiation/preopen
	tools = list(TOOL_SCREWDRIVER, TOOL_MULTITOOL, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 10 SECONDS
	category = CAT_STRUCTURE
	one_per_turf = TRUE


/datum/crafting_recipe/blast_doors
	name = "Blast Door"
	reqs = list(/obj/item/stack/sheet/plasteel = 15,
				/obj/item/stack/cable_coil = 15,
				/obj/item/electronics/airlock = 1
				)
	result = /obj/machinery/door/poddoor/preopen
	tools = list(TOOL_SCREWDRIVER, TOOL_MULTITOOL, TOOL_WIRECUTTER, TOOL_WELDER)
	time = 30 SECONDS
	category = CAT_STRUCTURE
	one_per_turf = TRUE

/datum/crafting_recipe/showercurtain
	name = "Shower Curtains"
	reqs = 	list(/obj/item/stack/sheet/cotton/cloth = 2, /obj/item/stack/sheet/plastic = 2, /obj/item/stack/rods = 1)
	result = /obj/structure/curtain
	category = CAT_STRUCTURE

/datum/crafting_recipe/aquarium
	name = "Aquarium"
	result = /obj/structure/aquarium
	time = 10 SECONDS
	reqs = list(/obj/item/stack/sheet/iron = 15,
				/obj/item/stack/sheet/glass = 10,
				/obj/item/aquarium_kit = 1
				)
	category = CAT_STRUCTURE

/datum/crafting_recipe/guillotine
	name = "Guillotine"
	result = /obj/structure/guillotine
	time = 150 // Building a functioning guillotine takes time
	reqs = list(/obj/item/stack/sheet/plasteel = 3,
		        /obj/item/stack/sheet/wood = 20,
		        /obj/item/stack/cable_coil = 10)
	tools = list(TOOL_SCREWDRIVER, TOOL_WRENCH, TOOL_WELDER)
	category = CAT_STRUCTURE
	dangerous_craft = TRUE

/datum/crafting_recipe/mirror
	name = "Wall Mirror Frame"
	result = /obj/item/wallframe/mirror
	time = 15 SECONDS
	reqs = list(/obj/item/stack/sheet/mineral/silver = 1, /obj/item/stack/sheet/glass = 2)
	tools = list(TOOL_WRENCH)
	category = CAT_STRUCTURE

/datum/crafting_recipe/bouquet
	name = "mixed flower bouquet"
	result = /obj/item/bouquets/bouquet
	time = 15 SECONDS
	reqs = list(/obj/item/grown/sunflower = 2, /obj/item/food/grown/flower/lily = 2, /obj/item/paper = 2)
	category = CAT_MISC

/datum/crafting_recipe/sunflower_bouquet
	name = "sunflowers bouquet"
	result = /obj/item/bouquets/bouquet/sunflower
	time = 15 SECONDS
	reqs = list(/obj/item/grown/sunflower = 6, /obj/item/paper = 2)
	category = CAT_MISC

/datum/crafting_recipe/poppy_bouquet
	name = "poppys bouquet"
	result = /obj/item/bouquets/bouquet/poppy
	time = 15 SECONDS
	reqs = list(/obj/item/food/grown/flower/poppy = 2, /obj/item/paper = 2)
	category = CAT_MISC
