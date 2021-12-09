//predominantly negative traits

/datum/quirk/badback
	name = "Bad Back"
	desc = "Thanks to your poor posture, backpacks and other bags never sit right on your back. More evently weighted objects are fine, though."
	value = -2
	mood_quirk = TRUE
	gain_text = "<span class='danger'>Your back REALLY hurts!</span>"
	lose_text = "<span class='notice'>Your back feels better.</span>"

/datum/quirk/badback/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.back && istype(H.back, /obj/item/storage/backpack))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "back_pain", /datum/mood_event/back_pain)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "back_pain")

/datum/quirk/blooddeficiency
	name = "Blood Deficiency"
	desc = "Your body can't produce enough blood to sustain itself."
	value = -2
	gain_text = "<span class='danger'>You feel your vigor slowly fading away.</span>"
	lose_text = "<span class='notice'>You feel vigorous again.</span>"
	medical_record_text = "Patient requires regular treatment for blood loss due to low production of blood."

/datum/quirk/blooddeficiency/on_process(delta_time)
	var/mob/living/carbon/human/H = quirk_holder
	if(NOBLOOD in H.dna.species.species_traits) //can't lose blood if your species doesn't have any
		return
	else
		if (H.blood_volume > (BLOOD_VOLUME_SAFE - 25)) // just barely survivable without treatment
			H.blood_volume -= 0.275 * delta_time

/datum/quirk/blindness
	name = "Blind"
	desc = "You are completely blind, nothing can counteract this."
	value = -4
	gain_text = "<span class='danger'>You can't see anything.</span>"
	lose_text = "<span class='notice'>You miraculously gain back your vision.</span>"
	medical_record_text = "Subject has permanent blindness."

/datum/quirk/blindness/add()
	quirk_holder.become_blind(ROUNDSTART_TRAIT)

/datum/quirk/blindness/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/blindfold/white/B = new(get_turf(H))
	if(!H.equip_to_slot_if_possible(B, ITEM_SLOT_EYES, bypass_equip_delay_self = TRUE)) //if you can't put it on the user's eyes, put it in their hands, otherwise put it on their eyes
		H.put_in_hands(B)
	H.regenerate_icons()

/datum/quirk/brainproblems
	name = "Brain Tumor"
	desc = "You have a little friend in your brain that is slowly destroying it. Thankfully, you start with a bottle of mannitol pills."
	value = -3
	gain_text = "<span class='danger'>You feel smooth.</span>"
	lose_text = "<span class='notice'>You feel wrinkled again.</span>"
	medical_record_text = "Patient has a tumor in their brain that is slowly driving them to brain death."
	var/where = "at your feet"

/datum/quirk/brainproblems/on_process()
	quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2)

/datum/quirk/brainproblems/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/storage/pill_bottle/mannitol/braintumor/P = new(get_turf(H))

	var/slot = H.equip_in_one_of_slots(P, list(ITEM_SLOT_LPOCKET, ITEM_SLOT_RPOCKET, ITEM_SLOT_BACKPACK), FALSE)
	if(slot)
		var/list/slots = list(
		ITEM_SLOT_LPOCKET = "in your left pocket",
		ITEM_SLOT_RPOCKET = "in your right pocket",
		ITEM_SLOT_BACKPACK = "in your backpack"
		)
		where = slots[slot]

/datum/quirk/brainproblems/post_add()
	to_chat(quirk_holder, "<span class='boldnotice'>There is a bottle of mannitol [where]. You're going to need it.</span>")

/datum/quirk/deafness
	name = "Deaf"
	desc = "You are incurably deaf."
	value = -2
	mob_trait = TRAIT_DEAF
	gain_text = "<span class='danger'>You can't hear anything.</span>"
	lose_text = "<span class='notice'>You're able to hear again!</span>"
	medical_record_text = "Subject's cochlear nerve is incurably damaged."

/datum/quirk/depression
	name = "Depression"
	desc = "You sometimes just hate life."
	mob_trait = TRAIT_DEPRESSION
	value = -1
	gain_text = "<span class='danger'>You start feeling depressed.</span>"
	lose_text = "<span class='notice'>You no longer feel depressed.</span>" //if only it were that easy!
	medical_record_text = "Patient has a severe mood disorder causing them to experience sudden moments of sadness."
	mood_quirk = TRUE

/datum/quirk/depression/on_process(delta_time)
	if(DT_PROB(0.05, delta_time))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "depression", /datum/mood_event/depression)


/datum/quirk/family_heirloom
	name = "Family Heirloom"
	desc = "You are the current owner of an heirloom, passed down for generations. You have to keep it safe!"
	value = -1
	mood_quirk = TRUE
	var/obj/item/heirloom
	var/where
	var/static/list/random_figures = subtypesof(/obj/item/toy/prize)
	var/static/list/random_trashes = subtypesof(/obj/item/trash)

/datum/quirk/family_heirloom/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/heirloom_type
	var/list/heirloom_table = list()

	heirloom_table += itemlist_species(quirk_holder) // 1. Species specific table
	heirloom_table += itemlist_jobs()				 // 2. Job & department specific table
	heirloom_table += itemlist_general()			 // 3. for everyone
	heirloom_type = pick(heirloom_table)			 // 4. pick one from the grand total table

	if(!heirloom_type)
		heirloom_type = pick(
		/obj/item/toy/cards/deck,
		/obj/item/lighter,
		/obj/item/dice/d20)
	heirloom = new heirloom_type(get_turf(quirk_holder))
	var/list/slots = list(
		"in your left pocket" = ITEM_SLOT_LPOCKET,
		"in your right pocket" = ITEM_SLOT_RPOCKET,
		"in your backpack" = ITEM_SLOT_BACKPACK
	)
	where = H.equip_in_one_of_slots(heirloom, slots, FALSE) || "at your feet"

