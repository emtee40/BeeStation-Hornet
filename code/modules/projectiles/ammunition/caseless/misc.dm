/obj/item/ammo_casing/caseless/laser
	name = "laser casing"
	desc = "You shouldn't be seeing this."
	caliber = "laser"
	icon_state = "s-casing-live"
	projectile_type = /obj/item/projectile/beam
	fire_sound = 'sound/weapons/laser.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy

/obj/item/ammo_casing/caseless/laser/gatling
	projectile_type = /obj/item/projectile/beam/weak/penetrator
	variance = 0.8

/obj/item/ammo_casing/caseless/pulse
	name = "pulse casing"
	desc = "You shouldn't be seeing this."
	caliber = "laser"
	icon_state = "s-casing-live"
	projectile_type = /obj/item/projectile/beam/pulse
	fire_sound = 'sound/weapons/laser.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy
