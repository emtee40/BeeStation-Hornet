#define SPIDER_IDLE 0
#define SPINNING_WEB 1
#define LAYING_EGGS 2
#define MOVING_TO_TARGET 3
#define SPINNING_COCOON 4

/mob/living/simple_animal/hostile/poison
	mobchatspan = "researchdirector"
	var/poison_per_bite = 5
	var/poison_type = /datum/reagent/toxin

/mob/living/simple_animal/hostile/poison/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(poison_per_bite && L.reagents)
			L.reagents.add_reagent(poison_type, poison_per_bite)

//The base "Spider" mob
/mob/living/simple_animal/hostile/poison/giant_spider
	name = "giant spider"
	desc = "Furry and black, it makes you shudder to look at it. This one has deep red eyes."
	icon_state = "guard"
	icon_living = "guard"
	icon_dead = "guard_dead"
	mob_biotypes = list(MOB_ORGANIC, MOB_BUG)
	speak_emote = list("chitters")
	emote_hear = list("chitters")
	speak_chance = 5
	speed = 2
	turns_per_move = 5
	see_in_dark = 10
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/spider = 2, /obj/item/reagent_containers/food/snacks/spiderleg = 8)
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "hits"
	initial_language_holder = /datum/language_holder/spider // Speaks buzzwords, understands buzzwords and common
	maxHealth = 80
	health = 80
	obj_damage = 30
	melee_damage = 20
	faction = list("spiders")
	pass_flags = PASSTABLE
	move_to_delay = 6
	ventcrawler = VENTCRAWLER_ALWAYS
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'
	unique_name = 1
	gold_core_spawnable = HOSTILE_SPAWN
	see_in_dark = 4
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	var/busy = SPIDER_IDLE // What a spider's doing
	var/datum/action/innate/spider/lay_web/lay_web // Web action
	var/web_speed // How quickly a spider lays down webs
	var/directive = "" // Message passed down to children, to relay the creator's orders

	do_footstep = TRUE
	discovery_points = 1000

/mob/living/simple_animal/hostile/poison/giant_spider/Initialize(mapload)
	. = ..()
	lay_web = new
	lay_web.Grant(src)

/mob/living/simple_animal/hostile/poison/giant_spider/Destroy()
	QDEL_NULL(lay_web)
	GLOB.spidermobs -= src
	return ..()

/mob/living/simple_animal/hostile/poison/giant_spider/Login()
	..()
	if(directive)
		to_chat(src, "<span class='spiderlarge'>Your mother left you a directive! Follow it at all costs.</span>")
		to_chat(src, "<span class='spiderlarge'><b>Directive: [directive]</b></span>")
		if(mind)
			mind.store_memory("<span class='spiderlarge'><b>Directive: [directive]</b></span>")
	SSmove_manager.stop_looping(src) // Just in case the AI's doing anything when we give them the mind
	GLOB.spidermobs[src] = TRUE

/mob/living/simple_animal/hostile/poison/giant_spider/give_mind(mob/user)
	..()
	if(directive)
		log_game("[key_name(src)] took control of [name] with the objective: '[directive]'.")
	return TRUE

/mob/living/simple_animal/hostile/poison/giant_spider/handle_automated_action()
	if(!..()) //AIStatus is off
		return FALSE
	if(AIStatus == AI_IDLE)
		if(!busy && prob(10))
			stop_automated_movement = TRUE
			Goto(pick(urange(20, src, 1)), move_to_delay)
			addtimer(CALLBACK(src, .proc/do_action), 5 SECONDS)
		return TRUE // We're idle, thus free to do stuff

/mob/living/simple_animal/hostile/poison/giant_spider/proc/do_action()
	stop_automated_movement = FALSE
	SSmove_manager.stop_looping(src)