/datum/quirk/family_heirloom/post_add()
	if(where == "in your backpack")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, "<span class='boldnotice'>There is a precious family [heirloom.name] [where], passed down from generation to generation. Keep it safe!</span>")

	var/list/names = splittext(quirk_holder.real_name, " ")
	var/family_name = names[names.len]

	heirloom.AddComponent(/datum/component/heirloom, quirk_holder.mind, family_name)

/datum/quirk/family_heirloom/on_process()
	if(heirloom in quirk_holder.GetAllContents())
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom_missing")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom", /datum/mood_event/family_heirloom)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom_missing", /datum/mood_event/family_heirloom_missing)

/datum/quirk/family_heirloom/clone_data()
	return heirloom

/datum/quirk/family_heirloom/on_clone(data)
	heirloom = data

/datum/quirk/family_heirloom/proc/itemlist_species(var/mob/living/carbon/human/H)
	var/list/heirloom_addition = list()

	switch(H.dna.species.id)
		if(SPECIES_HUMAN)
			heirloom_addition += /obj/item/clothing/head/kitty //you had terrible parents.
		if(SPECIES_FELINID)
			heirloom_addition += /obj/item/clothing/head/kitty
		if(SPECIES_LIZARD)
			heirloom_addition += /obj/item/toy/plush/lizardplushie
		if(SPECIES_OOZELING)
			heirloom_addition += /obj/item/toy/plush/slimeplushie
		if(SPECIES_MOTH)
			heirloom_addition += /obj/item/flashlight/lantern/heirloom_moth
			heirloom_addition += /obj/item/toy/plush/moth
		if(SPECIES_APID)
			heirloom_addition += /obj/item/toy/plush/beeplushie
		if(SPECIES_PLASMAMAN)
			heirloom_addition += /obj/item/coin/plasma
		if(SPECIES_ETHEREAL)
			heirloom_addition += /obj/item/coin/plasma //I am not sure what to give them
		if(SPECIES_IPC)
			heirloom_addition += /obj/item/disk/data
		//retired beecode speices, but let's give them some love
		if(SPECIES_FLY)
			heirloom_addition += /obj/item/reagent_containers/food/drinks/bottle/virusfood
		else
			heirloom_addition += /obj/item/toy/eldrich_book //spooky, eldritch

	// You get everything for 1% chance.
	if(prob(1))
		heirloom_addition += /obj/item/clothing/head/kitty
		heirloom_addition += /obj/item/toy/plush/lizardplushie
		heirloom_addition += /obj/item/toy/plush/slimeplushie
		heirloom_addition += /obj/item/flashlight/lantern/heirloom_moth
		heirloom_addition += /obj/item/toy/plush/moth
		heirloom_addition += /obj/item/toy/plush/beeplushie
		heirloom_addition += /obj/item/coin/plasma
		heirloom_addition += /obj/item/disk/data
		heirloom_addition += /obj/item/reagent_containers/food/drinks/bottle/virusfood
		heirloom_addition += /obj/item/toy/eldrich_book

	return heirloom_addition


