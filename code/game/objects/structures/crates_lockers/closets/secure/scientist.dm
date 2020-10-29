/obj/structure/closet/secure_closet/RD
	name = "\proper research director's locker"
	req_access = list(ACCESS_RD)
	icon_state = "rd"

/obj/structure/closet/secure_closet/RD/PopulateContents()
	..()
	new /obj/item/clothing/head/beret/sci(src)
	new /obj/item/clothing/neck/cloak/rd(src)
	new /obj/item/clothing/suit/bio_suit/scientist(src)
	new /obj/item/clothing/head/bio_hood/scientist(src)
	new /obj/item/clothing/suit/toggle/labcoat/rd(src)
	new /obj/item/clothing/under/rank/rnd/research_director(src)
	new /obj/item/clothing/under/rank/rnd/research_director/alt(src)
	new /obj/item/clothing/under/rank/rnd/research_director/hazard(src)
	new /obj/item/clothing/under/rank/rnd/research_director/turtleneck(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/cartridge/rd(src)
	new /obj/item/clothing/gloves/color/latex(src)
	new /obj/item/radio/headset/heads/rd(src)
	new /obj/item/tank/internals/air(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/megaphone/command(src)
	new /obj/item/storage/lockbox/medal/sci(src)
	new /obj/item/clothing/suit/armor/reactive/teleport(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/laser_pointer(src)
	new /obj/item/door_remote/research_director(src)
	new /obj/item/circuitboard/machine/techfab/department/science(src)
	new /obj/item/storage/photo_album/RD(src)
	new /obj/item/card/id/departmental_budget/sci(src)

/obj/structure/closet/secure_closet/gateway
	name = "\proper away team locker"
	req_access = list(ACCESS_GATEWAY)
	icon_state = "rd" // Placeholder

/obj/structure/closet/secure_closet/gateway/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/vest/light(src)
	new /obj/item/pinpointer/pinpointer_gateway(src)
	new /obj/item/gun/ballistic/revolver/pocket(src)
	new /obj/item/ammo_box/rpocket(src)
	new /obj/item/ammo_box/rpocket(src)
	new /obj/item/ammo_box/rpocket(src)

/obj/structure/closet/secure_closet/gatewayweapons
	name = "\proper away team secure firearms locker"
	req_access = list(ACCESS_RD)
	icon_state = "rd"

/obj/structure/closet/secure_closet/gatewayweapons/PopulateContents()
	..()
	for(var/i in 1 to 3)
	new /obj/item/gun/ballistic/automatic/striker(src)
	new /obj/item/ammo_box/magazine/striker(src)
	new /obj/item/ammo_box/magazine/striker(src)