//Nurses lay eggs and can heal other spiders.
/mob/living/simple_animal/hostile/poison/giant_spider/nurse
	desc = "Furry and black, it makes you shudder to look at it. This one has brilliant green eyes."
	icon_state = "nurse"
	icon_living = "nurse"
	icon_dead = "nurse_dead"
	gender = FEMALE
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/spider = 2, /obj/item/reagent_containers/food/snacks/spiderleg = 8, /obj/item/reagent_containers/food/snacks/spidereggs = 4)
	maxHealth = 40
	health = 40
	melee_damage = 10
	poison_per_bite = 3
	speed = 1 // A bit faster than midwives
	var/atom/movable/cocoon_target
	var/mob/living/simple_animal/hostile/poison/giant_spider/heal_target
	var/fed = 0
	var/enriched_fed = 0
	var/obj/effect/proc_holder/wrap/wrap
	var/datum/action/innate/spider/lay_eggs/lay_eggs
	var/datum/action/innate/spider/set_directive/set_directive
	var/static/list/consumed_mobs = list() //the tags of mobs that have been consumed by nurse spiders to lay eggs
	gold_core_spawnable = NO_SPAWN
	web_speed = 0.25
	///The health HUD applied to the mob.
	var/health_hud = DATA_HUD_MEDICAL_ADVANCED

/mob/living/simple_animal/hostile/poison/giant_spider/nurse/Initialize(mapload)
	. = ..()
	wrap = new
	AddAbility(wrap)
	lay_eggs = new
	lay_eggs.Grant(src)
	set_directive = new
	set_directive.Grant(src)
	var/datum/atom_hud/datahud = GLOB.huds[health_hud]
	datahud.add_hud_to(src)

/mob/living/simple_animal/hostile/poison/giant_spider/nurse/Destroy()
	RemoveAbility(wrap)
	QDEL_NULL(lay_eggs)
	QDEL_NULL(set_directive)
	return ..()

// Allows nurses to heal other spiders if they're adjacent
/mob/living/simple_animal/hostile/poison/giant_spider/nurse/AttackingTarget()
	if(is_busy)
		return
	if(!istype(target, /mob/living/simple_animal/hostile/poison/giant_spider))
		return ..()
	var/mob/living/simple_animal/hostile/poison/giant_spider/hurt_spider = target
	if(hurt_spider == src)
		to_chat(src, "<span class='warning'>You don't have the dexerity to wrap your own wounds.</span>")
		return
	if(hurt_spider.health >= hurt_spider.maxHealth)
		to_chat(src, "<span class='warning'>You can't find any wounds to wrap up.</span>")
		return
	visible_message("<span class='notice'>[src] begins wrapping the wounds of [hurt_spider].</span>","<span class='notice'>You begin wrapping the wounds of [hurt_spider].</span>")
	is_busy = TRUE
	if(do_after(src, 20, target = hurt_spider))
		hurt_spider.heal_overall_damage(20, 20)
		new /obj/effect/temp_visual/heal(get_turf(hurt_spider), "#80F5FF")
		visible_message("<span class='notice'>[src] wraps the wounds of [hurt_spider].</span>","<span class='notice'>You wrap the wounds of [hurt_spider].</span>")
	is_busy = FALSE

// Nurse AI Handling
// Handles automatically attacking, webbing, and healing.
/mob/living/simple_animal/hostile/poison/giant_spider/nurse/handle_automated_action()
	if(..())
		var/list/can_see = view(10, src)
		if(!busy)
			//first, check for potential food nearby to cocoon
			for(var/mob/living/C in can_see)
				if(istype(C, /mob/living/simple_animal/hostile/poison/giant_spider) && C.stat != DEAD && C.health < C.maxHealth)
					heal_target = C
				else if(C.stat && !C.anchored)
					cocoon_target = C
				if(cocoon_target || heal_target)
					busy = MOVING_TO_TARGET
					Goto(C, move_to_delay)
					//give up if we can't reach them after 10 seconds
					addtimer(CALLBACK(src, .proc/GiveUp, C), 10 SECONDS)
					return

			//second, spin a sticky spiderweb on this tile
			var/obj/structure/spider/stickyweb/W = locate() in get_turf(src)
			if(!W)
				lay_web.Activate()
			else
				//third, lay an egg cluster there if we can
				if(fed || enriched_fed)
					lay_eggs.Activate()
				else
					//fourthly, cocoon any nearby items so those pesky pinkskins can't use them
					for(var/obj/O in can_see)

						if(O.anchored)
							continue

						if(isitem(O) || isstructure(O) || ismachinery(O))
							cocoon_target = O
							busy = MOVING_TO_TARGET
							stop_automated_movement = TRUE
							Goto(O, move_to_delay)
							//give up if we can't reach them after 10 seconds
							addtimer(CALLBACK(src, .proc/GiveUp, O), 10 SECONDS)
							break

		else if(busy == MOVING_TO_TARGET)
			if(cocoon_target && get_dist(src, cocoon_target) <= 1)
				cocoon()
			else if (heal_target && get_dist(src, heal_target) <= 1)
				UnarmedAttack(heal_target)

	else
		busy = SPIDER_IDLE
		stop_automated_movement = FALSE

