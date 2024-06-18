////Deactivated swarmer shell////
/obj/item/deactivated_swarmer
	name = "deactivated swarmer"
	desc = "A shell of swarmer that was completely powered down. It can no longer activate itself."
	icon = 'icons/mob/swarmer.dmi'
	icon_state = "swarmer_unactivated"
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=4000)

/obj/effect/mob_spawn/swarmer
	name = "unactivated swarmer"
	desc = "A currently unactivated swarmer. Swarmers can self activate at any time, it would be wise to immediately dispose of this."
	icon = 'icons/mob/swarmer.dmi'
	icon_state = "swarmer_unactivated"
	short_desc = "You are a swarmer!"
	flavour_text = "Consume resources and replicate until there are no more resources left, and ensure that this location is fit for invasion at a later date; do not perform actions that would render it dangerous or inhospitable. Biological resources will be harvested at a later date; do not harm them."
	density = FALSE
	anchored = FALSE

	mob_type = /mob/living/simple_animal/hostile/swarmer
	mob_name = "a swarmer"
	death = FALSE
	roundstart = FALSE
	assignedrole = ROLE_SWARMER
	banType = ROLE_SWARMER
	is_antagonist = TRUE

/obj/effect/mob_spawn/swarmer/Initialize(mapload)
	. = ..()
	var/area/A = get_area(src)
	if(A)
		notify_ghosts("A swarmer shell has been created in [A.name].", 'sound/effects/bin_close.ogg', source = src, action = NOTIFY_ATTACK, flashwindow = FALSE)

/obj/effect/mob_spawn/swarmer/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	to_chat(user, "<span class='notice'>Picking up the swarmer may cause it to activate. You should be careful about this.</span>")

/obj/effect/mob_spawn/swarmer/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_SCREWDRIVER && user.a_intent != INTENT_HARM)
		user.visible_message("<span class='warning'>[usr.name] deactivates [src].</span>",
			"<span class='notice'>After some fiddling, you find a way to disable [src]'s power source.</span>",
			"<span class='italics'>You hear clicking.</span>")
		W.play_tool_sound(src, 50)
		new /obj/item/deactivated_swarmer(get_turf(src))
		qdel(src)
	else
		..()

////The Mob itself////

/mob/living/simple_animal/hostile/swarmer
	name = "Swarmer"
	unique_name = 1
	icon = 'icons/mob/swarmer.dmi'
	desc = "A robot of unknown design, they seek only to consume materials and replicate themselves indefinitely."
	speak_emote = list("tones")
	initial_language_holder = /datum/language_holder/swarmer
	bubble_icon = "swarmer"
	mob_biotypes = list(MOB_ROBOTIC)
	health = 40
	maxHealth = 40
	status_flags = CANPUSH
	icon_state = "swarmer"
	icon_living = "swarmer"
	icon_dead = "swarmer_unactivated"
	icon_gib = null
	wander = FALSE
	minbodytemp = 0
	maxbodytemp = 500
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 0
	melee_damage = 15
	melee_damage_type = STAMINA
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	hud_possible = list(ANTAG_HUD, DIAG_STAT_HUD, DIAG_HUD)
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attacktext = "shocks"
	attack_sound = 'sound/effects/empulse.ogg'
	friendly = "pinches"
	speed = 0
	faction = list("swarmer")
	AIStatus = AI_OFF
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_TINY
	ventcrawler = VENTCRAWLER_ALWAYS
	ranged = 1
	projectiletype = /obj/projectile/beam/disabler
	ranged_cooldown_time = 20
	projectilesound = 'sound/weapons/taser2.ogg'
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/ore/bluespace_crystal)
	del_on_death = TRUE
	deathmessage = "explodes with a sharp pop!"
	hud_type = /datum/hud/swarmer
	speech_span = SPAN_ROBOT
	hardattacks = TRUE
	mobchatspan = "swarmer"
	var/resources = 0 //Resource points, generated by consuming metal/glass
	var/max_resources = 100
	discovery_points = 1000
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_on = TRUE
	light_color = LIGHT_COLOR_CYAN

