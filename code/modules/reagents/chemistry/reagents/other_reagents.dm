/datum/reagent/blood
	data = list("viruses"=null,"blood_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null,"cloneable"=null,"factions"=null,"quirks"=null)
	name = "Blood"
	color = "#C80000" // rgb: 200, 0, 0
	metabolization_rate = 5 //fast rate so it disappears fast.
	taste_description = "iron"
	taste_mult = 1.3
	glass_icon_state = "glass_red"
	glass_name = "glass of tomato juice"
	glass_desc = "Are you sure this is tomato juice?"
	shot_glass_icon_state = "shotglassred"
	penetrates_skin = NONE
	ph = 7.4

	// FEED ME
/datum/reagent/blood/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustPests(rand(2,3))

/datum/reagent/blood/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if(data && data["viruses"])
		for(var/thing in data["viruses"])
			var/datum/disease/strain = thing

			if((strain.spread_flags & DISEASE_SPREAD_SPECIAL) || (strain.spread_flags & DISEASE_SPREAD_NON_CONTAGIOUS))
				continue

			if((methods & (TOUCH|VAPOR)) && (strain.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS))
				exposed_mob.ContactContractDisease(strain)
			else //ingest, patch or inject
				exposed_mob.ForceContractDisease(strain)

	if(iscarbon(exposed_mob))
		var/mob/living/carbon/exposed_carbon = exposed_mob
		if(exposed_carbon.get_blood_id() == /datum/reagent/blood && ((methods & INJECT) || ((methods & INGEST) && exposed_carbon.dna && exposed_carbon.dna.species && (DRINKSBLOOD in exposed_carbon.dna.species.species_traits))))
			if(!data || !(data["blood_type"] in get_safe_blood(exposed_carbon.dna.blood_type)))
				exposed_carbon.reagents.add_reagent(/datum/reagent/toxin, reac_volume * 0.5)
			else
				exposed_carbon.blood_volume = min(exposed_carbon.blood_volume + round(reac_volume, 0.1), BLOOD_VOLUME_MAXIMUM)


/datum/reagent/blood/on_new(list/data)
	if(istype(data))
		SetViruses(src, data)

/datum/reagent/blood/on_merge(list/mix_data)
	if(data && mix_data)
		if(data["blood_DNA"] != mix_data["blood_DNA"])
			data["cloneable"] = 0 //On mix, consider the genetic sampling unviable for pod cloning if the DNA sample doesn't match.
		if(data["viruses"] || mix_data["viruses"])

			var/list/mix1 = data["viruses"]
			var/list/mix2 = mix_data["viruses"]

			// Stop issues with the list changing during mixing.
			var/list/to_mix = list()

			for(var/datum/disease/advance/AD in mix1)
				if(AD.mutable)
					to_mix += AD
			for(var/datum/disease/advance/AD in mix2)
				if(AD.mutable)
					to_mix += AD

			var/datum/disease/advance/AD = Advance_Mix(to_mix)
			if(AD)
				var/list/preserve = list(AD)
				for(var/D in data["viruses"])
					if(istype(D, /datum/disease/advance))
						var/datum/disease/advance/A = D
						if(!A.mutable)
							preserve += A
					else
						preserve += D
				data["viruses"] = preserve
	return 1

/datum/reagent/blood/proc/get_diseases()
	. = list()
	if(data && data["viruses"])
		for(var/thing in data["viruses"])
			var/datum/disease/D = thing
			. += D

/datum/reagent/blood/expose_turf(turf/exposed_turf, reac_volume)//splash the blood all over the place
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/blood/bloodsplatter = locate() in exposed_turf //find some blood here
	if(!bloodsplatter)
		bloodsplatter = new(exposed_turf)
	if(data["blood_DNA"])
		bloodsplatter.add_blood_DNA(list(data["blood_DNA"] = data["blood_type"]))

/datum/reagent/liquidgibs
	name = "Liquid gibs"
	color = "#FF9966"
	description = "You don't even want to think about what's in here."
	taste_description = "gross iron"
	shot_glass_icon_state = "shotglassred"
	ph = 7.45
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/vaccine
	//data must contain virus type
	name = "Vaccine"
	color = "#C81040" // rgb: 200, 16, 64
	taste_description = "slime"
	penetrates_skin = NONE

/datum/reagent/vaccine/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if(!islist(data) || !(methods & (INGEST|INJECT)))
		return

	for(var/thing in exposed_mob.diseases)
		var/datum/disease/infection = thing
		if(infection.GetDiseaseID() in data)
			infection.cure()
	LAZYOR(exposed_mob.disease_resistances, data)

/datum/reagent/vaccine/on_merge(list/data)
	if(istype(data))
		src.data |= data.Copy()

/datum/reagent/corgium
	name = "Corgium"
	description = "A happy looking liquid that you feel compelled to consume if you want a better life."
	color = "#ecca7f"
	taste_description = "dog treats"
	can_synth = FALSE
	var/mob/living/simple_animal/pet/dog/corgi/new_corgi

/datum/reagent/corgium/on_mob_metabolize(mob/living/L)
	. = ..()
	new_corgi = new(get_turf(L))
	new_corgi.key = L.key
	new_corgi.name = L.real_name
	new_corgi.real_name = L.real_name
	ADD_TRAIT(L, TRAIT_NOBREATH, CORGIUM_TRAIT)
	//hack - equipt current hat
	var/mob/living/carbon/C = L
	if (istype(C))
		var/obj/item/hat = C.get_item_by_slot(ITEM_SLOT_HEAD)
		if (hat)
			new_corgi.place_on_head(hat,null,FALSE)
	L.forceMove(new_corgi)

/datum/reagent/corgium/on_mob_life(mob/living/carbon/M)
	. = ..()
	//If our corgi died :(
	if(new_corgi.stat)
		holder.remove_all_type(type)

/datum/reagent/corgium/on_mob_end_metabolize(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_NOBREATH, CORGIUM_TRAIT)
	//New corgi was deleted, goodbye cruel world.
	if(QDELETED(new_corgi))
		if(!QDELETED(L))
			qdel(L)
		return
	//Leave the corgi
	L.key = new_corgi.key
	L.adjustBruteLoss(new_corgi.getBruteLoss())
	L.adjustFireLoss(new_corgi.getFireLoss())
	L.forceMove(get_turf(new_corgi))
	// HACK - drop all corgi inventory
	var/turf/T = get_turf(new_corgi)
	if (new_corgi.inventory_head)
		if(!L.equip_to_slot_if_possible(new_corgi.inventory_head, ITEM_SLOT_HEAD,disable_warning = TRUE, bypass_equip_delay_self=TRUE))
			new_corgi.inventory_head.forceMove(T)
	new_corgi.inventory_back?.forceMove(T)
	new_corgi.inventory_head = null
	new_corgi.inventory_back = null
	qdel(new_corgi)

/datum/reagent/water
	name = "Water"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen."
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "water"
	var/cooling_temperature = 2
	glass_icon_state = "glass_clear"
	glass_name = "glass of water"
	glass_desc = "The father of all refreshments."
	shot_glass_icon_state = "shotglassclear"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	process_flags = ORGANIC | SYNTHETIC
	random_unrestricted = FALSE

/*
 *	Water reaction to turf
 */

/datum/reagent/water/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return

	var/cool_temp = cooling_temperature
	if(reac_volume >= 5)
		exposed_turf.MakeSlippery(TURF_WET_WATER, 10 SECONDS, min(reac_volume*1.5 SECONDS, 60 SECONDS))

	for(var/mob/living/simple_animal/slime/exposed_slime in exposed_turf)
		exposed_slime.apply_water()

	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in exposed_turf)
	if(hotspot && !isspaceturf(exposed_turf))
		if(exposed_turf.air)
			var/datum/gas_mixture/air = exposed_turf.air
			air.set_temperature(max(min(air.return_temperature()-(cool_temp*1000),air.return_temperature()/cool_temp),TCMB))
			air.react(src)
			qdel(hotspot)

/*
 *	Water reaction to an object
 */

/datum/reagent/water/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	exposed_obj.extinguish()
	exposed_obj.wash(CLEAN_TYPE_ACID)
	// Monkey cube
	if(istype(exposed_obj, /obj/item/reagent_containers/food/snacks/monkeycube))
		var/obj/item/reagent_containers/food/snacks/monkeycube/cube = exposed_obj
		cube.Expand()

	// Dehydrated carp
	else if(istype(exposed_obj, /obj/item/toy/plush/carpplushie/dehy_carp))
		var/obj/item/toy/plush/carpplushie/dehy_carp/dehy = exposed_obj
		dehy.Swell() // Makes a carp

	else if(istype(exposed_obj, /obj/item/stack/sheet/hairlesshide))
		var/obj/item/stack/sheet/hairlesshide/HH = exposed_obj
		new /obj/item/stack/sheet/wetleather(get_turf(HH), HH.amount)
		qdel(HH)

/*
 *	Water reaction to a mob
 */

/datum/reagent/water/expose_mob(mob/living/M, methods=TOUCH, reac_volume)//Splashing people with water can help put them out!
	if(!istype(M))
		return
	if(methods & TOUCH)
		M.extinguish_mob() // extinguish removes all fire stacks
	..()

/datum/reagent/water/holywater
	name = "Holy Water"
	description = "Water blessed by some deity."
	color = "#E0E8EF" // rgb: 224, 232, 239
	glass_icon_state  = "glass_clear"
	glass_name = "glass of holy water"
	glass_desc = "A glass of holy water."
	self_consuming = TRUE //divine intervention won't be limited by the lack of a liver
	ph = 7.5 //God is alkaline
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

	// Holy water. Mostly the same as water, it also heals the plant a little with the power of the spirits. Also ALSO increases instability.
/datum/reagent/water/holywater/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	if(chems.has_reagent(type, 1))
		mytray.adjustWater(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 0.1))
		if(myseed)
			myseed.adjust_instability(round(chems.get_reagent_amount(type) * 0.15))

/datum/reagent/water/holywater/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_HOLY, type)

/datum/reagent/water/holywater/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_HOLY, type)
	if(HAS_TRAIT_FROM(L, TRAIT_DEPRESSION, HOLYWATER_TRAIT))
		REMOVE_TRAIT(L, TRAIT_DEPRESSION, HOLYWATER_TRAIT)
		to_chat(L, "<span class='notice'>You cheer up, knowing that everything is going to be ok.</span>")
	..()

/datum/reagent/water/holywater/expose_mob(mob/living/M, methods=TOUCH, reac_volume)
	if(iscultist(M))
		to_chat(M, "<span class='userdanger'>A vile holiness begins to spread its shining tendrils through your mind, purging the Geometer of Blood's influence!</span>")
	..()

