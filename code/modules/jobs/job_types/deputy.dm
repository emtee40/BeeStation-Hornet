/datum/job/deputy
	title = "Deputy"
	flag = DEPUTY
	department_head = list("Head of Security")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/deputy

	access = list(ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_WEAPONS)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_WEAPONS)
    paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SEC
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_DEPUTY

/datum/outfit/job/deputy
	name = "Deputy"
	jobtype = /datum/job/deputy

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/rank/security/mallcop
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/hud/security/deputy
	suit = /obj/item/clothing/suit/hazardvest/deputy
	suit_store = /obj/item/flashlight/seclite
	head = /obj/item/clothing/head/beret/sec/deputy

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
