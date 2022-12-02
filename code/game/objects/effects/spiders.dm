//generic procs copied from obj/effect/alien
/obj/structure/spider
	name = "web"
	icon = 'icons/effects/effects.dmi'
	desc = "It's stringy and sticky."
	anchored = TRUE
	density = FALSE
	max_integrity = 15



/obj/structure/spider/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	if(damage_type == BURN)//the stickiness of the web mutes all attack sounds except fire damage type
		playsound(loc, 'sound/items/welder.ogg', 100, 1)


/obj/structure/spider/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == "melee")
		switch(damage_type)
			if(BURN)
				damage_amount *= 2
	. = ..()

/obj/structure/spider/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		take_damage(5, BURN, 0, 0)

/obj/structure/spider/stickyweb
	icon_state = "stickyweb1"

/obj/structure/spider/stickyweb/Initialize(mapload)
	if(prob(50))
		icon_state = "stickyweb2"
	. = ..()

/obj/structure/spider/stickyweb/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(istype(mover, /mob/living/simple_animal/hostile/poison/giant_spider))
		return TRUE
	else if(isliving(mover))
		if(istype(mover.pulledby, /mob/living/simple_animal/hostile/poison/giant_spider))
			return TRUE
		if(prob(50))
			to_chat(mover, "<span class='danger'>You get stuck in \the [src] for a moment.</span>")
			return FALSE
	else if(istype(mover, /obj/item/projectile))
		return prob(30)

/obj/structure/spider/eggcluster
	name = "egg cluster"
	desc = "They seem to pulse slightly with an inner life."
	icon_state = "eggs"
	var/amount_grown = 0
	// Spawn info
	var/spawns_remaining = 2
	var/enriched_spawns = 0
	// Team info
	var/datum/team/spiders/spider_team
	var/list/faction = list("spiders")
	// Whether or not a ghost can use the cluster to become a spider.
	var/ghost_ready = FALSE
	// The types of spiders the egg sac can produce.
	var/list/mob/living/potential_spawns = list(/mob/living/simple_animal/hostile/poison/giant_spider/guard,
								/mob/living/simple_animal/hostile/poison/giant_spider/hunter,
								/mob/living/simple_animal/hostile/poison/giant_spider/nurse)
	// The types of spiders the egg sac produces when we have enriched spawns left (laying spider ate a human)
	var/list/mob/living/potential_enriched_spawns = list(/mob/living/simple_animal/hostile/poison/giant_spider/tarantula,
							/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper,
							/mob/living/simple_animal/hostile/poison/giant_spider/nurse/midwife)

/obj/structure/spider/eggcluster/Initialize(mapload)
	pixel_x = rand(3,-3)
	pixel_y = rand(3,-3)
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/spider/eggcluster/process(delta_time)
	amount_grown += delta_time
	if(amount_grown >= 60 && !ghost_ready) // 1 minute to grow
		notify_ghosts("[src] is ready to hatch!", null, enter_link="<a href=?src=[REF(src)];activate=1>(Click to play)</a>", source=src, action=NOTIFY_ATTACK, ignore_key = POLL_IGNORE_SPIDER)
		ghost_ready = TRUE
		LAZYADD(GLOB.mob_spawners[name], src)
		SSmobs.update_spawners()
		GLOB.poi_list |= src

/obj/structure/spider/eggcluster/Topic(href, href_list)
	if(..())
		return
	if(href_list["activate"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost))
			attack_ghost(ghost)

/obj/structure/spider/eggcluster/attack_ghost(mob/user)
	. = ..()
	if(ghost_ready)
		make_spider(user)
	else
		to_chat(user, "<span class='warning'>[src] isn't ready yet!</span>")

/obj/structure/spider/eggcluster/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 500)
		take_damage(5, BURN, 0, 0)

/obj/structure/spider/eggcluster/Destroy()
	GLOB.poi_list -= src
	var/list/spawners = GLOB.mob_spawners[name]
	LAZYREMOVE(spawners, src)
	if(!LAZYLEN(spawners))
		GLOB.mob_spawners -= name
	SSmobs.update_spawners()
	return ..()

/**
  * Makes a ghost into a spider based on the type of egg cluster.
  *
  * Allows a ghost to get a prompt to use the egg cluster to become a spider.
  * Arguments:
  * * user - The ghost attempting to become a spider.
  */
/obj/structure/spider/eggcluster/proc/make_spider(mob/user)
	// Get what spiders the user can choose, and check to make sure their choice makes sense
	var/list/to_spawn = list()
	var/list/spider_list = list()
	if(!spider_team) // We don't have a team, just make one up
		spider_team = new()
	if(enriched_spawns)
		to_spawn = potential_enriched_spawns
	else
		to_spawn = potential_spawns
	for(var/choice in to_spawn)
		var/mob/living/simple_animal/spider = choice
		spider_list[initial(spider.name)] = choice
	var/chosen_spider = input("Spider Type", "Egg Cluster") as null|anything in spider_list
	if(QDELETED(src) || QDELETED(user) || !chosen_spider || !(spawns_remaining || enriched_spawns))
		return FALSE
	if(spider_list[chosen_spider] in potential_enriched_spawns)
		if(!enriched_spawns)
			to_chat(user, "<span class='warning'>You can't pick that type of spider anymore!</span>")
			return FALSE
		enriched_spawns--
	else
		spawns_remaining--

	// Setup our spooder
	var/spider_to_spawn = spider_list[chosen_spider]
	var/mob/living/simple_animal/hostile/poison/giant_spider/new_spider = new spider_to_spawn(get_turf(src))
	new_spider.faction = faction.Copy()
	new_spider.key = user.key
	var/datum/antagonist/spider/spider_antag = new_spider.mind.has_antag_datum(/datum/antagonist/spider)
	spider_antag.set_spider_team(spider_team)

	// Check to see if we need to delete ourselves
	if(!enriched_spawns && !spawns_remaining)
		qdel(src)
	return TRUE