/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/M)
	if(!data)
		data = list("misc" = 1)
	data["misc"]++
	M.jitteriness = min(M.jitteriness+4,10)
	if(iscultist(M))
		for(var/datum/action/innate/cult/blood_magic/BM in M.actions)
			to_chat(M, "<span class='cultlarge'>Your blood rites falter as holy water scours your body!</span>")
			for(var/datum/action/innate/cult/blood_spell/BS in BM.spells)
				qdel(BS)
	if(data["misc"] >= 25)		// 10 units, 45 seconds @ metabolism 0.4 units & tick rate 1.8 sec
		if(!M.stuttering)
			M.stuttering = 1
		M.stuttering = min(M.stuttering+4, 10)
		M.Dizzy(5)
		if(is_servant_of_ratvar(M) && prob(20))
			M.say(text2ratvar(pick("Please don't leave me...", "Rat'var what happened?", "My friends, where are you?", "The hierophant network just went dark, is anyone there?", "The light is fading...", "No... It can't be...")), forced = "holy water")
			if(prob(40))
				if(!HAS_TRAIT_FROM(M, TRAIT_DEPRESSION, HOLYWATER_TRAIT))
					to_chat(M, "<span class='large_brass'>You feel the light fading and the world collapsing around you...</span>")
					ADD_TRAIT(M, TRAIT_DEPRESSION, HOLYWATER_TRAIT)
		if(iscultist(M) && prob(20))
			M.say(pick("Av'te Nar'Sie","Pa'lid Mors","INO INO ORA ANA","SAT ANA!","Daim'niodeis Arc'iai Le'eones","R'ge Na'sie","Diabo us Vo'iscum","Eld' Mon Nobis"), forced = "holy water")
			if(prob(10))
				M.visible_message("<span class='danger'>[M] starts having a seizure!</span>", "<span class='userdanger'>You have a seizure!</span>")
				M.Unconscious(120)
				to_chat(M, "<span class='cultlarge'>[pick("Your blood is your bond - you are nothing without it", "Do not forget your place", \
				"All that power, and you still fail?", "If you cannot scour this poison, I shall scour your meager life!")].</span>")
	if(data["misc"] >= 60)	// 30 units, 135 seconds
		if(iscultist(M) || is_servant_of_ratvar(M))
			if(iscultist(M))
				SSticker.mode.remove_cultist(M.mind, FALSE, TRUE)
			if(is_servant_of_ratvar(M))
				remove_servant_of_ratvar(M.mind)
			M.jitteriness = 0
			M.stuttering = 0
			holder.remove_reagent(type, volume)	// maybe this is a little too perfect and a max() cap on the statuses would be better??
			return
	holder.remove_reagent(type, 0.4)	//fixed consumption to prevent balancing going out of whack

/datum/reagent/water/holywater/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume>=10)
		for(var/obj/effect/rune/R in exposed_turf)
			qdel(R)
	exposed_turf.Bless()

/datum/reagent/water/hollowwater
	name = "Hollow Water"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen, but it looks kinda hollow."
	color = "#88878777"
	taste_description = "emptyiness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/hydrogen_peroxide
	name = "Hydrogen peroxide"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen and oxygen." //intended intended
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "burning water"
	var/cooling_temperature = 2
	glass_icon_state = "glass_clear"
	glass_name = "glass of oxygenated water"
	glass_desc = "The father of all refreshments. Surely it tastes great, right?"
	shot_glass_icon_state = "shotglassclear"
	ph = 6.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/*
 * Water reaction to turf
 */

/datum/reagent/hydrogen_peroxide/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume >= 5)
		exposed_turf.MakeSlippery(TURF_WET_WATER, 10 SECONDS, min(reac_volume*1.5 SECONDS, 60 SECONDS))
/*
 * Water reaction to a mob
 */

/datum/reagent/hydrogen_peroxide/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)//Splashing people with h2o2 can burn them !
	. = ..()
	if(methods & TOUCH)
		exposed_mob.adjustFireLoss(2, 0) // burns

/datum/reagent/fuel/unholywater		//if you somehow managed to extract this from someone, dont splash it on yourself and have a smoke
	name = "Unholy Water"
	description = "Something that shouldn't exist on this plane of existence."
	taste_description = "suffering"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM  //1u/tick
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/fuel/unholywater/on_mob_life(mob/living/carbon/M)
	if(iscultist(M))
		M.drowsyness = max(M.drowsyness-5, 0)
		M.AdjustAllImmobility(-40, FALSE)
		M.adjustStaminaLoss(-10, 0)
		M.adjustToxLoss(-2, 0)
		M.adjustOxyLoss(-2, 0)
		M.adjustBruteLoss(-2, 0)
		M.adjustFireLoss(-2, 0)
		if(ishuman(M) && M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume += 3
	else  // Will deal about 90 damage when 50 units are thrown
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3, 150)
		M.adjustToxLoss(2, 0)
		M.adjustFireLoss(2, 0)
		M.adjustOxyLoss(2, 0)
		M.adjustBruteLoss(2, 0)
	holder.remove_reagent(type, 1)
	return TRUE

/datum/reagent/hellwater			//if someone has this in their system they've really pissed off an eldrich god
	name = "Hell Water"
	description = "YOUR FLESH! IT BURNS!"
	taste_description = "burning"
	process_flags = ORGANIC | SYNTHETIC
	ph = 0.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/hellwater/on_mob_life(mob/living/carbon/M)
	M.fire_stacks = min(5,M.fire_stacks + 3)
	M.IgniteMob()			//Only problem with igniting people is currently the commonly available fire suits make you immune to being on fire
	M.adjustToxLoss(1, 0)
	M.adjustFireLoss(1, 0)		//Hence the other damages... ain't I a bastard?
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 150)
	holder.remove_reagent(type, 1)

/datum/reagent/medicine/omnizine/godblood
	name = "Godblood"
	description = "Slowly heals all damage types. Has a rather high overdose threshold. Glows with mysterious power."
	overdose_threshold = 150
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/lube
	name = "Space Lube"
	description = "Lubricant is a substance introduced between two moving surfaces to reduce the friction and wear between them. giggity."
	color = "#009CA8" // rgb: 0, 156, 168
	taste_description = "cherry" // by popular demand
	var/lube_kind = TURF_WET_LUBE ///What kind of slipperiness gets added to turfs
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/lube/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume >= 1)
		exposed_turf.MakeSlippery(lube_kind, 15 SECONDS, min(reac_volume * 2 SECONDS, 120))

///Stronger kind of lube. Applies TURF_WET_SUPERLUBE.
/datum/reagent/lube/superlube
	name = "Super Duper Lube"
	description = "This \[REDACTED\] has been outlawed after the incident on \[DATA EXPUNGED\]."
	lube_kind = TURF_WET_SUPERLUBE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/spraytan
	name = "Spray Tan"
	description = "A substance applied to the skin to darken the skin."
	color = "#FFC080" // rgb: 255, 196, 128  Bright orange
	metabolization_rate = 10 * REAGENTS_METABOLISM // very fast, so it can be applied rapidly.  But this changes on an overdose
	overdose_threshold = 11 //Slightly more than one un-nozzled spraybottle.
	taste_description = "sour oranges"
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/spraytan/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(ishuman(exposed_mob))
		if(methods & (PATCH|VAPOR))
			var/mob/living/carbon/human/exposed_human = exposed_mob
			if(exposed_human.dna.species.id == "human")
				switch(exposed_human.skin_tone)
					if("african1")
						exposed_human.skin_tone = "african2"
					if("indian")
						exposed_human.skin_tone = "african1"
					if("arab")
						exposed_human.skin_tone = "indian"
					if("asian2")
						exposed_human.skin_tone = "arab"
					if("asian1")
						exposed_human.skin_tone = "asian2"
					if("mediterranean")
						exposed_human.skin_tone = "african1"
					if("latino")
						exposed_human.skin_tone = "mediterranean"
					if("caucasian3")
						exposed_human.skin_tone = "mediterranean"
					if("caucasian2")
						exposed_human.skin_tone = pick("caucasian3", "latino")
					if("caucasian1")
						exposed_human.skin_tone = "caucasian2"
					if ("albino")
						exposed_human.skin_tone = "caucasian1"

			if(MUTCOLORS in exposed_human.dna.species.species_traits) //take current alien color and darken it slightly
				var/newcolor = ""
				var/string = exposed_human.dna.features["mcolor"]
				var/len = length(string)
				var/char = ""
				var/ascii = 0
				for(var/i=1, i<=len, i += length(char))
					char = string[i]
					ascii = text2ascii(char)
					switch(ascii)
						if(48)
							newcolor += "0"
						if(49 to 57)
							newcolor += ascii2text(ascii-1)	//numbers 1 to 9
						if(97)
							newcolor += "9"
						if(98 to 102)
							newcolor += ascii2text(ascii-1)	//letters b to f lowercase
						if(65)
							newcolor += "9"
						if(66 to 70)
							newcolor += ascii2text(ascii+31)	//letters B to F - translates to lowercase
						else
							break
				if(ReadHSV(newcolor)[3] >= ReadHSV("#7F7F7F")[3])
					exposed_human.dna.features["mcolor"] = newcolor
			exposed_human.regenerate_icons()

		if((methods & INGEST) && show_message)
			to_chat(exposed_mob, "<span class='notice'>That tasted horrible.</span>")


/datum/reagent/spraytan/overdose_process(mob/living/M)
	metabolization_rate = 1 * REAGENTS_METABOLISM

	if(ishuman(M))
		var/mob/living/carbon/human/N = M
		N.hair_style = "Spiky"
		N.facial_hair_style = "Shaved"
		N.facial_hair_color = "000"
		N.hair_color = "000"
		if(!(HAIR in N.dna.species.species_traits)) //No hair? No problem!
			N.dna.species.species_traits += HAIR
		if(N.dna.species.use_skintones)
			N.skin_tone = "orange"
		else if(MUTCOLORS in N.dna.species.species_traits) //Aliens with custom colors simply get turned orange
			N.dna.features["mcolor"] = "f80"
		N.regenerate_icons()
		if(prob(7))
			if(N.w_uniform)
				M.visible_message(pick("<b>[M]</b>'s collar pops up without warning.</span>", "<b>[M]</b> flexes [M.p_their()] arms."))
			else
				M.visible_message("<b>[M]</b> flexes [M.p_their()] arms.")
	if(prob(10))
		M.say(pick("Shit was SO cash.", "You are everything bad in the world.", "What sports do you play, other than 'jack off to naked drawn Japanese people?'", "Don???t be a stranger. Just hit me with your best shot.", "My name is John and I hate every single one of you."), forced = /datum/reagent/spraytan)
	..()
	return

#define MUT_MSG_IMMEDIATE 1
#define MUT_MSG_EXTENDED 2
#define MUT_MSG_ABOUT2TURN 3

