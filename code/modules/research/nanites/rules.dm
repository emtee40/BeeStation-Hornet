/datum/nanite_rule
	var/name = "Generic Condition"
	var/desc = "When triggered, the program is active"
	var/datum/nanite_program/program

/datum/nanite_rule/New(datum/nanite_program/new_program)
	program = new_program
	if(LAZYLEN(new_program.rules) <= 5) //Avoid infinite stacking rules
		new_program.rules += src
	else
		qdel(src)

/datum/nanite_rule/proc/remove()
	program.rules -= src
	program = null
	qdel(src)

/datum/nanite_rule/proc/check_rule()
	return TRUE

/datum/nanite_rule/proc/display()
	return name

/datum/nanite_rule/proc/copy_to(datum/nanite_program/new_program)
	new type(new_program)

/datum/nanite_rule/health
	name = "Health"
	desc = "Checks the host's health status."

	var/threshold = 50
	var/above = TRUE

/datum/nanite_rule/health/check_rule()
	var/health_percent = program.host_mob.health / program.host_mob.maxHealth * 100
	if(above)
		if(health_percent >= threshold)
			return TRUE
	else
		if(health_percent < threshold)
			return TRUE
	return FALSE

/datum/nanite_rule/health/display()
	return "[name] [above ? ">" : "<"] [threshold]%"

/datum/nanite_rule/health/copy_to(datum/nanite_program/new_program)
	var/datum/nanite_rule/health/rule = new(new_program)
	rule.above = above
	rule.threshold = threshold

//TODO allow inversion
/datum/nanite_rule/crit
	name = "Crit"
	desc = "Checks if the host is in critical condition."

/datum/nanite_rule/crit/check_rule()
	if(program.host_mob.InCritical())
		return TRUE
	return FALSE

/datum/nanite_rule/death
	name = "Death"
	desc = "Checks if the host is dead."

/datum/nanite_rule/death/check_rule()
	if(program.host_mob.stat == DEAD || HAS_TRAIT(program.host_mob, TRAIT_FAKEDEATH))
		return TRUE
	return FALSE

/datum/nanite_rule/cloud_sync
	name = "Cloud Sync"
	desc = "Checks if the nanites have cloud sync enabled or disabled."
	var/check_type = "Enabled"

/datum/nanite_rule/cloud_sync/check_rule()
	if(check_type == "Enabled")
		return program.nanites.cloud_active
	else
		return !program.nanites.cloud_active

/datum/nanite_rule/cloud_sync/copy_to(datum/nanite_program/new_program)
	var/datum/nanite_rule/cloud_sync/rule = new(new_program)
	rule.check_type = check_type

/datum/nanite_rule/cloud_sync/display()
	return "[name]:[check_type]"

/datum/nanite_rule/nanites
	name = "Nanite Volume"
	desc = "Checks the host's nanite volume."

	var/threshold = 50
	var/above = TRUE

/datum/nanite_rule/nanites/check_rule()
	var/nanite_percent = (program.nanites.nanite_volume - program.nanites.safety_threshold)/(program.nanites.max_nanites - program.nanites.safety_threshold)*100
	if(above)
		if(nanite_percent >= threshold)
			return TRUE
	else
		if(nanite_percent < threshold)
			return TRUE
	return FALSE

/datum/nanite_rule/nanites/copy_to(datum/nanite_program/new_program)
	var/datum/nanite_rule/nanites/rule = new(new_program)
	rule.above = above
	rule.threshold = threshold

/datum/nanite_rule/nanites/display()
	return "[name] [above ? ">" : "<"] [threshold]%"

/datum/nanite_rule/damage
	name = "Damage"
	desc = "Checks the host's damage."

	var/threshold = 50
	var/above = TRUE
	var/damage_type = BRUTE

/datum/nanite_rule/damage/check_rule()
	var/damage_amt = 0
	switch(damage_type)
		if(BRUTE)
			damage_amt = program.host_mob.getBruteLoss()
		if(BURN)
			damage_amt = program.host_mob.getFireLoss()
		if(TOX)
			damage_amt = program.host_mob.getToxLoss()
		if(OXY)
			damage_amt = program.host_mob.getOxyLoss()
		if(CLONE)
			damage_amt = program.host_mob.getCloneLoss()

	if(above)
		if(damage_amt >= threshold)
			return TRUE
	else
		if(damage_amt < threshold)
			return TRUE
	return FALSE

/datum/nanite_rule/damage/copy_to(datum/nanite_program/new_program)
	var/datum/nanite_rule/damage/rule = new(new_program)
	rule.above = above
	rule.threshold = threshold
	rule.damage_type = damage_type

/datum/nanite_rule/damage/display()
	return "[damage_type] [above ? ">" : "<"] [threshold]"

/datum/nanite_rule/species
	name = "Species"
	desc = "Checks the host's race"

	var/species_rule = /datum/species/human
	var/mode_rule = "is"
	var/species_name_rule = "human"


/datum/nanite_rule/species/check_rule()
	var/species_match_rule = FALSE

	if(species_rule)
		if(species_rule == /datum/species/human)
			if(ishumanbasic(program.host_mob) && !is_species(program.host_mob, /datum/species/human/felinid))
				species_match_rule = TRUE
		else if(is_species(program.host_mob, species_rule))
			species_match_rule = TRUE


	if(species_match_rule)
		if(mode_rule)
			return TRUE
		else
			return FALSE
	else
		if(!mode_rule)
			return TRUE
		else
			return FALSE

/datum/nanite_rule/species/copy_to(datum/nanite_program/new_program)
	var/datum/nanite_rule/species/rule = new(new_program)
	rule.species_rule = species_rule
	rule.mode_rule = mode_rule
	rule.species_name_rule = species_name_rule

/datum/nanite_rule/species/display()
	return "[mode_rule ? "IS" : "IS NOT"] [species_name_rule]"
