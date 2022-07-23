
/datum/reagent/thermite
	name = "Thermite"
	description = "Thermite produces an aluminothermic reaction known as a thermite reaction. Can be used to melt walls."
	reagent_state = SOLID
	color = "#550000"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "sweet tasting metal"
	process_flags = ORGANIC | SYNTHETIC

/datum/reagent/thermite/reaction_turf(turf/T, reac_volume)
	if(reac_volume >= 1)
		T.AddComponent(/datum/component/thermite, reac_volume)

/datum/reagent/thermite/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(1, 0)
	..()
	return TRUE

/datum/reagent/nitroglycerin
	name = "Nitroglycerin"
	description = "Nitroglycerin is a heavy, colorless, oily, explosive liquid obtained by nitrating glycerol."
	color = "#808080" // rgb: 128, 128, 128
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "oil"

/datum/reagent/stabilizing_agent
	name = "Stabilizing Agent"
	description = "Keeps unstable chemicals stable. This does not work on everything."
	reagent_state = LIQUID
	color = "#FFFF00"
	chem_flags = NONE
	taste_description = "metal"

/datum/reagent/clf3
	name = "Chlorine Trifluoride"
	description = "Makes a temporary 3x3 fireball when it comes into existence, so be careful when mixing. ClF3 applied to a surface burns things that wouldn't otherwise burn, sometimes through the very floors of the station and exposing it to the vacuum of space."
	reagent_state = LIQUID
	color = "#FFC8C8"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	metabolization_rate = 4
	taste_description = "burning"
	process_flags = ORGANIC | SYNTHETIC

/datum/reagent/clf3/on_mob_life(mob/living/carbon/M)
	M.adjust_fire_stacks(2)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg, 0)
	..()
	return TRUE

/datum/reagent/clf3/reaction_turf(turf/T, reac_volume)
	if(isplatingturf(T))
		var/turf/open/floor/plating/F = T
		if(prob(10 + F.burnt + 5*F.broken)) //broken or burnt plating is more susceptible to being destroyed
			F.ex_act(EXPLODE_DEVASTATE)
	if(isfloorturf(T))
		var/turf/open/floor/F = T
		if(prob(reac_volume))
			F.make_plating()
		else if(prob(reac_volume))
			F.burn_tile()
		if(isfloorturf(F))
			for(var/turf/open/turf in RANGE_TURFS(1,F))
				if(!locate(/obj/effect/hotspot) in turf)
					new /obj/effect/hotspot(F)
	if(iswallturf(T))
		var/turf/closed/wall/W = T
		if(prob(reac_volume))
			W.ex_act(EXPLODE_DEVASTATE)

/datum/reagent/clf3/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(istype(M))
		if(method != INGEST && method != INJECT)
			M.adjust_fire_stacks(min(reac_volume/5, 10))
			M.IgniteMob()
			if(!locate(/obj/effect/hotspot) in M.loc)
				new /obj/effect/hotspot(M.loc)

/datum/reagent/sorium
	name = "Sorium"
	description = "Sends everything flying from the detonation point."
	reagent_state = LIQUID
	color = "#5A64C8"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "air and bitterness"

/datum/reagent/liquid_dark_matter
	name = "Liquid Dark Matter"
	description = "Sucks everything into the detonation point."
	reagent_state = LIQUID
	color = "#210021"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "compressed bitterness"

/datum/reagent/blackpowder
	name = "Black Powder"
	description = "Explodes. Violently."
	reagent_state = LIQUID
	color = "#000000"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	metabolization_rate = 0.05
	taste_description = "salt"

/datum/reagent/blackpowder/on_mob_life(mob/living/carbon/M)
	..()
	if(isplasmaman(M))
		M.hallucination += 5

/datum/reagent/blackpowder/on_ex_act()
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(1 + round(volume/6, 1), location, 0, 0, message = 0)
	e.start()
	holder.clear_reagents()

/datum/reagent/flash_powder
	name = "Flash Powder"
	description = "Makes a very bright flash."
	reagent_state = LIQUID
	color = "#C8C8C8"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "salt"

/datum/reagent/smoke_powder
	name = "Smoke Powder"
	description = "Makes a large cloud of smoke that can carry reagents."
	reagent_state = LIQUID
	color = "#C8C8C8"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "smoke"

/datum/reagent/smoke_powder/ez
	name = "EZ Smoke Powder"
	description = "A special variant of smoke powder that only activates when mixed with smoke powder activator."

/datum/reagent/smoke_powder_activator
	name = "EZ Smoke Activator"
	description = "Activates EZ smoke powder."
	reagent_state = LIQUID
	color = "#C8C8C8"

/datum/reagent/sonic_powder
	name = "Sonic Powder"
	description = "Makes a deafening noise."
	reagent_state = LIQUID
	color = "#C8C8C8"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "loud noises"

/datum/reagent/phlogiston
	name = "Phlogiston"
	description = "Catches you on fire and makes you ignite."
	reagent_state = LIQUID
	color = "#FA00AF"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "burning"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC

/datum/reagent/phlogiston/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	M.adjust_fire_stacks(1)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg, 0)
	M.IgniteMob()
	..()

/datum/reagent/phlogiston/on_mob_life(mob/living/carbon/M)
	M.adjust_fire_stacks(1)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg, 0)
	..()
	return TRUE

/datum/reagent/napalm
	name = "Napalm"
	description = "Very flammable."
	reagent_state = LIQUID
	color = "#FA00AF"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "burning"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC

/datum/reagent/napalm/on_mob_life(mob/living/carbon/M)
	M.adjust_fire_stacks(1)
	..()

/datum/reagent/napalm/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(istype(M))
		if(method != INGEST && method != INJECT)
			M.adjust_fire_stacks(min(reac_volume/4, 20))