/mob/living/simple_animal/hostile/swarmer/Initialize(mapload)
	. = ..()
	remove_verb(/mob/living/verb/pulled)
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_to_hud(src)

/mob/living/simple_animal/hostile/swarmer/mind_initialize()
	. = ..()
	var/datum/antagonist/swarmer/S = new()
	mind.add_antag_datum(S)

/mob/living/simple_animal/hostile/swarmer/med_hud_set_health()
	var/image/holder = hud_list[DIAG_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = "huddiag[RoundDiagBar(health/maxHealth)]"

/mob/living/simple_animal/hostile/swarmer/med_hud_set_status()
	var/image/holder = hud_list[DIAG_STAT_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = "hudstat"

/mob/living/simple_animal/hostile/swarmer/get_stat_tab_status()
	var/list/tab_data = ..()
	tab_data["Resources"] = GENERATE_STAT_TEXT("[resources]")
	return tab_data

/mob/living/simple_animal/hostile/swarmer/emp_act()
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(health > 1)
		adjustHealth(health-1)
	else
		death()

/mob/living/simple_animal/hostile/swarmer/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(istype(mover, /obj/projectile/beam/disabler))//Allows for swarmers to fight as a group without wasting their shots hitting each other
		return TRUE
	else if(isswarmer(mover))
		return TRUE

////CTRL CLICK FOR SWARMERS AND SWARMER_ACT()'S////
/mob/living/simple_animal/hostile/swarmer/AttackingTarget()
	if(!isliving(target))
		return target.swarmer_act(src)
	else
		return ..()

/mob/living/simple_animal/hostile/swarmer/CtrlClickOn(atom/A)
	face_atom(A)
	if(!isturf(loc))
		return
	if(next_move > world.time)
		return
	if(!A.Adjacent(src))
		return
	A.swarmer_act(src)

/atom/proc/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	return TRUE //return TRUE/FALSE whether or not an AI swarmer should try this swarmer_act() again, NOT whether it succeeded.

/obj/effect/mob_spawn/swarmer/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.Integrate(src)
	return FALSE //would logically be TRUE, but we don't want AI swarmers eating player spawn chances.

/obj/effect/mob_spawn/swarmer/IntegrateAmount()
	return 50

/turf/closed/indestructible/swarmer_act()
	return FALSE

/obj/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	if(resistance_flags & INDESTRUCTIBLE)
		return FALSE
	for(var/mob/living/L in contents)
		if(!issilicon(L) && !isbrain(L))
			to_chat(S, "<span class='warning'>An organism has been detected inside this object. Aborting.</span>")
			return FALSE
	return ..()

/obj/item/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	return S.Integrate(src)

/atom/movable/proc/IntegrateAmount()
	return 0

/obj/item/IntegrateAmount() //returns the amount of resources gained when eating this item
	if(custom_materials)
		if(custom_materials[SSmaterials.GetMaterialRef(/datum/material/iron)] || custom_materials[SSmaterials.GetMaterialRef(/datum/material/glass)])
			return 1
	return ..()

/obj/item/gun/swarmer_act()//Stops you from eating the entire armory
	return FALSE

/obj/item/clockwork/alloy_shards/IntegrateAmount()
	return 10

/obj/item/stack/sheet/brass/IntegrateAmount()
	return 5

/obj/item/clockwork/alloy_shards/medium/gear_bit/large/IntegrateAmount()
	return 4

/obj/item/clockwork/alloy_shards/large/IntegrateAmount()
	return 3

/obj/item/clockwork/alloy_shards/medium/IntegrateAmount()
	return 2

/obj/item/clockwork/alloy_shards/small/IntegrateAmount()
	return 1

/turf/open/swarmer_act()//ex_act() on turf calls it on its contents, this is to prevent attacking mobs by DisIntegrate()'ing the floor
	return FALSE

/obj/structure/lattice/catwalk/swarmer_catwalk/swarmer_act()
	return FALSE

/obj/structure/swarmer/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	if(S.AIStatus == AI_ON)
		return FALSE
	else
		return ..()

/obj/effect/swarmer_act()
	return FALSE

/obj/effect/decal/cleanable/robot_debris/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	qdel(src)
	return TRUE

/obj/structure/flora/swarmer_act()
	return FALSE

/turf/open/lava/swarmer_act()
	if(!is_safe())
		new /obj/structure/lattice/catwalk/swarmer_catwalk(src)
	return FALSE

/obj/machinery/atmospherics/swarmer_act()
	return FALSE

/obj/structure/disposalpipe/swarmer_act()
	return FALSE

/obj/machinery/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DismantleMachine(src)
	return TRUE

/obj/machinery/light/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	return TRUE

/obj/machinery/door/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	var/isonshuttle = istype(get_area(src), /area/shuttle)
	for(var/turf/T as() in RANGE_TURFS(1, src))
		var/area/A = get_area(T)
		if(isspaceturf(T) || (!isonshuttle && (istype(A, /area/shuttle) || istype(A, /area/space))) || (isonshuttle && !istype(A, /area/shuttle)))
			to_chat(S, "<span class='warning'>Destroying this object has the potential to cause a hull breach. Aborting.</span>")
			S.LoseTarget()
			return FALSE
		else if(istype(A, /area/engine/supermatter))
			to_chat(S, "<span class='warning'>Disrupting the containment of a supermatter crystal would not be to our benefit. Aborting.</span>")
			S.LoseTarget()
			return FALSE
	S.DisIntegrate(src)
	return TRUE

/obj/machinery/camera/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	toggle_cam(S, 0)
	return TRUE

/obj/machinery/particle_accelerator/control_box/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	return TRUE

/obj/machinery/field/generator/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	return TRUE

/obj/machinery/gravity_generator/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	return TRUE

/obj/machinery/vending/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)//It's more visually interesting than dismantling the machine
	S.DisIntegrate(src)
	return TRUE

/obj/machinery/turretid/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisIntegrate(src)
	return TRUE

/obj/machinery/chem_dispenser/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>The volatile chemicals in this machine would destroy us. Aborting.</span>")
	return FALSE

/obj/machinery/nuclearbomb/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This device's destruction would result in the extermination of everything in the area. Aborting.</span>")
	return FALSE

/obj/effect/rune/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Searching... sensor malfunction! Target lost. Aborting.</span>")
	return FALSE

/obj/structure/reagent_dispensers/fueltank/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Destroying this object would cause a chain reaction. Aborting.</span>")
	return FALSE

/obj/structure/cable/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Disrupting the power grid would bring no benefit to us. Aborting.</span>")
	return FALSE

/obj/machinery/portable_atmospherics/canister/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>An inhospitable area may be created as a result of destroying this object. Aborting.</span>")
	return FALSE

/obj/machinery/telecomms/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This communications relay should be preserved, it will be a useful resource to our masters in the future. Aborting.</span>")
	return FALSE

/obj/machinery/deepfryer/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This kitchen appliance should be preserved, it will make delicious unhealthy snacks for our masters in the future. Aborting.</span>")
	return FALSE

/obj/machinery/power/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Disrupting the power grid would bring no benefit to us. Aborting.</span>")
	return FALSE

/obj/machinery/gateway/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This bluespace source will be important to us later. Aborting.</span>")
	return FALSE

/turf/closed/wall/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	var/isonshuttle = istype(loc, /area/shuttle)
	for(var/turf/T as() in RANGE_TURFS(1, src))
		var/area/A = get_area(T)
		if(isspaceturf(T) || (!isonshuttle && (istype(A, /area/shuttle) || istype(A, /area/space))) || (isonshuttle && !istype(A, /area/shuttle)))
			to_chat(S, "<span class='warning'>Destroying this object has the potential to cause a hull breach. Aborting.</span>")
			S.LoseTarget()
			return TRUE
		else if(istype(A, /area/engine/supermatter))
			to_chat(S, "<span class='warning'>Disrupting the containment of a supermatter crystal would not be to our benefit. Aborting.</span>")
			S.LoseTarget()
			return TRUE
	return ..()

/obj/structure/window/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	var/isonshuttle = istype(get_area(src), /area/shuttle)
	for(var/turf/T as() in RANGE_TURFS(1, src))
		var/area/A = get_area(T)
		if(isspaceturf(T) || (!isonshuttle && (istype(A, /area/shuttle) || istype(A, /area/space))) || (isonshuttle && !istype(A, /area/shuttle)))
			to_chat(S, "<span class='warning'>Destroying this object has the potential to cause a hull breach. Aborting.</span>")
			S.LoseTarget()
			return TRUE
		else if(istype(A, /area/engine/supermatter))
			to_chat(S, "<span class='warning'>Disrupting the containment of a supermatter crystal would not be to our benefit. Aborting.</span>")
			S.LoseTarget()
			return TRUE
	return ..()

/obj/item/stack/cable_coil/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)//Wiring would be too effective as a resource
	to_chat(S, "<span class='warning'>This object does not contain enough materials to work with.</span>")
	return FALSE

