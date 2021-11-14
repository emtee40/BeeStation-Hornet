//God this is ugly, why was it split in like 4 files
/*

Contents:
- The Ninja Space Suit
- Ninja Space Suit Procs

*/

/obj/item/clothing/suit/space/space_ninja
	name = "ninja suit"
	desc = "A unique, vacuum-proof suit of nano-enhanced armor designed specifically for Spider Clan assassins."
	icon_state = "s-ninja"
	item_state = "s-ninja_suit"
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals, /obj/item/stock_parts/cell)
	slowdown = 1
	resistance_flags = LAVA_PROOF | ACID_PROOF
	armor = list("melee" = 60, "bullet" = 50, "laser" = 30,"energy" = 15, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 100, "acid" = 100, "stamina" = 60)
	strip_delay = 12

	actions_types = list(/datum/action/item_action/initialize_ninja_suit, /datum/action/item_action/ninjasmoke, /datum/action/item_action/ninjaboost, /datum/action/item_action/ninjapulse, /datum/action/item_action/ninjastar, /datum/action/item_action/ninjanet, /datum/action/item_action/ninja_sword_recall, /datum/action/item_action/ninja_stealth, /datum/action/item_action/toggle_glove)

		//Important parts of the suit.
	var/mob/living/carbon/human/suit_user
	var/obj/item/stock_parts/cell/cell
	var/datum/techweb/stored_research
	var/obj/item/energy_katana/energyKatana //For teleporting the katana back to the ninja (It's an ability)

		//Other articles of ninja gear worn together, used to easily reference them after initializing.
	var/obj/item/clothing/head/helmet/space/space_ninja/n_hood
	var/obj/item/clothing/shoes/space_ninja/n_shoes
	var/obj/item/clothing/gloves/space_ninja/n_gloves

		//Main function variables.
	var/s_initialized = 0//Suit starts off.
	var/s_coold = 0//If the suit is on cooldown. Can be used to attach different cooldowns to abilities. Ticks down every second based on suit ntick().
	var/s_cost = 2.5//Base energy cost each ntick.
	var/s_acost = 12.5//Additional cost for additional powers active.
	var/s_delay = 40//How fast the suit does certain things, lower is faster. Can be overridden in specific procs. Also determines adverse probability.
	var/a_transfer = 20//How much radium is used per adrenaline boost.
	var/a_maxamount = 7//Maximum number of adrenaline boosts.
	var/s_maxamount = 20//Maximum number of smoke bombs.

		//Support function variables.
	var/stealth = FALSE//Stealth off.
	var/s_busy = FALSE//Is the suit busy with a process? Like AI hacking. Used for safety functions.

		//Ability function variables.
	var/s_bombs = 10//Number of smoke bombs.
	var/a_boost = 3//Number of adrenaline boosters.

	var/datum/effect_system/spark_spread/spark_system

/obj/item/clothing/suit/space/space_ninja/Initialize()
	. = ..()

	//Spark Init
	spark_system = new
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

	//Research Init
	stored_research = new()

	//Cell Init
	cell = new/obj/item/stock_parts/cell/high
	cell.charge = 9000
	cell.name = "black power cell"
	cell.icon_state = "bscell"

/obj/item/clothing/suit/space/space_ninja/Destroy()
	QDEL_NULL(spark_system)
	QDEL_NULL(cell)
	if(suit_user)
		UnregisterSignal(suit_user, COMSIG_MOB_DEATH)
		suit_user = null
	return ..()

//Simply deletes all the attachments and self, killing all related procs.
/obj/item/clothing/suit/space/space_ninja/proc/terminate()
	qdel(n_hood)
	qdel(n_gloves)
	qdel(n_shoes)
	if(energyKatana)
		energyKatana.visible_message("<span class='warning'>[src] flares and then turns to dust!</span>")
		qdel(energyKatana)
	qdel(src)

//Randomizes suit parameters.
/obj/item/clothing/suit/space/space_ninja/proc/randomize_param()
	s_cost = rand(1,10)
	s_acost = rand(10,50)
	s_delay = rand(10,100)
	s_bombs = rand(5,20)
	a_boost = rand(1,7)


