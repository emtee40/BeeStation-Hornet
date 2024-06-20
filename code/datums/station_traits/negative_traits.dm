/datum/station_trait/announcement_intern
	name = "Announcement Intern"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Please be nice to him."
	blacklist = list(/datum/station_trait/announcement_medbot,
	/datum/station_trait/announcement_baystation
	)

/datum/station_trait/announcement_intern/New()
	. = ..()
	SSstation.announcer = /datum/centcom_announcer/intern

/datum/station_trait/carp_infestation
	name = "Carp infestation"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Dangerous fauna is present in the area of this station."
	trait_to_give = STATION_TRAIT_CARP_INFESTATION

/datum/station_trait/distant_supply_lines
	name = "Distant supply lines"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Due to the distance to our normal supply lines, cargo orders are more expensive."
	blacklist = list(/datum/station_trait/strong_supply_lines)
	trait_to_give = STATION_TRAIT_DISTANT_SUPPLY_LINES

/datum/station_trait/random_spawns
	name = "Drive-by landing"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Sorry for that, we missed your station by a few miles, so we just launched you towards your station in pods. Hope you don't mind!"
	trait_to_give = STATION_TRAIT_RANDOM_ARRIVALS
	blacklist = list(/datum/station_trait/hangover)
	possible_announcements = list("We overshot your station by a few miles. Prepare to be pod launched onto it.",
								"We've missed your station, sorry for that. You will be launched onto it shortly.")

/datum/station_trait/hangover
	name = "Hangover"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Ohh.... Man.... That mandatory office party from last shift... God that was awesome... I woke up in some random toilet 3 sectors away..."
	trait_to_give = STATION_TRAIT_HANGOVER
	blacklist = list(/datum/station_trait/random_spawns)
	possible_announcements = list("That was one hell of a night. Now, get back to work.",
								"Party's over. Get back to work.")

/datum/station_trait/hangover/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))
	RegisterSignal(SSmapping, COMSIG_SUBSYSTEM_POST_INITIALIZE, PROC_REF(create_spawners))

/datum/station_trait/hangover/proc/create_spawners()
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(pick_turfs_and_spawn))
	UnregisterSignal(SSmapping, COMSIG_SUBSYSTEM_POST_INITIALIZE)

/datum/station_trait/hangover/proc/pick_turfs_and_spawn()
	var/list/turf/turfs = get_safe_random_station_turfs(typesof(/area/hallway) | typesof(/area/crew_quarters/bar) | typesof(/area/crew_quarters/dorms), rand(200, 300))
	for(var/turf/T as() in turfs)
		new /obj/effect/spawner/hangover_spawn(T)

/datum/station_trait/hangover/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/living_mob, mob/spawned_mob, joined_late)
	SIGNAL_HANDLER

	if(joined_late || !iscarbon(living_mob))
		return

	var/mob/living/carbon/spawned_carbon = living_mob
	spawned_carbon.set_resting(TRUE, silent = TRUE)
	if(prob(50))
		spawned_carbon.adjust_drugginess(rand(15, 20))
	else
		spawned_carbon.drunkenness += rand(15, 25)
	spawned_carbon.adjust_disgust(rand(5, 55)) //How hungover are you?

	if(prob(35) && !spawned_carbon.head)
		var/obj/item/hat = pick(list(/obj/item/clothing/head/costume/sombrero, /obj/item/clothing/head/fedora, /obj/item/clothing/mask/balaclava, /obj/item/clothing/head/costume/ushanka, /obj/item/clothing/head/costume/cardborg, /obj/item/clothing/head/costume/pirate, /obj/item/clothing/head/cone))
		hat = new hat(spawned_mob)
		spawned_mob.equip_to_slot(hat, ITEM_SLOT_HEAD)

/datum/station_trait/blackout
	name = "Blackout"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Station lights seem to be damaged, be safe when starting your shift today."

/datum/station_trait/blackout/on_round_start()
	. = ..()
	for(var/a in GLOB.apcs_list)
		var/obj/machinery/power/apc/current_apc = a
		if(prob(60))
			current_apc.overload_lighting()

