/*
	Misc machines used to interact with artifact traits
*/

/obj/machinery/xenoarchaeology_machine
	icon = 'icons/obj/xenoarchaeology/xenoartifact_tech.dmi'
	///Do we move the artifact to our turf, or inside us?
	var/move_inside = FALSE
	///List of things we need to spit out
	var/list/held_contents = list()
	var/max_contents = 1

/obj/machinery/xenoarchaeology_machine/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_ARTIFACT_IGNORE, GENERIC_ITEM_TRAIT)

/obj/machinery/xenoarchaeology_machine/attackby(obj/item/I, mob/living/user, params)
	var/list/modifiers = params2list(params)
	var/atom/target = get_target()
	//Prechecks
	if(move_inside && length(held_contents) >= max_contents)
		return
	///Move the item to our target, so we can work with it, like we're a table
	if(user.a_intent != INTENT_HARM && !(I.item_flags & ABSTRACT))
		if(user.transferItemToLoc(I, target, silent = FALSE))
			//Center the icon where the user clicked.
			if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
				return
			//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
			I.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
			I.pixel_y = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)
			//Handle contents
			if(move_inside)
				register_contents(I)
	else
		return ..()

/obj/machinery/xenoarchaeology_machine/attack_hand(mob/living/user)
	. = ..()
	empty_contents()

/obj/machinery/xenoarchaeology_machine/proc/register_contents(atom/A)
	RegisterSignal(A, COMSIG_PARENT_QDELETING, PROC_REF(unregister_contents))
	RegisterSignal(A, COMSIG_MOVABLE_MOVED, PROC_REF(unregister_contents))
	held_contents += A

/obj/machinery/xenoarchaeology_machine/proc/unregister_contents(datum/source)
	SIGNAL_HANDLER

	held_contents -= source
	UnregisterSignal(source, COMSIG_PARENT_QDELETING)
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

/obj/machinery/xenoarchaeology_machine/proc/get_target()
	return move_inside ? src : drop_location()

/obj/machinery/xenoarchaeology_machine/proc/empty_contents(atom/movable/target, force)
	if(target && (list(target) & held_contents || force))
		target.forceMove(get_turf(src))
		unregister_contents(target)
		return
	for(var/atom/movable/A in held_contents)
		A.forceMove(get_turf(src))
		unregister_contents(A)

//Circuitboard
/obj/item/circuitboard/machine/xenoarchaeology_machine
	name = "place holder (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/xenoarchaeology_machine
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 5,
		/obj/item/stock_parts/matter_bin = 1)

/*
	Scale, measures artifact weight
*/
/obj/machinery/xenoarchaeology_machine/scale
	name = "industrial scale"
	desc = "A piece of industrial equipment, designed to weigh thousands of kilograms."
	icon_state = "scale"
	circuit = /obj/item/circuitboard/machine/xenoarchaeology_machine/scale

/obj/machinery/xenoarchaeology_machine/scale/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Interact to measure artifact weight.\nLabeled artifacts will also show label weights, against the total.</span>"

/obj/machinery/xenoarchaeology_machine/scale/attack_hand(mob/living/user)
	. = ..()
	///Get the combined weight of all artifacts in our target
	var/atom/target = get_target()
	var/total_weight = 0
	for(var/atom/A in target)
		var/datum/component/xenoartifact/X = A.GetComponent(/datum/component/xenoartifact)
		if(X)
			total_weight += X.get_material_weight()
		//If there's a label and we're obliged to 'help' the player
		var/obj/item/sticker/xenoartifact_label/L = locate(/obj/item/sticker/xenoartifact_label) in A.contents
		if(L)
			for(var/datum/xenoartifact_trait/T as() in L.traits)
				say("[initial(T.label_name)] - Weight: [initial(T.weight)]")
		else if(isitem(A) || isliving(A))
			if(isliving(A))
				if(prob(1))
					say("Unexpected Fatass Detected!")
					say("Get the fuck off me, lardass!")
				else
					say("Unexpected Item Detected!")
				return
	if(total_weight)
		say("Total Mass: [total_weight] KG.")
	else
		say("No Mass Detected!")
	playsound(src, 'sound/machines/uplinkpurchase.ogg', 50, TRUE)

