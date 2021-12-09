//does low brute damage, oxygen damage, and stamina damage and wets tiles when damaged
/datum/blobstrain/reagent/pressurized_slime
	name = "Pressurized Slime"
	description = "will do low brute, oxygen, and stamina damage, and wet tiles under targets."
	effectdesc = "will also wet tiles near blobs that are attacked or killed."
	analyzerdescdamage = "Does low brute damage, low oxygen damage, drains stamina, and wets tiles under targets, extinguishing them."
	analyzerdesceffect = "When attacked or killed, lubricates nearby tiles, extinguishing anything on them."
	color = "#AAAABB"
	complementary_color = "#BBBBAA"
	blobbernaut_message = "emits slime at"
	message = "The blob splashes into you"
	message_living = ", and you gasp for breath"
	reagent = /datum/reagent/blob/pressurized_slime

/datum/blobstrain/reagent/pressurized_slime/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if((damage_flag == "melee" || damage_flag == "bullet" || damage_flag == "laser") || damage_type != BURN)
		extinguisharea(B, damage)
	return ..()

/datum/blobstrain/reagent/pressurized_slime/death_reaction(obj/structure/blob/B, damage_flag)
	if(damage_flag == "melee" || damage_flag == "bullet" || damage_flag == "laser")
		B.visible_message("<span class='boldwarning'>The blob ruptures, spraying the area with liquid!</span>")
		extinguisharea(B, 50)

/datum/blobstrain/reagent/pressurized_slime/proc/extinguisharea(obj/structure/blob/B, probchance)
	for(var/turf/open/T in RANGE_TURFS(1, B))
		if(prob(probchance))
			T.MakeSlippery(TURF_WET_LUBE, min_wet_time = 10 SECONDS, wet_time_to_add = 5 SECONDS)
			for(var/obj/O in T)
				O.extinguish()
			for(var/mob/living/L in T)
				L.adjust_fire_stacks(-2.5)
				L.ExtinguishMob()

/datum/reagent/blob/pressurized_slime
	name = "Pressurized Slime"
	taste_description = "a sponge"
	color = "#AAAABB"

/datum/reagent/blob/pressurized_slime/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/camera/blob/O)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection)
	var/turf/open/T = get_turf(exposed_mob)
	if(istype(T) && prob(reac_volume))
		T.MakeSlippery(TURF_WET_LUBE, min_wet_time = 10 SECONDS, wet_time_to_add = 5 SECONDS)
		exposed_mob.adjust_fire_stacks(-(reac_volume / 10))
		exposed_mob.ExtinguishMob()
	exposed_mob.apply_damage(0.4*reac_volume, BRUTE)
	if(exposed_mob)
		exposed_mob.apply_damage(0.4*reac_volume, OXY)
	if(exposed_mob)
		exposed_mob.adjustStaminaLoss(reac_volume)
