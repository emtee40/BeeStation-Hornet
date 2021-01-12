// - TECH TREE -

/datum/eldritch_knowledge/base_flesh
	name = "Harbinger of Famine"
	desc = "Opens up the Path of Flesh to you. Allows you to transmute a pool of blood with a kitchen knife, or its derivatives, into a Flesh Blade. Allows you to recruit disciples."
	gain_text = "Hundred's of us starved, but I.. I found the strength in my greed."
	banned_knowledge = list(/datum/eldritch_knowledge/base_ash,/datum/eldritch_knowledge/base_rust,/datum/eldritch_knowledge/final/ash_final,/datum/eldritch_knowledge/final/rust_final)
	next_knowledge = list(/datum/eldritch_knowledge/flesh_grasp)
	required_atoms = list(/obj/item/kitchen/knife,/obj/effect/decal/cleanable/blood)
	result_atoms = list(/obj/item/melee/sickly_blade/flesh)
	cost = 5
	route = PATH_FLESH
	followers_increment = 1

/datum/eldritch_knowledge/flesh_grasp
	name = "Grasp of Flesh"
	gain_text = "My new found desires drove me to greater and greater heights."
	desc = "Empowers your mansus grasp to be able to create a single ghoul out of a dead person. Ghouls have only 25 HP and look like husks to the heathens' eyes."
	cost = 5
	next_knowledge = list(/datum/eldritch_knowledge/flesh_ghoul)
	var/ghoul_amt = 1
	var/list/spooky_scaries
	route = PATH_FLESH

/datum/eldritch_knowledge/flesh_grasp/on_mansus_grasp(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!ishuman(target) || target == user)
		return

	var/mob/living/carbon/human/human_target = target
	if(QDELETED(human_target) || human_target.stat != DEAD)
		return

	var/datum/antagonist/heretic/master = user.mind.has_antag_datum(/datum/antagonist/heretic)

	if(HAS_TRAIT(human_target, TRAIT_HUSK) && !master.get_knowledge(/datum/eldritch_knowledge/flesh_blade_upgrade))
		to_chat(user, "<span class='warning'>You are not strong enough to revive a dead ghoul!</span>")
		return

	if(LAZYLEN(spooky_scaries) >= ghoul_amt)
		to_chat(user, "<span class='warning'>Your patron cannot support more ghouls on this plane!</span>")
		return

	human_target.grab_ghost()

	if(!human_target.mind || !human_target.client)
		to_chat(user, "<span class='warning'>There is no soul connected to this body...</span>")
		return

	LAZYADD(spooky_scaries, human_target)
	log_game("[key_name_admin(human_target)] has become a ghoul, their master is [user.real_name]")
	//we change it to true only after we know they passed all the checks
	. = TRUE
	RegisterSignal(human_target,COMSIG_MOB_DEATH,.proc/remove_ghoul)
	human_target.revive(full_heal = TRUE, admin_revive = TRUE)
	ADD_TRAIT(human_target, TRAIT_NOSTAMCRIT, MAGIC_TRAIT)
	ADD_TRAIT(human_target, TRAIT_NOLIMBDISABLE, MAGIC_TRAIT)
	human_target.setMaxHealth(25)
	human_target.health = 25
	human_target.become_husk()
	human_target.faction |= "heretics"
	var/datum/antagonist/heretic_monster/heretic_monster = human_target.mind.add_antag_datum(/datum/antagonist/heretic_monster)
	heretic_monster.set_owner(master)

/datum/eldritch_knowledge/flesh_grasp/proc/remove_ghoul(datum/source)
	var/mob/living/carbon/human/humie = source
	spooky_scaries -= humie
	humie.mind.remove_antag_datum(/datum/antagonist/heretic_monster)
	UnregisterSignal(source, COMSIG_MOB_DEATH)