/datum/quirk/family_heirloom/proc/itemlist_jobs()
	var/list/heirloom_addition = list()
	var/DEPARTMENT_FLAG = 0

	// Job specific table
	switch(quirk_holder.mind.assigned_role)
		//Service jobs
		if(JOB_STRING_ASSISTANT)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/storage/toolbox/mechanical/old/heirloom
			heirloom_addition += /obj/item/clothing/gloves/cut/heirloom
			heirloom_addition += /obj/item/multitool
			if(prob(0.5))
				heirloom_addition += /obj/item/clothing/under/color/grey/glorf //very rare chance for ancient jumpsuit
				//the actual chance is likely 0.083% or less.
		if(JOB_STRING_JANITOR)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/mop
			heirloom_addition += /obj/item/clothing/suit/caution
			heirloom_addition += /obj/item/reagent_containers/glass/bucket
		if(JOB_STRING_BARTENDER)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/reagent_containers/glass/rag
			heirloom_addition += /obj/item/clothing/head/that
			heirloom_addition += /obj/item/reagent_containers/food/drinks/shaker
		if(JOB_STRING_COOK)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/reagent_containers/food/condiment/saltshaker
			heirloom_addition += /obj/item/kitchen/rollingpin
			heirloom_addition += /obj/item/clothing/head/chefhat
		if(JOB_STRING_BOTANIST)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/cultivator
			heirloom_addition += /obj/item/reagent_containers/glass/bucket
			heirloom_addition += /obj/item/storage/bag/plants
			heirloom_addition += /obj/item/toy/plush/beeplushie
			heirloom_addition += /obj/item/seeds/random //Would you dare to plant your heirloom?
		if(JOB_STRING_CURATOR)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/pen/fountain
			heirloom_addition += /obj/item/storage/pill_bottle/dice
		if(JOB_STRING_CHAPLAIN)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/toy/windupToolbox
			heirloom_addition += /obj/item/reagent_containers/food/drinks/bottle/holywater
		if(JOB_STRING_BARBER)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/handmirror
		if(JOB_STRING_VIP)
			DEPARTMENT_FLAG |= DEPARTMENT_COMMAND //They'll just get more annoying items
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/handmirror //so narcissistic
			heirloom_addition += /obj/item/modular_computer/laptop/preset/civillian //for business.
		if(JOB_STRING_DEBTOR)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += pick(random_trashes) //even such thing is precious to hobo. poor.
			heirloom_addition += pick(random_trashes)
			heirloom_addition += pick(random_trashes)
		if(JOB_STRING_LAWYER)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			//DEPARTMENT_FLAG |= DEPARTMENT_SECURITY //maybe not...
			heirloom_addition += /obj/item/gavelhammer
			heirloom_addition += /obj/item/book/manual/wiki/security_space_law
		//Entertainers
		if(JOB_STRING_CLOWN)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/bikehorn/golden
			heirloom_addition += /obj/item/bikehorn/golden
			heirloom_addition += /obj/item/bikehorn/golden	//high chance of spawning them
		if(JOB_STRING_MIME)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/reagent_containers/food/snacks/baguette/mime
			heirloom_addition += /obj/item/reagent_containers/food/snacks/baguette/mime
			heirloom_addition += /obj/item/reagent_containers/food/snacks/baguette/mime	//high chance of spawning them
		if(JOB_STRING_STAGE_MAGICIAN)
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/gun/magic/wand
			heirloom_addition += /obj/item/gun/magic/wand
			heirloom_addition += /obj/item/gun/magic/wand	//high chance of spawning them
		//Security
		if(JOB_STRING_HOS)
			DEPARTMENT_FLAG |= DEPARTMENT_COMMAND
			DEPARTMENT_FLAG |= DEPARTMENT_SECURITY
		if(JOB_STRING_WARDEN)
			DEPARTMENT_FLAG |= DEPARTMENT_SECURITY
			heirloom_addition += /obj/item/restraints/handcuffs
		if(JOB_STRING_SECURITY_OFFICER)
			DEPARTMENT_FLAG |= DEPARTMENT_SECURITY
			heirloom_addition += /obj/item/clothing/head/beret/sec
		if(JOB_STRING_DETECTIVE)
			DEPARTMENT_FLAG |= DEPARTMENT_SECURITY
			heirloom_addition += /obj/item/reagent_containers/food/drinks/bottle/whiskey
		if(JOB_STRING_DEPUTY) //It won't happen, but just in case.
			DEPARTMENT_FLAG |= DEPARTMENT_SECURITY
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
		//Science
		if(JOB_STRING_RD)
			DEPARTMENT_FLAG |= DEPARTMENT_COMMAND
			DEPARTMENT_FLAG |= DEPARTMENT_SCIENCE
			heirloom_addition += /obj/item/nanite_remote
		if(JOB_STRING_SCIENTIST)
			DEPARTMENT_FLAG |= DEPARTMENT_SCIENCE
			heirloom_addition += /obj/item/nanite_remote
		if(JOB_STRING_EXPLORATION_CREW)
			DEPARTMENT_FLAG |= DEPARTMENT_SCIENCE
			heirloom_addition += /obj/item/throwing_star/toy
		if(JOB_STRING_ROBOTICIST)
			DEPARTMENT_FLAG |= DEPARTMENT_SCIENCE
			heirloom_addition += pick(random_figures) //look at this nerd
			heirloom_addition += /obj/item/book/manual/wiki/medicine
		//Medical
		if(JOB_STRING_CMO)
			DEPARTMENT_FLAG |= DEPARTMENT_COMMAND
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			heirloom_addition += /obj/item/book/manual/wiki/chemistry
			heirloom_addition += /obj/item/book/manual/wiki/infections
			heirloom_addition += /obj/item/reagent_containers/dropper
			heirloom_addition += /obj/item/healthanalyzer
		if(JOB_STRING_BRIG_PHYSICIAN)
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			DEPARTMENT_FLAG |= DEPARTMENT_SECURITY
			heirloom_addition += /obj/item/healthanalyzer
		if(JOB_STRING_MEDICAL_DOCTOR)
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			heirloom_addition += /obj/item/healthanalyzer
		if(JOB_STRING_PARAMEDIC)
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			heirloom_addition += /obj/item/healthanalyzer
		if(JOB_STRING_PSYCHIATRIST)
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE //this is the true nature of your job.
			heirloom_addition += /obj/item/healthanalyzer
		if(JOB_STRING_CHEMIST)
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			heirloom_addition += /obj/item/book/manual/wiki/chemistry
			heirloom_addition += /obj/item/storage/bag/chemistry
			heirloom_addition += /obj/item/reagent_containers/dropper
		if(JOB_STRING_VIROLOGIST)
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			heirloom_addition += /obj/item/book/manual/wiki/infections
			heirloom_addition += /obj/item/book/manual/wiki/chemistry
			heirloom_addition += /obj/item/storage/bag/bio
			heirloom_addition += /obj/item/reagent_containers/food/drinks/bottle/virusfood
			heirloom_addition += /obj/item/reagent_containers/dropper
		if(JOB_STRING_GENETICIST)
			DEPARTMENT_FLAG |= DEPARTMENT_SCIENCE
			DEPARTMENT_FLAG |= DEPARTMENT_MEDICAL
			heirloom_addition += /obj/item/nanite_remote
		//Engineering
		if(JOB_STRING_CE)
			DEPARTMENT_FLAG |= DEPARTMENT_COMMAND
			DEPARTMENT_FLAG |= DEPARTMENT_ENGINEERING
			heirloom_addition += /obj/item/clothing/head/hardhat/white
		if(JOB_STRING_STATION_ENGINEER)
			DEPARTMENT_FLAG |= DEPARTMENT_ENGINEERING
			heirloom_addition += /obj/item/clothing/head/hardhat
		if(JOB_STRING_ATMOSPHERIC_TECHNICIAN)
			DEPARTMENT_FLAG |= DEPARTMENT_ENGINEERING
			heirloom_addition += /obj/item/lighter
			heirloom_addition += /obj/item/lighter/greyscale
			heirloom_addition += /obj/item/storage/box/matches
			heirloom_addition += /obj/item/tank/internals/emergency_oxygen/empty
		//Supply
		if(JOB_STRING_QM)
			DEPARTMENT_FLAG |= DEPARTMENT_CARGO
			heirloom_addition += /obj/item/stamp
			heirloom_addition += /obj/item/stamp/denied
		if(JOB_STRING_CARGO_TECHNICIAN)
			DEPARTMENT_FLAG |= DEPARTMENT_CARGO
			heirloom_addition += /obj/item/clipboard
		if(JOB_STRING_SHAFT_MINER)
			DEPARTMENT_FLAG |= DEPARTMENT_CARGO
			heirloom_addition += /obj/item/pickaxe/mini
			heirloom_addition += /obj/item/shovel
		//Other
		if(JOB_STRING_CAPTAIN)
			DEPARTMENT_FLAG |= DEPARTMENT_COMMAND
			heirloom_addition += /obj/item/reagent_containers/food/drinks/flask/gold
			heirloom_addition += /obj/item/reagent_containers/food/drinks/flask/gold
			heirloom_addition += /obj/item/reagent_containers/food/drinks/flask/gold
			//hich chance of spawning captain's flask
		if(JOB_STRING_HOP)
			DEPARTMENT_FLAG |= DEPARTMENT_COMMAND
			DEPARTMENT_FLAG |= DEPARTMENT_SERVICE
			heirloom_addition += /obj/item/toy/plush/ian
		//---End of Switch If lines---

	// Department specific table
	// Do NOT use 'else if' here because certain jobs are in multiple departments.
	// prob(1) means you can get an item assgiend to another department at a low chance.
	if(DEPARTMENT_FLAG & DEPARTMENT_SERVICE || prob(1))
		heirloom_addition += /obj/item/reagent_containers/glass/bucket
		heirloom_addition += /obj/item/storage/toolbox/mechanical/old/heirloom
		heirloom_addition += /obj/item/storage/box/matches
	if(DEPARTMENT_FLAG & DEPARTMENT_SECURITY || prob(1))
		heirloom_addition += /obj/item/book/manual/wiki/security_space_law
		heirloom_addition += /obj/item/radio/off
	if(DEPARTMENT_FLAG & DEPARTMENT_SCIENCE || prob(1))
		heirloom_addition += /obj/item/toy/plush/slimeplushie
		heirloom_addition += /obj/item/reagent_containers/food/snacks/monkeycube
		heirloom_addition += /obj/item/screwdriver
		heirloom_addition += /obj/item/wrench
		heirloom_addition += /obj/item/multitool
	if(DEPARTMENT_FLAG & DEPARTMENT_MEDICAL || prob(1))
		heirloom_addition += /obj/item/clothing/neck/stethoscope
		heirloom_addition += /obj/item/book/manual/wiki/medicine
		heirloom_addition += /obj/item/bodybag
		heirloom_addition += /obj/item/surgical_drapes
		heirloom_addition += /obj/item/scalpel
		heirloom_addition += /obj/item/hemostat
		heirloom_addition += /obj/item/retractor
		heirloom_addition += /obj/item/cautery
		heirloom_addition += /obj/item/bedsheet/medical
	if(DEPARTMENT_FLAG & DEPARTMENT_ENGINEERING || prob(1))
		heirloom_addition += /obj/item/screwdriver
		heirloom_addition += /obj/item/wrench
		heirloom_addition += /obj/item/weldingtool
		heirloom_addition += /obj/item/crowbar
		heirloom_addition += /obj/item/wirecutters
	if(DEPARTMENT_FLAG & DEPARTMENT_CARGO || prob(1))
		heirloom_addition += /obj/item/hand_labeler
		heirloom_addition += /obj/item/shovel
	if(DEPARTMENT_FLAG & DEPARTMENT_COMMAND || prob(1))
		heirloom_addition += /obj/item/reagent_containers/food/drinks/flask/gold
		heirloom_addition += /obj/item/book/manual/wiki/security_space_law
		heirloom_addition += /obj/item/clothing/glasses/sunglasses/advanced/gar/supergar
		heirloom_addition += /obj/item/stamp
		heirloom_addition += /obj/item/stamp/denied

	return heirloom_addition