/mob/living/simple_animal/hostile/poison/giant_spider/nurse/proc/GiveUp(C)
	if(busy == MOVING_TO_TARGET)
		cocoon_target = null
		heal_target = null
		busy = FALSE
		stop_automated_movement = FALSE
		SSmove_manager.stop_looping(src)

// Handles cocooning items
/mob/living/simple_animal/hostile/poison/giant_spider/nurse/proc/cocoon()
	if(stat != DEAD && cocoon_target && !cocoon_target.anchored)
		if(cocoon_target == src)
			to_chat(src, "<span class='warning'>You can't wrap yourself!</span>")
			return
		if(istype(cocoon_target, /mob/living/simple_animal/hostile/poison/giant_spider))
			to_chat(src, "<span class='warning'>You can't wrap other spiders!</span>")
			return
		if(!Adjacent(cocoon_target))
			to_chat(src, "<span class='warning'>You can't reach [cocoon_target]!</span>")
			return
		if(busy == SPINNING_COCOON)
			to_chat(src, "<span class='warning'>You're already spinning a cocoon!</span>")
			return //we're already doing this, don't cancel out or anything
		busy = SPINNING_COCOON
		visible_message("<span class='notice'>[src] begins to secrete a sticky substance around [cocoon_target].</span>","<span class='notice'>You begin wrapping [cocoon_target] into a cocoon.</span>")
		stop_automated_movement = TRUE
		SSmove_manager.stop_looping(src)
		if(do_after(src, 50, target = cocoon_target))
			if(busy == SPINNING_COCOON)
				var/obj/structure/spider/cocoon/C = new(cocoon_target.loc)
				if(isliving(cocoon_target))
					var/mob/living/L = cocoon_target
					if(L.blood_volume && (L.stat != DEAD || !consumed_mobs[L.tag])) //if they're not dead, you can consume them anyway
						if(istype(L, /mob/living/carbon/human))
							enriched_fed++
						else
							fed++
						consumed_mobs[L.tag] = TRUE
						health = maxHealth //heal up from feeding.
						lay_eggs.UpdateButtonIcon(TRUE)
						visible_message("<span class='danger'>[src] sticks a proboscis into [L] and sucks a viscous substance out.</span>","<span class='notice'>You suck the nutriment out of [L], feeding you enough to lay a cluster of eggs.</span>")
						L.death() //you just ate them, they're dead.
					else
						to_chat(src, "<span class='warning'>[L] cannot sate your hunger!</span>")
				cocoon_target.forceMove(C)

				if(cocoon_target.density || ismob(cocoon_target))
					C.icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
	cocoon_target = null
	busy = SPIDER_IDLE
	stop_automated_movement = FALSE

//midwives are the queen of the spiders, can send messages to all them and web faster.
/mob/living/simple_animal/hostile/poison/giant_spider/nurse/midwife
	name = "midwife"
	desc = "Furry and black, it makes you shudder to look at it. This one has scintillating green eyes."
	icon_state = "midwife"
	icon_living = "midwife"
	icon_dead = "midwife_dead"
	web_speed = 0.15 // Easily able to web
	// Allows the spider to use spider comms
	var/datum/action/innate/spider/comm/letmetalkpls

/mob/living/simple_animal/hostile/poison/giant_spider/nurse/midwife/Initialize(mapload)
	. = ..()
	letmetalkpls = new
	letmetalkpls.Grant(src)

/mob/living/simple_animal/hostile/poison/giant_spider/nurse/midwife/Destroy()
	QDEL_NULL(letmetalkpls)
	return ..()

