/*
 * Contains:
 *		Lasertag
 *		Costume
 *		Misc
 */

/*
 * Lasertag
 */
/obj/item/clothing/suit/bluetag
	name = "blue laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to red light." //Lasers are concentrated light
	icon_state = "bluetag"
	item_state = "bluetag"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/bluetag)
	resistance_flags = NONE

/obj/item/clothing/suit/redtag
	name = "red laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to blue light."
	icon_state = "redtag"
	item_state = "redtag"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	allowed = list (/obj/item/gun/energy/laser/redtag)
	resistance_flags = NONE

// Aristocrat Coats

/obj/item/clothing/suit/aristo_orange
	name = "orange aristocrat coat"
	desc = "A fancy coat made of silk. This one is orange."
	icon_state = "aristo_orange"
	item_state = "aristo_orange"

/obj/item/clothing/suit/aristo_red
	name = "red aristocrat coat"
	desc = "A fancy coat made of silk. This one is red."
	icon_state = "aristo_red"
	item_state = "aristo_red"

/obj/item/clothing/suit/aristo_brown
	name = "brown aristocrat coat"
	desc = "A fancy coat made of silk. This one is brown."
	icon_state = "aristo_brown"
	item_state = "aristo_brown"

/obj/item/clothing/suit/aristo_blue
	name = "blue aristocrat coat"
	desc = "A fancy coat made of silk. This one is blue."
	icon_state = "aristo_blue"
	item_state = "aristo_blue"

/////////////////
//DONATOR ITEMS//
/////////////////

/obj/item/clothing/suit/delinquent
	name = "deliquent jacket"
	desc = "Yare yare daze."
	icon_state = "jocoat"

/obj/item/clothing/suit/madsci
	name = "mad scientist labcoat"
	desc = "El psy congroo."
	icon_state = "madsci"

/obj/item/clothing/suit/hooded/renault_costume
	name = "renault costume"
	desc = "The cutest pair of pajamas you've ever seen."
	icon_state = "renault_suit"
	hoodtype = /obj/item/clothing/head/hooded/renault_hood

/obj/item/clothing/head/hooded/renault_hood
	name = "renault hoodie"
	desc = "An adorable hoodie vaguely resembling renault."
	icon_state = "renault_hoodie"
	flags_inv = HIDEEARS

/obj/item/clothing/suit/retro_jacket
	name = "retro jacket"
	desc = "Do you like hurting other people?"
	icon_state = "retro_jacket"

/*
 * Misc
 */

/obj/item/clothing/suit/straight_jacket
	name = "straight jacket"
	desc = "A suit that completely restrains the wearer. Manufactured by Antyphun Corp." //Straight jacket is antifun
	icon_state = "straight_jacket"
	item_state = "straight_jacket"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	equip_delay_self = 50
	strip_delay = 60
	breakouttime = 3000
	pocket_storage_component_path = FALSE

/obj/item/clothing/suit/ianshirt
	name = "worn shirt"
	desc = "A worn out, curiously comfortable t-shirt with a picture of Ian. You wouldn't go so far as to say it feels like being hugged when you wear it, but it's pretty close. Good for sleeping in."
	icon_state = "ianshirt"
	item_state = "ianshirt"

/obj/item/clothing/suit/nerdshirt
	name = "gamer shirt"
	desc = "A baggy shirt with vintage game character Phanic the Weasel. Why would anyone wear this?"
	icon_state = "nerdshirt"
	item_state = "nerdshirt"

/obj/item/clothing/suit/vapeshirt //wearing this is asking to get beat.
	name = "Vape Naysh shirt"
	desc = "A cheap white T-shirt with a big tacky \"VN\" on the front, Why would you wear this unironically?"
	icon_state = "vapeshirt"
	item_state = "vapeshirt"

/obj/item/clothing/suit/striped_sweater
	name = "striped sweater"
	desc = "Reminds you of someone, but you just can't put your finger on it..."
	icon_state = "waldo_shirt"
	item_state = "waldo_shirt"