/datum/quirk/family_heirloom/proc/itemlist_general()
	var/list/heirloom_addition = list()
	heirloom_addition += /obj/item/bedsheet/random //random bedsheet. you can get a fancy one if you're lucky.
	heirloom_addition += /obj/item/toy/cards/deck
	heirloom_addition += /obj/item/lighter
	heirloom_addition += /obj/item/dice/d20
	heirloom_addition += /obj/item/book/manual/wiki/security_space_law //1984. all crews are encourage to hold this book all times. giving higher chance for sec.

	// Rare chance to add some suspicious looking items
	if(prob(5)) //with 5% chance, these items are added to your table - which means you still have a chance to avoid them.
		//They are just looking suspicious, but don't really do a thing. For syndi card, it deals 1 throw damage.
		heirloom_addition += /obj/item/storage/toolbox/mechanical/old/heirloom/syndicate
		heirloom_addition += /obj/item/toy/cards/deck/heirloom
		heirloom_addition += /obj/item/soap/syndie
		heirloom_addition += /obj/item/reagent_containers/food/drinks/syndicatebeer/heirloom

	return heirloom_addition

/datum/quirk/frail
	name = "Frail"
	desc = "Your bones might as well be made of glass! Your limbs can take less damage before they become disabled."
	value = -2
	mob_trait = TRAIT_EASYLIMBDISABLE
	gain_text = "<span class='danger'>You feel frail.</span>"
	lose_text = "<span class='notice'>You feel sturdy again.</span>"
	medical_record_text = "Patient has unusually frail bones, recommend calcium-rich diet."