/datum/reagent/cryostylane
	name = "Cryostylane"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Cryostylane slowly cools all other reagents in the container 0K."
	color = "#0000DC"
	chem_flags = CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC


/datum/reagent/cryostylane/on_mob_life(mob/living/carbon/M) //TODO: code freezing into an ice cube
	if(M.reagents.has_reagent(/datum/reagent/oxygen))
		M.reagents.remove_reagent(/datum/reagent/oxygen, 0.5)
		M.adjust_bodytemperature(-15)
	..()

/datum/reagent/cryostylane/reaction_turf(turf/T, reac_volume)
	if(reac_volume >= 5)
		for(var/mob/living/simple_animal/slime/M in T)
			M.adjustToxLoss(rand(15,30))

/datum/reagent/pyrosium
	name = "Pyrosium"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Pyrosium slowly heats all other reagents in the container."
	color = "#64FAC8"
	chem_flags = CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC


/datum/reagent/pyrosium/on_mob_life(mob/living/carbon/M)
	if(M.reagents.has_reagent(/datum/reagent/oxygen))
		M.reagents.remove_reagent(/datum/reagent/oxygen, 0.5)
		M.adjust_bodytemperature(15)
	..()

/datum/reagent/teslium //Teslium. Causes periodic shocks, and makes shocks against the target much more effective.
	name = "Teslium"
	description = "An unstable, electrically-charged metallic slurry. Periodically electrocutes its victim, and makes electrocutions against them more deadly. Excessively heating teslium results in dangerous destabilization. Do not allow to come into contact with water."
	reagent_state = LIQUID
	color = "#20324D" //RGB: 32, 50, 77
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_GOAL_BOTANIST_HARVEST
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "charged metal"
	self_consuming = TRUE
	var/shock_timer = 0
	process_flags = ORGANIC | SYNTHETIC

/datum/reagent/teslium/on_mob_life(mob/living/carbon/M)
	shock_timer++
	if(shock_timer >= rand(5,30)) //Random shocks are wildly unpredictable
		shock_timer = 0
		M.electrocute_act(rand(5,20), "Teslium in their body", 1, 1) //Override because it's caused from INSIDE of you
		playsound(M, "sparks", 50, 1)
	..()

/datum/reagent/teslium/energized_jelly
	name = "Energized Jelly"
	description = "Electrically-charged jelly. Boosts jellypeople's nervous system, but only shocks other lifeforms."
	reagent_state = LIQUID
	color = "#CAFF43"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "jelly"

/datum/reagent/teslium/energized_jelly/on_mob_life(mob/living/carbon/M)
	if(isjellyperson(M))
		shock_timer = 0 //immune to shocks
		M.AdjustAllImmobility(-40, FALSE)
		M.adjustStaminaLoss(-2, 0)
		if(isluminescent(M))
			var/mob/living/carbon/human/H = M
			var/datum/species/jelly/luminescent/L = H.dna.species
			L.extract_cooldown = max(0, L.extract_cooldown - 20)
	..()

/datum/reagent/teslium/energized_jelly/energized_ooze
	name = "Energized Ooze"
	description = "Electrically-charged Ooze. Boosts Oozeling's nervous system, but only shocks other lifeforms."
	reagent_state = LIQUID
	color = "#CAFF43"
	chem_flags = CHEMICAL_RNG_GENERAL | CHEMICAL_RNG_FUN | CHEMICAL_RNG_BOTANY
	taste_description = "slime"
	overdose_threshold = 30

/datum/reagent/teslium/energized_jelly/energized_ooze/on_mob_life(mob/living/carbon/M)
	if(isoozeling(M))
		shock_timer = 0 //immune to shocks
		M.AdjustAllImmobility(-40, FALSE)
		M.adjustStaminaLoss(-2, 0)
	..()

/datum/reagent/teslium/energized_jelly/energized_ooze/overdose_process(mob/living/carbon/M)
	if(isoozeling(M) || isjellyperson(M))
		if(prob(25))
			M.electrocute_act(rand(5,20), "Energized Jelly overdose in their body", 1, 1) //Override because it's caused from INSIDE of you
			playsound(M, "sparks", 50, 1)
	..()

/datum/reagent/firefighting_foam
	name = "Firefighting Foam"
	description = "A historical fire suppressant. Originally believed to simply displace oxygen to starve fires, it actually interferes with the combustion reaction itself. Vastly superior to the cheap water-based extinguishers found on NT vessels."
	reagent_state = LIQUID
	color = "#A6FAFF55"
	chem_flags = NONE
	taste_description = "the inside of a fire extinguisher"

/datum/reagent/firefighting_foam/reaction_turf(turf/open/T, reac_volume)
	if (!istype(T))
		return

	if(reac_volume >= 1)
		var/obj/effect/particle_effect/foam/firefighting/F = (locate(/obj/effect/particle_effect/foam) in T)
		if(!F)
			F = new(T)
		else if(istype(F))
			F.lifetime = initial(F.lifetime) //reduce object churn a little bit when using smoke by keeping existing foam alive a bit longer

	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in T)
	if(hotspot && !isspaceturf(T))
		if(T.air)
			var/datum/gas_mixture/G = T.air
			if(G.return_temperature() > T20C)
				G.set_temperature(max(G.return_temperature()/2,T20C))
			G.react(src)
			qdel(hotspot)

/datum/reagent/firefighting_foam/reaction_obj(obj/O, reac_volume)
	O.extinguish()

/datum/reagent/firefighting_foam/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method in list(VAPOR, TOUCH))
		M.adjust_fire_stacks(-reac_volume)
		M.ExtinguishMob()
	..()