//hunters have a decent amount of poison and have decent general stats, making them offensive spiders.
/mob/living/simple_animal/hostile/poison/giant_spider/hunter
	desc = "Furry and black, it makes you shudder to look at it. This one has sparkling purple eyes."
	icon_state = "hunter"
	icon_living = "hunter"
	icon_dead = "hunter_dead"
	maxHealth = 100
	health = 100
	melee_damage = 20
	poison_per_bite = 5
	move_to_delay = 5
	speed = -0.1

//vipers are the rare variant of the hunter, able to move quickly and inject a lot of venom.
/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper
	name = "viper"
	desc = "Furry and black, it makes you shudder to look at it. This one has effervescent purple eyes."
	icon_state = "viper"
	icon_living = "viper"
	icon_dead = "viper_dead"
	maxHealth = 50
	health = 50
	melee_damage = 1
	poison_per_bite = 12
	move_to_delay = 4
	poison_type = /datum/reagent/toxin/venom
	gold_core_spawnable = NO_SPAWN

//tarantulas are really tanky, but slower than normal spiders. They can also break stuff much easier, and can do more damage.
/mob/living/simple_animal/hostile/poison/giant_spider/tarantula
	name = "tarantula"
	desc = "Furry and black, it makes you shudder to look at it. This one has abyssal red eyes."
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	maxHealth = 300
	health = 300
	melee_damage = 45
	obj_damage = 50
	poison_per_bite = 0
	move_to_delay = 8
	speed = 5
	web_speed = 0.5
	status_flags = NONE
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = NO_SPAWN

// Handles faster movement on webs
// This is triggered after the first time a spider steps on/off a web, making web-peeking using this harder
/mob/living/simple_animal/hostile/poison/giant_spider/tarantula/Moved(atom/oldloc, dir)
	. = ..()
	var/turf/T = get_turf(src)
	if(locate(/obj/structure/spider/stickyweb) in T)
		set_varspeed(0)
	else
		set_varspeed(5)

// Ice spiders - for when you want a spider that really doesn't care about atmos
/mob/living/simple_animal/hostile/poison/giant_spider/ice
	name = "giant ice spider"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	poison_type = /datum/reagent/consumable/frostoil
	color = rgb(114,228,250)
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/hostile/poison/giant_spider/nurse/ice
	name = "giant ice spider"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	poison_type = /datum/reagent/consumable/frostoil
	color = rgb(114,228,250)

/mob/living/simple_animal/hostile/poison/giant_spider/hunter/ice
	name = "giant ice spider"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	poison_type = /datum/reagent/consumable/frostoil
	color = rgb(114,228,250)
	gold_core_spawnable = NO_SPAWN

// Buffed spider for wizards to use
/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper/wizard
	maxHealth = 100
	health = 100

// SPIDER ACTIONS/PROCS

/datum/action/innate/spider
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	background_icon_state = "bg_alien"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/innate/spider/lay_web
	name = "Spin Web"
	desc = "Spin a web to slow down potential prey."
	button_icon_state = "lay_web"

/datum/action/innate/spider/lay_web/Activate()
	if(!istype(owner, /mob/living/simple_animal/hostile/poison/giant_spider))
		return
	var/mob/living/simple_animal/hostile/poison/giant_spider/spider = owner

	if(!isturf(spider.loc))
		return
	var/turf/target_turf = get_turf(spider)

	var/obj/structure/spider/stickyweb/web = locate() in target_turf
	if(web)
		to_chat(spider, "<span class='warning'>There's already a web here!</span>")
		return

	if(spider.busy != SPINNING_WEB)
		spider.busy = SPINNING_WEB
		spider.visible_message("<span class='notice'>[spider] begins to secrete a sticky substance.</span>","<span class='notice'>You begin to lay a web.</span>")
		spider.stop_automated_movement = TRUE
		if(do_after(spider, 40 * spider.web_speed, target = target_turf))
			if(spider.busy == SPINNING_WEB && spider.loc == target_turf)
				new /obj/structure/spider/stickyweb(target_turf)
		spider.busy = SPIDER_IDLE
		spider.stop_automated_movement = FALSE
	else
		to_chat(spider, "<span class='warning'>You're already spinning a web!</span>")

