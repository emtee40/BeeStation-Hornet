/datum/job/bartender
	title = JOB_BARTENDER
	flag = BARTENDER
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#bbe291"
	chat_color = "#B2CEB3"
	exp_type_department = EXP_TYPE_SERVICE // This is so the jobs menu can work properly

	outfit = /datum/outfit/job/bartender

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_BARTENDER
	departments = DEPARTMENT_BITFLAG_SERVICE
	rpg_title = "Tavernkeeper"

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/bar
	)
/datum/outfit/job/bartender
	name = JOB_BARTENDER
	jobtype = /datum/job/bartender

	id = /obj/item/card/id/job/bartender
	glasses = /obj/item/clothing/glasses/sunglasses/advanced/reagent
	belt = /obj/item/pda/bar
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/bartender
	suit = /obj/item/clothing/suit/armor/vest
	backpack_contents = list(/obj/item/storage/box/beanbag=1)
	shoes = /obj/item/clothing/shoes/laceup