/datum/reagent/mutationtoxin
	name = "Stable Mutation Toxin"
	description = "A humanizing toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	metabolization_rate = 0.2 //metabolizes to prevent micro-dosage. about 4u is necessary to transform
	taste_description = "slime"
	var/race = /datum/species/human
	process_flags = ORGANIC | SYNTHETIC
	var/list/mutationtexts = list( "You don't feel very well." = MUT_MSG_IMMEDIATE,
									"Your skin feels a bit abnormal." = MUT_MSG_IMMEDIATE,
									"Your limbs begin to take on a different shape." = MUT_MSG_EXTENDED,
									"Your appendages begin morphing." = MUT_MSG_EXTENDED,
									"You feel as though you're about to change at any moment!" = MUT_MSG_ABOUT2TURN)
	var/cycles_to_turn = 20 //the current_cycle threshold / iterations needed before one can transform
	can_synth = FALSE

/datum/reagent/mutationtoxin/on_mob_life(mob/living/carbon/human/H)
	. = TRUE
	if(!istype(H))
		return
	if(!(H.dna?.species) || !(H.mob_biotypes & MOB_ORGANIC))
		return

	if(prob(10))
		var/list/pick_ur_fav = list()
		var/filter = NONE
		if(current_cycle <= (cycles_to_turn*0.3))
			filter = MUT_MSG_IMMEDIATE
		else if(current_cycle <= (cycles_to_turn*0.8))
			filter = MUT_MSG_EXTENDED
		else
			filter = MUT_MSG_ABOUT2TURN

		for(var/i in mutationtexts)
			if(mutationtexts[i] == filter)
				pick_ur_fav += i
		to_chat(H, "<span class='warning'>[pick(pick_ur_fav)]</span>")

	if(current_cycle >= cycles_to_turn)
		var/datum/species/species_type = pick(race) //this worked with the old code, somehow, and it works here...
		H.set_species(species_type)
		H.reagents.del_reagent(type)
		to_chat(H, "<span class='warning'>You've become \a [lowertext(initial(species_type.name))]!</span>")
		return
	..()

/datum/reagent/mutationtoxin/classic //The one from plasma on green slimes
	name = "Mutation Toxin"
	description = "A corruptive toxin."
	color = "#13BC5E" // rgb: 19, 188, 94
	race = /datum/species/jelly/slime
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/unstable
	name = "Unstable Mutation Toxin"
	description = "A mostly safe mutation toxin."
	color = "#13BC5E" // rgb: 19, 188, 94
	race = list(/datum/species/jelly/slime,
						/datum/species/human,
						/datum/species/human/felinid,
						/datum/species/lizard,
						/datum/species/fly,
						/datum/species/moth,
						/datum/species/apid,
						/datum/species/pod,
						/datum/species/jelly,
						/datum/species/abductor,
						/datum/species/skeleton)
	can_synth = TRUE

/datum/reagent/mutationtoxin/felinid
	name = "Felinid Mutation Toxin"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/human/felinid
	taste_description = "something nyat good"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/lizard
	name = "Lizard Mutation Toxin"
	description = "A lizarding toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/lizard
	taste_description = "dragon's breath but not as cool"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/fly
	name = "Fly Mutation Toxin"
	description = "An insectifying toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/fly
	taste_description = "trash"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/moth
	name = "Moth Mutation Toxin"
	description = "A glowing toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/moth
	taste_description = "clothing"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/apid
	name = "Apid Mutation Toxin"
	description = "A sweet-smelling toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/apid
	taste_description = "honey"

/datum/reagent/mutationtoxin/pod
	name = "Podperson Mutation Toxin"
	description = "A vegetalizing toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/pod
	taste_description = "flowers"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/jelly
	name = "Imperfect Mutation Toxin"
	description = "A jellyfying toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/jelly
	taste_description = "grandma's gelatin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/jelly/on_mob_life(mob/living/carbon/human/H)
	if(isjellyperson(H))
		to_chat(H, "<span class='warning'>Your jelly shifts and morphs, turning you into another subspecies!</span>")
		var/species_type = pick(subtypesof(/datum/species/jelly))
		H.set_species(species_type)
		H.reagents.del_reagent(type)
		return TRUE
	if(current_cycle >= cycles_to_turn) //overwrite since we want subtypes of jelly
		var/datum/species/species_type = pick(subtypesof(race))
		H.set_species(species_type)
		H.reagents.del_reagent(type)
		to_chat(H, "<span class='warning'>You've become \a [initial(species_type.name)]!</span>")
		return TRUE
	return ..()

/datum/reagent/mutationtoxin/golem
	name = "Golem Mutation Toxin"
	description = "A crystal toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/golem/random
	taste_description = "rocks"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/abductor
	name = "Abductor Mutation Toxin"
	description = "An alien toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/abductor
	taste_description = "something out of this world... no, universe!"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/android
	name = "Android Mutation Toxin"
	description = "A robotic toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/android
	taste_description = "circuitry and steel"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/ipc
	name = "IPC Mutation Toxin"
	description = "An integrated positronic toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ipc
	taste_description = "silicon and copper"

/datum/reagent/mutationtoxin/ethereal
	name = "Ethereal Mutation Toxin"
	description = "A positively electric toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ethereal
	taste_description = "shocking"

/datum/reagent/mutationtoxin/oozeling
	name = "Oozeling Mutation Toxin"
	description = "An oozing toxin"
	color = "#611e80" //RGB: 97, 30, 128
	race = /datum/species/oozeling
	taste_description = "burning ooze"

//BLACKLISTED RACES
/datum/reagent/mutationtoxin/skeleton
	name = "Skeleton Mutation Toxin"
	description = "A scary toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/skeleton
	taste_description = "milk... and lots of it"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/zombie
	name = "Zombie Mutation Toxin"
	description = "An undead toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/zombie //Not the infectious kind. The days of xenobio zombie outbreaks are long past.
	taste_description = "brai...nothing in particular"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/goofzombie
	name = "Zombie Mutation Toxin"
	description = "An undead toxin... kinda..."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/krokodil_addict //Not the infectious kind. The days of xenobio zombie outbreaks are long past.
	taste_description = "krokodil"


/datum/reagent/mutationtoxin/ash
	name = "Ash Mutation Toxin"
	description = "An ashen toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/lizard/ashwalker
	taste_description = "savagery"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/supersoldier
	name = "Super Soldier Toxin"
	description = "A flesh-sculpting toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/human/supersoldier
	taste_description = "adminbuse"
	can_synth = FALSE
	random_unrestricted = FALSE



//DANGEROUS RACES
/datum/reagent/mutationtoxin/shadow
	name = "Shadow Mutation Toxin"
	description = "A dark toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/shadow
	taste_description = "the night"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mutationtoxin/plasma
	name = "Plasma Mutation Toxin"
	description = "A plasma-based toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/plasmaman
	taste_description = "plasma"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

#undef MUT_MSG_IMMEDIATE
#undef MUT_MSG_EXTENDED
#undef MUT_MSG_ABOUT2TURN

/datum/reagent/mulligan
	name = "Mulligan Toxin"
	description = "This toxin will rapidly change the DNA of human beings. Commonly used by Syndicate spies and assassins in need of an emergency ID change."
	color = "#5EFF3B" //RGB: 94, 255, 59
	metabolization_rate = INFINITY
	taste_description = "slime"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mulligan/on_mob_life(mob/living/carbon/human/H)
	..()
	if (!istype(H))
		return
	to_chat(H, "<span class='warning'><b>You grit your teeth in pain as your body rapidly mutates!</b></span>")
	H.visible_message("<b>[H]</b> suddenly transforms!")
	randomize_human(H)

/datum/reagent/aslimetoxin
	name = "Advanced Mutation Toxin"
	description = "An advanced corruptive toxin produced by slimes."
	color = "#13BC5E" // rgb: 19, 188, 94
	taste_description = "slime"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/aslimetoxin/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if(methods & ~TOUCH)
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/slime(), FALSE, TRUE)

/datum/reagent/gluttonytoxin
	name = "Gluttony's Blessing"
	description = "An advanced corruptive toxin produced by something terrible."
	color = "#5EFF3B" //RGB: 94, 255, 59
	taste_description = "decay"
	penetrates_skin = NONE

/datum/reagent/gluttonytoxin/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	exposed_mob.ForceContractDisease(new /datum/disease/transformation/morph(), FALSE, TRUE)

/datum/reagent/serotrotium
	name = "Serotrotium"
	description = "A chemical compound that promotes concentrated production of the serotonin neurotransmitter in humans."
	color = "#202040" // rgb: 20, 20, 40
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/serotrotium/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		if(prob(7))
			M.emote(pick("twitch","drool","moan","gasp"))
	..()

/datum/reagent/oxygen
	name = "Oxygen"
	description = "A colorless, odorless gas. Grows on trees but is still pretty valuable."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0 // oderless and tasteless
	ph = 9.2//It's acutally a huge range and very dependant on the chemistry but ph is basically a made up var in it's implementation anyways
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/oxygen/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if((!exposed_obj) || (!reac_volume))
		return
	var/temp = holder ? holder.chem_temp : T20C
	exposed_obj.atmos_spawn_air("o2=[reac_volume/2];TEMP=[temp]")

/datum/reagent/oxygen/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("o2=[reac_volume/2];TEMP=[temp]")

/datum/reagent/copper
	name = "Copper"
	description = "A highly ductile metal. Things made out of copper aren't very durable, but it makes a decent material for electrical wiring."
	reagent_state = SOLID
	color = "#6E3B08" // rgb: 110, 59, 8
	taste_description = "metal"
	random_unrestricted = FALSE
	ph = 5.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/copper/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if(!istype(exposed_obj, /obj/item/stack/sheet/iron))
		return

	var/obj/item/stack/sheet/iron/M = exposed_obj
	reac_volume = min(reac_volume, M.amount)
	new/obj/item/stack/tile/bronze(get_turf(M), reac_volume)
	M.use(reac_volume)

/datum/reagent/nitrogen
	name = "Nitrogen"
	description = "A colorless, odorless, tasteless gas. A simple asphyxiant that can silently displace vital oxygen."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/nitrogen/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if((!exposed_obj) || (!reac_volume))
		return
	var/temp = holder ? holder.chem_temp : T20C
	exposed_obj.atmos_spawn_air("n2=[reac_volume/2];TEMP=[temp]")

