#define DEPARTMENT_LOCKED_JOBS list("VIP", "Captain", "Head of Security")
#define DUMPTIME 3000

/datum/bank_account
	var/account_holder = "Rusty Venture"
	var/account_balance = 0
	var/datum/job/account_job
	var/list/bank_cards = list()
	var/add_to_accounts = TRUE
	var/account_id
	var/welfare = FALSE
	var/being_dumped = FALSE //pink levels are rising
	var/withdrawDelay = 0
	var/department_locked = FALSE //TRUE locks from changing `account_department` into something else. used for VIP, Captain, and HoS. Those jobs don't need to change paycheck department.
	/// used for cryo'ed people's account. Once it's TRUE, most bank features of the bank account will be disabled.
	var/suspended = FALSE
	/// your main department
	var/account_department

	///
	var/active_departments = NONE
	/// payment from each department.
	var/list/departments_paycheck = list(
		ACCOUNT_CIV=0,
		ACCOUNT_ENG=0,
		ACCOUNT_SCI=0,
		ACCOUNT_MED=0,
		ACCOUNT_SRV=0,
		ACCOUNT_CAR=0,
		ACCOUNT_SEC=0,
		ACCOUNT_VIP=0
	)
	/// bonus from each department.
	var/list/departments_bonus = list(
		ACCOUNT_CIV=0,
		ACCOUNT_ENG=0,
		ACCOUNT_SCI=0,
		ACCOUNT_MED=0,
		ACCOUNT_SRV=0,
		ACCOUNT_CAR=0,
		ACCOUNT_SEC=0,
		ACCOUNT_VIP=0
	)
	/// the amount of credits that would be returned to the station before it siphons roundstart credits into void when its owner went cryo.
	var/list/total_paid_payment = list(
		ACCOUNT_CIV=0,
		ACCOUNT_ENG=0,
		ACCOUNT_SCI=0,
		ACCOUNT_MED=0,
		ACCOUNT_SRV=0,
		ACCOUNT_CAR=0,
		ACCOUNT_SEC=0,
		ACCOUNT_VIP=0
	)




	//Amount payed on each payday
	var/paycheck_amount = 0
	//Bonus amount for a single payday
	var/paycheck_bonus = 0

/datum/bank_account/New(newname, job)
	if(add_to_accounts)
		SSeconomy.bank_accounts += src
	account_holder = newname
	account_job = job
	account_id = rand(111111,999999)
	paycheck_amount = account_job.paycheck
	account_department = account_job.paycheck_department
	if(account_job.title in DEPARTMENT_LOCKED_JOBS)
		department_locked = TRUE

/datum/bank_account/Destroy()
	if(add_to_accounts)
		SSeconomy.bank_accounts -= src
	return ..()

/datum/bank_account/proc/dumpeet()
	being_dumped = TRUE
	withdrawDelay = world.time + DUMPTIME

/datum/bank_account/proc/_adjust_money(amt)
	account_balance += amt
	if(account_balance < 0)
		account_balance = 0

/datum/bank_account/proc/has_money(amt)
	return account_balance >= amt

/datum/bank_account/proc/adjust_money(amt)
	if((amt < 0 && has_money(-amt)) || amt > 0)
		_adjust_money(amt)
		return TRUE
	return FALSE

/datum/bank_account/proc/transfer_money(datum/bank_account/from, amount)
	if(from.has_money(amount))
		adjust_money(amount)
		from.adjust_money(-amount)
		return TRUE
	return FALSE

/datum/bank_account/proc/get_department_strings()
	var/static/list/dept_flags = list(
		ACCOUNT_CIV_FLAG,
		ACCOUNT_ENG_FLAG,
		ACCOUNT_SCI_FLAG,
		ACCOUNT_MED_FLAG,
		ACCOUNT_SRV_FLAG,
		ACCOUNT_CAR_FLAG,
		ACCOUNT_SEC_FLAG,
		ACCOUNT_VIP_FLAG
	)

