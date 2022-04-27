/*
	true item, please make sure all off-shoots conform to this.
*/
/obj/item/xenoartifact
	name = "xenoartifact"
	icon = 'icons/obj/xenoarchaeology/xenoartifact.dmi'
	icon_state = "map_editor"
	w_class = WEIGHT_CLASS_NORMAL
	light_color = LIGHT_COLOR_FIRE
	desc = "A strange alien artifact. What could it possibly do?"
	throw_range = 4
	
	var/charge = 0 //How much input the artifact is getting from activator traits
	var/charge_req //This isn't a requirement anymore. This just affects how effective the charge is

	var/material //Associated traits & colour
	var/list/traits = list() //activation trait, minor 1, minor 2, minor 3, major, malfunction
	var/datum/xenoartifact_trait/touch_desc
	var/special_desc = "The Xenoartifact is made from a" //used for special examine circumstance, science goggles
	var/process_type
	var/code //Used for signaler trait
	var/frequency
	var/datum/radio_frequency/radio_connection
	var/min_desc //Just a holder for examine special_desc from minor traits

	var/max_range = 1 //How far his little arms can reach
	var/list/true_target = list()
	var/usedwhen //holder for worldtime
	var/cooldown = 8 SECONDS //Time between uses
	var/cooldownmod = 0 //Extra time traits can add to the cooldown

	var/icon_slots[4] //Associated with random sprite stuff, dw
	var/mutable_appearance/icon_overlay 

	var/malfunction_chance //Everytime the artifact is used this increases. When this is successfully proc'd the artifact gains a malfunction and this is lowered. 
	var/malfunction_mod = 1 //How much the chance can change in a sinlge itteration

	var/logging = TRUE

/obj/item/xenoartifact/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/xenoartifact_pricing)
	AddComponent(/datum/component/discoverable, 10000, TRUE) //Same values as original artifacts, exploration.

/obj/item/xenoartifact/Initialize(mapload, difficulty)
	. = ..()
	material = difficulty //Difficulty is set, in some cases, by xenoartifact_console
	if(!material)
		material = pick(BLUESPACE, PLASMA, URANIUM, BANANIUM)

	var/datum/component/xenoartifact_pricing/xenop = GetComponent(/datum/component/xenoartifact_pricing)

	switch(material)
		if(BLUESPACE)
			name = "bluespace [name]"
			generate_traits(list(/datum/xenoartifact_trait/minor/sharp, /datum/xenoartifact_trait/minor/radioactive,
							/datum/xenoartifact_trait/minor/sentient, /datum/xenoartifact_trait/major/sing, 
							/datum/xenoartifact_trait/major/laser, /datum/xenoartifact_trait/major/bomb,
							/datum/xenoartifact_trait/major/handmore, /datum/xenoartifact_trait/major/emp))
			if(!xenop.price)
				xenop.price = pick(100, 200, 300)

		if(PLASMA)
			name = "plasma [name]"
			generate_traits(list(/datum/xenoartifact_trait/major/sing, /datum/xenoartifact_trait/activator/burn,
							/datum/xenoartifact_trait/minor/dense, /datum/xenoartifact_trait/minor/sentient, 
							/datum/xenoartifact_trait/major/capture, /datum/xenoartifact_trait/major/timestop,
							/datum/xenoartifact_trait/major/bomb, /datum/xenoartifact_trait/major/mirrored,
							/datum/xenoartifact_trait/major/corginator,/datum/xenoartifact_trait/activator/clock,
							/datum/xenoartifact_trait/major/invisible,/datum/xenoartifact_trait/major/handmore,
							/datum/xenoartifact_trait/major/lamp, /datum/xenoartifact_trait/major/forcefield,
							/datum/xenoartifact_trait/activator/signal,/datum/xenoartifact_trait/major/heal,
							/datum/xenoartifact_trait/activator/signal, /datum/xenoartifact_trait/activator/batteryneed))
			if(!xenop.price)
				xenop.price = pick(200, 300, 500)
			malfunction_mod = 2

		if(URANIUM)
			name = "uranium [name]"
			generate_traits(list(/datum/xenoartifact_trait/major/sing, /datum/xenoartifact_trait/minor/sharp,
							/datum/xenoartifact_trait/major/laser, /datum/xenoartifact_trait/major/corginator,
							/datum/xenoartifact_trait/minor/sentient, /datum/xenoartifact_trait/minor/wearable,
							/datum/xenoartifact_trait/major/handmore, /datum/xenoartifact_trait/major/invisible,
							/datum/xenoartifact_trait/major/heal), TRUE) 
			if(!xenop.price)
				xenop.price = pick(300, 500, 800) 
			malfunction_mod = 8

		if(BANANIUM)
			name = "bananium [name]"
			generate_traits(list(/datum/xenoartifact_trait/major/sing))
			if(!xenop.price)
				xenop.price = pick(500, 800, 1000) 
			malfunction_mod = 0.5

	icon_state = null
	for(var/datum/xenoartifact_trait/T in traits) //This is kinda weird but it stops certain bugs.
		if(istype(T, /datum/xenoartifact_trait/minor/dense))
			T.on_init(src)
			return
	for(var/datum/xenoartifact_trait/T in traits)
		T.on_init(src)

	//Random sprite process, I'd like to maybe revisit this, make it a function. probably don't
	if(!(icon_state))
		var/holdthisplease = rand(1, 3)
		icon_state = "IB[holdthisplease]"//base
		generate_icon(icon, "IBL[holdthisplease]", material)
	if(prob(50) || icon_slots[1])//Top
		if(!(icon_slots[1])) //Some traits can set this too, it will be set to a code that looks like 901, 908, 905 ect.
			icon_slots[1] = rand(1, 2)
		generate_icon(icon, "ITP[icon_slots[1]]")
		generate_icon(icon, "ITPL[icon_slots[1]]", material)

	if(prob(30) || icon_slots[3])//Left
		if(!(icon_slots[3]))
			icon_slots[3] = rand(1, 2)
		generate_icon(icon, "IL[icon_slots[3]]")
		generate_icon(icon, "ILL[icon_slots[3]]", material)

	if(prob(50)  || icon_slots[4])//Right
		if(!(icon_slots[4]))
			icon_slots[4] = rand(1, 2)
		generate_icon(icon, "IR[icon_slots[4]]")
		generate_icon(icon, "IRL[icon_slots[4]]", material)

	if(prob(30) || icon_slots[2])//Bottom
		if(!(icon_slots[2]))
			icon_slots[2] = rand(1, 2)
		generate_icon(icon, "IBTM[icon_slots[2]]")
		generate_icon(icon, "IBTML[icon_slots[2]]", material)

