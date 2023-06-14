
//Academy Areas

/area/awaymission/academy
	name = "Academy Asteroids"
	icon_state = "away"

/area/awaymission/academy/headmaster
	name = "Academy Fore Block"
	icon_state = "away1"

/area/awaymission/academy/classrooms
	name = "Academy Classroom Block"
	icon_state = "away2"

/area/awaymission/academy/academyaft
	name = "Academy Ship Aft Block"
	icon_state = "away3"

/area/awaymission/academy/academygate
	name = "Academy Gateway"
	icon_state = "away4"

/area/awaymission/academy/academycellar
	name = "Academy Cellar"
	icon_state = "away4"

/area/awaymission/academy/academyengine
	name = "Academy Engine"
	icon_state = "away4"

//Academy Items

/obj/item/paper/fluff/awaymissions/academy/console_maint
	name = "Console Maintenance"
	default_raw_text = "We're upgrading to the latest mainframes for our consoles, the shipment should be in before spring break is over!"

/obj/item/paper/fluff/awaymissions/academy/class/automotive
	name = "Automotive Repair 101"

/obj/item/paper/fluff/awaymissions/academy/class/pyromancy
	name = "Pyromancy 250"

/obj/item/paper/fluff/awaymissions/academy/class/biology
	name = "Biology Lab"

/obj/item/paper/fluff/awaymissions/academy/grade/aplus
	name = "Summoning Midterm Exam"
	default_raw_text = "Grade: A+ Educator's Notes: Excellent form."

/obj/item/paper/fluff/awaymissions/academy/grade/bminus
	name = "Summoning Midterm Exam"
	default_raw_text = "Grade: B- Educator's Notes: Keep applying yourself, you're showing improvement."

/obj/item/paper/fluff/awaymissions/academy/grade/dminus
	name = "Summoning Midterm Exam"
	default_raw_text = "Grade: D- Educator's Notes: SEE ME AFTER CLASS."

/obj/item/paper/fluff/awaymissions/academy/grade/failure
	name = "Pyromancy Evaluation"
	default_raw_text = "Current Grade: F. Educator's Notes: No improvement shown despite multiple private lessons.  Suggest additional tutelage."

/// The immobile, close pulling singularity seen in the academy away mission
/obj/anomaly/singularity/academy
	move_self = FALSE

/obj/anomaly/singularity/academy/Initialize(mapload)
	. = ..()
	var/datum/component/singularity/singularity = singularity_component.resolve()
	singularity?.grav_pull = TRUE

/obj/anomaly/singularity/academy/process(delta_time)
	if(DT_PROB(0.5, delta_time))
		mezzer()

/obj/item/clothing/glasses/meson/truesight
	name = "The Lens of Truesight"
	desc = "I can see forever!"
	icon_state = "monocle"
	item_state = "headset"


/obj/structure/academy_wizard_spawner
	name = "Academy Defensive System"
	desc = "Made by Abjuration, Inc."
	icon = 'icons/obj/cult.dmi'
	icon_state = "forge"
	anchored = TRUE
	max_integrity = 200
	var/mob/living/current_wizard = null
	var/next_check = 0
	var/cooldown = 600
	var/faction = FACTION_WIZARD
	var/braindead_check = 0

/obj/structure/academy_wizard_spawner/New()
	START_PROCESSING(SSobj, src)

/obj/structure/academy_wizard_spawner/Destroy()
	if(!broken)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/academy_wizard_spawner/process()
	if(next_check < world.time)
		if(!current_wizard)
			for(var/mob/living/L in GLOB.player_list)
				if(L.get_virtual_z_level() == src.get_virtual_z_level() && L.stat != DEAD && !(faction in L.faction))
					summon_wizard()
					break
		else
			if(current_wizard.stat == DEAD)
				current_wizard = null
				summon_wizard()
			if(!current_wizard.client)
				if(!braindead_check)
					braindead_check = 1
				else
					braindead_check = 0
					give_control()
		next_check = world.time + cooldown

/obj/structure/academy_wizard_spawner/proc/give_control()
	set waitfor = FALSE

	if(!current_wizard)
		return
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as Wizard Academy Defender?", BAN_ROLE_WIZARD, null, /datum/role_preference/midround_ghost/wizard, 50, current_wizard)

	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		message_admins("[ADMIN_LOOKUPFLW(C)] was spawned as Wizard Academy Defender")
		current_wizard.ghostize(FALSE) // on the off chance braindead defender gets back in
		current_wizard.key = C.key
	else
		affected_mob.playable_bantype = BAN_ROLE_WIZARD
		current_wizard.ghostize(FALSE,SENTIENCE_FORCE)

/obj/structure/academy_wizard_spawner/proc/summon_wizard()
	var/turf/T = src.loc
	var/mob/living/carbon/human/wizbody = new(T)
	wizbody.fully_replace_character_name(wizbody.real_name, "Academy Teacher")
	wizbody.mind_initialize()
	var/datum/mind/wizmind = wizbody.mind
	wizmind.special_role = "Academy Defender"
	wizmind.add_antag_datum(/datum/antagonist/wizard/academy)
	current_wizard = wizbody

	give_control()