/datum/bank_account/proc/payday(amt_of_paychecks, free = FALSE)
	if(suspended)
		bank_card_talk("ERROR: Payday aborted, the account is closed by Nanotrasen Space Finance.")
		return FALSE
	var/money_to_transfer = paycheck_amount * amt_of_paychecks
	if(welfare)
		adjust_money(PAYCHECK_WELFARE) // Don't let welfare siphon your station budget
		bank_card_talk("Nanotrasen welfare system processed, account now holds $[account_balance].")
	if((money_to_transfer + paycheck_bonus) < 0) //Check if the bonus is docking more pay than possible
		paycheck_bonus -= money_to_transfer //Remove the debt with the payday
		money_to_transfer = 0 //No money for you
	else
		money_to_transfer += paycheck_bonus
	if(free)
		adjust_money(money_to_transfer)
		if(paycheck_bonus > 0) //Get rid of bonus if we have one
			paycheck_bonus = 0
	else
		var/datum/bank_account/D = SSeconomy.get_dep_account(account_department)
		if(D)
			if(!transfer_money(D, money_to_transfer))
				bank_card_talk("ERROR: Payday aborted, departmental funds insufficient.")
				return FALSE
			else
				bank_card_talk("Payday processed, account now holds $[account_balance].")
				total_paid_payment += money_to_transfer
				//The bonus only resets once it goes through.
				if(paycheck_bonus > 0) //And we're not getting rid of debt
					paycheck_bonus = 0
				return TRUE
	bank_card_talk("ERROR: Payday aborted, unable to contact departmental account.")
	return FALSE

/datum/bank_account/proc/bank_card_talk(message, force)
	if(!message || !bank_cards.len)
		return
	for(var/obj/A in bank_cards)
		var/mob/card_holder = recursive_loc_check(A, /mob)
		if(ismob(card_holder)) //If on a mob
			if(card_holder.client && !(card_holder.client.prefs.chat_toggles & CHAT_BANKCARD) && !force)
				return

			card_holder.playsound_local(get_turf(card_holder), 'sound/machines/twobeep_high.ogg', 50, TRUE)
			if(card_holder.can_hear())
				to_chat(card_holder, "[icon2html(A, card_holder)] *[message]*")
		else if(isturf(A.loc)) //If on the ground
			for(var/mob/M as() in hearers(1,get_turf(A)))
				if(M.client && !(M.client.prefs.chat_toggles & CHAT_BANKCARD) && !force)
					return
				playsound(A, 'sound/machines/twobeep_high.ogg', 50, TRUE)
				A.audible_message("[icon2html(A, hearers(A))] *[message]*", null, 1)
				break
		else
			for(var/mob/M in A.loc) //If inside a container with other mobs (e.g. locker)
				if(M.client && !(M.client.prefs.chat_toggles & CHAT_BANKCARD) && !force)
					return
				M.playsound_local(get_turf(M), 'sound/machines/twobeep_high.ogg', 50, TRUE)
				if(M.can_hear())
					to_chat(M, "[icon2html(A, M)] *[message]*")

/datum/bank_account/department
	account_holder = "Guild Credit Agency"
	var/department_id = "REPLACE_ME"
	add_to_accounts = FALSE

/datum/bank_account/department/New(dep_id, budget)
	department_id = dep_id
	account_balance = budget
	var/list/total_department_list = SSeconomy.department_accounts+SSeconomy.nonstation_accounts

	account_holder = total_department_list[dep_id]

	SSeconomy.generated_accounts += src

/datum/bank_account/proc/is_nonstation_account() // returns TRUE if the budget account is not Station department. i.e.) medical budget, security budget: FALSE / `nonstation_accounts` like VIP one: TRUE
	for(var/each in SSeconomy.nonstation_accounts)
		if(account_holder == SSeconomy.nonstation_accounts[each])
			return TRUE
	return FALSE

#undef DUMPTIME
#undef DEPARTMENT_LOCKED_JOBS
