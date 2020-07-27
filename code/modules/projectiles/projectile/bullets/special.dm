// Honker

/obj/item/projectile/bullet/honker
	name = "banana"
	damage = 0
	paralyze = 60
	movement_type = FLYING | UNSTOPPABLE
	nodamage = TRUE
	hitsound = 'sound/items/bikehorn.ogg'
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "banana"
	range = 200

/obj/item/projectile/bullet/honker/Initialize()
	. = ..()
	SpinAnimation()

// Mime

/obj/item/projectile/bullet/mime
	damage = 20

/obj/item/projectile/bullet/mime/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.silent = max(M.silent, 10)

// Special HoS "Bullets"

/obj/item/projectile/bullet/hos
	name = "3D printed .454 round"
	damage = 25

/obj/item/projectile/bullet/hos/hv
	name = "3D printed .454 HV round"
	speed = 0.2
	armour_penetration = 60

/obj/item/projectile/bullet/hos/heavy
	name = "3D printed .454 heavy round"
	damage = 35
	knockdown = 50

/obj/item/projectile/bullet/hos/heavy/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovableatom(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2)

/obj/item/projectile/bullet/hos/light
	name = "3D printed .454 plastic round"
	damage = 10
	stamina = 15

/obj/item/projectile/bullet/shotgun_breaching/hos
	name = "3D printed .454 breaching round"