//Circuitboard
/obj/item/circuitboard/machine/xenoarchaeology_machine/scale
	name = "industrial scale (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/xenoarchaeology_machine/scale

/*
	Conductor, measures artifact conductivty
*/
/obj/machinery/xenoarchaeology_machine/conductor
	name = "conducting plate"
	desc = "A piece of industrial equipment for measuring material conductivity."
	icon_state = "conductor"
	circuit = /obj/item/circuitboard/machine/xenoarchaeology_machine/conductor

/obj/machinery/xenoarchaeology_machine/conductor/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Interact to measure artifact conductivity.\nLabeled artifacts will also show label conductivity, against the total.</span>"

/obj/machinery/xenoarchaeology_machine/conductor/attack_hand(mob/living/user)
	. = ..()
	///Get the combined conductivity of all artifacts in our target
	var/atom/target = get_target()
	var/total_conductivity = 0
	for(var/atom/A in target)
		var/datum/component/xenoartifact/X = A.GetComponent(/datum/component/xenoartifact)
		if(X)
			total_conductivity += X.get_material_conductivity()
		//If there's a label and we're obliged to 'help' the player
		var/obj/item/sticker/xenoartifact_label/L = locate(/obj/item/sticker/xenoartifact_label) in A.contents
		if(L)
			for(var/datum/xenoartifact_trait/T as() in L.traits)
				say("[initial(T.label_name)] - conductivity: [initial(T.conductivity)]")
		else if(isitem(A) || isliving(A))
			if(isliving(A))
				if(prob(1))
					say("Unexpected Fatass Detected!")
					say("Get the fuck off me, lardass!")
				else
					say("Unexpected Item Detected!")
				return
	if(total_conductivity)
		say("Total Conductivity: [total_conductivity] MPC.")
	else
		say("No Conductivity Detected!")
	playsound(src, 'sound/machines/uplinkpurchase.ogg', 50, TRUE)

//Circuitboard
/obj/item/circuitboard/machine/xenoarchaeology_machine/conductor
	name = "conducting plate (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/xenoarchaeology_machine/conductor

/*
	Calibrator, calibrates artifacts
*/
/obj/machinery/xenoarchaeology_machine/calibrator
	name = "anomalous material calibrator"
	desc = "An experimental piece of scientific equipment, designed to calibrate anomalous materials."
	icon_state = "calibrator"
	move_inside = TRUE
	circuit = /obj/item/circuitboard/machine/xenoarchaeology_machine/calibrator
	///Which science server receives points
	var/datum/techweb/linked_techweb
	///radio used by the console to send messages on science channel
	var/obj/item/radio/headset/radio
	///Cooking logic
	var/cooking_time = 4 SECONDS
	var/cooking_timer

/obj/machinery/xenoarchaeology_machine/calibrator/tutorial/Initialize(mapload, _artifact_type)
	. = ..()
	var/obj/item/sticker/sticky_note/calibrator_tutorial/S = new(loc)
	S.afterattack(src, src, TRUE)
	unregister_contents(S)
	S.pixel_y = rand(-8, 8)
	S.pixel_x = rand(-8, 8)

/obj/machinery/xenoarchaeology_machine/calibrator/Initialize(mapload, _artifact_type)
	. = ..()
	//Link relevant stuff
	linked_techweb = SSresearch.science_tech
	//Radio setup
	radio = new /obj/item/radio/headset/headset_sci(src)

/obj/machinery/xenoarchaeology_machine/calibrator/Destroy()
	. = ..()
	QDEL_NULL(radio)
	if(cooking_timer)
		deltimer(cooking_timer)

/obj/machinery/xenoarchaeology_machine/calibrator/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-Click to calibrate inserted artifacts.\nArtifacts can be calibrated by labeling them 100% correctly, excluding malfunctions.</span>"

/obj/machinery/xenoarchaeology_machine/calibrator/attack_hand(mob/living/user)
	if(length(contents))
		return ..()
	else
		var/turf/T = get_turf(src)
		for(var/obj/item/I in T.contents)
			if(move_inside && length(held_contents) >= max_contents)
				return
			I.forceMove(src)
			register_contents(I)