/obj/effect/proc_holder/wrap
	name = "Wrap"
	panel = "Spider"
	desc = "Wrap something or someone in a cocoon. If it's a living being, you'll also consume them, allowing you to lay eggs."
	ranged_mousepointer = 'icons/effects/wrap_target.dmi'
	action_icon = 'icons/mob/actions/actions_animal.dmi'
	action_icon_state = "wrap_0"
	action_background_icon_state = "bg_alien"

/obj/effect/proc_holder/wrap/update_icon()
	action.button_icon_state = "wrap_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/wrap/Click()
	if(!istype(usr, /mob/living/simple_animal/hostile/poison/giant_spider/nurse))
		return TRUE
	var/mob/living/simple_animal/hostile/poison/giant_spider/nurse/user = usr
	activate(user)
	return TRUE

/obj/effect/proc_holder/wrap/proc/activate(mob/living/user)
	var/message
	if(active)
		message = "<span class='notice'>You no longer prepare to wrap something in a cocoon.</span>"
		remove_ranged_ability(message)
	else
		message = "<span class='notice'>You prepare to wrap something in a cocoon. <B>Left-click your target to start wrapping!</B></span>"
		add_ranged_ability(user, message, TRUE)
		return TRUE

/obj/effect/proc_holder/wrap/InterceptClickOn(mob/living/caller, params, atom/target)
	if(..())
		return
	if(ranged_ability_user.incapacitated() || !istype(ranged_ability_user, /mob/living/simple_animal/hostile/poison/giant_spider/nurse))
		remove_ranged_ability()
		return

	var/mob/living/simple_animal/hostile/poison/giant_spider/nurse/user = ranged_ability_user

	if(user.Adjacent(target) && (ismob(target) || isobj(target)))
		var/atom/movable/target_atom = target
		if(target_atom.anchored)
			return
		user.cocoon_target = target_atom
		INVOKE_ASYNC(user, /mob/living/simple_animal/hostile/poison/giant_spider/nurse/.proc/cocoon)
		remove_ranged_ability()
		return TRUE

/obj/effect/proc_holder/wrap/on_lose(mob/living/carbon/user)
	remove_ranged_ability()

// Laying eggs
// If a spider eats a human, they can lay eggs that can hatch into special variants of the base spiders
// Otherwise, it's just basic spiders.
/datum/action/innate/spider/lay_eggs
	name = "Lay Eggs"
	desc = "Lay a cluster of eggs, which will soon grow into more spiders. You must have a directive set and wrap a living being to do this."
	button_icon_state = "lay_eggs"

/datum/action/innate/spider/lay_eggs/IsAvailable()
	if(..())
		if(!istype(owner, /mob/living/simple_animal/hostile/poison/giant_spider/nurse))
			return FALSE
		var/mob/living/simple_animal/hostile/poison/giant_spider/nurse/S = owner
		if((S.fed || S.enriched_fed) && (S.directive || !S.ckey))
			return TRUE
		return FALSE

/datum/action/innate/spider/lay_eggs/Activate()
	if(!istype(owner, /mob/living/simple_animal/hostile/poison/giant_spider/nurse))
		return
	var/mob/living/simple_animal/hostile/poison/giant_spider/nurse/spider = owner

	var/obj/structure/spider/eggcluster/cluster = locate() in get_turf(spider)
	if(cluster)
		to_chat(spider, "<span class='warning'>There is already a cluster of eggs here!</span>")
	else if(!(spider.fed || spider.enriched_fed))
		to_chat(spider, "<span class='warning'>You are too hungry to do this!</span>")
	else if(!spider.directive && spider.ckey)
		to_chat(spider, "<span class='warning'>You need to set a directive to do this!</span>")
	else if(spider.busy != LAYING_EGGS)
		spider.busy = LAYING_EGGS
		spider.visible_message("<span class='notice'>[spider] begins to lay a cluster of eggs.</span>","<span class='notice'>You begin to lay a cluster of eggs.</span>")
		spider.stop_automated_movement = TRUE
		if(do_after(spider, 50, target = get_turf(spider)))
			if(spider.busy == LAYING_EGGS)
				cluster = locate() in get_turf(spider)
				if(!cluster || !isturf(spider.loc))
					var/obj/structure/spider/eggcluster/new_cluster = new /obj/structure/spider/eggcluster(get_turf(spider))
					if(spider.enriched_fed) // Add a special spider if the spider that made us ate a person instead of just a monkey
						new_cluster.enriched_spawns++
						new_cluster.spawns_remaining--
						spider.enriched_fed--
					else
						spider.fed--
					new_cluster.directive = spider.directive
					new_cluster.poison_type = spider.poison_type
					new_cluster.poison_per_bite = spider.poison_per_bite
					new_cluster.faction = spider.faction.Copy()
					UpdateButtonIcon(TRUE)
		spider.busy = SPIDER_IDLE
		spider.stop_automated_movement = FALSE

