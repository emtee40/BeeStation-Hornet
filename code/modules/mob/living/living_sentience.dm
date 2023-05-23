//WHY ISN'T THIS COMPONENT

/mob/living/ghostize(can_reenter_corpse, sentience_retention)
	. = ..()
	switch(sentience_retention)
		if (SENTIENCE_RETAIN)
			if (playable)	//so the alert goes through for observing ghosts
				set_playable()
		if (SENTIENCE_FORCE)
			set_playable()
		if (SENTIENCE_ERASE)
			playable = FALSE

/mob/living/attack_ghost(mob/user)
	. = ..()
	if(.)
		return
	give_mind(user)

/mob/living/Topic(href, href_list)
	if(..())
		return
	if(href_list["activate"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost) && playable)
			give_mind(ghost)

/mob/living/proc/give_mind(mob/user)
	if(key || !playable || stat)
		return 0
	var/question = alert("Do you want to become [name]?", "[name]", "Yes", "No")
	if(question != "Yes" || !src || QDELETED(src))
		return TRUE
	if(key)
		to_chat(user, "<span class='notice'>Someone else already took [name].</span>")
		return TRUE
	if(!user?.client.canGhostRole(role, TRUE, flags_1))
		return
	key = user.key
	log_game("[key_name(src)] took control of [name].")
	remove_from_spawner_menu()
	if(get_spawner_flavour_text())
		to_chat(src, "<span class='notice'>[get_spawner_flavour_text()]</span>")
	return TRUE

// this exists because some 'playable=TRUE' mobs are not actually playable because mob key is automatically given
// it prevents 'GLOB.poi_list' being glitched. without this, it will show xeno(or some mobs) twice in orbit panel.
/mob/living/proc/delayed_set_playable(called_again=FALSE)
	set waitfor = 0 // I didn't want to use 'addtimer(CALLBACK(), 2 SECONDS)' so I tried this instead
	if(called_again)
		sleep(20)
		set_playable()
		return
	delayed_set_playable(TRUE) // need to call this again because Init() proc is waiting for this

/mob/living/proc/set_playable()
	playable = TRUE
	if (!key)	//check if there is nobody already inhibiting this mob
		notify_ghosts("[name] can be controlled", null, enter_link="<a href=?src=[REF(src)];activate=1>(Click to play)</a>", source=src, action=NOTIFY_ATTACK, ignore_key = name)
		LAZYADD(GLOB.mob_spawners["[name]"], src)
		GLOB.poi_list |= src
		SSmobs.update_spawners()
	else // it's spawned but someone occupied already
		notify_ghosts("[name] has appeared!", source=src, action=NOTIFY_ORBIT, header="Something's Interesting!")


/mob/living/get_spawner_desc()
	return "Become [name]."

/mob/living/get_spawner_flavour_text()
	switch (flavor_text)
		if (FLAVOR_TEXT_EVIL)
			return "You are a untamed creature with no reason to hold back. Kill anyone you see as a threat to you or your cause."
		if (FLAVOR_TEXT_GOOD)
			return "Remember, you have no hate towards the inhabitants of the station. There is no reason for you to attack them unless you are attacked."
		if (FLAVOR_TEXT_GOAL_ANTAG)
			return "You have a disdain for the inhabitants of this station, but your goals are more important. Make sure you work towards your objectives with your kin, instead of attacking everything on sight."
	return flavor_text

/mob/living/proc/remove_from_spawner_menu()
	for(var/spawner in GLOB.mob_spawners)
		GLOB.mob_spawners[spawner] -= src
		if(!length(GLOB.mob_spawners[spawner]))
			GLOB.mob_spawners -= spawner
		SSmobs.update_spawners()
	GLOB.poi_list -= src