/datum/reagent/nitrogen/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if((!exposed_obj) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	exposed_obj.atmos_spawn_air("n2=[reac_volume/2];TEMP=[temp]")

/datum/reagent/nitrogen/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("n2=[reac_volume/2];TEMP=[temp]")
	return

/datum/reagent/hydrogen
	name = "Hydrogen"
	description = "A colorless, odorless, nonmetallic, tasteless, highly combustible diatomic gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0
	random_unrestricted = FALSE
	ph = 0.1//Now I'm stuck in a trap of my own design. Maybe I should make -ve phes? (not 0 so I don't get div/0 errors)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/potassium
	name = "Potassium"
	description = "A soft, low-melting solid that can easily be cut with a knife. Reacts violently with water."
	reagent_state = SOLID
	color = "#A0A0A0" // rgb: 160, 160, 160
	taste_description = "sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mercury
	name = "Mercury"
	description = "A curious metal that's a liquid at room temperature. Neurodegenerative and very bad for the mind."
	color = "#484848" // rgb: 72, 72, 72A
	taste_mult = 0 // apparently tasteless.
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/mercury/on_mob_life(mob/living/carbon/M)
	if((M.mobility_flags & MOBILITY_MOVE) && !isspaceturf(M.loc))
		step(M, pick(GLOB.cardinals))
	if(prob(5))
		M.emote(pick("twitch","drool","moan"))
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
	..()

/datum/reagent/sulfur
	name = "Sulfur"
	description = "A sickly yellow solid mostly known for its nasty smell. It's actually much more helpful than it looks in biochemisty."
	reagent_state = SOLID
	color = "#BF8C00" // rgb: 191, 140, 0
	taste_description = "rotten eggs"
	random_unrestricted = FALSE
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carbon
	name = "Carbon"
	description = "A crumbly black solid that, while unexciting on a physical level, forms the base of all known life. Kind of a big deal."
	reagent_state = SOLID
	color = "#1C1300" // rgb: 30, 20, 0
	taste_description = "sour chalk"
	random_unrestricted = FALSE
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carbon/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(isspaceturf(exposed_turf))
		return

	var/obj/effect/decal/cleanable/dirt/dirt_decal = (locate() in exposed_turf.contents)
	if(!dirt_decal)
		dirt_decal = new(exposed_turf)

/datum/reagent/chlorine
	name = "Chlorine"
	description = "A pale yellow gas that's well known as an oxidizer. While it forms many harmless molecules in its elemental form it is far from harmless."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "chlorine"
	random_unrestricted = FALSE
	ph = 7.4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/chlorine/on_mob_life(mob/living/carbon/M)
	M.take_bodypart_damage(1*REM, 0, 0, 0)
	. = 1
	..()

/datum/reagent/fluorine
	name = "Fluorine"
	description = "A comically-reactive chemical element. The universe does not want this stuff to exist in this form in the slightest."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "acid"
	process_flags = ORGANIC | SYNTHETIC
	random_unrestricted = FALSE
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/fluorine/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1*REM, 0)
	. = 1
	..()

/datum/reagent/sodium
	name = "Sodium"
	description = "A soft silver metal that can easily be cut with a knife. It's not salt just yet, so refrain from putting in on your chips."
	reagent_state = SOLID
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "salty metal"
	random_unrestricted = FALSE
	ph = 11.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/phosphorus
	name = "Phosphorus"
	description = "A ruddy red powder that burns readily. Though it comes in many colors, the general theme is always the same."
	reagent_state = SOLID
	color = "#832828" // rgb: 131, 40, 40
	taste_description = "vinegar"
	random_unrestricted = FALSE
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/lithium
	name = "Lithium"
	description = "A silver metal, its claim to fame is its remarkably low density. Using it is a bit too effective in calming oneself down."
	reagent_state = SOLID
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "metal"
	random_unrestricted = FALSE
	ph = 11.3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/lithium/on_mob_life(mob/living/carbon/M)
	if((M.mobility_flags & MOBILITY_MOVE) && !isspaceturf(M.loc) && isturf(M.loc))
		step(M, pick(GLOB.cardinals))
	if(prob(5))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/glycerol
	name = "Glycerol"
	description = "Glycerol is a simple polyol compound. Glycerol is sweet-tasting and of low toxicity."
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "sweetness"
	ph = 9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/space_cleaner/sterilizine
	name = "Sterilizine"
	description = "Sterilizes wounds in preparation for surgery."
	color = "#C8A5DC" // rgb: 200, 165, 220
	taste_description = "bitterness"
	ph = 10.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/space_cleaner/sterilizine/expose_mob(mob/living/carbon/exposed_carbon, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (TOUCH|VAPOR|PATCH)))
		return

	for(var/datum/surgery/surgery in exposed_carbon.surgeries)
		surgery.speed_modifier = max(0.2, surgery.speed_modifier)

/datum/reagent/iron
	name = "Iron"
	description = "Pure iron is a metal."
	reagent_state = SOLID
	taste_description = "iron"
	material = /datum/material/iron
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	color = "#606060" //pure iron? let's make it violet of course
	ph = 6

/datum/reagent/iron/on_mob_life(mob/living/carbon/C)
	if(C.blood_volume < BLOOD_VOLUME_NORMAL)
		C.blood_volume += 0.5
	..()

/datum/reagent/iron/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!exposed_mob.has_bane(BANE_IRON)) //If the target is weak to cold iron, then poison them.
		return
	if(!holder || (holder.chem_temp >= 100)) // COLD iron.
		return

	exposed_mob.reagents.add_reagent(/datum/reagent/toxin, reac_volume)

/datum/reagent/gold
	name = "Gold"
	description = "Gold is a dense, soft, shiny metal and the most malleable and ductile metal known."
	reagent_state = SOLID
	color = "#F7C430" // rgb: 247, 196, 48
	taste_description = "expensive metal"
	material = /datum/material/gold
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/silver
	name = "Silver"
	description = "A soft, white, lustrous transition metal, it has the highest electrical conductivity of any element and the highest thermal conductivity of any metal."
	reagent_state = SOLID
	color = "#D0D0D0" // rgb: 208, 208, 208
	taste_description = "expensive yet reasonable metal"
	material = /datum/material/silver
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/silver/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(exposed_mob.has_bane(BANE_SILVER))
		exposed_mob.reagents.add_reagent(/datum/reagent/toxin, reac_volume)

/datum/reagent/uranium
	name ="Uranium"
	description = "A silvery-white metallic chemical element in the actinide series, weakly radioactive."
	reagent_state = SOLID
	color = "#B8B8C0" // rgb: 184, 184, 192
	taste_description = "the inside of a reactor"
	var/irradiation_level = 1
	process_flags = ORGANIC | SYNTHETIC
	ph = 4
	material = /datum/material/uranium
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/uranium/on_mob_life(mob/living/carbon/M)
	M.apply_effect(irradiation_level/M.metabolism_efficiency,EFFECT_IRRADIATE,0)
	..()

/datum/reagent/uranium/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if((reac_volume < 3) || isspaceturf(exposed_turf))
		return

/datum/reagent/uranium/radium
	name = "Radium"
	description = "Radium is an alkaline earth metal. It is extremely radioactive."
	reagent_state = SOLID
	color = "#C7C7C7" // rgb: 199,199,199
	taste_description = "the colour blue and regret"
	irradiation_level = 2*REM
	process_flags = ORGANIC | SYNTHETIC
	random_unrestricted = FALSE
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/bluespace
	name = "Bluespace Dust"
	description = "A dust composed of microscopic bluespace crystals, with minor space-warping properties."
	reagent_state = SOLID
	color = "#0000CC"
	taste_description = "fizzling blue"
	process_flags = ORGANIC | SYNTHETIC
	ph = 12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/bluespace/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(methods & (TOUCH|VAPOR))
		do_teleport(exposed_mob, get_turf(exposed_mob), (reac_volume / 5), asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE) //4 tiles per crystal

/datum/reagent/bluespace/on_mob_life(mob/living/carbon/M)
	if(current_cycle > 10 && prob(15))
		to_chat(M, "<span class='warning'>You feel unstable...</span>")
		M.Jitter(2)
		current_cycle = 1
		addtimer(CALLBACK(M, /mob/living/proc/bluespace_shuffle), 30)
	..()

/mob/living/proc/bluespace_shuffle()
	do_teleport(src, get_turf(src), 5, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)

/datum/reagent/aluminium
	name = "Aluminium"
	description = "A silvery white and ductile member of the boron group of chemical elements."
	reagent_state = SOLID
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_description = "metal"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/silicon
	name = "Silicon"
	description = "A tetravalent metalloid, silicon is less reactive than its chemical analog carbon."
	reagent_state = SOLID
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_mult = 0
	random_unrestricted = FALSE
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/fuel
	name = "Welding Fuel"
	description = "Required for welders. Flammable."
	color = "#660000" // rgb: 102, 0, 0
	taste_description = "gross metal"
	glass_icon_state = "dr_gibb_glass"
	glass_name = "glass of welder fuel"
	glass_desc = "Unless you're an industrial tool, this is probably not safe for consumption."
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/fuel/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)//Splashing people with welding fuel to make them easy to ignite!
	. = ..()
	if(methods & (TOUCH|VAPOR))
		exposed_mob.adjust_fire_stacks(reac_volume / 10)

/datum/reagent/fuel/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1, 0)
	..()
	return TRUE

/datum/reagent/space_cleaner
	name = "Space Cleaner"
	description = "A compound used to clean things. Now with 50% more sodium hypochlorite! Not safe for consumption. If ingested, contact poison control immediately"
	color = "#A5F0EE" // rgb: 165, 240, 238
	taste_description = "sourness"
	reagent_weight = 0.6 //so it sprays further
	var/clean_types = CLEAN_WASH
	ph = 5.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/space_cleaner/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	exposed_obj?.wash(clean_types)

/datum/reagent/space_cleaner/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < 1)
		return

	exposed_turf.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	SEND_SIGNAL(exposed_turf, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRENGTH_BLOOD)
	for(var/obj/effect/decal/cleanable/C in exposed_turf)
		qdel(C)

	for(var/mob/living/simple_animal/slime/M in exposed_turf)
		M.adjustToxLoss(rand(5,10))

/datum/reagent/space_cleaner/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if(methods & (TOUCH|VAPOR))
		exposed_mob.wash(clean_types)

/datum/reagent/space_cleaner/ez_clean
	name = "EZ Clean"
	description = "A powerful, acidic cleaner sold by Waffle Co. Affects organic matter while leaving other objects unaffected."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "acid"
	penetrates_skin = VAPOR
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/space_cleaner/ez_clean/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(3.33)
	M.adjustFireLoss(3.33)
	M.adjustToxLoss(3.33)
	..()

/datum/reagent/space_cleaner/ez_clean/expose_mob(mob/living/M, methods=TOUCH, reac_volume)
	..()
	if((methods & (TOUCH|VAPOR)) && !issilicon(M))
		M.adjustBruteLoss(1.5)
		M.adjustFireLoss(1.5)

