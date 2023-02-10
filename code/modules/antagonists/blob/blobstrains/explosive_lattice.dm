//does aoe brute damage when hitting targets, is immune to explosions
/datum/blobstrain/reagent/explosive_lattice
	name = "Explosive Lattice"
	description = "will do brute damage in an area around targets."
	effectdesc = "will also resist explosions, but takes increased damage from fire and other energy sources."
	analyzerdescdamage = "Does medium brute damage and causes damage to everyone near its targets."
	analyzerdesceffect = "Is highly resistant to explosions, but takes increased damage from fire and other energy sources."
	color = "#8B2500"
	complementary_color = "#00668B"
	blobbernaut_message = "blasts"
	message = "The blob blasts you"
	reagent = /datum/reagent/blob/explosive_lattice

/datum/blobstrain/reagent/explosive_lattice/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_flag == "bomb")
		return 0
	else if(damage_flag != "melee" && damage_flag != "bullet" && damage_flag != "laser")
		return damage * 1.5
	return ..()

/datum/reagent/blob/explosive_lattice
	name = "Explosive Lattice"
	taste_description = "the bomb"
	color = "#8B2500"
	chem_flags = CHEMICAL_NOT_SYNTH | CHEMICAL_RNG_FUN

/datum/reagent/blob/explosive_lattice/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/camera/blob/overmind)
	. = ..()
	var/initial_volume = reac_volume
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	if(reac_volume >= 10) //if it's not a spore cloud, bad time incoming
		var/obj/effect/temp_visual/explosion/fast/E = new /obj/effect/temp_visual/explosion/fast(get_turf(exposed_mob))
		E.alpha = 150
		for(var/mob/living/L in ohearers(1, get_turf(exposed_mob)))
			if(ROLE_BLOB in L.faction) //no friendly fire
				continue
			var/aoe_volume = ..(L, TOUCH, initial_volume, 0, L.get_permeability_protection(), overmind)
			L.apply_damage(0.4*aoe_volume, BRUTE)
		if(exposed_mob)
			exposed_mob.apply_damage(0.6*reac_volume, BRUTE)
	else
		exposed_mob.apply_damage(0.6*reac_volume, BRUTE)
