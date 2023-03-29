/mob/living/simple_animal/bot/secbot/grievous //This bot is powerful. If you managed to get 4 eswords somehow, you deserve this horror. Emag him for best results.
	name = "General Beepsky"
	desc = "Is that a secbot with four eswords in its arms...?"
	icon = 'icons/mob/aibots.dmi'
	icon_state = "grievous"
	health = 150
	maxHealth = 150
	baton_type = /obj/item/melee/transforming/energy/sword/saber
	base_speed = 4 //he's a fast fucker
	var/obj/item/weapon
	var/block_chance = 50
	noloot = FALSE


/mob/living/simple_animal/bot/secbot/grievous/toy //A toy version of general beepsky!
	name = "Genewul Bweepskee"
	desc = "An adorable looking secbot with four toy swords taped to its arms"
	health = 50
	maxHealth = 50
	baton_type = /obj/item/toy/sword

/mob/living/simple_animal/bot/secbot/grievous/nullcrate
	name = "General Griefsky"
	desc = "The Syndicate sends their regards."
	emagged = 2
	noloot = TRUE
	faction = list(ROLE_SYNDICATE)

/mob/living/simple_animal/bot/secbot/grievous/nullcrate/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_CONTENTS | EMP_PROTECT_WIRES)

/mob/living/simple_animal/bot/secbot/grievous/bullet_act(obj/item/projectile/P)
	visible_message("[src] deflects [P] with its energy swords!")
	playsound(src, 'sound/weapons/blade1.ogg', 50, TRUE)
	return BULLET_ACT_BLOCK

/mob/living/simple_animal/bot/secbot/grievous/on_entered(datum/source, atom/movable/AM)
	. = ..()
	if(ismob(AM) && AM == target)
		visible_message("[src] flails his swords and cuts [AM]!")
		playsound(src,'sound/effects/beepskyspinsabre.ogg',100,TRUE,-1)
		INVOKE_ASYNC(src, PROC_REF(stun_attack), AM)

/mob/living/simple_animal/bot/secbot/grievous/Initialize(mapload)
	. = ..()
	weapon = new baton_type(src)
	weapon.attack_self(src)

/mob/living/simple_animal/bot/secbot/grievous/Destroy()
	QDEL_NULL(weapon)
	return ..()

/mob/living/simple_animal/bot/secbot/grievous/special_retaliate_after_attack(mob/user)
	if(mode != BOT_HUNT)
		return
	if(prob(block_chance))
		visible_message("[src] deflects [user]'s attack with his energy swords!")
		playsound(src, 'sound/weapons/blade1.ogg', 50, TRUE, -1)
		return TRUE

/mob/living/simple_animal/bot/secbot/grievous/stun_attack(mob/living/carbon/C) //Criminals don't deserve to live
	weapon.attack(C, src)
	playsound(src, 'sound/weapons/blade1.ogg', 50, TRUE, -1)
	if(C.stat == DEAD)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_icon)), 2)
		back_to_idle()


/mob/living/simple_animal/bot/secbot/grievous/handle_automated_action()
	if(!on)
		return
	switch(mode)
		if(BOT_IDLE)		// idle
			update_icon()
			SSmove_manager.stop_looping(src)
			look_for_perp()	// see if any criminals are in range
			if(!mode && auto_patrol)	// still idle, and set to patrol
				mode = BOT_START_PATROL	// switch to patrol mode
		if(BOT_HUNT)		// hunting for perp
			update_icon()
			playsound(src,'sound/effects/beepskyspinsabre.ogg',100,TRUE,-1)
			// general beepsky doesn't give up so easily, jedi scum
			if(frustration >= 20)
				SSmove_manager.stop_looping(src)
				back_to_idle()
				return
			if(target)		// make sure target exists
				if(Adjacent(target) && isturf(target.loc))	// if right next to perp
					target_lastloc = target.loc //stun_attack() can clear the target if they're dead, so this needs to be set first
					stun_attack(target)
					anchored = TRUE
					return
				else								// not next to perp
					var/turf/olddist = get_dist(src, target)
					SSmove_manager.move_to(src, target, 1, 4)
					if((get_dist(src, target)) >= (olddist))
						frustration++
					else
						frustration = 0
			else
				back_to_idle()

		if(BOT_START_PATROL)
			look_for_perp()
			start_patrol()

		if(BOT_PATROL)
			look_for_perp()
			bot_patrol()

/mob/living/simple_animal/bot/secbot/grievous/look_for_perp()
	anchored = FALSE
	var/judgment_criteria = judgment_criteria()
	for (var/mob/living/carbon/C in view(7,src)) //Let's find us a criminal
		if((C.stat) || (C.handcuffed))
			continue

		if((C.name == oldtarget_name) && (world.time < last_found + 100))
			continue

		threatlevel = C.assess_threat(judgment_criteria, weaponcheck=CALLBACK(src, PROC_REF(check_for_weapons)))

		if(!threatlevel)
			continue

		else if(threatlevel >= 4)
			target = C
			oldtarget_name = C.name
			speak("Level [threatlevel] infraction alert!")
			playsound(src, pick('sound/voice/beepsky/criminal.ogg', 'sound/voice/beepsky/justice.ogg', 'sound/voice/beepsky/freeze.ogg'), 50, FALSE)
			playsound(src,'sound/weapons/saberon.ogg',50,TRUE,-1)
			visible_message("[src] ignites his energy swords!")
			icon_state = "grievous-c"
			visible_message("<b>[src]</b> points at [C.name]!")
			mode = BOT_HUNT
			INVOKE_ASYNC(src, PROC_REF(handle_automated_action))
			break
		else
			continue


/mob/living/simple_animal/bot/secbot/grievous/explode()

	visible_message("<span class='boldannounce'>[src] lets out a huge cough as it blows apart!</span>")
	var/atom/Tsec = drop_location()

	var/obj/item/bot_assembly/secbot/Sa = new (Tsec)
	Sa.build_step = 1
	Sa.add_overlay("hs_hole")
	Sa.created_name = name
	new /obj/item/assembly/prox_sensor(Tsec)

	if(prob(50))
		drop_part(robot_arm, Tsec)

	do_sparks(3, TRUE, src)
	if(!noloot)
		for(var/IS = 0 to 4)
			drop_part(baton_type, Tsec)
	new /obj/effect/decal/cleanable/oil(Tsec)
	qdel(src)