/datum/reagent/cryptobiolin
	name = "Cryptobiolin"
	description = "Cryptobiolin causes confusion and dizziness."
	color = "#C8A5DC" // rgb: 200, 165, 220
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "sourness"
	ph = 11.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/cryptobiolin/on_mob_life(mob/living/carbon/M)
	M.Dizzy(1)
	if(!M.confused)
		M.confused = 1
	M.confused = max(M.confused, 20)
	..()

/datum/reagent/impedrezene
	name = "Impedrezene"
	description = "Impedrezene is a narcotic that impedes one's ability by slowing down the higher brain cell functions."
	color = "#C8A5DC" // rgb: 200, 165, 220A
	taste_description = "numbness"
	ph = 9.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/impedrezene/on_mob_life(mob/living/carbon/M)
	M.jitteriness = max(M.jitteriness-5,0)
	if(prob(80))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2*REM)
	if(prob(50))
		M.drowsyness = max(M.drowsyness, 3)
	if(prob(10))
		M.emote("drool")
	..()

/datum/reagent/nanomachines
	name = "Nanomachines"
	description = "Microscopic construction robots."
	color = "#535E66" // rgb: 83, 94, 102
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	taste_description = "sludge"
	penetrates_skin = NONE

/datum/reagent/nanomachines/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/robot(), FALSE, TRUE)

/datum/reagent/xenomicrobes
	name = "Xenomicrobes"
	description = "Microbes with an entirely alien cellular structure."
	color = "#535E66" // rgb: 83, 94, 102
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	taste_description = "sludge"
	penetrates_skin = NONE

/datum/reagent/xenomicrobes/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/xeno(), FALSE, TRUE)

/datum/reagent/fungalspores
	name = "Tubercle bacillus Cosmosis microbes"
	description = "Active fungal spores."
	color = "#92D17D" // rgb: 146, 209, 125
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	taste_description = "slime"

/datum/reagent/fungalspores/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/tuberculosis(), FALSE, TRUE)

/datum/reagent/snail
	name = "Agent-S"
	description = "Virological agent that infects the subject with Gastrolosis."
	color = "#003300" // rgb(0, 51, 0)
	taste_description = "goo"
	penetrates_skin = NONE
	ph = 11

/datum/reagent/snail/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/gastrolosis(), FALSE, TRUE)

/datum/reagent/fluorosurfactant//foam precursor
	name = "Fluorosurfactant"
	description = "A perfluoronated sulfonic acid that forms a foam when mixed with water."
	color = "#9E6B38" // rgb: 158, 107, 56
	taste_description = "metal"
	random_unrestricted = FALSE
	ph = 11
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/foaming_agent// Metal foaming agent. This is lithium hydride. Add other recipes (e.g. LiH + H2O -> LiOH + H2) eventually.
	name = "Foaming agent"
	description = "An agent that yields metallic foam when mixed with light metal and a strong acid."
	reagent_state = SOLID
	color = "#664B63" // rgb: 102, 75, 99
	taste_description = "metal"
	random_unrestricted = FALSE
	ph = 11.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/smart_foaming_agent //Smart foaming agent. Functions similarly to metal foam, but conforms to walls.
	name = "Smart foaming agent"
	description = "An agent that yields metallic foam which conforms to area boundaries when mixed with light metal and a strong acid."
	reagent_state = SOLID
	color = "#664B63" // rgb: 102, 75, 99
	taste_description = "metal"
	random_unrestricted = FALSE
	ph = 11.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/ammonia
	name = "Ammonia"
	description = "A caustic substance commonly used in fertilizer or household cleaners."
	reagent_state = GAS
	color = "#404030" // rgb: 64, 64, 48
	taste_description = "mordant"
	random_unrestricted = FALSE
	ph = 11.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/diethylamine
	name = "Diethylamine"
	description = "A secondary amine, mildly corrosive."
	color = "#604030" // rgb: 96, 64, 48
	taste_description = "iron"
	random_unrestricted = FALSE
	ph = 12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carbondioxide
	name = "Carbon Dioxide"
	reagent_state = GAS
	description = "A gas commonly produced by burning carbon fuels. You're constantly producing this in your lungs."
	color = "#B0B0B0" // rgb : 192, 192, 192
	taste_description = "something unknowable"
	random_unrestricted = FALSE
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carbondioxide/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if((!exposed_obj) || (!reac_volume))
		return
	var/temp = holder ? holder.chem_temp : T20C
	exposed_obj.atmos_spawn_air("co2=[reac_volume/5];TEMP=[temp]")

/datum/reagent/carbondioxide/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("co2=[reac_volume/5];TEMP=[temp]")

/datum/reagent/nitrous_oxide
	name = "Nitrous Oxide"
	description = "A potent oxidizer used as fuel in rockets and as an anaesthetic during surgery."
	reagent_state = LIQUID
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	color = "#808080"
	taste_description = "sweetness"
	ph = 5.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/nitrous_oxide/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if((!exposed_obj) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	exposed_obj.atmos_spawn_air("n2o=[reac_volume/5];TEMP=[temp]")

/datum/reagent/nitrous_oxide/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("n2o=[reac_volume/5];TEMP=[temp]")

/datum/reagent/nitrous_oxide/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if((!exposed_obj) || (!reac_volume))
		return
	var/temp = holder ? holder.chem_temp : T20C
	exposed_obj.atmos_spawn_air("n2o=[reac_volume/5];TEMP=[temp]")

/datum/reagent/nitrous_oxide/on_mob_life(mob/living/carbon/M)
	M.drowsyness += 2
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.blood_volume = max(H.blood_volume - 10, 0)
	if(prob(20))
		M.losebreath += 2
		M.confused = min(M.confused + 2, 5)
	..()

/datum/reagent/stimulum
	name = "Stimulum"
	description = "An unstable experimental gas that greatly increases the energy of those that inhale it, while dealing increasing toxin damage over time."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5 // Because stimulum/nitryl are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "E1A116"
	taste_description = "sourness"
	ph = 1.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/stimulum/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_STUNIMMUNE, type)
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	ADD_TRAIT(L, TRAIT_IGNOREDAMAGESLOWDOWN, type)
	ADD_TRAIT(L, TRAIT_NOSTAMCRIT, type)
	ADD_TRAIT(L, TRAIT_NOLIMBDISABLE, type)
	ADD_TRAIT(L, TRAIT_NOBLOCK, type)

/datum/reagent/stimulum/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_STUNIMMUNE, type)
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	REMOVE_TRAIT(L, TRAIT_IGNOREDAMAGESLOWDOWN, type)
	REMOVE_TRAIT(L, TRAIT_NOSTAMCRIT, type)
	REMOVE_TRAIT(L, TRAIT_NOLIMBDISABLE, type)
	REMOVE_TRAIT(L, TRAIT_NOBLOCK, type)
	..()

/datum/reagent/stimulum/on_mob_life(mob/living/carbon/M)
	M.adjustStaminaLoss(-2*REM, 0)
	..()

/datum/reagent/nitryl
	name = "Nitryl"
	description = "A highly reactive gas that makes you feel faster."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5 // Because stimulum/nitryl are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "burning"
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/nitryl/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(type, update=TRUE, priority=100, multiplicative_slowdown=-1, blacklisted_movetypes=(FLYING|FLOATING))

/datum/reagent/nitryl/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(type)
	..()

/datum/reagent/freon
	name = "Freon"
	description = "A powerful heat absorbent."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5 // Because stimulum/nitryl/freon/hypernoblium are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "burning"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/freon/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/freon)

/datum/reagent/freon/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/freon)
	return ..()

/datum/reagent/hypernoblium
	name = "Hyper-Noblium"
	description = "A suppressive gas that stops gas reactions on those who inhale it."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5 // Because stimulum/nitryl/freon/hyper-nob are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "searingly cold"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/hypernoblium/on_mob_metabolize(mob/living/L)
	. = ..()
	if(isplasmaman(L))
		ADD_TRAIT(L, TRAIT_NOFIRE, type)

/datum/reagent/hypernoblium/on_mob_end_metabolize(mob/living/L)
	if(isplasmaman(L))
		REMOVE_TRAIT(L, TRAIT_NOFIRE, type)
	return ..()

/datum/reagent/healium
	name = "Healium"
	description = "A powerful sleeping agent with healing properties"
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5
	color = "90560B"
	taste_description = "rubbery"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/healium/on_mob_metabolize(mob/living/L)
	. = ..()
	L.PermaSleeping()

/datum/reagent/healium/on_mob_end_metabolize(mob/living/L)
	L.SetSleeping(10)
	return ..()

/datum/reagent/healium/on_mob_life(mob/living/L)
	. = ..()
	L.adjustFireLoss(-2, FALSE)
	L.adjustToxLoss(-5, FALSE)
	L.adjustBruteLoss(-2, FALSE)

/datum/reagent/halon
	name = "Halon"
	description = "A fire suppression gas that removes oxygen and cools down the area"
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5
	color = "90560B"
	taste_description = "minty"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/halon/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/halon)
	ADD_TRAIT(L, TRAIT_RESISTHEAT, type)

/datum/reagent/halon/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/halon)
	REMOVE_TRAIT(L, TRAIT_RESISTHEAT, type)
	return ..()

/////////////////////////Colorful Powder////////////////////////////
//For colouring in /proc/mix_color_from_reagents

/datum/reagent/colorful_reagent/powder
	name = "Mundane Powder" //the name's a bit similar to the name of colorful reagent, but hey, they're practically the same chem anyway
	var/colorname = "none"
	description = "A powder that is used for coloring things."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 207, 54, 0
	taste_description = "the back of class"

/datum/reagent/colorful_reagent/powder/New()
	if(colorname == "none")
		description = "A rather mundane-looking powder. It doesn't look like it'd color much of anything."
	else if(colorname == "invisible")
		description = "An invisible powder. Unfortunately, since it's invisible, it doesn't look like it'd color much of anything."
	else
		description = "\An [colorname] powder, used for coloring things [colorname]."

/datum/reagent/colorful_reagent/powder/red
	name = "Red Powder"
	colorname = "red"
	color = "#DA0000" // red
	random_color_list = list("#FC7474")
	ph = 0.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/orange
	name = "Orange Powder"
	colorname = "orange"
	color = "#FF9300" // orange
	random_color_list = list("#FF9300")
	ph = 2

