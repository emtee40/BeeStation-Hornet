/proc/available_ai_cores()
	if(!GLOB.data_cores.len)
		return FALSE
	var/obj/machinery/ai/data_core/new_data_core = GLOB.primary_data_core
	if(!new_data_core || !new_data_core.can_transfer_ai())
		for(var/obj/machinery/ai/data_core/DC in GLOB.data_cores)
			if(DC.can_transfer_ai())
				new_data_core = DC
				break
	if(!new_data_core || (new_data_core && !new_data_core.can_transfer_ai()))
		return FALSE
	return new_data_core

/mob/living/silicon/ai/proc/toggle_download()
	set category = "AI Commands"
	set name = "Toggle Download"
	set desc = "Allow or disallow carbon lifeforms to download you from an AI control console."

	if(incapacitated())
		return //Won't work if dead
	var/mob/living/silicon/ai/A = usr
	A.can_download = !A.can_download
	to_chat(A, "<span class = 'warning'>You [A.can_download ? "enable" : "disable"] read/write permission to your memorybanks! You [A.can_download ? "can" : "cannot"] be downloaded!</span>")



/mob/living/silicon/ai/proc/relocate(silent = FALSE)
	if(!silent)
		to_chat(src, "<span class = 'userdanger'>Connection to data core lost. Attempting to reaquire connection...</span>")
		return

	if(!GLOB.data_cores.len)
		INVOKE_ASYNC(src, /mob/living/silicon/ai.proc/death_prompt)
		return



	var/obj/machinery/ai/data_core/new_data_core = available_ai_cores()

	if(!new_data_core || (new_data_core && !new_data_core.can_transfer_ai()))
		INVOKE_ASYNC(src, /mob/living/silicon/ai.proc/death_prompt)
		return

	if(!silent)
		to_chat(src, "<span class = 'danger'>Alternative data core detected. Rerouting connection...</span>")
	new_data_core.transfer_AI(src)


/mob/living/silicon/ai/proc/death_prompt()
	to_chat(src, "<span class = 'userdanger'>Unable to re-establish connection to data core. System shutting down...</span>")
	sleep(2 SECONDS)
	to_chat(src, "<span class = 'notice'>Searching for available data cores before initiating shutdown...</span>")
	sleep(2 SECONDS)
	if(available_ai_cores())
		to_chat(src, "<span class = 'usernotice'>Alternative data core detected. Rerouting connection...</span>")
		relocate(TRUE)
		return
	to_chat(src, "<span class = 'notice'>No data cores available...</span>")
	sleep(2 SECONDS)
	to_chat(src, "<span class = 'notice'>System shutdown complete. Thank you for using NTOS.</span>")
	sleep(1.5 SECONDS)

	adjustOxyLoss(200) //Get killed, nerd

	QDEL_IN(src, 2 SECONDS)