/obj/item/xenoartifact/examine(mob/living/carbon/user)
	. = ..()
	if(isobserver(user))
		to_chat(user, "<span class='notice'>[special_desc]</span>")
		return
	else if(istype(user?.glasses, /obj/item/clothing/glasses/science))
		to_chat(user, "<span class='notice'>[special_desc]</span>")

/obj/item/xenoartifact/interact(mob/user)
	. = ..()
	if(process_type == LIT) //Snuff out candle
		to_chat(user, "<span class='notice'>You snuff out [name]</span>")
		process_type = null
		return
	if(user.a_intent == INTENT_GRAB)
		touch_desc?.on_touch(src, user)
		return
	SEND_SIGNAL(src, XENOA_INTERACT, null, user, user)

/obj/item/xenoartifact/afterattack(atom/target, mob/user, proximity)
	. = ..()
	SEND_SIGNAL(src, XENOA_ATTACK, src, user, target)

/obj/item/xenoartifact/attackby(obj/item/I, mob/living/user, params)
	for(var/datum/xenoartifact_trait/T in traits)
		T.on_item(src, user, I)
	if(!(manage_cooldown(TRUE))||user?.a_intent == INTENT_GRAB||istype(I, /obj/item/xenoartifact_label)||istype(I, /obj/item/xenoartifact_labeler))
		return
	SEND_SIGNAL(src, XENOA_ATTACKBY, I, user, user)
	..()

/obj/item/xenoartifact/throw_impact(atom/target, mob/user)
	. = ..()
	SEND_SIGNAL(src, XENOA_THROW_IMPACT, null, user, target)