/datum/reagent/colorful_reagent/powder/yellow
	name = "Yellow Powder"
	colorname = "yellow"
	color = "#FFF200" // yellow
	random_color_list = list("#FFF200")
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/green
	name = "Green Powder"
	colorname = "green"
	color = "#A8E61D" // green
	random_color_list = list("#A8E61D")
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/blue
	name = "Blue Powder"
	colorname = "blue"
	color = "#00B7EF" // blue
	random_color_list = list("#71CAE5")
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/purple
	name = "Purple Powder"
	colorname = "purple"
	color = "#DA00FF" // purple
	random_color_list = list("#BD8FC4")
	ph = 13
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/invisible
	name = "Invisible Powder"
	colorname = "invisible"
	color = "#FFFFFF00" // white + no alpha
	random_color_list = list(null)	//because using the powder color turns things invisible
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/black
	name = "Black Powder"
	colorname = "black"
	color = "#1C1C1C" // not quite black
	random_color_list = list("#8D8D8D")	//more grey than black, not enough to hide your true colors
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/white
	name = "White Powder"
	colorname = "white"
	color = "#FFFFFF" // white
	random_color_list = list("#FFFFFF") //doesn't actually change appearance at all
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

 /* used by crayons, can't color living things but still used for stuff like food recipes */

/datum/reagent/colorful_reagent/powder/red/crayon
	name = "Red Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/orange/crayon
	name = "Orange Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/yellow/crayon
	name = "Yellow Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/green/crayon
	name = "Green Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/blue/crayon
	name = "Blue Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/purple/crayon
	name = "Purple Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

//datum/reagent/colorful_reagent/powder/invisible/crayon

/datum/reagent/colorful_reagent/powder/black/crayon
	name = "Black Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent/powder/white/crayon
	name = "White Crayon Powder"
	can_colour_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

//////////////////////////////////Hydroponics stuff///////////////////////////////

/datum/reagent/plantnutriment
	name = "Generic nutriment"
	description = "Some kind of nutriment. You can't really tell what it is. You should probably report it, along with how you obtained it."
	color = "#000000" // RBG: 0, 0, 0
	var/tox_prob = 0
	taste_description = "plant food"
	ph = 3

/datum/reagent/plantnutriment/on_mob_life(mob/living/carbon/M)
	if(prob(tox_prob))
		M.adjustToxLoss(1*REM, 0)
		. = 1
	..()

/datum/reagent/plantnutriment/eznutriment
	name = "E-Z-Nutrient"
	description = "Cheap and extremely common type of plant nutriment."
	color = "#376400" // RBG: 50, 100, 0
	tox_prob = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/plantnutriment/left4zednutriment
	name = "Left 4 Zed"
	description = "Unstable nutriment that makes plants mutate more often than usual."
	color = "#1A1E4D" // RBG: 26, 30, 77
	tox_prob = 25
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/plantnutriment/robustharvestnutriment
	name = "Robust Harvest"
	description = "Very potent nutriment that prevents plants from mutating."
	color = "#9D9D00" // RBG: 157, 157, 0
	tox_prob = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/plantnutriment/endurogrow
	name = "Enduro Grow"
	description = "A specialized nutriment, which decreases product quantity and potency, but strengthens the plants endurance."
	color = "#a06fa7" // RBG: 160, 111, 167
	tox_prob = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/plantnutriment/liquidearthquake
	name = "Liquid Earthquake"
	description = "A specialized nutriment, which increases the plant's production speed, as well as it's susceptibility to weeds."
	color = "#912e00" // RBG: 145, 46, 0
	tox_prob = 25
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED



// GOON OTHERS



/datum/reagent/oil
	name = "Oil"
	description = "Burns in a small smoky fire, mostly used to get Ash."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "oil"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/stable_plasma
	name = "Stable Plasma"
	description = "Non-flammable plasma locked into a liquid form that cannot ignite or become gaseous/solid."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "bitterness"
	taste_mult = 1.5
	process_flags = ORGANIC | SYNTHETIC
	random_unrestricted = FALSE
	ph = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/stable_plasma/on_mob_life(mob/living/carbon/C)
	C.adjustPlasma(10)
	..()

/datum/reagent/iodine
	name = "Iodine"
	description = "Commonly added to table salt as a nutrient. On its own it tastes far less pleasing."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "metal"
	random_unrestricted = FALSE
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet
	name = "Carpet"
	description = "For those that need a more creative way to roll out a red carpet."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "carpet" // Your tounge feels furry.
	var/carpet_type = /turf/open/floor/carpet
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/expose_turf(turf/exposed_turf, reac_volume)
	if(isplatingturf(exposed_turf) || istype(exposed_turf, /turf/open/floor/iron))
		var/turf/open/floor/target_floor = exposed_turf
		target_floor.PlaceOnTop(carpet_type, flags = CHANGETURF_INHERIT_AIR)
	..()

/datum/reagent/carpet/black
	name = "Black Carpet"
	description = "The carpet also comes in... BLAPCK" //yes, the typo is intentional
	color = "#1E1E1E"
	taste_description = "licorice"
	carpet_type = /turf/open/floor/carpet/black
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/blue
	name = "Blue Carpet"
	description = "For those that really need to chill out for a while."
	color = "#0000DC"
	taste_description = "frozen carpet"
	carpet_type = /turf/open/floor/carpet/blue
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/cyan
	name = "Cyan Carpet"
	description = "For those that need a throwback to the years of using poison as a construction material. Smells like asbestos."
	color = "#00B4FF"
	taste_description = "asbestos"
	carpet_type = /turf/open/floor/carpet/cyan
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/green
	name = "Green Carpet"
	description = "For those that need the perfect flourish for green eggs and ham."
	color = "#A8E61D"
	taste_description = "Green" //the caps is intentional
	carpet_type = /turf/open/floor/carpet/green
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/orange
	name = "Orange Carpet"
	description = "For those that prefer a healthy carpet to go along with their healthy diet."
	color = "#E78108"
	taste_description = "orange juice"
	carpet_type = /turf/open/floor/carpet/orange
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/purple
	name = "Purple Carpet"
	description = "For those that need to waste copious amounts of healing jelly in order to look fancy."
	color = "#91D865"
	taste_description = "jelly"
	carpet_type = /turf/open/floor/carpet/purple
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/red
	name = "Red Carpet"
	description = "For those that need an even redder carpet."
	color = "#731008"
	taste_description = "blood and gibs"
	carpet_type = /turf/open/floor/carpet/red
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/royal
	name = "Royal Carpet?"
	description = "For those that break the game and need to make an issue report."

/datum/reagent/carpet/royal/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(isplatingturf(T) || istype(T, /turf/open/floor/plasteel))
		var/turf/open/floor/F = T
		F.PlaceOnTop(/turf/open/floor/carpet, flags = CHANGETURF_INHERIT_AIR)

		// The quartermaster, as a semi-head, has a "pretender royal" metabolism
		else if(HAS_TRAIT(liver, TRAIT_PRETENDER_ROYAL_METABOLISM))
			if(prob(15))
				to_chat(M, "You feel like an impostor...")

/datum/reagent/carpet/royal/black
	name = "Royal Black Carpet"
	description = "For those that feel the need to show off their timewasting skills."
	color = "#000000"
	taste_description = "royalty"
	carpet_type = /turf/open/floor/carpet/royalblack
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/carpet/royal/blue
	name = "Royal Blue Carpet"
	description = "For those that feel the need to show off their timewasting skills.. in BLUE."
	color = "#5A64C8"
	taste_description = "blueyalty" //also intentional
	carpet_type = /turf/open/floor/carpet/royalblue
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/bromine
	name = "Bromine"
	description = "A brownish liquid that's highly reactive. Useful for stopping free radicals, but not intended for human consumption."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "chemicals"
	ph = 7.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/pentaerythritol
	name = "Pentaerythritol"
	description = "Slow down, it ain't no spelling bee!"
	reagent_state = SOLID
	color = "#E66FFF"
	taste_description = "acid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/acetaldehyde
	name = "Acetaldehyde"
	description = "Similar to plastic. Tastes like dead people."
	reagent_state = SOLID
	color = "#EEEEEF"
	taste_description = "dead people" //made from formaldehyde, ya get da joke ?
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/acetone_oxide
	name = "Acetone oxide"
	description = "Enslaved oxygen"
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "acid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/acetone_oxide/expose_mob(mob/living/M, methods=TOUCH, reac_volume)//Splashing people kills people!
	if(!istype(M))
		return
	if(methods & TOUCH)
		M.adjustFireLoss(2, FALSE) // burns,
		M.adjust_fire_stacks((reac_volume / 10))
	..()



/datum/reagent/phenol
	name = "Phenol"
	description = "An aromatic ring of carbon with a hydroxyl group. A useful precursor to some medicines, but has no healing properties on its own."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "acid"
	random_unrestricted = FALSE
	ph = 5.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/ash
	name = "Ash"
	description = "Phoenixes supposedly rise from this, but you've never seen it."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "ash"
	random_unrestricted = FALSE
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/acetone
	name = "Acetone"
	description = "A slick liquid with carcinogenic properties. Has a multitude of mundane uses in everyday life."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "acid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/colorful_reagent
	name = "Colorful Reagent"
	description = "Thoroughly sample the rainbow."
	reagent_state = LIQUID
	color = "#C8A5DC"
	var/list/random_color_list = list("#00aedb","#a200ff","#f47835","#d41243","#d11141","#00b159","#00aedb","#f37735","#ffc425","#008744","#0057e7","#d62d20","#ffa700")
	taste_description = "rainbows"
	var/can_colour_mobs = TRUE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/colorful_reagent/on_mob_life(mob/living/carbon/M)
	if(can_colour_mobs)
		M.add_atom_colour(pick(random_color_list), WASHABLE_COLOUR_PRIORITY)
	return ..()

/// Colors anything it touches a random color.
/datum/reagent/colorful_reagent/expose_atom(mob/living/M, reac_volume)
	if(can_colour_mobs)
		M.add_atom_colour(pick(random_color_list), WASHABLE_COLOUR_PRIORITY)
	..()

/datum/reagent/colorful_reagent/expose_obj(obj/O, reac_volume)
	if(O)
		O.add_atom_colour(pick(random_color_list), WASHABLE_COLOUR_PRIORITY)
	..()

/datum/reagent/colorful_reagent/expose_turf(turf/T, reac_volume)
	if(T)
		T.add_atom_colour(pick(random_color_list), WASHABLE_COLOUR_PRIORITY)
	..()

/datum/reagent/hair_dye
	name = "Quantum Hair Dye"
	description = "Has a high chance of making you look like a mad scientist."
	reagent_state = LIQUID
	color = "#C8A5DC"
	var/list/potential_colors = list("0ad","a0f","f73","d14","d14","0b5","0ad","f73","fc2","084","05e","d22","fa0") // fucking hair code
	taste_description = "sourness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/hair_dye/New()
	SSticker.OnRoundstart(CALLBACK(src,.proc/UpdateColor))
	return ..()

/datum/reagent/hair_dye/proc/UpdateColor()
	color = pick(potential_colors)

/datum/reagent/hair_dye/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_mob))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	exposed_human.hair_color = pick(potential_colors)
	exposed_human.facial_hair_color = pick(potential_colors)
	exposed_human.update_hair()

