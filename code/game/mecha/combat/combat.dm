/obj/mecha/combat
	force = 30
	internals_req_access = list(ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY)
	internal_damage_threshold = 50
	armor = list(MELEE = 30, BULLET = 30, "laser" = 15, ENERGY = 20, BOMB = 20, "bio" = 0, "rad" = 0, FIRE = 100, "acid" = 100, "stamina" = 0)
	mouse_pointer = 'icons/mecha/mecha_mouse.dmi'
	destruction_sleep_duration = 40
	exit_delay = 40

/obj/mecha/combat/restore_equipment()
	mouse_pointer = 'icons/mecha/mecha_mouse.dmi'
	. = ..()
