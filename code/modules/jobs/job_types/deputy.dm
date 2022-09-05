/datum/job/deputy
	title = JOB_NAME_DEPUTY
	flag = DEPUTY
	department_head = list(JOB_NAME_HEADOFSECURITY)
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "the head of security"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 180
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/deputy

	access = list(ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_WEAPONS)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_WEAPONS)
	paycheck = PAYCHECK_EASY
	bank_account_department = ACCOUNT_SEC_FLAG
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_DEPUTY  //see code/__DEFINES/jobs.dm
	departments = DEPARTMENT_BITFLAG_SECURITY

/datum/outfit/job/deputy
	name = JOB_NAME_DEPUTY
	jobtype = /datum/job/deputy

	id = /obj/item/card/id/job/deputy
	belt = /obj/item/storage/belt/security/deputy
	ears = /obj/item/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/rank/security/officer/mallcop/deputy
	accessory = /obj/item/clothing/accessory/armband/deputy
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/hud/security/deputy
	head = /obj/item/clothing/head/soft/sec
	l_pocket = /obj/item/pda/deputy

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/survival

/obj/item/card/id/pass/deputy
	name = "deputy promotion card"
	desc = "A small card, that when used on an ID, will grant basic security access, and the job title of 'Deputy.'"
	assignment = JOB_NAME_DEPUTY
	access = list(ACCESS_SEC_DOORS, ACCESS_MAINT_TUNNELS, ACCESS_COURT, ACCESS_BRIG, ACCESS_WEAPONS)