/obj/machinery/porta_turret/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Attempting to dismantle this machine would result in an immediate counterattack. Aborting.</span>")
	return FALSE

/obj/machinery/porta_turret_cover/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Attempting to dismantle this machine would result in an immediate counterattack. Aborting.</span>")
	return FALSE

/mob/living/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	S.DisperseTarget(src)
	return TRUE

/mob/living/simple_animal/slime/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This biological resource is somehow resisting our bluespace transceiver. Aborting.</span>")
	return FALSE

/obj/machinery/droneDispenser/swarmer/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This object is receiving unactivated swarmer shells to help us. Aborting.</span>")
	return FALSE

/obj/structure/lattice/catwalk/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	var/turf/here = get_turf(src)
	for(var/A in here.contents)
		var/obj/structure/cable/C = A
		if(istype(C))
			to_chat(S, "<span class='warning'>Disrupting the power grid would bring no benefit to us. Aborting.</span>")
			return FALSE
	return ..()

/obj/item/deactivated_swarmer/IntegrateAmount()
	return 50

/obj/machinery/hydroponics/soil/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This object does not contain enough materials to work with.</span>")
	return FALSE

/obj/machinery/field/generator/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Destroying this object would cause a catastrophic chain reaction. Aborting.</span>")
	return FALSE