//This proc prevents the suit from being taken off.
/obj/item/clothing/suit/space/space_ninja/proc/lock_suit(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	if(!is_ninja(H))
		to_chat(H, "<span class='danger'><B>fÄTaL ÈÈRRoR</B>: 382200-*#00CÖDE <B>RED</B>\nUNAUHORIZED USÈ DETÈCeD\nCoMMÈNCING SUB-R0UIN3 13...\nTÈRMInATING U-U-USÈR...</span>")
		H.gib()
		return FALSE
	if(!istype(H.head, /obj/item/clothing/head/helmet/space/space_ninja))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 100113 UNABLE TO LOCATE HEAD GEAR\nABORTING...")
		return FALSE
	if(!istype(H.shoes, /obj/item/clothing/shoes/space_ninja))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 122011 UNABLE TO LOCATE FOOT GEAR\nABORTING...")
		return FALSE
	if(!istype(H.gloves, /obj/item/clothing/gloves/space_ninja))
		to_chat(H, "<span class='userdanger'>ERROR</span>: 110223 UNABLE TO LOCATE HAND GEAR\nABORTING...")
		return FALSE
	suit_user = H
	ADD_TRAIT(src, TRAIT_NODROP, NINJA_SUIT_TRAIT)
	slowdown = 0
	n_hood = H.head
	ADD_TRAIT(n_hood, TRAIT_NODROP, NINJA_SUIT_TRAIT)
	n_shoes = H.shoes
	ADD_TRAIT(n_shoes, TRAIT_NODROP, NINJA_SUIT_TRAIT)
	n_shoes.slowdown--
	n_gloves = H.gloves
	ADD_TRAIT(n_gloves, TRAIT_NODROP, NINJA_SUIT_TRAIT)
	RegisterSignal(suit_user, COMSIG_MOB_DEATH, .proc/on_user_death)
	return TRUE

/obj/item/clothing/suit/space/space_ninja/proc/on_user_death()
	SIGNAL_HANDLER

	cancel_stealth()
	unlock_suit()

/obj/item/clothing/suit/space/space_ninja/proc/lockIcons(mob/living/carbon/human/H)
	icon_state = H.gender==FEMALE ? "s-ninjanf" : "s-ninjan"
	H.gloves.icon_state = "s-ninjan"
	H.gloves.item_state = "s-ninjan"

//This proc allows the suit to be taken off.
/obj/item/clothing/suit/space/space_ninja/proc/unlock_suit()
	suit_user = null
	REMOVE_TRAIT(src, TRAIT_NODROP, NINJA_SUIT_TRAIT)
	slowdown = 1
	icon_state = "s-ninja"
	if(n_hood)//Should be attached, might not be attached.
		REMOVE_TRAIT(n_hood, TRAIT_NODROP, NINJA_SUIT_TRAIT)
	if(n_shoes)
		REMOVE_TRAIT(n_shoes, TRAIT_NODROP, NINJA_SUIT_TRAIT)
		n_shoes.slowdown++
	if(n_gloves)
		n_gloves.icon_state = "s-ninja"
		n_gloves.item_state = "s-ninja"
		REMOVE_TRAIT(n_gloves, TRAIT_NODROP, NINJA_SUIT_TRAIT)
		n_gloves.candrain = FALSE
		n_gloves.draining = FALSE


/obj/item/clothing/suit/space/space_ninja/examine(mob/user)
	. = .()
	if(s_initialized && user == suit_user)
		. += "All systems operational. Current energy capacity: <B>[DisplayEnergy(cell.charge)]</B>.\n"+\
		"The CLOAK-tech device is <B>[stealth?"active":"inactive"]</B>.\n"+\
		"There are <B>[s_bombs]</B> smoke bomb\s remaining.\n"+\
		"There are <B>[a_boost]</B> adrenaline booster\s remaining."

/obj/item/clothing/suit/space/space_ninja/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/initialize_ninja_suit))
		toggle_on_off()
		return TRUE
	if(!s_initialized)
		to_chat(user, "<span class='warning'><b>ERROR</b>: suit offline.  Please activate suit.</span>")
		return FALSE
	if(istype(action, /datum/action/item_action/ninjasmoke))
		ninjasmoke()
		return TRUE
	if(istype(action, /datum/action/item_action/ninjaboost))
		ninjaboost()
		return TRUE
	if(istype(action, /datum/action/item_action/ninjapulse))
		ninjapulse()
		return TRUE
	if(istype(action, /datum/action/item_action/ninjastar))
		ninjastar()
		return TRUE
	if(istype(action, /datum/action/item_action/ninjanet))
		ninjanet()
		return TRUE
	if(istype(action, /datum/action/item_action/ninja_sword_recall))
		ninja_sword_recall()
		return TRUE
	if(istype(action, /datum/action/item_action/ninja_stealth))
		stealth()
		return TRUE
	if(istype(action, /datum/action/item_action/toggle_glove))
		n_gloves.toggledrain()
		return TRUE
	return FALSE

