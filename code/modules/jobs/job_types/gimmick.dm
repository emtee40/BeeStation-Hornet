/datum/job/gimmick //gimmick var must be set to true for all gimmick jobs BUT the parent
	title = JOB_GIMMICK
	flag = GIMMICK
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "no one"
	selection_color = "#dddddd"
	chat_color = "#FFFFFF"

	exp_type_department = EXP_TYPE_GIMMICK

	access = list(ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_MAINT_TUNNELS)
	paycheck = PAYCHECK_ASSISTANT
	paycheck_department = ACCOUNT_CIV

	display_order = JOB_DISPLAY_ORDER_ASSISTANT
	departments = DEPARTMENT_BITFLAG_SERVICE
	rpg_title = "Peasant"

	allow_bureaucratic_error = FALSE
	outfit = /datum/outfit/job/gimmick

/datum/outfit/job/gimmick
	can_be_admin_equipped = FALSE // we want just the parent outfit to be unequippable since this leads to problems

/datum/job/gimmick/barber
	title = JOB_BARBER
	flag = BARBER
	outfit = /datum/outfit/job/gimmick/barber
	access = list(ACCESS_MORGUE, ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_MORGUE, ACCESS_MAINT_TUNNELS)
	gimmick = TRUE
	chat_color = "#bd9e86"

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman
	)

/datum/outfit/job/gimmick/barber
	name = JOB_BARBER
	jobtype = /datum/job/gimmick/barber

	id = /obj/item/card/id/job/barber
	belt = /obj/item/pda/unlicensed
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/suit/sl
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/storage/wallet
	l_pocket = /obj/item/razor/straightrazor
	can_be_admin_equipped = TRUE

/datum/job/gimmick/stage_magician
	title = JOB_STAGE_MAGICIAN
	flag = MAGICIAN
	outfit = /datum/outfit/job/gimmick/stage_magician
	access = list(ACCESS_THEATRE, ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_THEATRE, ACCESS_MAINT_TUNNELS)
	gimmick = TRUE
	chat_color = "#b898b3"
	paycheck_department = ACCOUNT_SRV

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/magic
	)

/datum/outfit/job/gimmick/stage_magician
	name = JOB_STAGE_MAGICIAN
	jobtype = /datum/job/gimmick/stage_magician

	id = /obj/item/card/id/job/stage_magician
	belt = /obj/item/pda/unlicensed
	head = /obj/item/clothing/head/that
	ears = /obj/item/radio/headset
	neck = /obj/item/bedsheet/magician
	uniform = /obj/item/clothing/under/suit/black_really
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/color/white
	l_hand = /obj/item/cane
	backpack_contents = list(/obj/item/choice_beacon/magic=1)
	can_be_admin_equipped = TRUE

/datum/job/gimmick/psychiatrist
	title = JOB_PSYCHIATRIST
	flag = SHRINK
	outfit = /datum/outfit/job/gimmick/psychiatrist
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MEDICAL)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MEDICAL)
	paycheck = PAYCHECK_EASY
	gimmick = TRUE
	chat_color = "#a2dfdc"
	departments = DEPARTMENT_BITFLAG_MEDICAL
	paycheck_department = ACCOUNT_MED

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman
	)

/datum/outfit/job/gimmick/psychiatrist //psychiatrist doesnt get much shit, but he has more access and a cushier paycheck
	name = JOB_PSYCHIATRIST
	jobtype = /datum/job/gimmick/psychiatrist

	id = /obj/item/card/id/job/psychiatrist
	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(/obj/item/choice_beacon/pet/ems=1)
	can_be_admin_equipped = TRUE

/datum/job/gimmick/vip
	title = JOB_VIP
	flag = CELEBRITY
	outfit = /datum/outfit/job/gimmick/vip
	access = list(ACCESS_MAINT_TUNNELS) //Assistants with shitloads of money, what could go wrong?
	minimal_access = list(ACCESS_MAINT_TUNNELS)
	gimmick = TRUE
	paycheck = PAYCHECK_VIP //our power is being fucking rich
	chat_color = "#ebc96b"

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/vip
	)

/datum/outfit/job/gimmick/vip
	name = JOB_VIP
	jobtype = /datum/job/gimmick/vip

	id = /obj/item/card/id/gold/vip
	belt = /obj/item/pda/vip
	glasses = /obj/item/clothing/glasses/sunglasses/advanced
	ears = /obj/item/radio/headset/heads //VIP can talk loud for no reason
	uniform = /obj/item/clothing/under/suit/black_really
	shoes = /obj/item/clothing/shoes/laceup
	can_be_admin_equipped = TRUE