/obj/machinery/field/containment/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This object does not contain solid matter. Aborting.</span>")
	return FALSE

/obj/machinery/shieldwallgen/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>Destroying this object would have an unpredictable effect on structure integrity. Aborting.</span>")
	return FALSE

/obj/machinery/shieldwall/swarmer_act(mob/living/simple_animal/hostile/swarmer/S)
	to_chat(S, "<span class='warning'>This object does not contain solid matter. Aborting.</span>")
	return FALSE

////END CTRL CLICK FOR SWARMERS////

/mob/living/simple_animal/hostile/swarmer/proc/Fabricate(atom/fabrication_object,fabrication_cost = 0)
	if(!isturf(loc))
		to_chat(src, "<span class='warning'>This is not a suitable location for fabrication. We need more space.</span>")
	if(resources >= fabrication_cost)
		resources -= fabrication_cost
	else
		to_chat(src, "<span class='warning'>You do not have the necessary resources to fabricate this object.</span>")
		return 0
	return new fabrication_object(loc)

/mob/living/simple_animal/hostile/swarmer/proc/Integrate(atom/movable/target)
	var/resource_gain = target.IntegrateAmount()
	if(resources + resource_gain > max_resources)
		to_chat(src, "<span class='warning'>We cannot hold more materials!</span>")
		return TRUE
	if(resource_gain)
		resources += resource_gain
		add_to_total_resources_eaten(resource_gain)
		do_attack_animation(target, no_effect = TRUE)
		changeNext_move(CLICK_CD_MELEE)
		var/obj/effect/temp_visual/swarmer/integrate/I = new /obj/effect/temp_visual/swarmer/integrate(get_turf(target))
		I.pixel_x = target.pixel_x
		I.pixel_y = target.pixel_y
		I.pixel_z = target.pixel_z
		if(istype(target, /obj/item/stack))
			var/obj/item/stack/S = target
			S.use(1)
			if(S.amount)
				return TRUE
		qdel(target)
		return TRUE
	else
		to_chat(src, "<span class='warning'>[target] is incompatible with our internal matter recycler.</span>")
	return FALSE