/datum/reagent/barbers_aid
	name = "Barber's Aid"
	description = "A solution to hair loss across the world."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "sourness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/barbers_aid/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=FALSE)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_mob))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	var/datum/sprite_accessory/hair/picked_hair = pick(GLOB.hair_styles_list)
	var/datum/sprite_accessory/facial_hair/picked_beard = pick(GLOB.facial_hair_styles_list)
	to_chat(exposed_human, "<span class='notice'>Hair starts sprouting from your scalp.</span>")
	exposed_human.hair_style = picked_hair
	exposed_human.facial_hair_style = picked_beard
	exposed_human.update_hair()

/datum/reagent/concentrated_barbers_aid
	name = "Concentrated Barber's Aid"
	description = "A concentrated solution to hair loss across the world."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "sourness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/concentrated_barbers_aid/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_mob))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	to_chat(exposed_human, "<span class='notice'>Your hair starts growing at an incredible speed!</span>")
	exposed_human.hair_style = "Very Long Hair"
	exposed_human.facial_hair_style = "Beard (Very Long)"
	exposed_human.update_hair()

/datum/reagent/baldium
	name = "Baldium"
	description = "A major cause of hair loss across the world."
	reagent_state = LIQUID
	color = "#ecb2cf"
	taste_description = "bitterness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/baldium/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=FALSE)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_mob))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	to_chat(exposed_human, "<span class='danger'>Your hair is falling out in clumps!</span>")
	exposed_human.hairstyle = "Bald"
	exposed_human.facial_hairstyle = "Shaved"
	exposed_human.update_hair()

/datum/reagent/saltpetre
	name = "Saltpetre"
	description = "A fairly innocuous chemical which can be used to improve the potency of various plant species."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	taste_description = "cool salt"
	random_unrestricted = FALSE
	ph = 11.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/lye
	name = "Lye"
	description = "Also known as sodium hydroxide. As a profession, making this is somewhat underwhelming."
	reagent_state = LIQUID
	color = "#FFFFD6" // very very light yellow
	taste_description = "acid"
	random_unrestricted = FALSE
	ph = 11.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drying_agent
	name = "Drying agent"
	description = "A desiccant. Can be used to dry things."
	reagent_state = LIQUID
	color = "#A70FFF"
	taste_description = "dryness"
	random_unrestricted = FALSE
	ph = 10.7
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/drying_agent/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	exposed_turf.MakeDry(ALL, TRUE, reac_volume * 5 SECONDS) //50 deciseconds per unit

/datum/reagent/drying_agent/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	if(exposed_obj.type != /obj/item/clothing/shoes/galoshes)
		return
	var/t_loc = get_turf(exposed_obj)
	qdel(exposed_obj)
	new /obj/item/clothing/shoes/galoshes/dry(t_loc)

// Virology virus food chems.

/datum/reagent/toxin/mutagen/mutagenvirusfood
	name = "Mutagenic Agar"
	color = "#A3C00F" // rgb: 163,192,15
	taste_description = "sourness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/toxin/mutagen/mutagenvirusfood/sugar
	name = "Sucrose Agar"
	color = "#41B0C0" // rgb: 65,176,192
	taste_description = "sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/medicine/synaptizine/synaptizinevirusfood
	name = "Virus Rations"
	color = "#D18AA5" // rgb: 209,138,165
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/toxin/plasma/plasmavirusfood
	name = "Virus Plasma"
	color = "#A69DA9" // rgb: 166,157,169
	taste_description = "bitterness"
	taste_mult = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/toxin/plasma/plasmavirusfood/weak
	name = "Weakened Virus Plasma"
	color = "#CEC3C6" // rgb: 206,195,198
	taste_description = "bitterness"
	taste_mult = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/uranium/uraniumvirusfood
	name = "Decaying Uranium Gel"
	color = "#67ADBA" // rgb: 103,173,186
	taste_description = "the inside of a reactor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/uranium/uraniumvirusfood/unstable
	name = "Unstable Uranium Gel"
	color = "#2FF2CB" // rgb: 47,242,203
	taste_description = "the inside of a reactor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/uranium/uraniumvirusfood/stable
	name = "Stable Uranium Gel"
	color = "#04506C" // rgb: 4,80,108
	taste_description = "the inside of a reactor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/laughter/laughtervirusfood
	name = "Anomolous Virus Food"
	color = "#ffa6ff" //rgb: 255,166,255
	taste_description = "a bad idea"

/datum/reagent/consumable/virus_food/advvirusfood
	name = "Highly Unstable Virus Food"
	color = "#ffffff" //rgb: 255,255,255 ITS PURE WHITE CMON
	taste_description = "an EXTREMELY bad idea"
	can_synth = FALSE

/datum/reagent/consumable/virus_food/viralbase
	name = "Experimental Viral Base"
	description = "Recently discovered by Nanotrasen's top scientists after years of research, this substance can be used as the base for extremely rare and extremely dangerous viruses once exposed to uranium."
	color = "#fff0da"
	taste_description = "tears of scientists"
	can_synth = FALSE

// Bee chemicals

/datum/reagent/royal_bee_jelly
	name = "Royal Bee Jelly"
	description = "Royal Bee Jelly, if injected into a Queen Space Bee said bee will split into two bees."
	color = "#00ff80"
	taste_description = "strange honey"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/royal_bee_jelly/on_mob_life(mob/living/carbon/M)
	if(prob(2))
		M.say(pick("Bzzz...","BZZ BZZ","Bzzzzzzzzzzz..."), forced = "royal bee jelly")
	..()

//Misc reagents

/datum/reagent/romerol
	name = "Romerol"
	// the REAL zombie powder
	description = "Romerol is a highly experimental bioterror agent \
		which causes dormant nodules to be etched into the grey matter of \
		the subject. These nodules only become active upon death of the \
		host, upon which, the secondary structures activate and take control \
		of the host body."
	color = "#123524" // RGB (18, 53, 36)
	metabolization_rate = INFINITY
	taste_description = "brains"
	ph = 0.5

/datum/reagent/romerol/expose_mob(mob/living/carbon/human/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	// Silently add the zombie infection organ to be activated upon death
	if(!exposed_mob.getorganslot(ORGAN_SLOT_ZOMBIE))
		var/obj/item/organ/zombie_infection/nodamage/ZI = new()
		ZI.Insert(exposed_mob)

/datum/reagent/magillitis
	name = "Magillitis"
	description = "An experimental serum which causes rapid muscular growth in Hominidae. Side-affects may include hypertrichosis, violent outbursts, and an unending affinity for bananas."
	reagent_state = LIQUID
	color = "#00f041"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/magillitis/on_mob_life(mob/living/carbon/M)
	..()
	if((ismonkey(M) || ishuman(M)) && current_cycle >= 10)
		M.gorillize()

/datum/reagent/growthserum
	name = "Growth Serum"
	description = "A commercial chemical designed to help older men in the bedroom."//not really it just makes you a giant
	color = "#ff0000"//strong red. rgb 255, 0, 0
	var/current_size = RESIZE_DEFAULT_SIZE
	taste_description = "bitterness" // apparently what viagra tastes like
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/growthserum/on_mob_life(mob/living/carbon/H)
	var/newsize = current_size
	switch(volume)
		if(0 to 19)
			newsize = 1.25*RESIZE_DEFAULT_SIZE
		if(20 to 49)
			newsize = 1.5*RESIZE_DEFAULT_SIZE
		if(50 to 99)
			newsize = 2*RESIZE_DEFAULT_SIZE
		if(100 to 199)
			newsize = 2.5*RESIZE_DEFAULT_SIZE
		if(200 to INFINITY)
			newsize = 3.5*RESIZE_DEFAULT_SIZE

	H.resize = newsize/current_size
	current_size = newsize
	H.update_transform()
	..()

/datum/reagent/growthserum/on_mob_end_metabolize(mob/living/M)
	M.resize = RESIZE_DEFAULT_SIZE/current_size
	current_size = RESIZE_DEFAULT_SIZE
	M.update_transform()
	..()

/datum/reagent/plastic_polymers
	name = "Plastic Polymers"
	description = "The petroleum-based components of plastic."
	color = "#f7eded"
	taste_description = "plastic"
	random_unrestricted = FALSE
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/glitter
	name = "Generic Glitter"
	description = "If you can see this description, contact a coder."
	color = "#FFFFFF" //pure white
	taste_description = "plastic"
	reagent_state = SOLID
	var/glitter_type = /obj/effect/decal/cleanable/glitter
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/glitter/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	new glitter_type(exposed_turf)

/datum/reagent/glitter/pink
	name = "Pink Glitter"
	description = "Pink sparkles that get everywhere."
	color = "#ff8080" //A light pink color
	glitter_type = /obj/effect/decal/cleanable/glitter/pink
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/glitter/white
	name = "White Glitter"
	description = "White sparkles that get everywhere."
	glitter_type = /obj/effect/decal/cleanable/glitter/white
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/glitter/blue
	name = "Blue Glitter"
	description = "Blue sparkles that get everywhere."
	color = "#4040FF" //A blueish color
	glitter_type = /obj/effect/decal/cleanable/glitter/blue
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/pax
	name = "Pax"
	description = "A colorless liquid that suppresses violent urges in its subjects."
	color = "#AAAAAA55"
	taste_description = "water"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	ph = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/pax/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_PACIFISM, type)

/datum/reagent/pax/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PACIFISM, type)
	..()

/datum/reagent/bz_metabolites
	name = "BZ metabolites"
	description = "A harmless metabolite of BZ gas."
	color = "#FAFF00"
	taste_description = "acrid cinnamon"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/bz_metabolites/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, CHANGELING_HIVEMIND_MUTE, type)

/datum/reagent/bz_metabolites/on_mob_end_metabolize(mob/living/L)
	..()
	REMOVE_TRAIT(L, CHANGELING_HIVEMIND_MUTE, type)

/datum/reagent/bz_metabolites/on_mob_life(mob/living/L)
	if(L.mind)
		var/datum/antagonist/changeling/changeling = L.mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling)
			changeling.chem_charges = max(changeling.chem_charges-2, 0)
	return ..()

/datum/reagent/pax/peaceborg
	name = "Synthpax"
	description = "A colorless liquid that suppresses violent urges in its subjects. Cheaper to synthesize than normal Pax, but wears off faster."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/peaceborg
	can_synth = FALSE
	random_unrestricted = FALSE

/datum/reagent/peaceborg/confuse
	name = "Dizzying Solution"
	description = "Makes the target off balance and dizzy."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "dizziness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/peaceborg/confuse/on_mob_life(mob/living/carbon/M)
	if(M.confused < 6)
		M.confused = CLAMP(M.confused + 3, 0, 5)
	if(M.dizziness < 6)
		M.dizziness = CLAMP(M.dizziness + 3, 0, 5)
	if(prob(20))
		to_chat(M, "You feel confused and disorientated.")
	..()