// Directive command, for giving children orders
// The set directive is placed in the notes of every child spider, and said child gets the objective when they log into the mob
/datum/action/innate/spider/set_directive
	name = "Set Directive"
	desc = "Set a directive for your children to follow."
	button_icon_state = "directive"

/datum/action/innate/spider/set_directive/IsAvailable()
	if(..())
		if(!istype(owner, /mob/living/simple_animal/hostile/poison/giant_spider))
			return FALSE
		var/mob/living/simple_animal/hostile/poison/giant_spider/S = owner
		if(S.directive)
			return FALSE
		return TRUE

/datum/action/innate/spider/set_directive/Activate()
	if(!istype(owner, /mob/living/simple_animal/hostile/poison/giant_spider/nurse))
		return
	var/mob/living/simple_animal/hostile/poison/giant_spider/nurse/S = owner
	if(!S.playable)
		var/new_directive = stripped_input(S, "Enter the new directive", "Create directive", "[S.directive]")
		if(new_directive)
			S.directive = new_directive
			message_admins("[ADMIN_LOOKUPFLW(owner)] set its directive to: '[S.directive]'.")
			log_game("[key_name(owner)] set its directive to: '[S.directive]'.")
			S.lay_eggs.UpdateButtonIcon(TRUE)

// Spider command ability for broodmothers
/datum/action/innate/spider/comm
	name = "Command"
	desc = "Send a command to all living spiders."
	button_icon_state = "command"

/datum/action/innate/spider/comm/IsAvailable()
	return ..() && istype(owner, /mob/living/simple_animal/hostile/poison/giant_spider/nurse/midwife)

/datum/action/innate/spider/comm/Trigger()
	var/input = stripped_input(owner, "Input a command for your children to follow.", "Command", "")
	if(QDELETED(src) || !input || !IsAvailable())
		return FALSE
	spider_command(owner, input)
	return TRUE

/datum/action/innate/spider/comm/proc/spider_command(mob/living/user, message)
	if(!message)
		return
	if(CHAT_FILTER_CHECK(message))
		to_chat(usr, "<span class='warning'>Your message contains forbidden words.</span>")
		return
	message = user.treat_message_min(message)
	var/my_message = "<span class='spider'><b>Command from [user]:</b> [message]</span>"
	for(var/mob/living/simple_animal/hostile/poison/giant_spider/M in GLOB.spidermobs)
		to_chat(M, my_message)
	for(var/M in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(M, user)
		to_chat(M, "[link] [my_message]")
	usr.log_talk(message, LOG_SAY, tag="spider command")

// Temperature damage
// Flat 20 brute if they're out of safe temperature, making them vulnerable to fire or spacing
/mob/living/simple_animal/hostile/poison/giant_spider/handle_temperature_damage()
	if(bodytemperature < minbodytemp)
		adjustBruteLoss(20)
		throw_alert("temp", /atom/movable/screen/alert/cold, 3)
	else if(bodytemperature > maxbodytemp)
		adjustBruteLoss(20)
		throw_alert("temp", /atom/movable/screen/alert/hot, 3)
	else
		clear_alert("temp")

#undef SPIDER_IDLE
#undef SPINNING_WEB
#undef LAYING_EGGS
#undef MOVING_TO_TARGET
#undef SPINNING_COCOON
