/datum/job/clown
	title = JOB_NAME_CLOWN
	flag = CLOWN
	description = "Be the life and soul of the station. Entertain the crew with your hilarious jokes and silly antics, including slipping, pie-ing and honking around. Remember your job is to keep things funny for others, not just yourself."
	department_for_prefs = DEPT_BITFLAG_CIV
	department_head = list(JOB_NAME_HEADOFPERSONNEL)
	supervisors = "the head of personnel"
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	selection_color = "#dddddd"

	outfit = /datum/outfit/job/clown

	access = list(ACCESS_THEATRE)
	minimal_access = list(ACCESS_THEATRE)

	department_flag = CIVILIAN
	departments = DEPT_BITFLAG_SRV
	bank_account_department = ACCOUNT_SRV_BITFLAG
	payment_per_department = list(ACCOUNT_SRV_ID = PAYCHECK_MINIMAL)


	display_order = JOB_DISPLAY_ORDER_CLOWN
	rpg_title = "Jester"

	species_outfits = list(
		SPECIES_PLASMAMAN = /datum/outfit/plasmaman/honk
	)

	minimal_lightup_areas = list(/area/crew_quarters/theatre)

/datum/job/clown/New()
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CLOWN_BRIDGE))
		outfit = /datum/outfit/job/clown/bridge

/datum/job/clown/after_spawn(mob/living/carbon/human/H, mob/M, latejoin = FALSE, client/preference_source, on_dummy = FALSE)
	. = ..()
	if(!ishuman(H) || !M.client || on_dummy)
		return
	H.apply_pref_name(/datum/preference/name/clown, preference_source)
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CLOWN_BRIDGE))
		to_chat(M, "<span class='notice bold'>The <span class='clown bold'>Clown Planet</span> has given all clowns access to a specific weakness in airlock ID scanners, resulting in all clowns having <b>bridge access</b>! Honk!</span>")

/datum/outfit/job/clown
	name = JOB_NAME_CLOWN
	jobtype = /datum/job/clown

	id = /obj/item/card/id/job/clown
	belt = /obj/item/modular_computer/tablet/pda/clown
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	mask = /obj/item/clothing/mask/gas/clown_hat
	l_pocket = /obj/item/bikehorn
	backpack_contents = list(
		/obj/item/stamp/clown = 1,
		/obj/item/reagent_containers/spray/waterflower = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/obj/item/instrument/bikehorn = 1,
		)

	implants = list(/obj/item/implant/sad_trombone)

	backpack = /obj/item/storage/backpack/clown
	satchel = /obj/item/storage/backpack/clown
	duffelbag = /obj/item/storage/backpack/duffelbag/clown //strangely has a duffel

	box = /obj/item/storage/box/hug/survival

	chameleon_extras = /obj/item/stamp/clown

/datum/outfit/job/clown/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_BANANIUM_SHIPMENTS))
		backpack_contents[/obj/item/stack/sheet/mineral/bananium/five] = 1

/datum/outfit/job/clown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.fully_replace_character_name(H.real_name, pick(GLOB.clown_names)) //rename the mob AFTER they're equipped so their ID gets updated properly.
	H.dna.add_mutation(CLOWNMUT)
	ADD_TRAIT(H, TRAIT_NAIVE, JOB_TRAIT)

/datum/outfit/job/clown/bridge
	name = "Clown (Bridge Access)"
	id = /obj/item/card/id/job/clown/bridge

/datum/job/clown/bridge/get_access()
	return ..() + ACCESS_HEADS
