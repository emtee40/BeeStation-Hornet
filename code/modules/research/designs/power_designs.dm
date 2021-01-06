////////////////////////////////////////
//////////////////Power/////////////////
////////////////////////////////////////

/datum/design/basic_cell
	name = "Basic Power Cell"
	desc = "A basic power cell that holds 1 MJ of energy."
	id = "basic_cell"
	build_type = PROTOLATHE | AUTOLATHE |MECHFAB
	materials = list(/datum/material/iron = 700, /datum/material/glass = 50, /datum/material/copper = 100)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/empty
	category = list("Misc","Power Designs","Machinery","initial")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/high_cell
	name = "High-Capacity Power Cell"
	desc = "A power cell that holds 10 MJ of energy."
	id = "high_cell"
	build_type = PROTOLATHE | AUTOLATHE | MECHFAB
	materials = list(/datum/material/iron = 700, /datum/material/glass = 60, /datum/material/copper = 100)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/high/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/super_cell
	name = "Super-Capacity Power Cell"
	desc = "A power cell that holds 20 MJ of energy."
	id = "super_cell"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/iron = 700, /datum/material/glass = 70, /datum/material/copper = 100)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/super/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/hyper_cell
	name = "Hyper-Capacity Power Cell"
	desc = "A power cell that holds 30 MJ of energy."
	id = "hyper_cell"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/iron = 700, /datum/material/gold = 150, /datum/material/silver = 150, /datum/material/glass = 80, /datum/material/copper = 100)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/hyper/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/bluespace_cell
	name = "Bluespace Power Cell"
	desc = "A power cell that holds 40 MJ of energy."
	id = "bluespace_cell"
	build_type = PROTOLATHE | MECHFAB
	materials = list(/datum/material/iron = 800, /datum/material/gold = 120, /datum/material/glass = 160, /datum/material/diamond = 160, /datum/material/titanium = 300, /datum/material/bluespace = 100, /datum/material/copper = 100)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/bluespace/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/gun_cell
	name = "Weapon Power Cell"
	desc = "A a reinforced cell capable of releaseing short, high intensity electricity bursts without exploding."
	id = "gun_cell"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/glass = 70)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell/mini
	name = "compact Weapon Power Cell"
	desc = "A a reinforced cell capable of releaseing short, high intensity electricity bursts without exploding."
	id = "gun_cell_m"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 40)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/mini/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell/super
	name = "improved Weapon Power Cell"
	desc = "A improved weapon power cell, with larger capacity and higher charge rate."
	id = "gun_cell_u"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/plasma = 300, /datum/material/glass = 80)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/super/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell/hicap
	name = "high capacity Weapon Power Cell"
	desc = "A weapon power cell that can hold large amounts of electricity, but charges at a slower rate."
	id = "gun_cell_h"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/uranium = 150, /datum/material/glass = 80)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/hicap/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell/frec
	name = "fast recharge Weapon Power Cell"
	desc = "A weapon power cell that can charge faster, but cannot store as much energy."
	id = "gun_cell_r"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/gold = 150, /datum/material/glass = 80)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/hicap/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell/atec
	name = "fast recharge Weapon Power Cell"
	desc = "A weapon power cell that can charge faster, but cannot store as much energy."
	id = "gun_cell_atec"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/gold = 150, /datum/material/glass = 80)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/hicap/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/gun_cell/atec_mini
	name = "fast recharge Weapon Power Cell"
	desc = "A weapon power cell that can charge faster, but cannot store as much energy."
	id = "gun_cell_atec_mini"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/gold = 150, /datum/material/glass = 80)
	construction_time=100
	build_path = /obj/item/stock_parts/cell/gun/hicap/empty
	category = list("Misc","Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/light_replacer
	name = "Light Replacer"
	desc = "A device to automatically replace lights. Refill with working light bulbs."
	id = "light_replacer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1500, /datum/material/silver = 150, /datum/material/glass = 3000)
	build_path = /obj/item/lightreplacer
	category = list("Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/inducer
	name = "Inducer"
	desc = "The NT-75 Electromagnetic Power Inducer can wirelessly induce electric charge in an object, allowing you to recharge power cells without having to remove them."
	id = "inducer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 1000, /datum/material/copper = 100)
	build_path = /obj/item/inducer/sci
	category = list("Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/pacman
	name = "Machine Design (PACMAN-type Generator Board)"
	desc = "The circuit board that for a PACMAN-type portable generator."
	id = "pacman"
	build_path = /obj/item/circuitboard/machine/pacman
	category = list("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/pacman/super
	name = "Machine Design (SUPERPACMAN-type Generator Board)"
	desc = "The circuit board that for a SUPERPACMAN-type portable generator."
	id = "superpacman"
	build_path = /obj/item/circuitboard/machine/pacman/super
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/pacman/mrs
	name = "Machine Design (MRSPACMAN-type Generator Board)"
	desc = "The circuit board that for a MRSPACMAN-type portable generator."
	id = "mrspacman"
	build_path = /obj/item/circuitboard/machine/pacman/mrs
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING
