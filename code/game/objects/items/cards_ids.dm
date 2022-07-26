/* Cards
 * Contains:
 *		DATA CARD
 *		ID CARD
 *		FINGERPRINT CARD HOLDER
 *		FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the IC data card reader
 */
/obj/item/card
	name = "card"
	desc = "Does card things."
	icon = 'icons/obj/card.dmi'
	w_class = WEIGHT_CLASS_TINY

	var/list/files = list()

/obj/item/card/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to swipe [user.p_their()] neck with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return BRUTELOSS

/obj/item/card/data
	name = "data card"
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has a stripe running down the middle."
	icon_state = "data_1"
	obj_flags = UNIQUE_RENAME
	var/function = "storage"
	var/data = "null"
	var/special = null
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	var/detail_color = COLOR_ASSEMBLY_ORANGE

/obj/item/card/data/Initialize(mapload)
	.=..()
	update_icon()

/obj/item/card/data/update_icon()
	cut_overlays()
	if(detail_color == COLOR_FLOORTILE_GRAY)
		return
	var/mutable_appearance/detail_overlay = mutable_appearance('icons/obj/card.dmi', "[icon_state]-color")
	detail_overlay.color = detail_color
	add_overlay(detail_overlay)

/obj/item/card/data/full_color
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has the entire card colored."
	icon_state = "data_2"

/obj/item/card/data/disk
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one inexplicibly looks like a floppy disk."
	icon_state = "data_3"

/*
 * ID CARDS
 */
/obj/item/card/emag
	desc = "It is an ID card, the magnetic strip is exposed and attached to some circuitry."
	name = "cryptographic sequencer"
	icon_state = "emag"
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	item_flags = NO_MAT_REDEMPTION | NOBLUDGEON
	var/prox_check = TRUE //If the emag requires you to be in range

/obj/item/card/emag/bluespace
	name = "bluespace cryptographic sequencer"
	desc = "It's a blue card with a magnetic strip attached to some circuitry. It appears to have some sort of transmitter attached to it."
	icon_state = "emag_bs"
	prox_check = FALSE

/obj/item/card/emag/attack()
	return

/obj/item/card/emag/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/atom/A = target
	if(!proximity && prox_check)
		return
	log_combat(user, A, "attempted to emag")
	A.emag_act(user)

/obj/item/card/emagfake
	desc = "It is an ID card, the magnetic strip is exposed and attached to some circuitry. Closer inspection shows that this card is a poorly made replica, with a \"DonkCo\" logo stamped on the back."
	name = "cryptographic sequencer"
	icon_state = "emag"
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/emagfake/afterattack()
	. = ..()
	playsound(src, 'sound/items/bikehorn.ogg', 50, 1)

/obj/item/card/id
	name = "identification card"
	desc = "A card used to provide ID and determine access across the station."
	icon_state = "id"
	item_state = "card-id"
	worn_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	slot_flags = ITEM_SLOT_ID
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "stamina" = 0)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/mining_points = 0 //For redeeming at mining equipment vendors
	var/list/access = list()
	var/registered_name// The name registered_name on the card
	var/assignment
	var/hud_state = JOB_HUD_UNKNOWN
	var/access_txt // mapping aid
	var/datum/bank_account/registered_account
	var/obj/machinery/paystand/my_store

/obj/item/card/id/Initialize(mapload)
	. = ..()
	if(mapload && access_txt)
		access = text2access(access_txt)

/obj/item/card/id/Destroy()
	if (registered_account)
		registered_account.bank_cards -= src
	if (my_store && my_store.my_card == src)
		my_store.my_card = null
	return ..()

/obj/item/card/id/proc/set_hud_icon_on_spawn(jobname)
	if(jobname)
		var/temp = get_hud_by_jobname(jobname)
		if(temp != JOB_HUD_UNKNOWN)
			hud_state = temp
	// This is needed for some irregular jobs

/obj/item/card/id/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message("<span class='notice'>[user] shows you: [icon2html(src, viewers(user))] [src.name].</span>", "<span class='notice'>You show \the [src.name].</span>")
	add_fingerprint(user)

/obj/item/card/id/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if(NAMEOF(src, assignment),NAMEOF(src, registered_name))
				update_label()

/obj/item/card/id/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/holochip))
		insert_money(W, user)
		return
	else if(istype(W, /obj/item/stack/spacecash))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/coin))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/storage/bag/money))
		var/obj/item/storage/bag/money/money_bag = W
		var/list/money_contained = money_bag.contents

		var/money_added = mass_insert_money(money_contained, user)

		if (money_added)
			to_chat(user, "<span class='notice'>You stuff the contents into the card! They disappear in a puff of bluespace smoke, adding [money_added] worth of credits to the linked account.</span>")
		return
	else
		return ..()

/obj/item/card/id/proc/insert_money(obj/item/I, mob/user, physical_currency)
	if(!registered_account)
		to_chat(user, "<span class='warning'>[src] doesn't have a linked account to deposit [I] into!</span>")
		return
	var/cash_money = I.get_item_credit_value()
	if(!cash_money)
		to_chat(user, "<span class='warning'>[I] doesn't seem to be worth anything!</span>")
		return

	registered_account.adjust_money(cash_money)
	if(physical_currency)
		to_chat(user, "<span class='notice'>You stuff [I] into [src]. It disappears in a small puff of bluespace smoke, adding [cash_money] credits to the linked account.</span>")
	else
		to_chat(user, "<span class='notice'>You insert [I] into [src], adding [cash_money] credits to the linked account.</span>")

	to_chat(user, "<span class='notice'>The linked account now reports a balance of $[registered_account.account_balance].</span>")
	qdel(I)

/obj/item/card/id/proc/mass_insert_money(list/money, mob/user)
	if(!registered_account)
		to_chat(user, "<span class='warning'>[src] doesn't have a linked account to deposit into!</span>")
		return FALSE

	if (!money || !money.len)
		return FALSE

	var/total = 0

	for (var/obj/item/physical_money in money)
		total += physical_money.get_item_credit_value()
		CHECK_TICK

	registered_account.adjust_money(total)
	SSblackbox.record_feedback("amount", "credits_inserted", total)
	QDEL_LIST(money)

	return total

/obj/item/card/id/proc/alt_click_can_use_id(mob/living/user)
	if(!isliving(user))
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	return TRUE

// Returns true if new account was set.
/obj/item/card/id/proc/set_new_account(mob/living/user)
	. = FALSE
	var/datum/bank_account/old_account = registered_account

	var/new_bank_id = input(user, "Enter your account ID number.", "Account Reclamation", 111111) as num

	if(!alt_click_can_use_id(user))
		return
	if(!new_bank_id || new_bank_id < 111111 || new_bank_id > 999999)
		to_chat(user, "<span class='warning'>The account ID number needs to be between 111111 and 999999.</span>")
		return
	if (registered_account && registered_account.account_id == new_bank_id)
		to_chat(user, "<span class='warning'>The account ID was already assigned to this card.</span>")
		return

	for(var/A in SSeconomy.bank_accounts)
		var/datum/bank_account/B = A
		if(B.account_id == new_bank_id)
			if (old_account)
				old_account.bank_cards -= src

			B.bank_cards += src
			registered_account = B
			to_chat(user, "<span class='notice'>The provided account has been linked to this ID card.</span>")

			return TRUE

	to_chat(user, "<span class='warning'>The account ID number provided is invalid.</span>")
	return

/obj/item/card/id/AltClick(mob/living/user)
	if(!alt_click_can_use_id(user))
		return

	if(!registered_account)
		set_new_account(user)
		return

	if (world.time < registered_account.withdrawDelay)
		registered_account.bank_card_talk("<span class='warning'>ERROR: UNABLE TO LOGIN DUE TO SCHEDULED MAINTENANCE. MAINTENANCE IS SCHEDULED TO COMPLETE IN [(registered_account.withdrawDelay - world.time)/10] SECONDS.</span>", TRUE)
		return

	var/amount_to_remove =  FLOOR(input(user, "How much do you want to withdraw? Current Balance: [registered_account.account_balance]", "Withdraw Funds", 5) as num, 1)

	if(!amount_to_remove || amount_to_remove < 0)
		to_chat(user, "<span class='warning'>You're pretty sure that's not how money works.</span>")
		return
	if(!alt_click_can_use_id(user))
		return
	if(registered_account.adjust_money(-amount_to_remove))
		var/obj/item/holochip/holochip = new (user.drop_location(), amount_to_remove)
		user.put_in_hands(holochip)
		to_chat(user, "<span class='notice'>You withdraw [amount_to_remove] credits into a holochip.</span>")
		return
	else
		var/difference = amount_to_remove - registered_account.account_balance
		registered_account.bank_card_talk("<span class='warning'>ERROR: The linked account requires [difference] more credit\s to perform that withdrawal.</span>", TRUE)

/obj/item/card/id/examine(mob/user)
	..()
	if(mining_points)
		. += "There's [mining_points] mining equipment redemption point\s loaded onto this card."
	. = ..()
	if(istype(src, /obj/item/card/id/paper))  // forces off bank info for paper slip
		return
	if(registered_account)
		. += "The account linked to the ID belongs to '[registered_account.account_holder]' and reports a balance of $[registered_account.account_balance]."
		if(registered_account.account_job)
			var/datum/bank_account/D = SSeconomy.get_dep_account(registered_account.account_department)
			if(D)
				. += "The [D.account_holder] reports a balance of $[D.account_balance]."
		. += "<span class='info'>Alt-Click the ID to pull money from the linked account in the form of holochips.</span>"
		. += "<span class='info'>You can insert credits into the linked account by pressing holochips, cash, or coins against the ID.</span>"
		if(registered_account.account_holder == user.real_name)
			. += "<span class='boldnotice'>If you lose this ID card, you can reclaim your account by Alt-Clicking a blank ID card while holding it and entering your account ID number.</span>"
	else
		. += "<span class='info'>There is no registered account linked to this card. Alt-Click to add one.</span>"

/obj/item/card/id/GetAccess()
	return access

/obj/item/card/id/GetID()
	return src

/obj/item/card/id/RemoveID()
	return src

/*
Usage:
update_label()
	Sets the id name to whatever registered_name and assignment is

update_label("John Doe", "Clowny")
	Properly formats the name and occupation and sets the id name to the arguments
*/
/obj/item/card/id/proc/update_label(newname, newjob)
	if(newname || newjob)
		name = "[(!newname)	? "identification card"	: "[newname]'s ID Card"][(!newjob) ? "" : " ([newjob])"]"
		return

	name = "[(!registered_name)	? "identification card"	: "[registered_name]'s ID Card"][(!assignment) ? "" : " ([assignment])"]"

/obj/item/card/id/silver
	name = "silver identification card"
	desc = "A silver ID card, issued to positions which require honour and dedication."
	icon_state = "silver"
	item_state = "silver_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	hud_state = JOB_HUD_RAWCENTCOM

/obj/item/card/id/silver/reaper
	name = "Thirteen's ID Card (Reaper)"
	access = list(ACCESS_MAINT_TUNNELS)
	assignment = "Reaper"
	registered_name = "Thirteen"
	hud_state = JOB_HUD_SYNDICATE

/obj/item/card/id/gold
	name = "gold identification card"
	desc = "A golden ID card. issued to positions which wield power and might."
	icon_state = "gold"
	item_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	hud_state = JOB_HUD_RAWCOMMAND

/obj/item/card/id/silver/spacepol
	name = "space police access card"
	access = list(ACCESS_HUNTERS)
	hud_state = JOB_HUD_NOTCENTCOM

/obj/item/card/id/silver/spacepol/bounty
	name = "bounty hunter access card"
	access = list(ACCESS_HUNTERS)
	hud_state = JOB_HUD_UNKNOWN

/obj/item/card/id/space_russian
	name = "space russian card"
	access = list(ACCESS_HUNTERS)
	hud_state = JOB_HUD_UNKNOWN

/obj/item/card/id/pirate
	name = "pirate ship card"
	access = list(ACCESS_PIRATES)
	hud_state = JOB_HUD_SYNDICATE

/obj/item/card/id/syndicate
	name = "agent card"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE)
	icon_state = "syndicate"
	hud_state = JOB_HUD_SYNDICATE
	var/anyone = FALSE //Can anyone forge the ID or just syndicate?
	var/forged = FALSE //have we set a custom name and job assignment, or will we use what we're given when we chameleon change?

	var/datum/action/item_action/chameleon/change/chameleon_action

/obj/item/card/id/syndicate/Initialize(mapload)
	. = ..()
	chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/card/id
	chameleon_action.chameleon_name = "ID Card"
	chameleon_action.chameleon_blacklist = typecacheof(list(
		/obj/item/card,
		/obj/item/card/data,
		/obj/item/card/data/full_color,
		/obj/item/card/data/disk,
		/obj/item/card/emag,
		/obj/item/card/emag/bluespace,
		/obj/item/card/emag/halloween,
		/obj/item/card/emagfake,
		/obj/item/card/id/pass/deputy,
		/obj/item/card/id/pass/mining_access_card,
		/obj/item/card/mining_point_card,
		/obj/item/card/id,
		/obj/item/card/id/prisoner/one,
		/obj/item/card/id/prisoner/two,
		/obj/item/card/id/prisoner/three,
		/obj/item/card/id/prisoner/four,
		/obj/item/card/id/prisoner/five,
		/obj/item/card/id/prisoner/six,
		/obj/item/card/id/prisoner/seven,
		/obj/item/card/id/departmental_budget,
		/obj/item/card/id/syndicate/anyone,
		/obj/item/card/id/syndicate/nuke_leader,
		/obj/item/card/id/syndicate/debug,
		/obj/item/card/id/syndicate/broken,
		/obj/item/card/id/away/old/apc,
		/obj/item/card/id/away/deep_storage,
		/obj/item/card/id/changeling,
		/obj/item/card/id/mining,
		/obj/item/card/id/pass), only_root_path = TRUE)
	chameleon_action.initialize_disguises()

/obj/item/card/id/syndicate/afterattack(obj/item/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/item/card/id))
		var/obj/item/card/id/I = O
		src.access |= I.access
		log_id("[key_name(user)] copied all avaliable access from [I] to agent ID [src] at [AREACOORD(user)].")
		if(isliving(user) && user.mind)
			if(user.mind.special_role || anyone)
				to_chat(usr, "<span class='notice'>The card's microscanners activate as you pass it over the ID, copying its access.</span>")

/obj/item/card/id/syndicate/attack_self(mob/user)
	if(isliving(user) && user.mind)
		var/first_use = registered_name ? FALSE : TRUE
		if(!(user.mind.special_role || anyone)) //Unless anyone is allowed, only syndies can use the card, to stop metagaming.
			if(first_use) //If a non-syndie is the first to forge an unassigned agent ID, then anyone can forge it.
				anyone = TRUE
			else
				return ..()

		var/popup_input = alert(user, "Choose Action", "Agent ID", "Show", "Forge/Reset", "Change Account ID")
		if(user.incapacitated())
			return
		if(popup_input == "Forge/Reset" && !forged)
			var/input_name = stripped_input(user, "What name would you like to put on this card? Leave blank to randomise.", "Agent card name", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), MAX_NAME_LEN)
			input_name = reject_bad_name(input_name)
			if(!input_name)
				// Invalid/blank names give a randomly generated one.
				if(user.gender == MALE)
					input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
				else if(user.gender == FEMALE)
					input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]"
				else
					input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

			var/target_occupation = stripped_input(user, "What occupation would you like to put on this card?\nNote: This will not grant any access levels other than Maintenance.", "Agent card job assignment", assignment ? assignment : "Assistant", MAX_MESSAGE_LEN)
			if(!target_occupation)
				return
			log_id("[key_name(user)] forged agent ID [src] name to [input_name] and occupation to [target_occupation] at [AREACOORD(user)].")
			registered_name = input_name
			assignment = target_occupation
			update_label()
			forged = TRUE
			to_chat(user, "<span class='notice'>You successfully forge the ID card.</span>")
			log_game("[key_name(user)] has forged \the [initial(name)] with name \"[registered_name]\" and occupation \"[assignment]\".")

			// First time use automatically sets the account id to the user.
			if (first_use && !registered_account)
				if(ishuman(user))
					var/mob/living/carbon/human/accountowner = user

					for(var/bank_account in SSeconomy.bank_accounts)
						var/datum/bank_account/account = bank_account
						if(account.account_id == accountowner.account_id)
							account.bank_cards += src
							registered_account = account
							to_chat(user, "<span class='notice'>Your account number has been automatically assigned.</span>")
			return
		else if (popup_input == "Forge/Reset" && forged)
			registered_name = initial(registered_name)
			assignment = initial(assignment)
			log_id("[key_name(user)] reset agent ID [src] name to default at [AREACOORD(user)].")
			log_game("[key_name(user)] has reset \the [initial(name)] named \"[src]\" to default.")
			update_label()
			forged = FALSE
			to_chat(user, "<span class='notice'>You successfully reset the ID card.</span>")
			return
		else if (popup_input == "Change Account ID")
			set_new_account(user)
			return
	return ..()


/obj/item/card/id/syndicate/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	chameleon_action.emp_randomise()

// broken chameleon agent card
/obj/item/card/id/syndicate/broken
	access = list() // their access is even broken

/obj/item/card/id/syndicate/broken/afterattack(obj/item/O, mob/user, proximity)
	return

/obj/item/card/id/syndicate/broken/Initialize(mapload)
	. = ..()
	chameleon_action.emp_randomise(INFINITY)

/obj/item/card/id/syndicate/anyone
	anyone = TRUE

/obj/item/card/id/syndicate/nuke_leader
	name = "lead agent card"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE, ACCESS_SYNDICATE_LEADER)

/obj/item/card/id/syndicate/ratvar
	name = "servant ID card"
	icon_state = "ratvar"
	access = list(ACCESS_CLOCKCULT, ACCESS_MAINT_TUNNELS)
	hud_state = JOB_HUD_UNKNOWN

/obj/item/card/id/syndicate_command
	name = "syndicate ID card"
	desc = "An ID straight from the Syndicate."
	registered_name = "Syndicate"
	icon_state = "syndicate"
	assignment = "Syndicate Officer"
	access = list(ACCESS_SYNDICATE)
	hud_state = JOB_HUD_SYNDICATE

/obj/item/card/id/syndicate/debug
	name = "\improper Debug ID"
	desc = "A shimmering ID card with the ability to open anything."
	icon_state = "centcom"
	registered_name = "Central Command"
	assignment = "Admiral"
	anyone = TRUE
	hud_state = JOB_HUD_CENTCOM

/obj/item/card/id/syndicate/debug/Initialize(mapload)
	access = get_every_access()
	registered_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	. = ..()

/obj/item/card/id/captains_spare
	name = "captain's spare ID"
	desc = "The spare ID of the High Lord himself."
	icon_state = "gold"
	item_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	registered_name = "Captain"
	assignment = "Captain"
	investigate_flags = ADMIN_INVESTIGATE_TARGET
	hud_state = JOB_HUD_ACTINGCAPTAIN

/obj/item/card/id/captains_spare/Initialize(mapload)
	var/datum/job/captain/J = new/datum/job/captain
	access = J.get_access()
	. = ..()

/obj/item/card/id/centcom
	name = "\improper CentCom ID"
	desc = "A shimmering Central Command ID card. Simply seeing this is illegal for the majority of the crew."
	icon_state = "centcom"
	registered_name = "Central Command"
	assignment = "General"
	hud_state = JOB_HUD_CENTCOM