/datum/station_trait/empty_maint
	name = "Cleaned out maintenance"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Our workers cleaned out most of the junk in the maintenace areas."
	blacklist = list(/datum/station_trait/filled_maint)
	trait_to_give = STATION_TRAIT_EMPTY_MAINT


/datum/station_trait/overflow_job_bureacracy
	name = "Overflow bureacracy mistake"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 5
	show_in_report = TRUE
	var/list/jobs_to_use = list(JOB_NAME_CLOWN, JOB_NAME_BARTENDER, JOB_NAME_COOK, JOB_NAME_BOTANIST, JOB_NAME_CARGOTECHNICIAN, JOB_NAME_MIME, JOB_NAME_JANITOR)
	var/chosen_job

/datum/station_trait/overflow_job_bureacracy/New()
	. = ..()
	chosen_job = pick(jobs_to_use)
	RegisterSignal(SSjob, COMSIG_SUBSYSTEM_POST_INITIALIZE, PROC_REF(set_overflow_job_override))

/datum/station_trait/overflow_job_bureacracy/get_report()
	return "[name] - It seems for some reason we put out the wrong job-listing for the overflow role this shift...I hope you like [chosen_job]s."

/datum/station_trait/overflow_job_bureacracy/proc/set_overflow_job_override(datum/source, new_overflow_role)
	SIGNAL_HANDLER

	SSjob.set_overflow_role(chosen_job)

/datum/station_trait/slow_shuttle
	name = "Slow Shuttle"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Due to distance to our supply station, the cargo shuttle will have a slower flight time to your cargo department."
	blacklist = list(/datum/station_trait/quick_shuttle)

/datum/station_trait/slow_shuttle/on_round_start()
	. = ..()
	SSshuttle.supply.callTime *= 1.5

/datum/station_trait/bot_languages
	name = "Bot Language Matrix Malfunction"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Your station's friendly bots have had their language matrix fried due to an event, resulting in some strange and unfamiliar speech patterns."

/datum/station_trait/bot_languages/New()
	. = ..()
	/// What "caused" our robots to go haywire (fluff)
	var/event_source = pick(list("an ion storm", "a syndicate hacking attempt", "a malfunction", "issues with your onboard AI", "an intern's mistakes", "budget cuts"))
	report_message = "Your station's friendly bots have had their language matrix fried due to [event_source], resulting in some strange and unfamiliar speech patterns."

/datum/station_trait/bot_languages/on_round_start()
	. = ..()
	//All bots that exist round start have their set language randomized.
	for(var/mob/living/simple_animal/bot/found_bot in GLOB.alive_mob_list)
		/// The bot's language holder - so we can randomize and change their language
		var/datum/language_holder/bot_languages = found_bot.get_language_holder()
		bot_languages.selected_language = bot_languages.get_random_spoken_language()

/datum/station_trait/united_budget
	name = "United Department Budget Management"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Your station has been selected for one of our financial experiments! All station budgets have been united into one, and all budget cards will be linked to one account!"
	trait_to_give = STATION_TRAIT_UNITED_BUDGET

/datum/station_trait/united_budget/New()
	. = ..()
	var/event_source = pick(list("As your station has been selected for one of our financial experiments,",
		                         "Our financial planner has decided:",
		                         "Our new AI financial plan support module has generated a new budgeting system:",
		                         "We thought the current budget categorisation system was too complicated, so",
		                         "It appears one of your superiors has it out for you, so",
		                         "The Syndicate damaged documents on procedures for the station's budgeting system, so",
		                         "Due to our intern having free reign over the station budget system,",
		                         "Thanks to our financial intern,",
		                         "Due to the budget cuts in Nanotrasen Space Finance,",
		                         "Since \[REDACTED\] has been \[REDACTED\] by \[REDACTED\],"))
	report_message = "[event_source] all station budgets have been united into one, and all budget cards will be linked to one account."
