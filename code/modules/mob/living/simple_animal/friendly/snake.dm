/mob/living/simple_animal/hostile/retaliate/poison
	var/poison_per_bite = 0
	var/poison_type = /datum/reagent/toxin

/mob/living/simple_animal/hostile/retaliate/poison/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.reagents && !poison_per_bite == 0)
			L.reagents.add_reagent(poison_type, poison_per_bite)

/mob/living/simple_animal/hostile/retaliate/poison/snake
	name = "snake"
	desc = "A slithery snake. These legless reptiles are the bane of mice and adventurers alike."
	icon_state = "snake"
	icon_living = "snake"
	icon_dead = "snake_dead"
	speak_emote = list("hisses")
	health = 20
	maxHealth = 20
	attacktext = "bites"
	melee_damage = 6
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "steps on"
	faction = list("hostile")
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST, MOB_REPTILE)
	gold_core_spawnable = FRIENDLY_SPAWN
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	chat_color = "#26F55A"
	poison_per_bite = 3
	poison_type = /datum/reagent/toxin/venom
	can_be_held = TRUE
	worn_slot_flags = ITEM_SLOT_HEAD
	head_icon = 'icons/mob/pets_held.dmi'
	held_state = "snake"


/mob/living/simple_animal/hostile/retaliate/poison/snake/Initialize(mapload)
	AddComponent(/datum/component/udder, /obj/item/udder/venom, reagent_produced_typepath = /datum/reagent/toxin/venom)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	. = ..()


/mob/living/simple_animal/hostile/retaliate/poison/snake/ListTargets(atom/the_target)
	var/atom/target_from = GET_TARGETS_FROM(src)
	var/list/living_mobs = list()
	var/list/mice = list()
	for(var/mob/living/HM in oview(vision_range, target_from))
		//Yum a tasty mouse
		if(istype(HM, /mob/living/simple_animal/mouse))
			mice += HM
			continue
		living_mobs += HM

	// if no tasty mice to chase, lets chase any living mob enemies in our vision range
	if(!length(mice))
		//Filter living mobs (in range mobs) by those we consider enemies (retaliate behaviour)
		return living_mobs & enemies
	return mice

/mob/living/simple_animal/hostile/retaliate/poison/snake/AttackingTarget()
	if(istype(target, /mob/living/simple_animal/mouse))
		visible_message("<span class='notice'>[name] consumes [target] in a single gulp!</span>", "<span class='notice'>You consume [target] in a single gulp!</span>")
		QDEL_NULL(target)
		adjustBruteLoss(-2)
	else
		return ..()