/obj/item/card/id/centcom/Initialize(mapload)
	access = get_all_centcom_access()
	. = ..()

/obj/item/card/id/ert
	name = "\improper CentCom ID"
	desc = "A shimmering Emergency Response Team ID card. All access with style."
	icon_state = "ert"
	registered_name = "Emergency Response Team Commander"
	assignment = "Emergency Response Team Commander"
	hud_state = JOB_HUD_CENTCOM

/obj/item/card/id/ert/Initialize(mapload)
	access = get_all_accesses()+get_ert_access("commander")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/Security
	registered_name = "Security Response Officer"
	assignment = "Security Response Officer"
	icon_state = "ert"

/obj/item/card/id/ert/Security/Initialize(mapload)
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/Engineer
	registered_name = "Engineer Response Officer"
	assignment = "Engineer Response Officer"
	icon_state = "ert"

/obj/item/card/id/ert/Engineer/Initialize(mapload)
	access = get_all_accesses()+get_ert_access("eng")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/Medical
	registered_name = "Medical Response Officer"
	assignment = "Medical Response Officer"
	icon_state = "ert"

/obj/item/card/id/ert/Medical/Initialize(mapload)
	access = get_all_accesses()+get_ert_access("med")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/chaplain
	registered_name = "Religious Response Officer"
	assignment = "Religious Response Officer"
	icon_state = "ert"

/obj/item/card/id/ert/chaplain/Initialize(mapload)
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/Janitor
	registered_name = "Janitorial Response Officer"
	assignment = "Janitorial Response Officer"
	icon_state = "ert"

/obj/item/card/id/ert/Janitor/Initialize(mapload)
	access = get_all_accesses()
	. = ..()

/obj/item/card/id/ert/kudzu
	registered_name = "Weed Whacker"
	assignment = "Weed Whacker"
	icon_state = "ert"

/obj/item/card/id/ert/kudzu/Initialize(mapload)
	access = get_all_accesses()
	. = ..()

/obj/item/card/id/prisoner
	name = "prisoner ID card"
	desc = "You are a number, you are not a free man."
	icon_state = "orange"
	item_state = "orange-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	assignment = "Prisoner"
	registered_name = "Prisoner"
	var/goal = 0 //How far from freedom?
	var/points = 0
	var/permanent = FALSE
	hud_state = JOB_HUD_PRISONER

/obj/item/card/id/prisoner/examine(mob/user)
	. = ..()

	if(!permanent)
		. += "<span class='notice'>A little display on the card reads: You have accumulated [points] out of the [goal] points you need for freedom.</span>"

	else
		. += "<span class='notice'>The mark on the ID indicates the sentence is permanent.</span>"

/obj/item/card/id/prisoner/one
	name = "Prisoner #13-001"
	registered_name = "Prisoner #13-001"

/obj/item/card/id/prisoner/two
	name = "Prisoner #13-002"
	registered_name = "Prisoner #13-002"

/obj/item/card/id/prisoner/three
	name = "Prisoner #13-003"
	registered_name = "Prisoner #13-003"

/obj/item/card/id/prisoner/four
	name = "Prisoner #13-004"
	registered_name = "Prisoner #13-004"

/obj/item/card/id/prisoner/five
	name = "Prisoner #13-005"
	registered_name = "Prisoner #13-005"

/obj/item/card/id/prisoner/six
	name = "Prisoner #13-006"
	registered_name = "Prisoner #13-006"

/obj/item/card/id/prisoner/seven
	name = "Prisoner #13-007"
	registered_name = "Prisoner #13-007"

/obj/item/card/id/mining
	name = "mining ID"
	hud_state = JOB_HUD_RAWCARGO
	access = list(ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MECH_MINING, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)

/obj/item/card/id/paper
	name = "paper slip identifier"
	desc = "Some spare papers taped into a vague card shape, and a name scribbled on it. Seems trustworthy."
	icon_state = "paper"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50, "stamina" = 0)
	resistance_flags = null  // removes all resistance because its a piece of paper
	access = list()
	assignment = "Unverified"
	hud_state = JOB_HUD_PAPER

/obj/item/card/id/paper/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/pen))
		var/target_name = stripped_input(user, "What name would you like to write onto the card?", "Written name:", registered_name || "John Doe", MAX_MESSAGE_LEN)
		registered_name = target_name || registered_name  // in case they hit cancel
		assignment = "Unverified"
		to_chat(user, "You scribble the name [target_name] onto the slip.")
		update_label()

/obj/item/card/id/paper/alt_click_can_use_id(mob/living/user)
	to_chat(user, "There's no money circuitry in here!")

/obj/item/card/id/paper/insert_money(obj/item/I, mob/user, physical_currency)
	to_chat(user, "You can't insert money into a slip!")  // not sure if this is triggerable but just as a safeclip

/obj/item/card/id/paper/GetAccess()
	return list()

/obj/item/card/id/paper/update_label(newname, newjob)
	if(newname || newjob)
		name = "[(!newname)	? "paper slip identifier": "[newname]'s paper slip"]"
		return

	name = "[(!registered_name)	? "paper slip identifier": "[registered_name]'s paper slip (presumably)"]"