/obj/item/clothing/suit/dracula
	name = "dracula coat"
	desc = "Looks like this belongs in a very old movie set."
	icon_state = "draculacoat"
	item_state = "draculacoat"

/obj/item/clothing/suit/drfreeze_coat
	name = "doctor freeze's labcoat"
	desc = "A labcoat imbued with the power of features and freezes."
	icon_state = "drfreeze_coat"
	item_state = "drfreeze_coat"

/obj/item/clothing/suit/gothcoat
	name = "gothic coat"
	desc = "Perfect for those who want stalk in a corner of a bar."
	icon_state = "gothcoat"
	item_state = "gothcoat"

/obj/item/clothing/suit/xenos
	name = "xenos suit"
	desc = "A suit made out of chitinous alien hide."
	icon_state = "xenos"
	item_state = "xenos_helm"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	allowed = list(/obj/item/clothing/mask/facehugger/toy)

/obj/item/clothing/suit/nemes
	name = "pharoah tunic"
	desc = "Lavish space tomb not included."
	icon_state = "pharoah"
	icon_state = "pharoah"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/caution
	name = "wet floor sign"
	desc = "Caution! Wet Floor!"
	icon_state = "caution"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	custom_price = 10
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN
	attack_verb = list("warned", "cautioned", "smashed")
	armor = list(MELEE = 5,  BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0, STAMINA = 0)
	pocket_storage_component_path = null

/obj/item/clothing/suit/spookyghost
	name = "spooky ghost"
	desc = "This is obviously just a bedsheet, but maybe try it on?"
	icon_state = "bedsheet"
	user_vars_to_edit = list("name" = "Spooky Ghost", "real_name" = "Spooky Ghost" , "incorporeal_move" = INCORPOREAL_MOVE_BASIC, "appearance_flags" = KEEP_TOGETHER|TILE_BOUND, "alpha" = 150)
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //so the bedsheet goes over everything but fire

/obj/item/clothing/suit/bronze
	name = "bronze suit"
	desc = "A big and clanky suit made of bronze that offers no protection and looks very unfashionable. Nice."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_cuirass_old"
	armor = list(MELEE = 5,  BULLET = 0, LASER = -5, ENERGY = 0, BOMB = 10, BIO = 0, RAD = 0, FIRE = 20, ACID = 20, STAMINA = 30)

/obj/item/clothing/suit/ghost_sheet
	name = "ghost sheet"
	desc = "The hands float by themselves, so it's extra spooky."
	icon_state = "ghost_sheet"
	item_state = "ghost_sheet"
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = UNDER_HEAD_LAYER

/obj/item/clothing/under/costume/joker
	name = "comedian suit"
	desc = "The worst part of having a mental illness is people expect you to behave as if you don't."
	icon_state = "joker"
	item_state = "joker"
	can_adjust = FALSE

/obj/item/clothing/suit/joker
	name = "comedian coat"
	desc = "I mean, don't you have to be funny to be a comedian?"
	icon_state = "joker_coat"
	item_state = "joker_coat"

/obj/item/clothing/suit/toggle/softshell
	name = "softshell jacket"
	desc = "A Nanotrasen-branded softshell jacket."
	icon_state = "softshell"
	item_state = "softshell"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/radio)
	armor = list(MELEE = 0,  BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 30, RAD = 0, FIRE = 0, ACID = 0, STAMINA = 0)
	togglename = "zipper"
	body_parts_covered = CHEST|GROIN|ARMS

//extra hoodies!

/obj/item/clothing/suit/hooded/hoodie
	name = "white hoodie"
	desc = "A casual hoodie to keep you warm and comfy."
	icon_state = "hoodie"
	item_state = "hoodie"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list(MELEE = 0,  BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0, STAMINA = 0)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	hoodtype = /obj/item/clothing/head/hooded/hoodie