/obj/structure/academy_wizard_spawner/deconstruct(disassembled = TRUE)
	if(!broken)
		broken = 1
		visible_message("<span class='warning'>[src] breaks down!</span>")
		icon_state = "forge_off"
		STOP_PROCESSING(SSobj, src)

/datum/outfit/wizard/academy
	name = "Academy Wizard"
	r_pocket = null
	r_hand = null
	suit = /obj/item/clothing/suit/wizrobe/red
	head = /obj/item/clothing/head/wizard/red
	backpack_contents = list(/obj/item/storage/box/survival = 1)

/obj/item/dice/d20/fate
	name = "\improper Die of Fate"
	desc = "A die with twenty sides. You can feel unearthly energies radiating from it. Using this might be VERY risky."
	icon_state = "d20"
	sides = 20
	microwave_riggable = FALSE
	var/reusable = TRUE
	var/used = FALSE
	var/roll_in_progress = FALSE

/obj/item/dice/d20/fate/stealth
	name = "d20"
	desc = "A die with twenty sides. The preferred die to throw at the GM."

/obj/item/dice/d20/fate/one_use
	reusable = FALSE

/obj/item/dice/d20/fate/one_use/stealth
	name = "d20"
	desc = "A die with twenty sides. The preferred die to throw at the GM."

/obj/item/dice/d20/fate/cursed
	name = "cursed Die of Fate"
	desc = "A die with twenty sides. You feel that rolling this is a REALLY bad idea."
	color = "#00BB00"

	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 1

/obj/item/dice/d20/fate/diceroll(mob/user)
	. = ..()
	if(roll_in_progress)
		to_chat(user, "<span class='warning'>The dice is already channeling its power! Be patient!</span>")
		return

	if(!used)
		if(!ishuman(user) || !user.mind || (user.mind in SSticker.mode.wizards))
			to_chat(user, "<span class='warning'>You feel the magic of the dice is restricted to ordinary humans!</span>")
			return

		if(!reusable)
			used = TRUE
		roll_in_progress = TRUE
		var/turf/T = get_turf(src)
		T.visible_message("<span class='userdanger'>[src] flares briefly.</span>")
		addtimer(CALLBACK(src, PROC_REF(effect), user, .), 1 SECONDS)

/obj/item/dice/d20/fate/equipped(mob/user, slot)
	if(!ishuman(user) || !user.mind || (user.mind in SSticker.mode.wizards))
		to_chat(user, "<span class='warning'>You feel the magic of the dice is restricted to ordinary humans! You should leave it alone.</span>")
		user.dropItemToGround(src)