/obj/item/card/id/set_hud_icon_on_spawn(jobname)
	return

/obj/item/card/id/paper/examine(mob/user)
	. = ..()
	. += "There is no accounts linked, as it is a piece of paper."

/obj/item/card/id/away
	name = "\proper a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."
	hud_state = JOB_HUD_UNKNOWN
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/hotel
	name = "Staff ID"
	desc = "A staff ID used to access the hotel's doors."
	hud_state = JOB_HUD_RAWSERVICE
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/hotel/securty
	name = "Officer ID"
	hud_state = JOB_HUD_RAWSECURITY
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old
	name = "\proper a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."
	icon_state = "centcom"
	hud_state = JOB_HUD_RAWCENTCOM

/obj/item/card/id/away/old/sec
	name = "Charlie Station Security Officer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Security Officer\"."
	assignment = "Charlie Station Security Officer"
	hud_state = JOB_HUD_RAWSECURITY
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old/sci
	name = "Charlie Station Scientist's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Scientist\"."
	assignment = "Charlie Station Scientist"
	hud_state = JOB_HUD_RAWSCIENCE
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/eng
	name = "Charlie Station Engineer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Station Engineer\"."
	assignment = "Charlie Station Engineer"
	hud_state = JOB_HUD_RAWENGINEERING
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE)

/obj/item/card/id/away/old/apc
	name = "APC Access ID"
	desc = "A special ID card that allows access to APC terminals."
	hud_state = JOB_HUD_UNKNOWN
	access = list(ACCESS_ENGINE_EQUIP)

/obj/item/card/id/away/deep_storage //deepstorage.dmm space ruin
	name = "bunker access ID"

///Department Budget Cards///

/obj/item/card/id/departmental_budget
	name = "departmental card (budget)"
	desc = "Provides access to the departmental budget."
	icon_state = "budget"
	var/department_ID = ACCOUNT_CIV
	var/department_name = ACCOUNT_CIV_NAME
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	investigate_flags = ADMIN_INVESTIGATE_TARGET

/obj/item/card/id/departmental_budget/Initialize(mapload)
	. = ..()
	var/datum/bank_account/B = SSeconomy.get_dep_account(department_ID)
	if(B)
		registered_account = B
		if(!B.bank_cards.Find(src))
			B.bank_cards += src
		name = "departmental card ([department_name])"
		desc = "Provides access to the [department_name]."
	SSeconomy.dep_cards += src

/obj/item/card/id/departmental_budget/Destroy()
	SSeconomy.dep_cards -= src
	return ..()

/obj/item/card/id/departmental_budget/civ
	department_ID = ACCOUNT_CIV
	department_name = ACCOUNT_CIV_NAME
	icon_state = "budget"
	hud_state = JOB_HUD_RAWCOMMAND

/obj/item/card/id/departmental_budget/eng
	department_ID = ACCOUNT_ENG
	department_name = ACCOUNT_ENG_NAME
	icon_state = "budget_eng"
	hud_state = JOB_HUD_RAWENGINEERING

/obj/item/card/id/departmental_budget/sci
	department_ID = ACCOUNT_SCI
	department_name = ACCOUNT_SCI_NAME
	icon_state = "budget_sci"
	hud_state = JOB_HUD_RAWSCIENCE

/obj/item/card/id/departmental_budget/med
	department_ID = ACCOUNT_MED
	department_name = ACCOUNT_MED_NAME
	icon_state = "budget_med"
	hud_state = JOB_HUD_RAWMEDICAL

/obj/item/card/id/departmental_budget/srv
	department_ID = ACCOUNT_SRV
	department_name = ACCOUNT_SRV_NAME
	icon_state = "budget_srv"
	hud_state = JOB_HUD_RAWSERVICE

/obj/item/card/id/departmental_budget/car
	department_ID = ACCOUNT_CAR
	department_name = ACCOUNT_CAR_NAME
	icon_state = "budget_car"
	hud_state = JOB_HUD_RAWCARGO

/obj/item/card/id/departmental_budget/sec
	department_ID = ACCOUNT_SEC
	department_name = ACCOUNT_SEC_NAME
	icon_state = "budget_sec"
	hud_state = JOB_HUD_RAWSECURITY

/// Job Specific ID Cards///
// These should have default job name and hud state, etc, because chameleon card needs such information
// ---- Command ----
/obj/item/card/id/job/captain
	name = "Job card (Com) - Captain"
	assignment = "Captain"
	icon_state = "captain"
	hud_state = JOB_HUD_CAPTAIN

/obj/item/card/id/job/rawcommand
	name = "Job card (Com) - Custom"
	icon_state = JOB_HUD_RAWCOMMAND
	hud_state = JOB_HUD_RAWCOMMAND

// ---- Service ----
/obj/item/card/id/job/assistant
	name = "Job card (Serv) - Assistant"
	assignment = "Assistant"
	icon_state = "id"
	hud_state = JOB_HUD_ASSISTANT

