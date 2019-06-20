
/mob/living/silicon/cyborg/gib_animation()
	new /obj/effect/temp_visual/gib_animation(loc, "gibbed-r")

/mob/living/silicon/cyborg/dust(just_ash, drop_items, force)
	if(mmi)
		qdel(mmi)
	..()

/mob/living/silicon/cyborg/spawn_dust()
	new /obj/effect/decal/remains/robot(loc)

/mob/living/silicon/cyborg/dust_animation()
	new /obj/effect/temp_visual/dust_animation(loc, "dust-r")

/mob/living/silicon/cyborg/death(gibbed)
	if(stat == DEAD)
		return

	. = ..()

	locked = FALSE //unlock cover

	if(!QDELETED(builtInCamera) && builtInCamera.status)
		builtInCamera.toggle_cam(src,0)
	update_headlamp(1) //So borg lights are disabled when killed.

	uneq_all() // particularly to ensure sight modes are cleared

	update_icons()

	unbuckle_all_mobs(TRUE)

	SSblackbox.ReportDeath(src)
