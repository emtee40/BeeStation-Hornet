/datum/job/janitor
	jkey = JOB_KEY_JANITOR
	jtitle = JOB_NAME_JANITOR
	job_bitflags = JOB_BITFLAG_SELECTABLE
	department_head = list(JOB_NAME_HEADOFPERSONNEL)
	faction = "station"
	total_positions = 2
	spawn_positions = 1
	selection_color = "#bbe291"

	outfit = /datum/outfit/job/janitor

	access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)

	departments = DEPT_BITFLAG_SRV
	bank_account_department = ACCOUNT_SRV_BITFLAG
	payment_per_department = list(ACCOUNT_SRV_ID = PAYCHECK_EASY)

	display_order = JOB_DISPLAY_ORDER_JANITOR
	rpg_title = "Groundskeeper"
	biohazard = 40//cleaning up hazardous messes puts janitors at extra risk

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/janitor
	)

/datum/outfit/job/janitor
	name = JOB_KEY_JANITOR
	jobtype = /datum/job/janitor

	id = /obj/item/card/id/job/janitor
	belt = /obj/item/modular_computer/tablet/pda/janitor
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/janitor

/datum/outfit/job/janitor/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(GARBAGEDAY in SSevents.holidays)
		l_pocket = /obj/item/gun/ballistic/revolver
		r_pocket = /obj/item/ammo_box/a357