/*
	check_charge() is essentially what runs all the minor, major, and malf trait activations. 
	This process also culls any irrelivent targets in reference to max_range and calculates the true charge.
	True charge is simply, almost, the average of the charge and charge_req. This allows for a unique varience of 
	output from artifacts, generally producing some funny results too.
	
*/
/obj/item/xenoartifact/proc/check_charge(mob/user, charge_mod)
	if(logging)
		log_game("[user] attempted to activate [src] at [world.time]. Located at [x] [y] [z].")
	if(prob(malfunction_chance)) //See if we pick up an malfunction
		var/datum/xenoartifact_trait/T = pick(subtypesof(/datum/xenoartifact_trait/malfunction))
		traits += new T
		malfunction_chance = malfunction_chance*0.2
	else    
		malfunction_chance += malfunction_mod

	for(var/atom/M in true_target) //Cull
		if(get_dist(get_turf(src), get_turf(M)) > max_range)   
			true_target -= M
	if(true_target.len < 1) //Don't bother if there aren't any targets
		return

	charge = charge + charge_mod
	if(manage_cooldown(TRUE))//Execution of traits here
		for(var/datum/xenoartifact_trait/minor/T in traits)//Minor traits aren't apart of the target loop
			T.activate(src, user, user)
		charge = (charge+charge_req)/1.9 //Not quite an average. Generally produces slightly higher results.     
		for(var/atom/M in true_target)
			create_beam(M)
			for(var/datum/xenoartifact_trait/malfunction/T in traits) //Malf
				T.activate(src, M, user)
			for(var/datum/xenoartifact_trait/major/T in traits) //Major
				if(logging)
					log_game("[src] activated trait [T]. Located at [x] [y] [z]")
				T.activate(src, M, user)
			if(!(get_trait(/datum/xenoartifact_trait/minor/aura))) //Quick fix for bug that selects multiple targets for noraisin
				break
		manage_cooldown()
	else
		playsound(get_turf(src), 'sound/machines/buzz-sigh.ogg', 10, TRUE)   
	charge = 0
	true_target = list()

/obj/item/xenoartifact/proc/manage_cooldown(checking = FALSE)
	if(!usedwhen)
		if(!(checking))
			usedwhen = world.time //Should I be using a different measure here?
		return TRUE
	else if(usedwhen + cooldown + cooldownmod < world.time)
		cooldownmod = 0
		usedwhen = null
		return TRUE
	else 
		return FALSE

/*
	generate_traits() is used to, as you'd guess, generate traits for the artifact. 
	The argument passed is a list of blacklisted traits you don't your artifact to have, allowing
	for a defenition of artifact types.
	The process also generates some partial hints, like a touch description and science-glasses description(special_desc)
	malf is an option to nab a malfunction trait on init. See URANIUM types.
*/
/obj/item/xenoartifact/proc/generate_traits(var/list/blacklist_traits, malf = FALSE)
	var/datum/xenoartifact_trait/new_trait
	
	var/list/activators
	for(var/T in list(subtypesof(/datum/xenoartifact_trait/activator))) //Activator
		activators += T
	activators -= blacklist_traits
	if(activators.len < 1)
		log_game("An almost impossible event has occured. [src] has failed to generate any traits!.")
		return
	new_trait = pick(activators)
	blacklist_traits += list(new_trait, initial(new_trait.blacklist_traits))
	traits += new new_trait
	special_desc = initial(new_trait.desc) ? "[special_desc] [initial(new_trait.desc)]" : special_desc

	var/minor_desc
	var/list/minors = list()
	for(var/X in 1 to 3) //Minors
		for(var/T in list(subtypesof(/datum/xenoartifact_trait/minor)))
			minors += T
		minors -= blacklist_traits
		if(minors.len < 1)
			log_game("An almost impossible event has occured. [src] has failed to generate any traits!.")
			return
		new_trait = pick(minors)
		blacklist_traits += list(new_trait, initial(new_trait.blacklist_traits))
		traits += new new_trait
		if(!minor_desc && initial(new_trait.desc))
			minor_desc = initial(new_trait.desc)
		if(!touch_desc)
			var/datum/xenoartifact_trait/D = new new_trait
			if(D.on_touch(src, src))
				touch_desc = new new_trait
			//qdel(D)

	special_desc = minor_desc ? "[special_desc] [minor_desc] material." : "[special_desc] material"

	var/list/majors
	for(var/T in list(subtypesof(/datum/xenoartifact_trait/major))) //Major
		majors += T
	majors -= blacklist_traits
	if(majors.len < 1)
		log_game("An almost impossible event has occured. [src] has failed to generate any traits!.")
		return
	new_trait = pick(majors)
	blacklist_traits += list(new_trait, initial(new_trait.blacklist_traits))
	traits += new new_trait
	special_desc = initial(new_trait.desc) ? "[special_desc] The shape is [initial(new_trait.desc)]." : special_desc

	charge_req = rand(1, 10) * 10

	if(!malf)
		return
	var/list/malfs
	for(var/T in list(subtypesof(/datum/xenoartifact_trait/malfunction))) //Major
		malfs += T
	malfs -= blacklist_traits
	if(malfs.len < 1)
		log_game("An almost impossible event has occured. [src] has failed to generate any traits!.")
		return
	new_trait = pick(malfs)
	blacklist_traits += list(new_trait, initial(new_trait.blacklist_traits))
	traits += new new_trait
	