/datum/quirk/foreigner
	name = "Foreigner"
	desc = "You're not from around here. You don't know Galactic Common!"
	value = -1
	gain_text = "<span class='notice'>The words being spoken around you don't make any sense."
	lose_text = "<span class='notice'>You've developed fluency in Galactic Common."
	medical_record_text = "Patient does not speak Galactic Common and may require an interpreter."

/datum/quirk/foreigner/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(ishuman(H) && H.job != "Curator")
		H.add_blocked_language(/datum/language/common)
		H.grant_language(/datum/language/uncommon)

/datum/quirk/foreigner/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(ishuman(H) && H.job != "Curator")
		H.remove_blocked_language(/datum/language/common)
		H.remove_language(/datum/language/uncommon)

/datum/quirk/heavy_sleeper
	name = "Heavy Sleeper"
	desc = "You sleep like a rock! Whenever you're put to sleep or knocked unconscious, you take a little bit longer to wake up."
	value = -1
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = "<span class='danger'>You feel sleepy.</span>"
	lose_text = "<span class='notice'>You feel awake again.</span>"
	medical_record_text = "Patient has abnormal sleep study results and is difficult to wake up."

/datum/quirk/hypersensitive
	name = "Hypersensitive"
	desc = "For better or worse, everything seems to affect your mood more than it should."
	value = -1
	gain_text = "<span class='danger'>You seem to make a big deal out of everything.</span>"
	lose_text = "<span class='notice'>You don't seem to make a big deal out of everything anymore.</span>"

/datum/quirk/hypersensitive/add()
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier += 0.5

/datum/quirk/hypersensitive/remove()
	if(quirk_holder)
		var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
		if(mood)
			mood.mood_modifier -= 0.5

/datum/quirk/light_drinker
	name = "Light Drinker"
	desc = "You just can't handle your drinks and get drunk very quickly."
	value = -1
	mob_trait = TRAIT_LIGHT_DRINKER
	gain_text = "<span class='notice'>Just the thought of drinking alcohol makes your head spin.</span>"
	lose_text = "<span class='danger'>You're no longer severely affected by alcohol.</span>"

/datum/quirk/nearsighted //t. errorage
	name = "Nearsighted"
	desc = "You are nearsighted without prescription glasses, but spawn with a pair."
	value = -1
	gain_text = "<span class='danger'>Things far away from you start looking blurry.</span>"
	lose_text = "<span class='notice'>You start seeing faraway things normally again.</span>"
	medical_record_text = "Patient requires prescription glasses in order to counteract nearsightedness."

/datum/quirk/nearsighted/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nearsighted/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/regular/glasses = new(get_turf(H))
	H.put_in_hands(glasses)
	H.equip_to_slot(glasses, ITEM_SLOT_EYES)
	H.regenerate_icons() //this is to remove the inhand icon, which persists even if it's not in their hands

/datum/quirk/nyctophobia
	name = "Nyctophobia"
	desc = "As far as you can remember, you've always been afraid of the dark. While in the dark without a light source, you instinctually act careful, and constantly feel a sense of dread."
	value = -1

/datum/quirk/nyctophobia/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.dna.species.id in list("shadow", "nightmare"))
		return //we're tied with the dark, so we don't get scared of it; don't cleanse outright to avoid cheese
	var/turf/T = get_turf(quirk_holder)
	if(T.get_lumcount() <= 0.2)
		if(quirk_holder.m_intent == MOVE_INTENT_RUN)
			to_chat(quirk_holder, "<span class='warning'>Easy, easy, take it slow... you're in the dark...</span>")
			quirk_holder.toggle_move_intent()
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "nyctophobia", /datum/mood_event/nyctophobia)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "nyctophobia")

/datum/quirk/nonviolent
	name = "Pacifist"
	desc = "The thought of violence makes you sick. So much so, in fact, that you can't hurt anyone."
	value = -2
	mob_trait = TRAIT_PACIFISM
	gain_text = "<span class='danger'>You feel repulsed by the thought of violence!</span>"
	lose_text = "<span class='notice'>You think you can defend yourself again.</span>"
	medical_record_text = "Patient is unusually pacifistic and cannot bring themselves to cause physical harm."