/obj/item/card/id/job/hop
	name = "Job card (Serv) - HoP"
	assignment = "Head of Personnel"
	icon_state = "hop"
	hud_state = JOB_HUD_HEADOFPERSONNEL
/obj/item/card/id/job/botanist
	name = "Job card (Serv) - Botanist"
	assignment = "Botanist"
	icon_state = "serv"
	hud_state = JOB_HUD_BOTANIST

/obj/item/card/id/job/cook
	name = "Job card (Serv) - Cook"
	assignment = "Cook"
	icon_state = "serv"
	hud_state = JOB_HUD_COOK

/obj/item/card/id/job/bartender
	name = "Job card (Serv) - Bartender"
	assignment = "Bartender"
	icon_state = "serv"
	hud_state = JOB_HUD_BARTENDER

/obj/item/card/id/job/barber
	name = "Job card (Serv) - Barber"
	assignment = "Barber"
	icon_state = "serv"
	hud_state = JOB_HUD_BARBER

/obj/item/card/id/job/magician
	name = "Job card (Serv) - Magician"
	assignment = "Magician"
	icon_state = "serv"
	hud_state = JOB_HUD_STAGEMAGICIAN

/obj/item/card/id/job/curator
	name = "Job card (Serv) - Curator"
	assignment = "Curator"
	icon_state = "chap"
	hud_state = JOB_HUD_CURATOR

/obj/item/card/id/job/chap
	name = "Job card (Serv) - Chaplain"
	assignment = "Chaplain"
	icon_state = "chap"
	hud_state = JOB_HUD_CHAPLAIN

/obj/item/card/id/job/janitor
	name = "Job card (Serv) - Janitor"
	assignment = "Janitor"
	icon_state = "janitor"
	hud_state = JOB_HUD_JANITOR

/obj/item/card/id/job/clown
	name = "Job card (Serv) - Clown"
	assignment = "Clown"
	icon_state = "clown"
	hud_state = JOB_HUD_CLOWN

/obj/item/card/id/job/mime
	name = "Job card (Serv) - Mime"
	assignment = "Mime"
	icon_state = "mime"
	hud_state = JOB_HUD_MIME

/obj/item/card/id/job/lawyer
	name = "Job card (Serv) - Lawyer"
	assignment = "Lawyer"
	icon_state = "lawyer"
	hud_state = JOB_HUD_LAWYER

/obj/item/card/id/job/rawservice
	name = "Job card (Serv) - Custom"
	icon_state = JOB_HUD_RAWSERVICE
	hud_state = JOB_HUD_RAWSERVICE

// ---- Cargo ----
/obj/item/card/id/job/qm
	name = "Job card (Cargo) - QM"
	assignment = "Quartermaster"
	icon_state = "qm"
	hud_state = JOB_HUD_QUARTERMASTER

/obj/item/card/id/job/miner
	name = "Job card (Cargo) - Shaft Miner"
	assignment = "Shaft Miner"
	icon_state = "miner"
	hud_state = JOB_HUD_SHAFTMINER

/obj/item/card/id/job/cargo
	name = "Job card (Cargo) - Cargo Tech"
	assignment = "Cargo Technician"
	icon_state = "cargo"
	hud_state = JOB_HUD_CARGOTECHNICIAN

/obj/item/card/id/job/rawcargo
	name = "Job card (Cargo) - Custom"
	icon_state = "rawcargo"
	hud_state = JOB_HUD_RAWCARGO

// ---- Engineering ----
/obj/item/card/id/job/ce
	name = "Job card (Eng) - CE"
	assignment = "Chief Engineer"
	icon_state = "ce"
	hud_state = JOB_HUD_CHIEFENGINEER

/obj/item/card/id/job/engi
	name = "Job card (Eng) - Station Engi"
	assignment = "Station Engineer"
	icon_state = "engi"
	hud_state = JOB_HUD_STATIONENGINEER

/obj/item/card/id/job/atmos
	name = "Job card (Eng) - Atmos"
	assignment = "Atmospheric Technician"
	icon_state = "atmos"
	hud_state = JOB_HUD_ATMOSPHERICTECHNICIAN

/obj/item/card/id/job/rawengineering
	name = "Job card (Eng) - Custom"
	icon_state = "rawengineering"
	hud_state = JOB_HUD_RAWENGINEERING

// ---- Science -----
/obj/item/card/id/job/rd
	name = "Job card (RND) - RD"
	assignment = "Research Director"
	icon_state = "rd"
	hud_state = JOB_HUD_RESEARCHDIRECTOR

/obj/item/card/id/job/roboticist
	name = "Job card (RND) - Roboticist"
	assignment = "Roboticist"
	icon_state = "roboticist"
	hud_state = JOB_HUD_ROBOTICIST

/obj/item/card/id/job/sci
	name = "Job card (RND) - Scientist"
	assignment = "Scientist"
	icon_state = "sci"
	hud_state = JOB_HUD_SCIENTIST

