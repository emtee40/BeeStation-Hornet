/obj/item/projectile/bullet/gyro
	name ="explosive bolt"
	icon_state= "bolter"
	damage = 50

/obj/item/projectile/bullet/gyro/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, devastation_range = -1, light_impact_range = 2)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm
	name ="\improper HEDP rocket"
	desc = "USE A WEEL GUN"
	icon_state= "84mm-hedp"
	damage = 80
	var/anti_armour_damage = 200
	armour_penetration = 100
	dismemberment = 100

/obj/item/projectile/bullet/a84mm/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, devastation_range = -1, heavy_impact_range = 1, light_impact_range = 3, flame_range = 4, flash_range = 1, adminlog = FALSE)

	if(ismecha(target))
		var/obj/mecha/M = target
		M.take_damage(anti_armour_damage)
	if(issilicon(target))
		var/mob/living/silicon/S = target
		S.take_overall_damage(anti_armour_damage*0.75, anti_armour_damage*0.25)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm_he
	name ="\improper HE rocket"
	desc = "Boom."
	icon_state = "missile"
	damage = 30
	ricochets_max = 0 //it's a MISSILE

/obj/item/projectile/bullet/a84mm_he/on_hit(atom/target, blocked=0)
	..()
	if(!isliving(target)) //if the target isn't alive, so is a wall or something
		explosion(target, heavy_impact_range = 1, light_impact_range = 2, flame_range = 3, flash_range = 4)
	else
		explosion(target, light_impact_range = 2, flame_range = 3, flash_range = 4)
	return BULLET_ACT_HIT