/datum/quirk/paraplegic
	name = "Paraplegic"
	desc = "Your legs do not function. Nothing will ever fix this. But hey, free wheelchair!"
	value = -3
	human_only = TRUE
	gain_text = null // Handled by trauma.
	lose_text = null
	medical_record_text = "Patient has an untreatable impairment in motor function in the lower extremities."

/datum/quirk/paraplegic/add()
	var/datum/brain_trauma/severe/paralysis/paraplegic/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/paraplegic/on_spawn()
	if(quirk_holder.buckled) // Handle late joins being buckled to arrival shuttle chairs.
		quirk_holder.buckled.unbuckle_mob(quirk_holder)

	var/turf/T = get_turf(quirk_holder)
	var/obj/structure/chair/spawn_chair = locate() in T

	var/obj/vehicle/ridden/wheelchair/wheels = new(T)
	if(spawn_chair) // Makes spawning on the arrivals shuttle more consistent looking
		wheels.setDir(spawn_chair.dir)

	wheels.buckle_mob(quirk_holder)

	// During the spawning process, they may have dropped what they were holding, due to the paralysis
	// So put the things back in their hands.

	for(var/obj/item/I in T)
		if(I.fingerprintslast == quirk_holder.ckey)
			quirk_holder.put_in_hands(I)

/datum/quirk/poor_aim
	name = "Poor Aim"
	desc = "You're terrible with guns and can't line up a straight shot to save your life. Dual-wielding is right out."
	value = -1
	mob_trait = TRAIT_POOR_AIM
	medical_record_text = "Patient possesses a strong tremor in both hands."

/datum/quirk/prosopagnosia
	name = "Prosopagnosia"
	desc = "You have a mental disorder that prevents you from being able to recognize faces at all."
	value = -1
	mob_trait = TRAIT_PROSOPAGNOSIA
	medical_record_text = "Patient suffers from prosopagnosia and cannot recognize faces."

/datum/quirk/prosthetic_limb
	name = "Prosthetic Limb"
	desc = "An accident caused you to lose one of your limbs. Because of this, you now have a random prosthetic!"
	value = -1
	var/slot_string = "limb"

/datum/quirk/prosthetic_limb/on_spawn()
	var/limb_slot = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/bodypart/old_part = H.get_bodypart(limb_slot)
	var/obj/item/bodypart/prosthetic
	switch(limb_slot)
		if(BODY_ZONE_L_ARM)
			prosthetic = new/obj/item/bodypart/l_arm/robot/surplus(quirk_holder)
			slot_string = "left arm"
		if(BODY_ZONE_R_ARM)
			prosthetic = new/obj/item/bodypart/r_arm/robot/surplus(quirk_holder)
			slot_string = "right arm"
		if(BODY_ZONE_L_LEG)
			prosthetic = new/obj/item/bodypart/l_leg/robot/surplus(quirk_holder)
			slot_string = "left leg"
		if(BODY_ZONE_R_LEG)
			prosthetic = new/obj/item/bodypart/r_leg/robot/surplus(quirk_holder)
			slot_string = "right leg"
	prosthetic.replace_limb(H)
	qdel(old_part)
	H.regenerate_icons()

/datum/quirk/prosthetic_limb/post_add()
	to_chat(quirk_holder, "<span class='boldannounce'>Your [slot_string] has been replaced with a surplus prosthetic. It is fragile and will easily come apart under duress. Additionally, \
	you need to use a welding tool and cables to repair it, instead of bruise packs and ointment.</span>")

/datum/quirk/pushover
	name = "Pushover"
	desc = "Your first instinct is always to let people push you around. Resisting out of grabs will take conscious effort."
	value = -2
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = "<span class='danger'>You feel like a pushover.</span>"
	lose_text = "<span class='notice'>You feel like standing up for yourself.</span>"
	medical_record_text = "Patient presents a notably unassertive personality and is easy to manipulate."

/datum/quirk/insanity
	name = "Reality Dissociation Syndrome"
	desc = "You suffer from a severe disorder that causes very vivid hallucinations. Mindbreaker toxin can suppress its effects, and you are immune to mindbreaker's hallucinogenic properties. <b>This is not a license to grief.</b>"
	value = -2
	//no mob trait because it's handled uniquely
	gain_text = "<span class='userdanger'>...</span>"
	lose_text = "<span class='notice'>You feel in tune with the world again.</span>"
	medical_record_text = "Patient suffers from acute Reality Dissociation Syndrome and experiences vivid hallucinations."

/datum/quirk/insanity/on_process(delta_time)
	if(quirk_holder.reagents.has_reagent(/datum/reagent/toxin/mindbreaker, needs_metabolizing = TRUE))
		quirk_holder.hallucination = 0
		return
	if(DT_PROB(2, delta_time)) //we'll all be mad soon enough
		madness()

/datum/quirk/insanity/proc/madness()
	quirk_holder.hallucination += rand(10, 25)

/datum/quirk/insanity/post_add() //I don't /think/ we'll need this but for newbies who think "roleplay as insane" = "license to kill" it's probably a good thing to have
	if(!quirk_holder.mind || quirk_holder.mind.special_role)
		return
	to_chat(quirk_holder, "<span class='big bold info'>Please note that your dissociation syndrome does NOT give you the right to attack people or otherwise cause any interference to \
	the round. You are not an antagonist, and the rules will treat you the same as other crewmembers.</span>")