/obj/item/xenoartifact/proc/get_proximity(range) //Gets a singular bam beano
	. = null
	for(var/mob/living/M in oview(range, get_turf(src)))
		. = process_target(M)
	if(isliving(loc))
		. = loc
	return

/obj/item/xenoartifact/proc/get_trait(typepath) //Returns the desired trait and it's values if it's in the artifact's
	for(var/datum/xenoartifact_trait/T in traits)
		if(istype(T, typepath)) //Using  == here breaks it
			return T
	return FALSE

/obj/item/xenoartifact/proc/generate_icon(var/icn, var/icnst = "", colour) //Add extra icon overlays
	icon_overlay = mutable_appearance(icn, icnst)
	icon_overlay.layer = FLOAT_LAYER //Not doing this fucks the object icons when you're holding it
	icon_overlay.appearance_flags = RESET_ALPHA// Not doing this fucks the alpha?
	icon_overlay.alpha = alpha//
	if(colour)
		icon_overlay.color = colour
	add_overlay(icon_overlay)

/obj/item/xenoartifact/proc/process_target(atom/target) //This is painful
	. = target
	var/mob/living/M
	if(isliving(target))
		M = target
		. = M
	else if(isliving(target?.loc))
		M = target.loc
		. = M
	if(M?.pulling)
		. = M.pulling
	RegisterSignal(., COMSIG_PARENT_QDELETING, .proc/on_target_del, .)
	return

/obj/item/xenoartifact/proc/on_target_del(atom/target)
	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	true_target -= target
	target = null

/obj/item/xenoartifact/proc/create_beam(atom/target) //Helps show how the artifact is working. Hint stuff.
	var/datum/beam/xenoa_beam/B = new(src.loc, get_turf(target), time=1.5 SECONDS, beam_icon='icons/obj/xenoarchaeology/xenoartifact.dmi', beam_icon_state="xenoa_beam", btype=/obj/effect/ebeam/xenoa_ebeam, col = material)
	INVOKE_ASYNC(B, /datum/beam/xenoa_beam.proc/Start)

/obj/item/xenoartifact/proc/default_activate(chr, mob/user, atom/target) //Default template used to interface with activator signals.
	if(!(manage_cooldown(TRUE)))
		return FALSE
	charge = chr
	true_target += process_target(target)
	check_charge(user)
	return TRUE

/obj/item/xenoartifact/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/xenoartifact/proc/send_signal(var/datum/signal/signal)
	if(!radio_connection||!signal)
		return
	radio_connection.post_signal(src, signal)

/obj/item/xenoartifact/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return
	SEND_SIGNAL(src, XENOA_SIGNAL, null, get_proximity(max_range), get_proximity(max_range))

/obj/item/xenoartifact/on_block(mob/living/carbon/human/owner, atom/movable/hitby)
	. = ..()
	if(!(manage_cooldown(TRUE)) || !get_trait(/datum/xenoartifact_trait/minor/blocking))
		return
	SEND_SIGNAL(src, COMSIG_PARENT_ATTACKBY, src, owner, hitby)

/obj/item/xenoartifact/process(delta_time)
	switch(process_type)
		if(LIT)
			true_target = list(get_proximity(min(max_range, 5)))
			if(get_proximity(min(max_range, 5)))
				visible_message("<span class='danger'>The [name] flicks out.</span>")
				default_activate(25, null, null)
				process_type = null
				return PROCESS_KILL
		if(TICK)
			visible_message("<span class='notice'>The [name] ticks.</span>")
			true_target = list(get_proximity(min(max_range, 5)))
			default_activate(25, null, null)
			if(prob(13))
				process_type = null
				return PROCESS_KILL
		else    
			return PROCESS_KILL