/obj/structure/spider/spiderling
	name = "spiderling"
	desc = "It never stays still for long."
	icon_state = "spiderling"
	anchored = FALSE
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	max_integrity = 3
	var/amount_grown = 0
	var/grow_as = null
	var/obj/machinery/atmospherics/components/unary/vent_pump/entry_vent
	var/travelling_in_vent = 0
	var/list/faction = list("spiders")

/obj/structure/spider/spiderling/Destroy()
	new/obj/item/reagent_containers/food/snacks/spiderling(get_turf(src))
	. = ..()

/obj/structure/spider/spiderling/Initialize(mapload)
	. = ..()
	pixel_x = rand(6,-6)
	pixel_y = rand(6,-6)
	START_PROCESSING(SSobj, src)
	AddComponent(/datum/component/swarming)

/obj/structure/spider/spiderling/hunter
	grow_as = /mob/living/simple_animal/hostile/poison/giant_spider/hunter

/obj/structure/spider/spiderling/nurse
	grow_as = /mob/living/simple_animal/hostile/poison/giant_spider/nurse

/obj/structure/spider/spiderling/midwife
	grow_as = /mob/living/simple_animal/hostile/poison/giant_spider/nurse/midwife

/obj/structure/spider/spiderling/viper
	grow_as = /mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper

/obj/structure/spider/spiderling/tarantula
	grow_as = /mob/living/simple_animal/hostile/poison/giant_spider/tarantula

/obj/structure/spider/spiderling/Bump(atom/user)
	if(istype(user, /obj/structure/table))
		forceMove(user.loc)
	else
		..()

/obj/structure/spider/spiderling/process()
	if(travelling_in_vent)
		if(isturf(loc))
			travelling_in_vent = 0
			entry_vent = null
	else if(entry_vent)
		if(get_dist(src, entry_vent) <= 1)
			var/list/vents = list()
			var/datum/pipeline/entry_vent_parent = entry_vent.parents[1]
			for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in entry_vent_parent.other_atmosmch)
				vents.Add(temp_vent)
			if(!vents.len)
				entry_vent = null
				return
			var/obj/machinery/atmospherics/components/unary/vent_pump/exit_vent = pick(vents)
			if(prob(50))
				visible_message("<B>[src] scrambles into the ventilation ducts!</B>", \
								"<span class='italics'>You hear something scampering through the ventilation ducts.</span>")

			spawn(rand(20,60))
				forceMove(exit_vent)
				var/travel_time = round(get_dist(loc, exit_vent.loc) / 2)
				spawn(travel_time)

					if(!exit_vent || exit_vent.welded)
						forceMove(entry_vent)
						entry_vent = null
						return

					if(prob(50))
						audible_message("<span class='italics'>You hear something scampering through the ventilation ducts.</span>")
					sleep(travel_time)

					if(!exit_vent || exit_vent.welded)
						forceMove(entry_vent)
						entry_vent = null
						return
					forceMove(exit_vent.loc)
					entry_vent = null
					var/area/new_area = get_area(loc)
					if(new_area)
						new_area.Entered(src)
	//=================

	else if(prob(33))
		var/target_atom = pick(oview(10, src))
		if(target_atom)
			SSmove_manager.move_to(src, target_atom)
			if(prob(40))
				src.visible_message("<span class='notice'>\The [src] skitters[pick(" away"," around","")].</span>")
	else if(prob(10))
		//ventcrawl!
		for(var/obj/machinery/atmospherics/components/unary/vent_pump/v in view(7,src))
			if(!v.welded)
				entry_vent = v
				SSmove_manager.move_to(src, entry_vent, 1)
				break
	if(isturf(loc))
		amount_grown += rand(0,2)
		if(amount_grown >= 100)
			if(!grow_as)
				if(prob(3))
					grow_as = pick(/mob/living/simple_animal/hostile/poison/giant_spider/tarantula, /mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper, /mob/living/simple_animal/hostile/poison/giant_spider/nurse/midwife)
				else
					grow_as = pick(/mob/living/simple_animal/hostile/poison/giant_spider, /mob/living/simple_animal/hostile/poison/giant_spider/hunter, /mob/living/simple_animal/hostile/poison/giant_spider/nurse)
			var/mob/living/simple_animal/hostile/poison/giant_spider/S = new grow_as(src.loc)
			S.faction = faction.Copy()
			qdel(src)



/obj/structure/spider/cocoon
	name = "cocoon"
	desc = "Something wrapped in silky spider web."
	icon_state = "cocoon1"
	max_integrity = 60

/obj/structure/spider/cocoon/Initialize(mapload)
	icon_state = pick("cocoon1","cocoon2","cocoon3")
	. = ..()

/obj/structure/spider/cocoon/container_resist(mob/living/user)
	var/breakout_time = 600
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, "<span class='notice'>You struggle against the tight bonds... (This will take about [DisplayTimeText(breakout_time)].)</span>")
	visible_message("You see something struggling and writhing in \the [src]!")
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src)
			return
		qdel(src)



/obj/structure/spider/cocoon/Destroy()
	var/turf/T = get_turf(src)
	src.visible_message("<span class='warning'>\The [src] splits open.</span>")
	for(var/atom/movable/A in contents)
		A.forceMove(T)
	return ..()