/obj/item/clothing/suit/space/space_ninja/proc/toggle_on_off()
	if(s_busy)
		to_chat(loc, "<span class='userdanger'>ERROR</span>: You cannot use this function at this time.")
		return FALSE
	if(s_initialized)
		turn_off()
	else
		set_up_suit()
	. = TRUE

/obj/item/clothing/suit/space/space_ninja/proc/set_up_suit()
	s_busy = TRUE

	to_chat(suit_user, "<span class='notice'>Now initializing...</span>")
	sleep(s_delay)

	if(!lock_suit(suit_user))//To lock the suit onto wearer.
		s_busy = FALSE
		return
	to_chat(suit_user, "<span class='notice'>Securing external locking mechanism...\nNeural-net established.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>Extending neural-net interface...\nNow monitoring brain wave pattern...</span>")
	sleep(s_delay)

	if(suit_user.stat == DEAD|| suit_user.health <= 0)
		to_chat(suit_user, "<span class='danger'><B>FÄAL ï¿½Rrï¿½R</B>: 344--93#ï¿½&&21 BRï¿½ï¿½N |/|/aVï¿½ PATT$RN <B>RED</B>\nA-A-aBï¿½rTï¿½NG...</span>")
		unlock_suit()
		s_busy = FALSE
		return
	lockIcons(suit_user)//Check for icons.
	suit_user.regenerate_icons()
	to_chat(suit_user, "<span class='notice'>Linking neural-net interface...\nPattern</span>\green <B>GREEN</B><span class='notice'>, continuing operation.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>VOID-shift device status: <B>ONLINE</B>.\nCLOAK-tech device status: <B>ONLINE</B>.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>Primary system status: <B>ONLINE</B>.\nBackup system status: <B>ONLINE</B>.\nCurrent energy capacity: <B>[DisplayEnergy(cell.charge)]</B>.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>All systems operational. Welcome to <B>SpiderOS</B>, [suit_user.real_name].</span>")
	suit_user = TRUE
	START_PROCESSING(SSprocessing, src)
	s_busy = FALSE

/obj/item/clothing/suit/space/space_ninja/proc/turn_off()
	if(alert("Are you certain you wish to remove the suit? This will take time and remove all abilities.",,"Yes","No")!="Yes")
		return

	s_busy = TRUE

	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>Now de-initializing...</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>Logging off, [suit_user.real_name]. Shutting down <B>SpiderOS</B>.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>Primary system status: <B>OFFLINE</B>.\nBackup system status: <B>OFFLINE</B>.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>VOID-shift device status: <B>OFFLINE</B>.\nCLOAK-tech device status: <B>OFFLINE</B>.</span>")
	cancel_stealth()//Shutdowns stealth.

	to_chat(suit_user, "<span class='notice'>Disconnecting neural-net interface...</span>\green<B>Success</B><span class='notice'>.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>Disengaging neural-net interface...</span>\green<B>Success</B><span class='notice'>.</span>")
	sleep(s_delay)

	to_chat(suit_user, "<span class='notice'>Unsecuring external locking mechanism...\nNeural-net abolished.\nOperation status: <B>FINISHED</B>.</span>")
	unlock_suit()
	suit_user.regenerate_icons()
	s_initialized = FALSE
	s_busy = FALSE

/obj/item/clothing/suit/space/space_ninja/process(delta_time)
	if(!suit_user)
		terminate()//Kills the suit and attached objects.

	else if(cell.charge > 0)
		if(s_coold)
			s_coold--//Checks for ability s_cooldown first.

		cell.charge -= s_cost//s_cost is the default energy cost each ntick, usually 5.
		if(stealth)//If stealth is active.
			cell.charge -= s_acost

	else
		cell.charge = 0
		cancel_stealth()