/obj/item/clothing/head/hooded/hoodie
	name = "white hoodie hood"
	desc = "A hood attached to your hoodie, simple as."
	icon_state = "hoodie"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/hoodie/blue
	name = "blue hoodie"
	color = "#52aecc"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/blue

/obj/item/clothing/head/hooded/hoodie/blue
	name = "blue hoodie hood"
	color = "#52aecc"

/obj/item/clothing/suit/hooded/hoodie/green
	name = "green hoodie"
	color = "#9ed63a"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/green

/obj/item/clothing/head/hooded/hoodie/green
	name = "green hoodie hood"
	color = "#9ed63a"

/obj/item/clothing/suit/hooded/hoodie/orange
	name = "orange hoodie"
	color = "#ff8c19"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/orange

/obj/item/clothing/head/hooded/hoodie/orange
	name = "orange hoodie hood"
	color = "#ff8c19"

/obj/item/clothing/suit/hooded/hoodie/pink
	name = "pink hoodie"
	desc = "<i>fabulous</i> feels."
	color = "#ffa69b"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/pink

/obj/item/clothing/head/hooded/hoodie/pink
	name = "pink hoodie hood"
	color = "#ffa69b"

/obj/item/clothing/suit/hooded/hoodie/red
	name = "red hoodie"
	color = "#c42822"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/red

/obj/item/clothing/head/hooded/hoodie/red
	name = "red hoodie hood"
	color = "#c42822"

/obj/item/clothing/suit/hooded/hoodie/black
	name = "black hoodie"
	color = "#2e2e2e"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/black

/obj/item/clothing/head/hooded/hoodie/black
	name = "black hoodie hood"
	color = "#2e2e2e"

/obj/item/clothing/suit/hooded/hoodie/yellow
	name = "yellow hoodie"
	color = "#ffe14d"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/yellow

/obj/item/clothing/head/hooded/hoodie/yellow
	name = "yellow hoodie hood"
	color = "#ffe14d"

/obj/item/clothing/suit/hooded/hoodie/darkblue
	name = "dark blue hoodie"
	color = "#3285ba"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/darkblue

/obj/item/clothing/head/hooded/hoodie/darkblue
	name = "dark blue hoodie hood"
	color = "#3285ba"

/obj/item/clothing/suit/hooded/hoodie/teal
	name = "teal hoodie"
	color = "#77f3b7"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/teal

/obj/item/clothing/head/hooded/hoodie/teal
	name = "teal hoodie hood"
	color = "#77f3b7"

/obj/item/clothing/suit/hooded/hoodie/purple
	name = "purple hoodie"
	color = "#73479c"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/purple

/obj/item/clothing/head/hooded/hoodie/purple
	name = "purple hoodie hood"
	color = "#73479c"

/obj/item/clothing/suit/hooded/hoodie/brown
	name = "brown hoodie"
	color = "#a17229"
	hoodtype = /obj/item/clothing/head/hooded/hoodie/brown

/obj/item/clothing/head/hooded/hoodie/brown
	name = "brown hoodie"
	color = "#a17229"

/obj/item/clothing/suit/hooded/hoodie/durathread
	name = "durathread hoodie"
	desc = "A hoodie made from durathread, its resilient fibres provide some protection to the wearer."
	color = "#8291a1"
	armor = list(MELEE = 15, BULLET = 25, LASER = 10, FIRE = 40, ACID = 10, BOMB = 5, STAMINA = 30)
	hoodtype = /obj/item/clothing/head/hooded/hoodie/durathread

/obj/item/clothing/head/hooded/hoodie/durathread
	name = "durathread hoodie hood"
	desc = "A duratread hood attached to your hoodie, robust as."
	armor = list(MELEE = 5, BULLET = 5, LASER = 5, FIRE = 20, ACID = 5, BOMB = 5, STAMINA = 15)
	color = "#8291a1"