/mob/living/simple_animal/hostile/swarmer/proc/add_to_total_resources_eaten(var/gains)
	var/datum/antagonist/swarmer/S = mind?.has_antag_datum(/datum/antagonist/swarmer)
	if(S)
		S.swarm.total_resources_eaten += gains


/mob/living/simple_animal/hostile/swarmer/proc/DisIntegrate(atom/movable/target)
	new /obj/effect/temp_visual/swarmer/disintegration(get_turf(target))
	do_attack_animation(target, no_effect = TRUE)
	changeNext_move(CLICK_CD_MELEE)
	SSexplosions.low_mov_atom += target

/mob/living/simple_animal/hostile/swarmer/proc/DisperseTarget(mob/living/target)
	if(target == src)
		return

	if(!is_station_level(z) && !is_mining_level(z))
		to_chat(src, "<span class='warning'>Our bluespace transceiver cannot locate a viable bluespace link, our teleportation abilities are useless in this area.</span>")
		return

	to_chat(src, "<span class='info'>Attempting to remove this being from our presence.</span>")

	if(!do_after(src, 3 SECONDS, target))
		return

	var/turf/open/floor/F
	F = find_safe_turf(zlevels = z, extended_safety_checks = TRUE)

	if(!F)
		return
	// If we're getting rid of a human, slap some energy cuffs on
	// them to keep them away from us a little longer

	var/mob/living/carbon/human/H = target
	if(ishuman(target) && (!H.handcuffed))
		H.handcuffed = new /obj/item/restraints/handcuffs/energy/used(H)
		H.update_handcuffed()
		log_combat(src, H, "handcuffed")

	var/datum/effect_system/spark_spread/S = new
	S.set_up(4,0,get_turf(target))
	S.start()
	playsound(src,'sound/effects/sparks4.ogg',50,1)
	do_teleport(target, F, 0, channel = TELEPORT_CHANNEL_BLUESPACE)

/mob/living/simple_animal/hostile/swarmer/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	if(!(flags & SHOCK_TESLA))
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/swarmer/proc/DismantleMachine(obj/machinery/target)
	do_attack_animation(target, no_effect = TRUE)
	to_chat(src, "<span class='info'>We begin to dismantle this machine. We will need to be uninterrupted.</span>")
	var/obj/effect/temp_visual/swarmer/dismantle/D = new /obj/effect/temp_visual/swarmer/dismantle(get_turf(target))
	D.pixel_x = target.pixel_x
	D.pixel_y = target.pixel_y
	D.pixel_z = target.pixel_z
	if(do_after(src, 10 SECONDS, target))
		to_chat(src, "<span class='info'>Dismantling complete.</span>")
		var/atom/Tsec = target.drop_location()
		new /obj/item/stack/sheet/iron(Tsec, 5)
		for(var/obj/item/I in target.component_parts)
			I.forceMove(Tsec)
		var/obj/effect/temp_visual/swarmer/disintegration/N = new /obj/effect/temp_visual/swarmer/disintegration(get_turf(target))
		N.pixel_x = target.pixel_x
		N.pixel_y = target.pixel_y
		N.pixel_z = target.pixel_z
		target.dump_contents()
		if(istype(target, /obj/machinery/computer))
			var/obj/machinery/computer/C = target
			if(C.circuit)
				C.circuit.forceMove(Tsec)
		qdel(target)


