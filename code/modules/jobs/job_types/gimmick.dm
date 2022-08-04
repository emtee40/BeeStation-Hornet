/datum/job/gimmick //gimmick var must be set to true for all gimmick jobs BUT the parent
	title = JOB_NAME_GIMMICK
	flag = GIMMICK
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "no one"
	selection_color = "#dddddd"

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
	title = JOB_NAME_BARBER
	flag = BARBER
	supervisors = "the head of personnel"
	department_head = list(JOB_NAME_HEADOFPERSONNEL)
	department_flag = CIVILIAN
	gimmick = TRUE

	outfit = /datum/outfit/job/gimmick/barber

	access = list(ACCESS_MORGUE, ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_MORGUE, ACCESS_MAINT_TUNNELS)
	paycheck = PAYCHECK_ASSISTANT
	paycheck_department = ACCOUNT_SRV

	departments = DEPARTMENT_BITFLAG_SERVICE
	rpg_title = "Scissorhands"

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman
	)

/datum/outfit/job/gimmick/barber
	name = JOB_NAME_BARBER
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
	title = JOB_NAME_STAGEMAGICIAN
	flag = MAGICIAN
	supervisors = "the head of personnel"
	department_head = list(JOB_NAME_HEADOFPERSONNEL)
	department_flag = CIVILIAN
	gimmick = TRUE

	outfit = /datum/outfit/job/gimmick/stage_magician

	access = list(ACCESS_THEATRE, ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_THEATRE, ACCESS_MAINT_TUNNELS)
	paycheck = PAYCHECK_MINIMAL
	paycheck_department = ACCOUNT_SRV

	departments = DEPARTMENT_BITFLAG_SERVICE
	rpg_title = "Master Illusionist"

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/magic
	)

/datum/outfit/job/gimmick/stage_magician
	name = JOB_NAME_STAGEMAGICIAN
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
	title = JOB_NAME_PSYCHIATRIST
	flag = PSYCHIATRIST
	supervisors = "the chief medical officer"
	department_head = list(JOB_NAME_CHIEFMEDICALOFFICER)
	department_flag = MEDSCI
	gimmick = TRUE

	outfit = /datum/outfit/job/gimmick/psychiatrist

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MEDICAL)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MEDICAL)
	paycheck = PAYCHECK_EASY
	departments = DEPARTMENT_BITFLAG_MEDICAL

	paycheck_department = ACCOUNT_MED
	rpg_title = "Enchanter"

	mind_traits = list(TRAIT_MADNESS_IMMUNE)

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman
	)

/datum/outfit/job/gimmick/psychiatrist //psychiatrist doesnt get much shit, but he has more access and a cushier paycheck
	name = JOB_NAME_PSYCHIATRIST
	jobtype = /datum/job/gimmick/psychiatrist

	id = /obj/item/card/id/job/psychiatrist
	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(/obj/item/choice_beacon/pet/ems=1)
	can_be_admin_equipped = TRUE

/datum/job/gimmick/vip
	title = JOB_NAME_VIP
	flag = CELEBRITY
	department_flag = CIVILIAN
	gimmick = TRUE

	outfit = /datum/outfit/job/gimmick/vip

	access = list(ACCESS_MAINT_TUNNELS) //Assistants with shitloads of money, what could go wrong?
	minimal_access = list(ACCESS_MAINT_TUNNELS)
	paycheck = PAYCHECK_VIP  //our power is being fucking rich
	paycheck_department = ACCOUNT_CIV

	departments = DEPARTMENT_BITFLAG_SERVICE // might need to be changed
	rpg_title = "Master of Patronage"

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/vip
	)

/datum/outfit/job/gimmick/vip
	name = JOB_NAME_VIP
	jobtype = /datum/job/gimmick/vip

	id = /obj/item/card/id/gold/vip
	belt = /obj/item/pda/vip
	glasses = /obj/item/clothing/glasses/sunglasses/advanced
	ears = /obj/item/radio/headset/heads //VIP can talk loud for no reason
	uniform = /obj/item/clothing/under/suit/black_really
	shoes = /obj/item/clothing/shoes/laceup
	can_be_admin_equipped = TRUE

/datum/job/gimmick/experiment
	title = "Experiment"
	flag = EXPERIMENT
	supervisors = "the research director"
	department_head = list("Research Director")
	department_flag = SCIENTIST
	gimmick = TRUE

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH, ACCESS_TOX)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH, ACCESS_TOX)
	paycheck = PAYCHECK_EASY
	departments = DEPARTMENT_BITFLAG_SCIENCE

	paycheck_department = ACCOUNT_SCI
	rpg_title = "Beastman"

	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON

/datum/job/gimmick/experiment/equip(mob/living/carbon/human/H, visualsOnly, announce, latejoin, datum/outfit/outfit_override, client/preference_source)
	if(visualsOnly)
		CRASH("dynamic preview is unsupported")
	//Make the monkey
	var/mob/living/carbon/monkey/K = H.monkeyize(skip_animation = TRUE)
	K.real_name = "Experiment-[pick("A", "B", "C")]-[rand(0, 100)]"
	K.name = K.real_name
	//Equip a bag, ID & cute outfit
	var/obj/item/storage/backpack/B = new(get_turf(K))
	K.equip_to_slot_if_possible(B, ITEM_SLOT_BACK)

	var/obj/item/card/id/job/scientist/id_card = new(get_turf(K))
	id_card.update_label(K.name, title)
	LAZYADD(id_card.access, access)
	id_card.forceMove(B)

	var/obj/item/clothing/under/rank/rnd/scientist/outfit = new(get_turf(K))
	K.equip_to_slot_if_possible(outfit, ITEM_SLOT_ICLOTHING)

	return K