/obj/item/card/id/job/exploration
	name = "Job card (RND) - Explo Crew"
	assignment = "Exploration Crew"
	icon_state = "exploration"
	hud_state = JOB_HUD_EXPLORATIONCREW

/obj/item/card/id/job/rawscience
	name = "Job card (RND) - Custom"
	icon_state = "rawscience"
	hud_state = JOB_HUD_RAWSCIENCE

// ---- Medical ----
/obj/item/card/id/job/cmo
	name = "Job card (Med) - CMO"
	assignment = "Chief Medical Officer"
	icon_state = "cmo"
	hud_state = JOB_HUD_CHEIFMEDICALOFFICIER

/obj/item/card/id/job/med
	name = "Job card (Med) - Medical Doctor"
	assignment = "Medical Doctor"
	icon_state = "med"
	hud_state = JOB_HUD_MEDICALDOCTOR

/obj/item/card/id/job/paramed
	name = "Job card (Med) - Paramedic"
	assignment = "Paramedic"
	icon_state = "paramed"
	hud_state = JOB_HUD_PARAMEDIC

/obj/item/card/id/job/viro
	name = "Job card (Med) - Virologist"
	assignment = "Virologist"
	icon_state = "viro"
	hud_state = JOB_HUD_VIROLOGIST

/obj/item/card/id/job/chemist
	name = "Job card (Med) - Chemist"
	assignment = "Chemist"
	icon_state = "chemist"
	hud_state = JOB_HUD_CHEMIST

/obj/item/card/id/job/gene
	name = "Job card (Med) - Geneticist"
	assignment = "Geneticist"
	icon_state = "gene"
	hud_state = JOB_HUD_GENETICIST

/obj/item/card/id/job/psychi
	name = "Job card (Med) - Psychiatrist"
	assignment = "Psychiatrist"
	icon_state = "med"
	hud_state = JOB_HUD_PSYCHIATRIST

/obj/item/card/id/job/rawmedical
	name = "Job card (Med) - Custom"
	icon_state = "rawmedical"
	hud_state = JOB_HUD_RAWMEDICAL


// ---- Security ----
/obj/item/card/id/job/hos
	name = "Job card (Sec) - HoS"
	assignment = "Head of Security"
	icon_state = "hos"
	hud_state = JOB_HUD_HEADOFSECURITY

/obj/item/card/id/job/sec
	name = "Job card (Sec) - Security Officer"
	assignment = "Security Officier"
	icon_state = "sec"
	hud_state = JOB_HUD_SECURITYOFFICER

/obj/item/card/id/job/brigphys
	name = "Job card (Sec) - Brig Phys"
	assignment = "Brig Physician"
	icon_state = "brigphys"
	hud_state = JOB_HUD_BRIGPHYSICIAN

/obj/item/card/id/job/deputy
	name = "Job card (Sec) - Deputy"
	assignment = "Deputy"
	icon_state = "deputy"
	hud_state = JOB_HUD_DEPUTY

/obj/item/card/id/job/detective
	name = "Job card (Sec) - Detective"
	assignment = "Detective"
	icon_state = "detective"
	hud_state = JOB_HUD_DETECTIVE

/obj/item/card/id/job/warden
	name = "Job card (Sec) - Warden"
	assignment = "Warden"
	icon_state = "warden"
	hud_state = JOB_HUD_WARDEN

/obj/item/card/id/job/rawsecurity
	name = "Job card (Sec) - Custom"
	icon_state = "rawsecurity"
	hud_state = JOB_HUD_RAWSECURITY

 // ---- ???? ----
/obj/item/card/id/job/unknown
	name = "Job card - unassigned"
	icon_state = "id"
	hud_state = JOB_HUD_UNKNOWN

/obj/item/card/id/gold/vip
	name = "important gold identification card"
	assignment = "VIP"
	hud_state = JOB_HUD_VIP

/obj/item/card/id/gold/king
	name = "their majesty's gold identification card"
	assignment = "King"
	hud_state = JOB_HUD_KING


/obj/item/card/id/pass
	name = "promotion pass"
	desc = "A card that, when swiped on your ID card, will grant you all the access. Should not substitute your actual ID card."
	icon_state = "data_1"
	registered_name = "Unregistered ID"
	assignment = "Access Pass"
	hud_state = JOB_HUD_UNKNOWN

/obj/item/card/id/pass/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if (!proximity)
		return .
	var/obj/item/card/id/idcard = target
	if(istype(idcard))
		if(istype(idcard, /obj/item/card/id/paper))
			to_chat(user, to_chat(user, "<span class='warning'>The pass beeps a warning about this not being a proper id."))
			return
		for(var/give_access in access)
			idcard.access |= give_access
		if(assignment!=initial(assignment))
			idcard.assignment = assignment
		if(name!=initial(name))
			idcard.name = name
		to_chat(user, "You upgrade your [idcard] with the [name].")
		log_id("[key_name(user)] added access to '[idcard]' using [src] at [AREACOORD(user)].")
		qdel(src)