/obj/item/xenoartifact/Destroy()
	SSradio.remove_object(src, frequency)
	qdel(radio_connection)
	qdel(traits)
	qdel(touch_desc)
	for(var/atom/C in contents)
		if(ismovableatom(C))
			var/atom/movable/AM
			AM.forceMove(get_turf(loc))
		else
			qdel(C)
	//for(var/datum/xenoartifact_trait/T in traits)
		//T.on_del(src)
		//qdel(T)
	..()

/obj/item/xenoartifact/maint //Semi-toddler-safe version, for maint loot table.
	material = BLUESPACE

/obj/item/xenoartifact/maint/Initialize(mapload, difficulty)
	if(prob(0.1))
		material = pick(PLASMA, URANIUM, BANANIUM)
	difficulty = material
	..()

/datum/component/xenoartifact_pricing //Temporary pricing component for temporary shipping solution
	var/modifier = 0.70 //Buying and selling related
	var/price //default price gets generated if it isn't set by console. This only happens if the artifact spawns outside of that process

/obj/item/xenoartifact/objective
	//Exploration

/obj/item/xenoartifact/objective/Initialize(mapload, difficulty)
	. = ..()
	traits += new /datum/xenoartifact_trait/special/objective

/obj/item/xenoartifact/objective/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/gps, "[scramble_message_replace_chars("#########", 100)]", TRUE)

/obj/effect/ebeam/xenoa_ebeam
	name = "xenoartifact beam"

/obj/effect/ebeam/xenoa_ebeam/New(loc, ..., col)
	. = ..()
	color = col

/datum/beam/xenoa_beam
	var/color

/datum/beam/xenoa_beam/New(beam_origin,beam_target,beam_icon='icons/effects/beam.dmi',beam_icon_state="b_beam",time=50,maxdistance=10,btype = /obj/effect/ebeam,beam_sleep_time=3, col)
	color = col
	..()

/datum/beam/xenoa_beam/Draw()
	var/Angle = round(Get_Angle(origin,target))
	var/matrix/rot_matrix = matrix()
	rot_matrix.Turn(Angle)

	//Translation vector for origin and target
	var/DX = (32*target?.x+target.pixel_x)-(32*origin?.x+origin.pixel_x)
	var/DY = (32*target?.y+target.pixel_y)-(32*origin?.y+origin.pixel_y)
	var/N = 0
	var/length = round(sqrt((DX)**2+(DY)**2)) //hypotenuse of the triangle formed by target and origin's displacement

	for(N in 0 to length-1 step 32)//-1 as we want < not <=, but we want the speed of X in Y to Z and step X
		if(QDELETED(src) || finished)
			break
		var/obj/effect/ebeam/xenoa_ebeam/X = new(origin_oldloc, color)
		X.owner = src
		elements += X

		//Assign icon, for main segments it's base_icon, for the end, it's icon+icon_state
		//cropped by a transparent box of length-N pixel size
		if(N+32>length)
			var/icon/II = new(icon, icon_state)
			II.DrawBox(null,1,(length-N),32,32)
			X.icon = II
		else
			X.icon = base_icon
		X.transform = rot_matrix

		//Calculate pixel offsets (If necessary)
		var/Pixel_x
		var/Pixel_y
		if(DX == 0)
			Pixel_x = 0
		else
			Pixel_x = round(sin(Angle)+32*sin(Angle)*(N+16)/32)
		if(DY == 0)
			Pixel_y = 0
		else
			Pixel_y = round(cos(Angle)+32*cos(Angle)*(N+16)/32)

		//Position the effect so the beam is one continous line
		var/a
		if(abs(Pixel_x)>32)
			a = Pixel_x > 0 ? round(Pixel_x/32) : CEILING(Pixel_x/32, 1)
			X.x += a
			Pixel_x %= 32
		if(abs(Pixel_y)>32)
			a = Pixel_y > 0 ? round(Pixel_y/32) : CEILING(Pixel_y/32, 1)
			X.y += a
			Pixel_y %= 32

		X.pixel_x = Pixel_x
		X.pixel_y = Pixel_y
		CHECK_TICK
	afterDraw()