/datum/eldritch_knowledge/flesh_grasp/on_eldritch_blade(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/C = target
	var/datum/status_effect/eldritch/E = C.has_status_effect(/datum/status_effect/eldritch/rust) || C.has_status_effect(/datum/status_effect/eldritch/ash) || C.has_status_effect(/datum/status_effect/eldritch/flesh)
	if(E)
		C.silent = max(C.silent, 4 SECONDS)
		E.on_effect()

/datum/eldritch_knowledge/flesh_ghoul
	name = "Imperfect Ritual"
	desc = "Allows you to resurrect the dead as voiceless dead by sacrificing them on the transmutation rune with a poppy. Voiceless dead are mute and have 50 HP. You can only have 2 at a time."
	gain_text = "I found notes of a dark ritual, unfinished... yet still, I pushed forward."
	cost = 5
	required_atoms = list(/mob/living/carbon/human,/obj/item/reagent_containers/food/snacks/grown/poppy)
	next_knowledge = list(/datum/eldritch_knowledge/flesh_mark,/datum/eldritch_knowledge/essence,/datum/eldritch_knowledge/ashen_eyes,/datum/eldritch_knowledge/armor)
	route = PATH_FLESH
	var/max_amt = 2
	var/current_amt = 0
	var/list/ghouls = list()

/datum/eldritch_knowledge/flesh_ghoul/on_finished_recipe(mob/living/user,list/atoms,loc)
	var/mob/living/carbon/human/humie = locate() in atoms
	if(QDELETED(humie) || humie.stat != DEAD)
		return

	if(length(ghouls) >= max_amt)
		return

	if(HAS_TRAIT(humie,TRAIT_HUSK))
		return

	humie.grab_ghost()

	if(!humie.mind || !humie.client)
		var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as a [humie.real_name], a voiceless dead", ROLE_HERETIC, null, ROLE_HERETIC, 50,humie)
		if(!LAZYLEN(candidates))
			to_chat(user,"<span class='warning'>No ghost could be found...</span>")
			return
		var/mob/dead/observer/C = pick(candidates)
		message_admins("[key_name_admin(C)] has taken control of ([key_name_admin(humie)]) to replace an AFK player.")
		humie.ghostize(0)
		humie.key = C.key

	log_game("[key_name_admin(humie)] has become a voiceless dead, their master is [user.real_name]")
	humie.revive(full_heal = TRUE, admin_revive = TRUE)
	ADD_TRAIT(humie,TRAIT_MUTE,MAGIC_TRAIT)
	ADD_TRAIT(humie, TRAIT_STUNIMMUNE, MAGIC_TRAIT)
	ADD_TRAIT(humie, TRAIT_CONFUSEIMMUNE, MAGIC_TRAIT)
	ADD_TRAIT(humie, TRAIT_IGNOREDAMAGESLOWDOWN, MAGIC_TRAIT)
	ADD_TRAIT(humie, TRAIT_NOSTAMCRIT, MAGIC_TRAIT)
	ADD_TRAIT(humie, TRAIT_NOLIMBDISABLE, MAGIC_TRAIT)
	humie.setMaxHealth(50)
	humie.health = 50 // Voiceless dead are much tougher than ghouls
	humie.become_husk()
	humie.faction |= "heretics"

	if (!IS_HERETIC_CULTIST(humie))
		var/datum/antagonist/heretic_monster/heretic_monster = humie.mind.add_antag_datum(/datum/antagonist/heretic_monster)
		var/datum/antagonist/heretic/master = user.mind.has_antag_datum(/datum/antagonist/heretic)
		heretic_monster.set_owner(master)
		RegisterSignal(humie,COMSIG_MOB_DEATH,.proc/remove_ghoul)
	atoms -= humie
	ghouls += humie

/datum/eldritch_knowledge/flesh_ghoul/proc/remove_ghoul(datum/source)
	var/mob/living/carbon/human/humie = source
	ghouls -= humie
	humie.mind.remove_antag_datum(/datum/antagonist/heretic_monster)
	UnregisterSignal(source,COMSIG_MOB_DEATH)

/datum/eldritch_knowledge/flesh_mark
	name = "Priest Ascension"
	gain_text = "I saw them, the marked ones. The screams.. the silence."
	desc = "As a Priest of Flesh, you can recruit more disciples. Also, your Mansus Grasp now applies the Mark of Flesh on hit. Attack the afflicted with your Sickly Blade to detonate the mark. Upon detonation, the Mark of Flesh causes additional bleeding."
	cost = 10
	next_knowledge = list(/datum/eldritch_knowledge/summon/raw_prophet)
	banned_knowledge = list(/datum/eldritch_knowledge/rust_mark,/datum/eldritch_knowledge/ash_mark)
	route = PATH_FLESH
	followers_increment = 1

/datum/eldritch_knowledge/flesh_mark/on_mansus_grasp(target,user,proximity_flag,click_parameters)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.apply_status_effect(/datum/status_effect/eldritch/flesh)

/datum/eldritch_knowledge/summon/raw_prophet
	name = "Raw Ritual"
	gain_text = "The Uncanny Man, who walks alone in the valley between the worlds... I was able to summon his aid."
	desc = "You can now summon a Raw Prophet by transmutating a pair of eyes, a left arm and a pool of blood. Raw prophets have increased seeing range, as well as X-Ray vision, but they are very fragile."
	cost = 5
	required_atoms = list(/obj/item/organ/eyes,/obj/item/bodypart/l_arm,/obj/item/bodypart/r_arm,/obj/effect/decal/cleanable/blood)
	mob_to_summon = /mob/living/simple_animal/hostile/eldritch/raw_prophet
	next_knowledge = list(/datum/eldritch_knowledge/flesh_blade_upgrade,/datum/eldritch_knowledge/spell/blood_siphon,/datum/eldritch_knowledge/curse/alteration,/datum/eldritch_knowledge/dematerialize)
	route = PATH_FLESH

/datum/eldritch_knowledge/flesh_blade_upgrade
	name = "Prophet Ascension"
	gain_text = "It rained blood, that's when i understood the gravekeeper's advice."
	desc = "As a Prophet of Flesh, you can recruit more disciples. Makes your ghouls stronger and allows you to revive fallen ghouls. Enhances your blade to cause additional bleeding."
	cost = 10
	next_knowledge = list(/datum/eldritch_knowledge/summon/stalker)
	banned_knowledge = list(/datum/eldritch_knowledge/ash_blade_upgrade,/datum/eldritch_knowledge/rust_blade_upgrade)
	route = PATH_FLESH
	followers_increment = 1

/datum/eldritch_knowledge/flesh_blade_upgrade/on_mansus_touch(atom/target, mob/user, proximity_flag, click_parameters)
	..()
	var/mob/living/carbon/t_mob = target
	if (user.a_intent != INTENT_HARM && (IS_HERETIC_CULTIST(t_mob) || IS_HERETIC(t_mob)))
		if (istype(t_mob))
			t_mob.adjustFireLoss(-12)
			t_mob.adjustBruteLoss(-12)
		return FALSE
	return TRUE

/datum/eldritch_knowledge/flesh_blade_upgrade/on_eldritch_blade(target,user,proximity_flag,click_parameters)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.bleed_rate += 1

/datum/eldritch_knowledge/summon/stalker
	name = "Lonely Ritual"
	gain_text = "I was able to combine my greed and desires to summon an eldritch beast I had never seen before. An ever shapeshifting mass of flesh, it knew well my goals."
	desc = "You can now summon a Stalker by transmutating a pair of eyes, a candle, a pen and a piece of paper. Stalkers can shapeshift into harmless animals to get close to the victim."
	cost = 5
	required_atoms = list(/obj/item/kitchen/knife,/obj/item/reagent_containers/food/snacks/grown/poppy,/obj/item/pen,/obj/item/paper)
	mob_to_summon = /mob/living/simple_animal/hostile/eldritch/stalker
	next_knowledge = list(/datum/eldritch_knowledge/final/flesh_final,/datum/eldritch_knowledge/summon/ashy,/datum/eldritch_knowledge/summon/rusty,/datum/eldritch_knowledge/spell/cleave)
	route = PATH_FLESH

/datum/eldritch_knowledge/final/flesh_final
	name = "Priest's Final Hymn"
	gain_text = "Man of this world. Hear me! For the time of the lord of arms has come! Emperor of Flesh guides my army!"
	desc = "Bring 3 bodies onto a transmutation rune to gain the ability of shedding your human form, and gaining untold power."
	required_atoms = list(/mob/living/carbon/human)
	cost = 15
	route = PATH_FLESH
	followers_increment = 1

/datum/eldritch_knowledge/final/flesh_final/on_finished_recipe(mob/living/user, list/atoms, loc)
	. = ..()
	priority_announce("$^@&#*$^@(#&$(@&#^$&#^@# Ever coiling vortex. Reality unfolded. THE LORD OF ARMS, [user.real_name] has ascended! Fear the ever twisting hand! $^@&#*$^@(#&$(@&#^$&#^@#","#$^@&#*$^@(#&$(@&#^$&#^@#", 'sound/ai/spanomalies.ogg')
	user.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/shed_human_form)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	H.physiology.brute_mod *= 0.5
	H.physiology.burn_mod *= 0.5
	var/datum/antagonist/heretic/heretic = user.mind.has_antag_datum(/datum/antagonist/heretic)
	var/datum/eldritch_knowledge/flesh_grasp/ghoul1 = heretic.get_knowledge(/datum/eldritch_knowledge/flesh_grasp)
	ghoul1.ghoul_amt *= 3
	var/datum/eldritch_knowledge/flesh_ghoul/ghoul2 = heretic.get_knowledge(/datum/eldritch_knowledge/flesh_ghoul)
	ghoul2.max_amt *= 3