/datum/reagent/peaceborg/inabizine
	name = "Inabizine"
	description = "Induces muscle relaxation, which makes holding objects and standing difficult."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "relaxing"

/datum/reagent/peaceborg/inabizine/on_mob_life(mob/living/carbon/M)
	if(prob(33))
		M.Stun(20, 0)
		M.blur_eyes(5)
	if(prob(33))
		M.Knockdown(2 SECONDS)
	if(prob(20))
		to_chat(M, "Your muscles relax...")
	..()

/datum/reagent/peaceborg/tire
	name = "Tiring Solution"
	description = "An very mild stamina toxin that wears out the target. Completely harmless."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "tiredness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/peaceborg/tire/on_mob_life(mob/living/carbon/M)
	var/healthcomp = (100 - M.health)	//DOES NOT ACCOUNT FOR ADMINBUS THINGS THAT MAKE YOU HAVE MORE THAN 200/210 HEALTH, OR SOMETHING OTHER THAN A HUMAN PROCESSING THIS.
	if(M.getStaminaLoss() < (45 - healthcomp))	//At 50 health you would have 200 - 150 health meaning 50 compensation. 60 - 50 = 10, so would only do 10-19 stamina.)
		M.adjustStaminaLoss(10)
	if(prob(30))
		to_chat(M, "You should sit down and take a rest...")
	..()

/datum/reagent/tranquility
	name = "Tranquility"
	description = "A highly mutative liquid of unknown origin."
	color = "#9A6750" //RGB: 154, 103, 80
	taste_description = "inner peace"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	penetrates_skin = NONE

/datum/reagent/tranquility/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/gondola(), FALSE, TRUE)

/datum/reagent/liquidadamantine
	name = "Liquid Adamantine"
	description = "A legengary lifegiving metal liquified."
	color = "#10cca6" //RGB: 16, 204, 166
	taste_description = "lifegiiving metal"
	can_synth = FALSE
	random_unrestricted = FALSE

/datum/reagent/spider_extract
	name = "Spider Extract"
	description = "A highly specialized extract coming from the Australicus sector, used to create broodmother spiders."
	color = "#ED2939"
	taste_description = "upside down"

/// Improvised reagent that induces vomiting. Created by dipping a dead mouse in welder fluid.
/datum/reagent/yuck
	name = "Organic Slurry"
	description = "A mixture of various colors of fluid. Induces vomiting."
	glass_name = "glass of ...yuck!"
	glass_desc = "It smells like a carcass, and doesn't look much better."
	color = "#545000"
	taste_description = "insides"
	taste_mult = 4
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	var/yuck_cycle = 0 //! The `current_cycle` when puking starts.

/datum/reagent/yuck/on_mob_add(mob/living/L)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_NOHUNGER)) //they can't puke
		holder.del_reagent(type)

#define YUCK_PUKE_CYCLES 3 		// every X cycle is a puke
#define YUCK_PUKES_TO_STUN 3 	// hit this amount of pukes in a row to start stunning
/datum/reagent/yuck/on_mob_life(mob/living/carbon/C)
	if(!yuck_cycle)
		if(prob(8))
			var/dread = pick("Something is moving in your stomach...", \
				"A wet growl echoes from your stomach...", \
				"For a moment you feel like your surroundings are moving, but it's your stomach...")
			to_chat(C, "<span class='userdanger'>[dread]</span>")
			yuck_cycle = current_cycle
	else
		var/yuck_cycles = current_cycle - yuck_cycle
		if(yuck_cycles % YUCK_PUKE_CYCLES == 0)
			if(yuck_cycles >= YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN)
				holder.remove_reagent(type, 5)
			C.vomit(rand(14, 26), stun = yuck_cycles >= YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN)
	if(holder)
		return ..()
#undef YUCK_PUKE_CYCLES
#undef YUCK_PUKES_TO_STUN

/datum/reagent/yuck/on_mob_end_metabolize(mob/living/L)
	yuck_cycle = 0 // reset vomiting
	return ..()

/datum/reagent/yuck/on_transfer(atom/A, methods=TOUCH, trans_volume)
	if((methods & INGEST) || !iscarbon(A))
		return ..()

	A.reagents.remove_reagent(type, trans_volume)
	A.reagents.add_reagent(/datum/reagent/fuel, trans_volume * 0.75)
	A.reagents.add_reagent(/datum/reagent/water, trans_volume * 0.25)

	return ..()

//monkey powder heehoo
/datum/reagent/monkey_powder
	name = "Monkey Powder"
	description = "Just add water!"
	color = "#9C5A19"
	taste_description = "bananas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/plasma_oxide
	name = "Hyper-Plasmium Oxide"
	description = "Compound created deep in the cores of demon-class planets. Commonly found through deep geysers."
	color = "#470750" // rgb: 255, 255, 255
	taste_description = "hell"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/exotic_stabilizer
	name = "Exotic Stabilizer"
	description = "Advanced compound created by mixing stabilizing agent and hyper-plasmium oxide."
	color = "#180000" // rgb: 255, 255, 255
	taste_description = "blood"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/wittel
	name = "Wittel"
	description = "An extremely rare metallic-white substance only found on demon-class planets."
	color = "#FFFFFF" // rgb: 255, 255, 255
	taste_mult = 0 // oderless and tasteless
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/metalgen
	name = "Metalgen"
	data = list("material"=null)
	description = "A purple metal morphic liquid, said to impose it's metallic properties on whatever it touches."
	color = "#b000aa"
	taste_mult = 0 // oderless and tasteless
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	/// The material flags used to apply the transmuted materials
	var/applied_material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	/// The amount of materials to apply to the transmuted objects if they don't contain materials
	var/default_material_amount = 100

/datum/reagent/metalgen/expose_obj(obj/exposed_obj, volume)
	. = ..()
	metal_morph(exposed_obj)

/datum/reagent/metalgen/expose_turf(turf/exposed_turf, volume)
	. = ..()
	metal_morph(exposed_turf)

///turn an object into a special material
/datum/reagent/metalgen/proc/metal_morph(atom/A)
	var/metal_ref = data["material"]
	if(!metal_ref)
		return

	var/metal_amount = 0
	var/list/materials_to_transmute = A.get_material_composition(BREAKDOWN_INCLUDE_ALCHEMY)
	for(var/metal_key in materials_to_transmute) //list with what they're made of
		metal_amount += materials_to_transmute[metal_key]

	if(!metal_amount)
		metal_amount = default_material_amount //some stuff doesn't have materials at all. To still give them properties, we give them a material. Basically doesn't exist

	var/list/metal_dat = list((metal_ref) = metal_amount)
	A.material_flags = applied_material_flags
	A.set_custom_materials(metal_dat)
	ADD_TRAIT(A, TRAIT_MAT_TRANSMUTED, type)

/datum/reagent/gravitum
	name = "Gravitum"
	description = "A rare kind of null fluid, capable of temporalily removing all weight of whatever it touches." //i dont even
	color = "#050096" // rgb: 5, 0, 150
	taste_mult = 0 // oderless and tasteless
	metabolization_rate = 0.1 * REAGENTS_METABOLISM //20 times as long, so it's actually viable to use
	var/time_multiplier = 1 MINUTES //1 minute per unit of gravitum on objects. Seems overpowered, but the whole thing is very niche
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/gravitum/expose_obj(obj/exposed_obj, volume)
	. = ..()
	exposed_obj.AddElement(/datum/element/forced_gravity, 0)
	addtimer(CALLBACK(exposed_obj, .proc/_RemoveElement, list(/datum/element/forced_gravity, 0)), volume * time_multiplier)

/datum/reagent/gravitum/on_mob_add(mob/living/L)
	L.AddElement(/datum/element/forced_gravity, 0) //0 is the gravity, and in this case weightless
	return ..()

/datum/reagent/gravitum/on_mob_end_metabolize(mob/living/L)
	L.RemoveElement(/datum/element/forced_gravity, 0)

/datum/reagent/cellulose
	name = "Cellulose Fibers"
	description = "A crystaline polydextrose polymer, plants swear by this stuff."
	reagent_state = SOLID
	color = "#E6E6DA"
	taste_mult = 0
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/gravy
	name = "Gravy"
	description = "A mixture of flour, water, and the juices of cooked meat."
	taste_description = "gravy"
	color = "#623301"
	taste_mult = 1.2

/datum/reagent/eldritch //unholy water, but for eldritch cultists. why couldn't they have both just used the same reagent? who knows. maybe nar'sie is considered to be too "mainstream" of a god to worship in the cultist community.
	name = "Eldritch Essence"
	description = "A strange liquid that defies the laws of physics. It re-energizes and heals those who can see beyond this fragile reality, but is incredibly harmful to the closed-minded. It metabolizes very quickly."
	taste_description = "Ag'hsj'saje'sh"
	color = "#1f8016"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM  //1u/tick
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/eldritch/on_mob_life(mob/living/carbon/M)
	if(IS_HERETIC(M))
		M.drowsyness = max(M.drowsyness-5, 0)
		M.AdjustAllImmobility(-40, FALSE)
		M.adjustStaminaLoss(-10, FALSE)
		M.adjustToxLoss(-2, FALSE)
		M.adjustOxyLoss(-2, FALSE)
		M.adjustBruteLoss(-2, FALSE)
		M.adjustFireLoss(-2, FALSE)
		if(ishuman(M) && M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume += 3
	else
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3, 150)
		M.adjustToxLoss(2, FALSE)
		M.adjustFireLoss(2, FALSE)
		M.adjustOxyLoss(2, FALSE)
		M.adjustBruteLoss(2, FALSE)
	return ..()

/datum/reagent/consumable/ratlight
	name = "Ratvarian Light"
	description = "A special concoction said to have been blessed by an ancient god. Makes the consumer glow with literal enlightenment."
	color = "#B5A642"
	taste_description = "enlightenment"
	metabolization_rate = 0.8 * REAGENTS_METABOLISM
	var/datum/language_holder/prev_language

/datum/reagent/consumable/ratlight/expose_mob(mob/living/M)
	M.set_light(2)
	..()

/datum/reagent/universal_indicator
	name = "Universal indicator"
	description = "A solution that can be used to create pH paper booklets, or sprayed on things to colour them by their pH."
	taste_description = "a strong chemical taste"
	color = "#1f8016"

//Colours things by their pH
/datum/reagent/universal_indicator/expose_atom(atom/exposed_atom, reac_volume)
	. = ..()
	if(exposed_atom.reagents)
		var/color
		CONVERT_PH_TO_COLOR(exposed_atom.reagents.ph, color)
		exposed_atom.add_atom_colour(color, WASHABLE_COLOUR_PRIORITY)
