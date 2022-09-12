#define REPORT_WAIT_TIME_MINIMUM 600
#define REPORT_WAIT_TIME_MAXIMUM 1500

PROCESSING_SUBSYSTEM_DEF(station)
	name = "Station"
	init_order = INIT_ORDER_STATION
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	wait = 5 SECONDS

	///A list of currently active station traits
	var/list/station_traits
	///Assoc list of trait type || assoc list of traits with weighted value. Used for picking traits from a specific category.
	var/list/selectable_traits_by_types
	///Currently active announcer. Starts as a type but gets initialized after traits are selected
	var/datum/centcom_announcer/announcer = /datum/centcom_announcer/default

/datum/controller/subsystem/processing/station/Initialize(timeofday)

	station_traits = list()
	selectable_traits_by_types = list(STATION_TRAIT_POSITIVE = list(), STATION_TRAIT_NEUTRAL = list(), STATION_TRAIT_NEGATIVE = list())

	//station_traits += new /datum/station_trait/united_budget
	prepare_report()

	announcer = new announcer() //Initialize the station's announcer datum

	return ..()

///Rolls for the amount of traits and adds them to the traits list
/datum/controller/subsystem/processing/station/proc/setup_traits()
	for(var/i in subtypesof(/datum/station_trait))
		var/datum/station_trait/trait_typepath = i
		if(initial(trait_typepath.trait_flags) & STATION_TRAIT_ABSTRACT)
			continue //Dont add abstract ones to it
		selectable_traits_by_types[initial(trait_typepath.trait_type)][trait_typepath] = initial(trait_typepath.weight)

	var/positive_trait_count = pick(20;0, 5;1, 1;2)
	var/neutral_trait_count = pick(10;0, 10;1, 3;2)
	var/negative_trait_count = pick(20;0, 5;1, 1;2)

	pick_traits(STATION_TRAIT_POSITIVE, positive_trait_count)
	pick_traits(STATION_TRAIT_NEUTRAL, neutral_trait_count)
	pick_traits(STATION_TRAIT_NEGATIVE, negative_trait_count)


///Picks traits of a specific category (e.g. bad or good) and a specified amount, then initializes them and adds them to the list of traits.
/datum/controller/subsystem/processing/station/proc/pick_traits(trait_type, amount)
	if(!amount)
		return
	for(var/iterator in 1 to amount)
		var/datum/station_trait/picked_trait = pickweight(selectable_traits_by_types[trait_type]) //Rolls from the table for the specific trait type
		if(!picked_trait)
			return
		picked_trait = new picked_trait()
		station_traits += picked_trait
		selectable_traits_by_types[picked_trait.trait_type] -= picked_trait.type		//We don't want it to roll trait twice
		if(!picked_trait.blacklist)
			continue
		for(var/i in picked_trait.blacklist)
			var/datum/station_trait/trait_to_remove = i
			selectable_traits_by_types[initial(trait_to_remove.trait_type)] -= trait_to_remove

/datum/controller/subsystem/processing/station/proc/prepare_report()
	if(!station_traits.len)		//no active traits why bother
		return

	var/report = "<b><i>Central Command Divergency Report</i></b><hr>"

	for(var/datum/station_trait/trait as() in station_traits)
		if(trait.trait_flags & STATION_TRAIT_ABSTRACT)
			continue
		if(!trait.report_message || !trait.show_in_report)
			continue
		report += "[trait.get_report()]<BR><hr>"

	addtimer(CALLBACK(GLOBAL_PROC, .proc/print_command_report, report, "Central Command Divergency Report", FALSE), rand(REPORT_WAIT_TIME_MINIMUM, REPORT_WAIT_TIME_MAXIMUM))

#undef REPORT_WAIT_TIME_MINIMUM
#undef REPORT_WAIT_TIME_MAXIMUM