/obj/item/clothing/suit/space/space_ninja/attackby(obj/item/I, mob/user, params)
	if(user != suit_user)//Safety, in case you try doing this without wearing the suit/being the person with the suit.
		return ..()

	if(istype(I, /obj/item/reagent_containers/glass))//If it's a glass beaker.
		if(I.reagents.has_reagent(/datum/reagent/uranium/radium, a_transfer) && a_boost < a_maxamount)
			I.reagents.remove_reagent(/datum/reagent/uranium/radium, a_transfer)
			a_boost++;
			to_chat(user, "<span class='notice'>There are now [a_boost] adrenaline boosts remaining.</span>")
			return
		if(I.reagents.has_reagent(/datum/reagent/smoke_powder, a_transfer) && s_bombs < s_maxamount)
			I.reagents.remove_reagent(/datum/reagent/smoke_powder, a_transfer)
			s_bombs++;
			to_chat(user, "<span class='notice'>There are now [s_bombs] smoke bombs remaining.</span>")
			return


	else if(istype(I, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = I
		if(C.maxcharge <= cell.maxcharge || !n_gloves?.candrain)
			return
		to_chat(user, "<span class='notice'>Higher maximum capacity detected.\nUpgrading...</span>")
		if(!do_after(user, s_delay, target = src))
			to_chat(user, "<span class='danger'>Procedure interrupted. Protocol terminated.</span>")
			return
		user.transferItemToLoc(C, src)
		C.charge = min(C.charge+cell.charge, C.maxcharge)
		var/obj/item/stock_parts/cell/old_cell = cell
		old_cell.charge = 0
		user.put_in_hands(old_cell)
		old_cell.add_fingerprint(user)
		old_cell.corrupt()
		old_cell.update_icon()
		cell = C
		to_chat(user, "<span class='notice'>Upgrade complete. Maximum capacity: <b>[round(cell.maxcharge/100)]</b>%</span>")
		return

	else if(istype(I, /obj/item/disk/tech_disk))//If it's a data disk, we want to copy the research on to the suit.
		var/obj/item/disk/tech_disk/TD = I
		if(TD.stored_research)//If it has something on it.
			to_chat(user, "Research information detected, processing...")
			if(do_after(user, s_delay, target = src))
				TD.stored_research.copy_research_to(stored_research)
				to_chat(user, "<span class='notice'>Data analyzed and updated. Disk erased.</span>")
			else
				to_chat(user, "<span class='userdanger'>ERROR</span>: Procedure interrupted. Process terminated.")
		else
			to_chat(user, "<span class='notice'>No research information detected.</span>")
		return
	return ..()

/obj/item/clothing/head/helmet/space/space_ninja
	desc = "What may appear to be a simple black garment is in fact a highly sophisticated nano-weave helmet. Standard issue ninja gear."
	name = "ninja hood"
	icon_state = "s-ninja"
	item_state = "s-ninja_mask"
	armor = list("melee" = 60, "bullet" = 50, "laser" = 30,"energy" = 15, "bomb" = 30, "bio" = 30, "rad" = 25, "fire" = 100, "acid" = 100, "stamina" = 60)
	strip_delay = 12
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	blockTracking = 1//Roughly the only unique thing about this helmet.
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/mask/gas/space_ninja
	name = "ninja mask"
	desc = "A close-fitting mask that acts both as an air filter and a post-modern fashion statement."
	icon_state = "s-ninja"
	item_state = "s-ninja_mask"
	strip_delay = 120
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF


/obj/item/clothing/shoes/space_ninja
	name = "ninja shoes"
	desc = "A pair of running shoes. Excellent for running and even better for smashing skulls."
	icon_state = "s-ninja"
	item_state = "secshoes"
	permeability_coefficient = 0.01
	clothing_flags = NOSLIP
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 60, "bullet" = 50, "laser" = 30,"energy" = 15, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 100, "acid" = 100, "stamina" = 60)
	strip_delay = 120
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/space_ninja
	desc = "These nano-enhanced gloves insulate from electricity and provide fire resistance."
	name = "ninja gloves"
	icon_state = "s-ninja"
	item_state = "s-ninja"
	siemens_coefficient = 0
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	strip_delay = 120
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/draining = 0
	var/candrain = 0
	var/drain = 300


/obj/item/clothing/gloves/space_ninja/Touch(atom/A, proximity)
	if(!candrain || draining || !proximity)
		return FALSE
	if(!ishuman(loc))
		return FALSE	//Only works while worn
	if(isturf(A))
		return FALSE

	var/mob/living/carbon/human/H = loc

	var/obj/item/clothing/suit/space/space_ninja/suit = H.wear_suit
	if(!istype(suit))
		return FALSE

	A.add_fingerprint(H)

	draining = TRUE
	var/result = A.ninjadrain_act(suit,H,src)
	draining = FALSE

	if(result)
		to_chat(H, "<span class='notice'>Gained <B>[DisplayEnergy(.)]</B> of energy from [A].</span>")
	return FALSE	//as to not cancel attack_hand()


/obj/item/clothing/gloves/space_ninja/proc/toggledrain()
	var/mob/living/carbon/human/U = loc
	to_chat(U, "You <b>[candrain?"disable":"enable"]</b> special interaction.")
	candrain =! candrain

/obj/item/clothing/gloves/space_ninja/examine(mob/user)
	. = ..()
	if(HAS_TRAIT_FROM(src, TRAIT_NODROP, NINJA_SUIT_TRAIT))
		. += "The energy drain mechanism is <B>[candrain?"active":"inactive"]</B>."