/obj/item/dice/d20/fate/proc/effect(var/mob/living/carbon/human/user,roll)
	var/turf/T = get_turf(src)

	switch(roll)
		if(1)
			//Dust
			T.visible_message("<span class='userdanger'>[user] turns to dust!</span>")
			user.sethellbound()
			user.dust()
		if(2)
			//Death
			T.visible_message("<span class='userdanger'>[user] suddenly dies!</span>")
			user.death()
		if(3)
			//Swarm of creatures
			T.visible_message("<span class='userdanger'>A swarm of creatures surround [user]!</span>")
			for(var/direction in GLOB.alldirs)
				new /mob/living/simple_animal/hostile/netherworld(get_step(get_turf(user),direction))
		if(4)
			//Destroy Equipment
			T.visible_message("<span class='userdanger'>Everything [user] is holding and wearing disappears!</span>")
			for(var/obj/item/I in user)
				if(istype(I, /obj/item/implant))
					continue
				qdel(I)
		if(5)
			//Monkeying
			T.visible_message("<span class='userdanger'>[user] transforms into a monkey!</span>")
			user.monkeyize()
		if(6)
			//Cut speed
			T.visible_message("<span class='userdanger'>[user] starts moving slower!</span>")
			user.add_movespeed_modifier(MOVESPEED_ID_DIE_OF_FATE, update=TRUE, priority=100, multiplicative_slowdown=1)
		if(7)
			//Throw
			T.visible_message("<span class='userdanger'>Unseen forces throw [user]!</span>")
			user.Stun(60)
			user.adjustBruteLoss(50)
			var/throw_dir = pick(GLOB.cardinals)
			var/atom/throw_target = get_edge_target_turf(user, throw_dir)
			user.throw_at(throw_target, 200, 4)
		if(8)
			//Fueltank Explosion
			T.visible_message("<span class='userdanger'>An explosion bursts into existence around [user]!</span>")
			explosion(get_turf(user),-1,0,2, flame_range = 2, magic = TRUE)
		if(9)
			//Cold
			var/datum/disease/D = new /datum/disease/cold()
			T.visible_message("<span class='userdanger'>[user] looks a little under the weather!</span>")
			user.ForceContractDisease(D, FALSE, TRUE)
		if(10)
			//Nothing
			T.visible_message("<span class='userdanger'>Nothing seems to happen.</span>")
		if(11)
			//Cookie
			T.visible_message("<span class='userdanger'>A cookie appears out of thin air!</span>")
			var/obj/item/reagent_containers/food/snacks/cookie/C = new(drop_location())
			do_smoke(0, drop_location())
			C.name = "Cookie of Fate"
		if(12)
			//Healing
			T.visible_message("<span class='userdanger'>[user] looks very healthy!</span>")
			user.revive(full_heal = 1, admin_revive = 1)
		if(13)
			//Mad Dosh
			T.visible_message("<span class='userdanger'>Mad dosh shoots out of [src]!</span>")
			var/turf/Start = get_turf(src)
			for(var/direction in GLOB.alldirs)
				var/turf/dirturf = get_step(Start,direction)
				if(rand(0,1))
					new /obj/item/stack/spacecash/c1000(dirturf)
				else
					var/obj/item/storage/bag/money/M = new(dirturf)
					for(var/i in 1 to rand(5,50))
						new /obj/item/coin/gold(M)
		if(14)
			//Free Gun
			T.visible_message("<span class='userdanger'>An impressive gun appears!</span>")
			do_smoke(0, drop_location())
			new /obj/item/gun/ballistic/revolver/mateba(drop_location())
		if(15)
			//Random One-use spellbook
			T.visible_message("<span class='userdanger'>A magical looking book drops to the floor!</span>")
			do_smoke(0, drop_location())
			new /obj/item/book/granter/spell/random(drop_location())
		if(16)
			//Servant & Servant Summon
			T.visible_message("<span class='userdanger'>A Dice Servant appears in a cloud of smoke!</span>")
			var/mob/living/carbon/human/H = new(drop_location())
			do_smoke(0, drop_location())

			H.equipOutfit(/datum/outfit/butler)
			var/datum/mind/servant_mind = new /datum/mind()
			var/datum/antagonist/magic_servant/A = new
			servant_mind.add_antag_datum(A)
			A.setup_master(user)
			servant_mind.transfer_to(H)

			var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as [user.real_name] Servant?", BAN_ROLE_WIZARD, null, /datum/role_preference/midround_ghost/wizard, 50, H)
			if(LAZYLEN(candidates))
				var/mob/dead/observer/C = pick(candidates)
				message_admins("[ADMIN_LOOKUPFLW(C)] was spawned as Dice Servant")
				H.key = C.key

			var/obj/effect/proc_holder/spell/targeted/summonmob/S = new
			S.target_mob = H
			user.mind.AddSpell(S)

		if(17)
			//Tator Kit
			T.visible_message("<span class='userdanger'>A suspicious box appears!</span>")
			new /obj/item/storage/box/syndie_kit/bundle_A(drop_location())
			do_smoke(0, drop_location())
		if(18)
			//Captain ID
			T.visible_message("<span class='userdanger'>A golden identification card appears!</span>")
			new /obj/item/card/id/captains_spare(drop_location())
			do_smoke(0, drop_location())
		if(19)
			//Instrinct Resistance
			T.visible_message("<span class='userdanger'>[user] looks very robust!</span>")
			user.physiology.brute_mod *= 0.5
			user.physiology.burn_mod *= 0.5

		if(20)
			//Free wizard!
			T.visible_message("<span class='userdanger'>Magic flows out of [src] and into [user]!</span>")
			user.mind.make_Wizard()
	//roll is completed, allow others players to roll the dice
	roll_in_progress = FALSE


/datum/outfit/butler
	name = "Butler"
	uniform = /obj/item/clothing/under/suit/black_really
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/bowler
	glasses = /obj/item/clothing/glasses/monocle
	gloves = /obj/item/clothing/gloves/color/white

/obj/effect/proc_holder/spell/targeted/summonmob
	name = "Summon Servant"
	desc = "This spell can be used to call your servant, whenever you need it."
	charge_max = 100
	clothes_req = 0
	invocation = "JE VES"
	invocation_type = INVOCATION_WHISPER
	range = -1
	level_max = 0 //cannot be improved
	cooldown_min = 100
	include_user = 1

	var/mob/living/target_mob

	action_icon_state = "summons"

/obj/effect/proc_holder/spell/targeted/summonmob/cast(list/targets,mob/user = usr)
	if(!target_mob)
		return
	var/turf/Start = get_turf(user)
	for(var/direction in GLOB.alldirs)
		var/turf/T = get_step(Start,direction)
		if(!T.density)
			target_mob.Move(T)

/obj/structure/ladder/unbreakable/rune
	name = "\improper Teleportation Rune"
	desc = "Could lead anywhere."
	icon = 'icons/obj/rune.dmi'
	icon_state = "1"
	color = rgb(0,0,255)

/obj/structure/ladder/unbreakable/rune/update_icon()
	return

/obj/structure/ladder/unbreakable/rune/show_fluff_message(up,mob/user)
	user.visible_message("[user] activates \the [src].","<span class='notice'>You activate \the [src].</span>")

/obj/structure/ladder/unbreakable/rune/use(mob/user, is_ghost=FALSE)
	if(is_ghost || !(user.mind in SSticker.mode.wizards))
		..()