/datum/quirk/social_anxiety
	name = "Social Anxiety"
	desc = "Talking to people is very difficult for you, and you often stutter or even lock up."
	value = -1
	gain_text = "<span class='danger'>You start worrying about what you're saying.</span>"
	lose_text = "<span class='notice'>You feel easier about talking again.</span>" //if only it were that easy!
	medical_record_text = "Patient is usually anxious in social encounters and prefers to avoid them."
	var/dumb_thing = TRUE

/datum/quirk/social_anxiety/on_process(delta_time)
	var/nearby_people = 0
	for(var/mob/living/carbon/human/H in oview(3, quirk_holder))
		if(H.client)
			nearby_people++
	var/mob/living/carbon/human/H = quirk_holder
	if(DT_PROB(2 + nearby_people, delta_time))
		H.stuttering = max(3, H.stuttering)
	else if(DT_PROB(min(3, nearby_people), delta_time) && !H.silent)
		to_chat(H, "<span class='danger'>You retreat into yourself. You <i>really</i> don't feel up to talking.</span>")
		H.silent = max(10, H.silent)
	else if(DT_PROB(0.5, delta_time) && dumb_thing)
		to_chat(H, "<span class='userdanger'>You think of a dumb thing you said a long time ago and scream internally.</span>")
		dumb_thing = FALSE //only once per life
		if(prob(1))
			new/obj/item/reagent_containers/food/snacks/spaghetti/pastatomato(get_turf(H)) //now that's what I call spaghetti code

//If you want to make some kind of junkie variant, just extend this quirk.
/datum/quirk/junkie
	name = "Junkie"
	desc = "You can't get enough of hard drugs."
	value = -2
	gain_text = "<span class='danger'>You suddenly feel the craving for drugs.</span>"
	lose_text = "<span class='notice'>You feel like you should kick your drug habit.</span>"
	medical_record_text = "Patient has a history of hard drugs."
	var/drug_list = list(/datum/reagent/drug/crank, /datum/reagent/drug/krokodil, /datum/reagent/medicine/morphine, /datum/reagent/drug/happiness, /datum/reagent/drug/methamphetamine, /datum/reagent/drug/ketamine) //List of possible IDs
	var/datum/reagent/reagent_type //!If this is defined, reagent_id will be unused and the defined reagent type will be instead.
	var/datum/reagent/reagent_instance //! actual instanced version of the reagent
	var/where_drug //! Where the drug spawned
	var/obj/item/drug_container_type //! If this is defined before pill generation, pill generation will be skipped. This is the type of the pill bottle.
	var/where_accessory //! where the accessory spawned
	var/obj/item/accessory_type //! If this is null, an accessory won't be spawned.
	var/process_interval = 30 SECONDS //! how frequently the quirk processes
	var/next_process = 0 //! ticker for processing

/datum/quirk/junkie/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	if (!reagent_type)
		reagent_type = pick(drug_list)
	reagent_instance = new reagent_type()
	H.reagents.addiction_list.Add(reagent_instance)
	var/current_turf = get_turf(quirk_holder)
	if (!drug_container_type)
		drug_container_type = /obj/item/storage/pill_bottle
	var/obj/item/drug_instance = new drug_container_type(current_turf)
	if (istype(drug_instance, /obj/item/storage/pill_bottle))
		var/pill_state = "pill[rand(1,20)]"
		for(var/i in 1 to 7)
			var/obj/item/reagent_containers/pill/P = new(drug_instance)
			P.icon_state = pill_state
			P.reagents.add_reagent(reagent_type, 1)

	var/obj/item/accessory_instance
	if (accessory_type)
		accessory_instance = new accessory_type(current_turf)
	var/list/slots = list(
		"in your left pocket" = ITEM_SLOT_LPOCKET,
		"in your right pocket" = ITEM_SLOT_RPOCKET,
		"in your backpack" = ITEM_SLOT_BACKPACK
	)
	where_drug = H.equip_in_one_of_slots(drug_instance, slots, FALSE) || "at your feet"
	if (accessory_instance)
		where_accessory = H.equip_in_one_of_slots(accessory_instance, slots, FALSE) || "at your feet"
	announce_drugs()

/datum/quirk/junkie/post_add()
	if(where_drug == "in your backpack" || where_accessory == "in your backpack")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

/datum/quirk/junkie/proc/announce_drugs()
	to_chat(quirk_holder, "<span class='boldnotice'>There is a [initial(drug_container_type.name)] of [initial(reagent_type.name)] [where_drug]. Better hope you don't run out...</span>")

/datum/quirk/junkie/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(world.time > next_process)
		next_process = world.time + process_interval
		if(!H.reagents.addiction_list.Find(reagent_instance))
			if(QDELETED(reagent_instance))
				reagent_instance = new reagent_type()
			else
				reagent_instance.addiction_stage = 0
			H.reagents.addiction_list += reagent_instance
			to_chat(quirk_holder, "<span class='danger'>You thought you kicked it, but you suddenly feel like you need [reagent_instance.name] again...</span>")

/datum/quirk/junkie/smoker
	name = "Smoker"
	desc = "Sometimes you just really want a smoke. Probably not great for your lungs."
	value = -1
	gain_text = "<span class='danger'>You could really go for a smoke right about now.</span>"
	lose_text = "<span class='notice'>You feel like you should quit smoking.</span>"
	medical_record_text = "Patient is a current smoker."
	reagent_type = /datum/reagent/drug/nicotine
	accessory_type = /obj/item/lighter/greyscale

