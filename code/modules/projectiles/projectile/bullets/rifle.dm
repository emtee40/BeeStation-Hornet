// 5.56mm (M-90gl Carbine)

/obj/projectile/bullet/a556
	name = "5.56mm bullet"
	damage = 35

// 7.62 (Nagant Rifle)

/obj/projectile/bullet/a762
	name = "7.62 bullet"
	damage = 60

/obj/projectile/bullet/a762_enchanted
	name = "enchanted 7.62 bullet"
	damage = 20
	stamina = 80

// .41 Cal (Pipe Pistol/Rifle)

/obj/projectile/bullet/a41
	name = ".41 bullet"
	damage = 35
	speed = 0.7

/obj/projectile/bullet/a41/paper
	//Possible damage range between 25 and 28
	damage = 28
	speed = 0.8

/obj/projectile/bullet/a41/paper/Initialize(mapload)
	. = ..()
	//Actual damage of projectile is reduced by 0 to 3 damage
	damage -= (round(rand(0, 3), 1))

/obj/projectile/bullet/a41/paper/copper
	//Possible damage between 39 and 42
	damage = 42
	armour_penetration = -30

/obj/projectile/bullet/a41/paper/hotload
	//Possible damage between 32 and 35
	damage = 35
	speed = 0.6
	armour_penetration = 25