/obj/machinery/xenoarchaeology_machine/calibrator/AltClick(mob/user)
	. = ..()
	if(!length(held_contents) || cooking_timer)
		playsound(get_turf(src), 'sound/machines/uplinkerror.ogg', 60)
		return
	playsound(src, 'sound/machines/uplinkpurchase.ogg', 50, TRUE)
	for(var/atom/A as() in contents-radio)
		var/solid_as = TRUE
		//Once we find an artifact-
		var/datum/component/xenoartifact/X = A.GetComponent(/datum/component/xenoartifact)
		//We then want to find a sticker attached to it-
		var/obj/item/sticker/xenoartifact_label/L = locate(/obj/item/sticker/xenoartifact_label) in A.contents
		//Early checks
		if(!X || !L || X?.calibrated || X?.calcified)
			var/decision = "No"
			if(!L && X)
				say("No label detected!")
				if(!X.calcified)
					decision = tgui_alert(user, "Do you want to continue, this will destroy [A]?", "Calcify Artifact", list("Yes", "No"))
			if(decision == "No")
				//This stops us from spitting out stuff we shouldn't, mostly
				if(A in held_contents)
					empty_contents(A)
				continue
			else
				solid_as = FALSE
		//Loop through traits and see if we're fucked or not
		var/score = 0
		var/max_score = 0
		if(solid_as) //This is kinda wacky but it's for a player option so idc
			for(var/i in X.artifact_traits)
				for(var/datum/xenoartifact_trait/T in X.artifact_traits[i])
					if(!(locate(T) in L.traits))
						if(T.contribute_calibration)
							solid_as = FALSE
					else
						score += 1
					max_score = T.contribute_calibration ?  max_score + 1 : max_score
		//FX
		INVOKE_ASYNC(src, PROC_REF(do_cooking_sounds), solid_as)
		cooking_timer = addtimer(CALLBACK(src, PROC_REF(finish_cooking), A, X, score, max_score, solid_as), cooking_time, TIMER_STOPPABLE)

/obj/machinery/xenoarchaeology_machine/calibrator/proc/do_cooking_sounds(status)
	playsound(src, 'sound/machines/capacitor_charge.ogg', 50, TRUE)
	sleep(2 SECONDS)
	playsound(src, 'sound/machines/capacitor_discharge.ogg', 50, TRUE)
	sleep(2 SECONDS)
	playsound(src, status ? 'sound/machines/microwave/microwave-end.ogg' : 'sound/machines/buzz-two.ogg', 50, TRUE)

/obj/machinery/xenoarchaeology_machine/calibrator/proc/finish_cooking(atom/A, datum/component/xenoartifact/X, score, max_score, solid_as)
	//Timer
	if(cooking_timer)
		deltimer(cooking_timer)
	cooking_timer = null
	empty_contents(A)
	//If we're cooked
	if(!solid_as)
		X.calcify()
		return
	//Scoring & success
	if(score)
		var/success_rate = score / max_score
		var/dp_reward = max(0, (A.custom_price*X.artifact_type.dp_rate)*success_rate)
		linked_techweb?.add_point_type(TECHWEB_POINT_TYPE_DISCOVERY, dp_reward)
		//Announce this, for honor or shame
		var/message = "[A] has been calibrated, and generated [dp_reward] Discovery Points!"
		say(message)
		radio?.talk_into(src, message, RADIO_CHANNEL_SCIENCE)
	//Calibrate the artifact
	X.calibrate()
	//Prompt user to delete or keep malfunctions
	var/decision = tgui_alert(usr, "Do you want to calcify [A]'s malfunctions?", "Remove Malfunctions", list("Yes", "No"))
	if(decision == "Yes")
		for(var/i in X.artifact_traits)
			for(var/datum/xenoartifact_trait/T in X.artifact_traits[i])
				if(istype(T, /datum/xenoartifact_trait/malfunction))
					qdel(T)

//Circuitboard
/obj/item/circuitboard/machine/xenoarchaeology_machine/calibrator
	name = "anomalous material calibrator (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/xenoarchaeology_machine/calibrator
