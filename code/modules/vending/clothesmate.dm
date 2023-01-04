//DON'T FORGET TO CHANGE THE REFILL SIZE IF YOU CHANGE THE MACHINE'S CONTENTS!
/obj/machinery/vending/clothing
	name = "ClothesMate"
	desc = "A vending machine for clothing."
	icon_state = "clothes"
	icon_deny = "clothes-deny"
	product_slogans = "Dress for success!;Prepare to look swagalicious!;Look at all this swag!;Why leave style up to fate? Use the ClothesMate!"
	vend_reply = "Thank you for using the ClothesMate!"
	light_color = LIGHT_COLOR_GREEN
	product_categories = list(
		list(
					"name" = "Head",
					"icon" = "hat-cowboy",
					"products" = list(
						/obj/item/clothing/head/beanie = 10,
						/obj/item/clothing/head/beanie/black = 10,
						/obj/item/clothing/head/beanie/striped = 10,
						/obj/item/clothing/head/rasta = 3,
						/obj/item/clothing/head/kippah = 3,
						/obj/item/clothing/head/taqiyahred = 3,
						/obj/item/clothing/head/that = 1,
						/obj/item/clothing/head/fedora = 1,
						/obj/item/clothing/head/sombrero = 1,
						/obj/item/clothing/head/wig/natural  = 4,
					),
			),

			list(
					"name" = "Accessories",
					"icon" = "glasses",
					"products" = list(
						/obj/item/clothing/glasses/sunglasses = 2,
						/obj/item/clothing/glasses/regular = 2,
		            	/obj/item/clothing/glasses/regular/jamjar = 1,
						/obj/item/clothing/glasses/orange = 1,
		            	/obj/item/clothing/glasses/red = 1,
						/obj/item/clothing/gloves/fingerless = 2,
		            	/obj/item/clothing/neck/scarf/ = 10,
						/obj/item/clothing/neck/large_scarf = 10,
						/obj/item/clothing/neck/tie/ = 10,
						/obj/item/clothing/neck/tie/horrible = 3,
						/obj/item/storage/belt/fannypack = 3,
		            	/obj/item/storage/belt/fannypack/blue = 3,
		            	/obj/item/storage/belt/fannypack/red = 3,
						/obj/item/clothing/ears/headphones = 2,
						/obj/item/clothing/accessory/waistcoat = 1,
						/obj/item/clothing/glasses/monocle = 1,
					),
			),

			list(
					"name" = "Under",
					"icon" = "shirt",
					"products" = list(
						/obj/item/clothing/under/misc/overalls = 2,
						/obj/item/clothing/under/pants/jeans = 2,
						/obj/item/clothing/under/pants/camo = 2,
						/obj/item/clothing/under/pants/track = 2,
						/obj/item/clothing/under/rank/civilian/bartender/purple = 2,
					),
			),

			list(
					"name" = "Suits & Skirts",
					"icon" = "vest",
					"products" = list(
						/obj/item/clothing/under/dress/skirt/plaid = 2,
						/obj/item/clothing/under/dress/skirt = 2,
						/obj/item/clothing/under/suit/navy = 1,
						/obj/item/clothing/under/suit/black_really = 1,
		           	 	/obj/item/clothing/under/suit/burgundy = 1,
		           	 	/obj/item/clothing/under/suit/charcoal = 1,
		           	 	/obj/item/clothing/under/suit/white = 1,
		            	/obj/item/clothing/under/suit/sl = 1,
						/obj/item/clothing/suit/jacket = 2,
		            	/obj/item/clothing/suit/jacket/puffer/vest = 2,
		            	/obj/item/clothing/suit/jacket/puffer = 2,
						/obj/item/clothing/suit/toggle/softshell = 2,
		            	/obj/item/clothing/suit/jacket/letterman = 2,
		            	/obj/item/clothing/suit/jacket/letterman_red = 2,
						/obj/item/clothing/suit/ianshirt = 1,
						/obj/item/clothing/suit/hooded/wintercoat/old = 3,
						/obj/item/clothing/suit/jacket/miljacket = 1,
		            	/obj/item/clothing/suit/apron/purple_bartender = 2,
						/obj/item/clothing/suit/hooded/hoodie = 3,
						/obj/item/clothing/suit/hooded/hoodie/blue = 3,
						/obj/item/clothing/suit/hooded/hoodie/green = 3,
						/obj/item/clothing/suit/hooded/hoodie/orange = 3,
						/obj/item/clothing/suit/hooded/hoodie/pink = 3,
						/obj/item/clothing/suit/hooded/hoodie/red = 3,
						/obj/item/clothing/suit/hooded/hoodie/black = 3,
						/obj/item/clothing/suit/hooded/hoodie/yellow = 3,
						/obj/item/clothing/suit/hooded/hoodie/darkblue = 3,
						/obj/item/clothing/suit/hooded/hoodie/teal = 3,
						/obj/item/clothing/suit/hooded/hoodie/purple = 3,
						),
			),

			list(
					"name" = "Shoes",
					"icon" = "socks",
					"products" = list(
						/obj/item/clothing/shoes/sneakers/black = 4,
						/obj/item/clothing/shoes/laceup = 2,
		            	/obj/item/clothing/shoes/sandal = 2,
					),
			),

			list(
					"name" = "Special",
					"icon" = "star",
					"products" = list(
						/obj/item/clothing/suit/poncho = 1,
		            	/obj/item/clothing/under/costume/kilt = 1,
		            	/obj/item/clothing/under/dress/sundress = 1,
		            	/obj/item/clothing/under/dress/striped = 1,
		            	/obj/item/clothing/under/dress/sailor = 1,
		            	/obj/item/clothing/under/dress/redeveninggown = 1,
						),
			),
	)




	contraband = list(/obj/item/clothing/under/syndicate/tacticool = 1,
		              /obj/item/clothing/mask/balaclava = 1,
		              /obj/item/clothing/head/ushanka = 1,
		              /obj/item/clothing/under/costume/soviet = 1,
		              /obj/item/storage/belt/fannypack/black = 2,
		              /obj/item/clothing/suit/jacket/letterman_syndie = 1,
		              /obj/item/clothing/under/costume/jabroni = 1,
		              /obj/item/clothing/suit/vapeshirt = 1,
		              /obj/item/clothing/under/costume/geisha = 1)
	premium = list(/obj/item/clothing/under/suit/checkered = 1,
		           /obj/item/clothing/suit/jacket/leather = 1,
		           /obj/item/clothing/suit/jacket/leather/overcoat = 1,
		           /obj/item/clothing/neck/necklace/dope = 3,
		           /obj/item/clothing/suit/jacket/letterman_nanotrasen = 1)
	refill_canister = /obj/item/vending_refill/clothing
	default_price = 40
	extra_price = 60
	dept_req_for_free = NO_FREEBIES

/obj/item/vending_refill/clothing
	machine_name = "ClothesMate"
	icon_state = "refill_clothes"
