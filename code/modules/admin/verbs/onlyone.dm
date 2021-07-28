GLOBAL_VAR_INIT(highlander, FALSE)
/client/proc/only_one() //Gives everyone kilts, berets, claymores, and pinpointers, with the objective to hijack the emergency shuttle.
	if(!SSticker.HasRoundStarted())
		alert("The game hasn't started yet!")
		return
	GLOB.highlander = TRUE

	send_to_playing_players(span_boldannounce("<font size=6>THERE CAN BE ONLY ONE</font>"))

	for(var/obj/item/disk/nuclear/N in GLOB.poi_list)
		var/datum/component/stationloving/component = N.GetComponent(/datum/component/stationloving)
		if (component)
			component.relocate() //Gets it out of bags and such

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat == DEAD || !(H.client))
			continue
		H.make_scottish()

	message_admins(span_adminnotice("[key_name_admin(usr)] used THERE CAN BE ONLY ONE!"))
	log_admin("[key_name(usr)] used THERE CAN BE ONLY ONE.")
	addtimer(CALLBACK(SSshuttle.emergency, /obj/docking_port/mobile/emergency.proc/request, null, 1), 50)

/client/proc/only_one_delayed()
	send_to_playing_players(span_userdanger("Bagpipes begin to blare. You feel Scottish pride coming over you."))
	message_admins(span_adminnotice("[key_name_admin(usr)] used (delayed) THERE CAN BE ONLY ONE!"))
	log_admin("[key_name(usr)] used delayed THERE CAN BE ONLY ONE.")
	addtimer(CALLBACK(src, .proc/only_one), 420)

/mob/living/carbon/human/proc/make_scottish()
	mind.add_antag_datum(/datum/antagonist/highlander)