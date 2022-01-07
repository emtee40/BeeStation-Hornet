GLOBAL_DATUM_INIT(ai_os, /datum/ai_os, new)

/datum/ai_os
	var/name = "Decentralized Resource Management System (DRMS)"

	var/total_cpu = 0

	var/total_ram = 0

	var/previous_cpu = 0
	var/previous_ram = 0

	var/list/cpu_assigned
	var/list/ram_assigned

/datum/ai_os/New()
	update_hardware()
	cpu_assigned = list()
	ram_assigned = list()

/datum/ai_os/proc/remove_ai(mob/living/silicon/ai/AI)
	cpu_assigned.Remove(AI)
	ram_assigned.Remove(AI)
	update_allocations()

/datum/ai_os/proc/total_cpu_assigned()
	var/total = 0
	for(var/N in cpu_assigned)
		total += cpu_assigned[N]
	return total

/datum/ai_os/proc/total_ram_assigned()
	var/total = 0
	for(var/N in ram_assigned)
		total += ram_assigned[N]
	return total

/datum/ai_os/proc/update_hardware()
	previous_cpu = total_cpu
	previous_ram = total_ram
	total_cpu = 0
	total_ram = 0
	for(var/obj/machinery/ai/expansion_card_holder/C in GLOB.expansion_card_holders)
		if(!C.valid_holder() && !C.roundstart)
			continue
		for(var/CARD in C.installed_cards)
			if(istype(CARD, /obj/item/processing_card))
				var/obj/item/processing_card/PC = CARD
				total_cpu += PC.tier
			if(istype(CARD, /obj/item/memory_card))
				var/obj/item/memory_card/MC = CARD
				total_ram += MC.tier

	update_allocations()

/datum/ai_os/proc/update_allocations()
	if(total_cpu >= previous_cpu && total_ram >= previous_ram)
		return

	var/list/ram_removal = list()
	var/list/cpu_removal = list()

	var/list/cpu_assigned_copy = cpu_assigned.Copy()
	var/list/ram_assigned_copy = ram_assigned.Copy()

	var/list/affected_AIs = list()

	log_game("allocations running")

	if(total_cpu < previous_cpu)
		var/needed_amount = previous_cpu - total_cpu
		for(var/A in cpu_assigned_copy)
			var/mob/living/silicon/ai/AI = A
			if(cpu_assigned_copy[AI] >= needed_amount)
				cpu_assigned_copy[AI] -= needed_amount
				cpu_removal[AI] += needed_amount
				previous_cpu -= needed_amount
				break
			else if(cpu_assigned_copy[AI])
				var/amount = cpu_assigned_copy[AI]
				cpu_assigned_copy[AI] -= amount
				cpu_removal[AI] += amount
				previous_cpu -= amount
				needed_amount -= amount
				if(total_cpu >= previous_cpu)
					break
		//If that somehow didn't work which it sometimes doesn't we just clear everything
		if(total_cpu < previous_cpu)
			for(var/A in cpu_assigned_copy)
				var/amount = cpu_assigned_copy[A]
				cpu_assigned_copy[A] = 0
				cpu_removal[A] += amount
				previous_cpu -= amount

	if(total_ram < previous_ram)
		var/needed_amount = previous_ram - total_ram
		for(var/A in ram_assigned_copy)
			var/mob/living/silicon/ai/AI = A
			if(ram_assigned_copy[AI] >= needed_amount)
				ram_assigned_copy[AI] -= needed_amount
				ram_removal[AI] += needed_amount
				previous_ram -= needed_amount
				break
			else if(cpu_assigned_copy[AI])
				var/amount = cpu_assigned_copy[AI]
				ram_assigned_copy[AI] -= amount
				ram_removal[AI] += amount
				needed_amount -= amount
				previous_ram -= amount
				if(total_ram >= previous_ram)
					break
		//If that somehow didn't work which it sometimes doesn't we just clear everything
		if(total_ram < previous_ram)
			for(var/A in ram_assigned_copy)
				var/amount = ram_assigned_copy[A]
				ram_assigned_copy[A] = 0
				ram_removal[A] += amount
				previous_ram -= amount

	for(var/A in ram_removal)
		ram_assigned[A] = ram_assigned[A] - ram_removal[A]
		affected_AIs |= A

	for(var/A in cpu_removal)
		cpu_assigned[A] = cpu_assigned[A] - cpu_removal[A]
		affected_AIs |= A

	to_chat(affected_AIs, "<span class = 'warning'>You have been deducted processing capabilities. Please contact your network administrator if you believe this to be an error.</span>")
	log_game("allocations ending")

/datum/ai_os/proc/add_cpu(mob/living/silicon/ai/AI, amount)
	if(!AI || !amount)
		return
	if(!istype(AI))
		return
	cpu_assigned[AI] += amount

	update_allocations()

/datum/ai_os/proc/remove_cpu(mob/living/silicon/ai/AI, amount)
	if(!AI || !amount)
		return
	if(!istype(AI))
		return
	if(cpu_assigned[AI] - amount < 0)
		cpu_assigned[AI] = 0
	else
		cpu_assigned[AI] -= amount

	update_allocations()

/datum/ai_os/proc/add_ram(mob/living/silicon/ai/AI, amount)
	if(!AI || !amount)
		return
	if(!istype(AI))
		return
	ram_assigned[AI] += amount

	update_allocations()

/datum/ai_os/proc/remove_ram(mob/living/silicon/ai/AI, amount)
	if(!AI || !amount)
		return
	if(!istype(AI))
		return
	if(ram_assigned[AI] - amount < 0)
		ram_assigned[AI] = 0
	else
		ram_assigned[AI] -= amount

	update_allocations()


/datum/ai_os/proc/clear_ai_resources(mob/living/silicon/ai/AI)
	if(!AI || !istype(AI))
		return

	remove_ram(AI, ram_assigned[AI])
	remove_cpu(AI, cpu_assigned[AI])

	update_allocations()
