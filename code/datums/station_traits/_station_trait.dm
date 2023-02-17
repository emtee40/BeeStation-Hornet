///Base class of station traits. These are used to influence rounds in one way or the other by influencing the levers of the station.
///Remember to enable your station trait in config\game_options.txt! (search for "STATION TRAITS")
/datum/station_trait
	///Name of the trait
	var/name = "unnamed station trait"
	///The trait's id, which tends to just be the name of the datum
	var/id = "unidentified"
	///The type of this trait. Used to classify how this trait influences the station
	var/trait_type = STATION_TRAIT_NEUTRAL
	///Whether or not this trait uses process()
	var/trait_processes = FALSE
	///Chance relative to other traits of its type to be picked
	var/weight = 10
	///Does this trait show in the centcom report?
	var/show_in_report = FALSE
	///What message to show in the centcom report?
	var/report_message
	///What code-trait does this station trait give? gives none if null
	var/trait_to_give
	///What traits are incompatible with this one?
	var/blacklist
	///Extra flags for station traits such as it being abstract
	var/trait_flags
	///Should we announce anything roundstart? If so, those are our options
	var/list/possible_announcements


/datum/station_trait/New()
	. = ..()
	SSticker.OnRoundstart(CALLBACK(src, .proc/on_round_start))
	if(trait_processes)
		START_PROCESSING(SSstation, src)
	if(trait_to_give)
		ADD_TRAIT(SSstation, trait_to_give, STATION_TRAIT)

///Proc ran when round starts. Use this for roundstart effects.
/datum/station_trait/proc/on_round_start()
	if(length(possible_announcements))
		priority_announce(pick(possible_announcements), null, null, has_important_message = TRUE)

///type of info the centcom report has on this trait, if any.
/datum/station_trait/proc/get_report()
	return "[name] - [report_message]"