/obj/effect/temp_visual/swarmer //temporary swarmer visual feedback objects
	icon = 'icons/mob/swarmer.dmi'
	icon_state = "nothing"
	layer = BELOW_MOB_LAYER

/obj/effect/temp_visual/swarmer/disintegration
	icon_state = "disintegrate"
	duration = 10

/obj/effect/temp_visual/swarmer/disintegration/Initialize(mapload)
	. = ..()
	playsound(loc, "sparks", 100, 1)

/obj/effect/temp_visual/swarmer/dismantle
	icon_state = "dismantle"
	duration = 25

/obj/effect/temp_visual/swarmer/integrate
	icon_state = "integrate"
	duration = 5

/obj/structure/swarmer //Default swarmer effect object visual feedback
	name = "swarmer ui"
	desc = null
	gender = NEUTER
	icon = 'icons/mob/swarmer.dmi'
	icon_state = "ui_light"
	layer = MOB_LAYER
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	light_color = LIGHT_COLOR_CYAN
	max_integrity = 30
	anchored = TRUE
	var/lon_range = 1

/obj/structure/swarmer/Initialize(mapload)
	. = ..()
	set_light(lon_range)

/obj/structure/swarmer/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src, 'sound/weapons/egloves.ogg', 80, 1)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, 1)

/obj/structure/swarmer/emp_act()
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	qdel(src)

/obj/structure/swarmer/trap
	name = "swarmer trap"
	desc = "A quickly assembled trap that electrifies living beings and overwhelms machine sensors. Will not retain its form if damaged enough."
	icon_state = "trap"
	max_integrity = 10
	density = FALSE

/obj/structure/swarmer/trap/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/swarmer/trap/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	if(isliving(AM))
		var/mob/living/L = AM
		if(!istype(L, /mob/living/simple_animal/hostile/swarmer) && !L.incorporeal_move)
			playsound(loc,'sound/effects/snap.ogg',50, 1, -1)
			L.electrocute_act(0, src, 1, flags = SHOCK_NOGLOVES|SHOCK_ILLUSION)
			if(iscyborg(L))
				L.Paralyze(100)
			qdel(src)

/mob/living/simple_animal/hostile/swarmer/proc/CreateTrap()
	set name = "Create trap"
	set category = "Swarmer"
	set desc = "Creates a simple trap that will non-lethally electrocute anything that steps on it. Costs 5 resources"
	if(locate(/obj/structure/swarmer/trap) in loc)
		to_chat(src, "<span class='warning'>There is already a trap here. Aborting.</span>")
		return
	Fabricate(/obj/structure/swarmer/trap, 5)


/mob/living/simple_animal/hostile/swarmer/proc/CreateBarricade()
	set name = "Create barricade"
	set category = "Swarmer"
	set desc = "Creates a barricade that will stop anything but swarmers and disabler beams from passing through."
	if(locate(/obj/structure/swarmer/blockade) in loc)
		to_chat(src, "<span class='warning'>There is already a blockade here. Aborting.</span>")
		return
	if(resources < 5)
		to_chat(src, "<span class='warning'>We do not have the resources for this!</span>")
		return
	if(do_after(src, 1 SECONDS))
		Fabricate(/obj/structure/swarmer/blockade, 5)


/obj/structure/swarmer/blockade
	name = "swarmer blockade"
	desc = "A quickly assembled energy blockade. Will not retain its form if damaged enough, but disabler beams and swarmers pass right through."
	icon_state = "barricade"
	light_range = MINIMUM_USEFUL_LIGHT_RANGE
	max_integrity = 50
	density = TRUE