/datum/quirk/junkie/smoker/on_spawn()
	drug_container_type = pick(/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/fancy/cigarettes/cigpack_midori,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift,
		/obj/item/storage/fancy/cigarettes/cigpack_robust,
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold,
		/obj/item/storage/fancy/cigarettes/cigpack_carp)
	. = ..()

/datum/quirk/junkie/smoker/announce_drugs()
	to_chat(quirk_holder, "<span class='boldnotice'>There is a [initial(drug_container_type.name)] [where_drug], and a lighter [where_accessory]. Make sure you get your favorite brand when you run out.</span>")


/datum/quirk/junkie/smoker/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/I = H.get_item_by_slot(ITEM_SLOT_MASK)
	if (istype(I, /obj/item/clothing/mask/cigarette))
		var/obj/item/storage/fancy/cigarettes/C = drug_container_type
		if(istype(I, initial(C.spawn_type)))
			SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "wrong_cigs")
			return
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "wrong_cigs", /datum/mood_event/wrong_brand)

/datum/quirk/alcoholic
	name = "Alcoholic"
	desc = "You can't stand being sober."
	value = -1
	gain_text = "<span class='danger'>You could really go for a drink right about now.</span>"
	lose_text = "<span class='notice'>You feel like you should quit drinking.</span>"
	medical_record_text = "Patient is an alcohol abuser."
	var/where_drink //Where the bottle spawned
	var/drink_types = list(/obj/item/reagent_containers/food/drinks/bottle/ale,
					/obj/item/reagent_containers/food/drinks/bottle/beer,
					/obj/item/reagent_containers/food/drinks/bottle/gin,
		            /obj/item/reagent_containers/food/drinks/bottle/whiskey,
					/obj/item/reagent_containers/food/drinks/bottle/vodka,
					/obj/item/reagent_containers/food/drinks/bottle/rum,
					/obj/item/reagent_containers/food/drinks/bottle/applejack)
	var/need = 0 // How much they crave alcohol at the moment
	var/tick_number = 0 // Keeping track of how many ticks have passed between a check
	var/obj/item/reagent_containers/food/drinks/bottle/drink_instance

/datum/quirk/alcoholic/on_spawn()
	drink_instance = pick(drink_types)
	drink_instance = new drink_instance()
	var/list/slots = list("in your backpack" = ITEM_SLOT_BACKPACK)
	var/mob/living/carbon/human/H = quirk_holder
	where_drink = H.equip_in_one_of_slots(drink_instance, slots, FALSE) || "at your feet"

/datum/quirk/alcoholic/post_add()
	to_chat(quirk_holder, "<span class='boldnotice'>There is a small bottle of [drink_instance] [where_drink]. You only have a single bottle, might have to find some more...</span>")

/datum/quirk/alcoholic/on_process()
	if(tick_number >= 6) // how many ticks should pass between a check
		tick_number = 0
		var/mob/living/carbon/human/H = quirk_holder
		if(H.drunkenness > 0) // If they're not drunk, need goes up. else they're satisfied
			need = -15
		else
			need++

		switch(need)
			if(1 to 10)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "alcoholic", /datum/mood_event/withdrawal_light, "alcohol")
				if(prob(5))
					to_chat(H, "<span class='notice'>You could go for a drink right about now.</span>")
			if(10 to 20)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "alcoholic", /datum/mood_event/withdrawal_medium, "alcohol")
				if(prob(5))
					to_chat(H, "<span class='notice'>You feel like you need alcohol. You just can't stand being sober.</span>")
			if(20 to 30)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "alcoholic", /datum/mood_event/withdrawal_severe, "alcohol")
				if(prob(5))
					to_chat(H, "<span class='danger'>You have an intense craving for a drink.</span>")
			if(30 to INFINITY)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "alcoholic", /datum/mood_event/withdrawal_critical, "Alcohol")
				if(prob(5))
					to_chat(H, "<span class='boldannounce'>You're not feeling good at all! You really need some alcohol.</span>")
			else
				SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "alcoholic")
	tick_number++

/datum/quirk/unstable
	name = "Unstable"
	desc = "Due to past troubles, you are unable to recover your sanity if you lose it. Be very careful managing your mood!"
	value = -2
	mob_trait = TRAIT_UNSTABLE
	gain_text = "<span class='danger'>There's a lot on your mind right now.</span>"
	lose_text = "<span class='notice'>Your mind finally feels calm.</span>"
	medical_record_text = "Patient's mind is in a vulnerable state, and cannot recover from traumatic events."

/datum/quirk/phobia
	name = "Phobia"
	desc = "Because of a traumatic event in your past you have developed a strong phobia."
	value = -2
	gain_text = "<span class='danger'>You start feeling an irrational fear of something.</span>"
	lose_text = "<span class='notice'>You are no longer irrationally afraid.</span>"
	medical_record_text = "Patient suffers from a deeply-rooted phobia."

/datum/quirk/phobia/add()
	var/datum/brain_trauma/mild/phobia/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/phobia/remove()
	var/mob/living/carbon/human/H = quirk_holder
	H.cure_trauma_type(/datum/brain_trauma/mild/phobia, TRAUMA_RESILIENCE_ABSOLUTE)