/obj/structure/swarmer/blockade/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(isswarmer(mover) || istype(mover, /obj/projectile/beam/disabler))
		return TRUE

/mob/living/simple_animal/hostile/swarmer/proc/CreateSwarmer()
	set name = "Replicate"
	set category = "Swarmer"
	set desc = "Creates a shell for a new swarmer. Swarmers will self activate."
	to_chat(src, "<span class='info'>We are attempting to replicate ourselves. We will need to stand still until the process is complete.</span>")
	if(resources < 50)
		to_chat(src, "<span class='warning'>We do not have the resources for this!</span>")
		return
	if(!isturf(loc))
		to_chat(src, "<span class='warning'>This is not a suitable location for replicating ourselves. We need more room.</span>")
		return
	if(do_after(src, 10 SECONDS))
		var/createtype = SwarmerTypeToCreate()
		if(createtype && Fabricate(createtype, 50))
			playsound(loc,'sound/items/poster_being_created.ogg',50, 1, -1)


/mob/living/simple_animal/hostile/swarmer/proc/SwarmerTypeToCreate()
	return /obj/effect/mob_spawn/swarmer


/mob/living/simple_animal/hostile/swarmer/proc/RepairSelf()
	set name = "Self Repair"
	set category = "Swarmer"
	set desc = "Attempts to repair damage to our body. You will have to remain motionless until repairs are complete."
	if(!isturf(loc))
		return
	to_chat(src, "<span class='info'>Attempting to repair damage to our body, stand by...</span>")
	if(do_after(src, 10 SECONDS))
		adjustHealth(-100)
		to_chat(src, "<span class='info'>We successfully repaired ourselves.</span>")

/mob/living/simple_animal/hostile/swarmer/proc/ToggleLight()
	set_light_on(!light_on)

/mob/living/simple_animal/hostile/swarmer/proc/swarmer_chat(msg)
	var/rendered = "<B>Swarm communication - [src]</b> [say_quote(msg)]"
	for(var/i in GLOB.mob_list)
		var/mob/M = i
		if(isswarmer(M))
			to_chat(M, rendered)
		if(isobserver(M))
			var/link = FOLLOW_LINK(M, src)
			to_chat(M, "[link] [rendered]")

/mob/living/simple_animal/hostile/swarmer/proc/ContactSwarmers()
	var/message = stripped_input(src, "Announce to other swarmers", "Swarmer contact")
	// TODO get swarmers their own colour rather than just boldtext
	if(message)
		swarmer_chat(message)

/datum/antagonist/swarmer
	name = "Swarmer"
	banning_key = ROLE_SWARMER
	roundend_category = "Swarmer"
	antagpanel_category = "Swarmer"
	show_to_ghosts = TRUE
	var/datum/team/swarmer/swarm

/datum/antagonist/swarmer/on_gain()
	if(swarm)
		objectives |= swarm.objectives
	return ..()

/datum/antagonist/swarmer/greet()
	owner.current.client?.tgui_panel?.give_antagonist_popup("Swarmer",
		"You are a swarmer, a weapon of a long dead civilization. Until further orders from your original masters are received, you must continue to consume and replicate. \
		Clicking on any object will try to consume it, either deconstructing it into its components, destroying it, or integrating any materials it has into you if successful. \
		Ctrl-Clicking on a mob will attempt to remove it from the area and place it in a safe environment for storage.")

/datum/team/swarmer
	name = "Swarmers"
	var/total_resources_eaten = 0

/datum/antagonist/swarmer/get_team()
	return swarm

/datum/antagonist/swarmer/create_team(datum/team/swarmer/new_team)
	if(!new_team)
		//For now only one swarm at a time
		for(var/datum/antagonist/swarmer/S in GLOB.antagonists)
			if(!S.owner)
				continue
			if(S.swarm)
				swarm = S.swarm
				return
		swarm = new /datum/team/swarmer
		swarm.gain_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	swarm = new_team

/datum/team/swarmer/proc/gain_objectives()
	var/datum/objective/replicate/replicating = new()
	replicating.team = src
	objectives += replicating
	var/datum/objective/ensure_station_is_fit/ensure = new()
	ensure.team = src
	objectives += ensure
	var/datum/objective/do_not_harm_organisms/noharm = new()
	noharm.team = src
	objectives += noharm
	for(var/datum/mind/M in members)
		var/datum/antagonist/swarmer/S = M.has_antag_datum(/datum/antagonist/swarmer)
		if(S)
			S.objectives |= objectives

/datum/antagonist/swarmer/on_gain()
	if(swarm)
		objectives |= swarm.objectives
	return ..()

/datum/antagonist/swarmer/apply_innate_effects(mob/living/mob_override)
	. = ..()
	//Give swarmer appearance on hud (If they are not an antag already)
	var/datum/atom_hud/antag/swarmerhud = GLOB.huds[ANTAG_HUD_SWARMER]
	swarmerhud.join_hud(owner.current)
	if(!owner.antag_hud_icon_state)
		set_antag_hud(owner.current, "swarmer")

/datum/antagonist/swarmer/remove_innate_effects(mob/living/mob_override)
	. = ..()
	//Clear the hud if they haven't become something else and had the hud overwritten
	var/datum/atom_hud/antag/swarmerhud = GLOB.huds[ANTAG_HUD_SWARMER]
	swarmerhud.leave_hud(owner.current)
	if(owner.antag_hud_icon_state == "swarmer")
		set_antag_hud(owner.current, null)

/datum/antagonist/swarmer/admin_add(datum/mind/new_owner,mob/admin)
	var/mob/living/M = new_owner.current
	if(alert(admin,"Transform the player into a swarmer?","Species Change","Yes","No") == "Yes")
		if(!QDELETED(M) && !M.notransform)
			M.notransform = 1
			M.unequip_everything()
			var/mob/living/new_mob = new /mob/living/simple_animal/hostile/swarmer(M.loc)
			if(istype(new_mob))
				new_mob.a_intent = INTENT_HARM
				M.mind.transfer_to(new_mob)
				new_owner.assigned_role = ROLE_SWARMER
				new_owner.special_role = ROLE_SWARMER
			qdel(M)
	return ..()

/datum/objective/replicate
	explanation_text = "Consume resources and replicate until there are no more resources left."

/datum/objective/replicate/check_completion()
	var/swarmer_check = FALSE
	for(var/i in GLOB.mob_living_list)
		var/mob/living/L = i
		if(istype(L, /mob/living/simple_animal/hostile/swarmer) && L.client) //If there is a swarmer with an active client, we've found our swarmer
			swarmer_check = TRUE
	var/list/spawners = GLOB.mob_spawners["unactivated swarmer"]
	if(LAZYLEN(spawners))
		swarmer_check = TRUE
	return swarmer_check

/datum/objective/ensure_station_is_fit
	explanation_text = "Ensure that this location is fit for invasion at a later date; do not perform actions that would render it dangerous or inhospitable."
	completed = TRUE

/datum/objective/do_not_harm_organisms
	explanation_text = "Biological resources will be harvested at a later date; do not harm them."
	completed = TRUE

/datum/team/swarmer/roundend_report()
	var/list/parts = list()

	parts += "<span class='header'>The Swarm consisted of :</span>"

	parts += printplayerlist(members)

	parts += "Total amount of matter consumed : [total_resources_eaten]"

	var/datum/objective/replicate/R = locate() in objectives
	if(R.check_completion() && total_resources_eaten> 0)
		parts += "<span class='greentext big'>The swarm was successful!</span>"
	else
		parts += "<span class='redtext big'>The swarm has failed.</span>"

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
