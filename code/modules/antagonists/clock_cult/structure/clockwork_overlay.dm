//an "overlay" used by clockwork walls and floors to appear normal to mesons.
/obj/effect/clockwork/overlay
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/atom/linked

/obj/effect/clockwork/overlay/examine(mob/user)
	if(linked)
		return linked.examine(user)
	else
		return ..()

/obj/effect/clockwork/overlay/ex_act()
	return FALSE

/obj/effect/clockwork/overlay/singularity_act()
	return
/obj/effect/clockwork/overlay/singularity_pull()
	return

/obj/effect/clockwork/overlay/singularity_pull(S, current_size)
	return

/obj/effect/clockwork/overlay/Destroy()
	if(linked)
		linked = null
	. = ..()

/obj/effect/clockwork/overlay/wall
	name = "clockwork wall"
	icon = 'icons/turf/walls/clockwork_wall.dmi'
	icon_state = "clockwork_wall-0"
	base_icon_state = "clockwork_wall"
	layer = CLOSED_TURF_LAYER

/obj/effect/clockwork/overlay/wall/update_icon_state()
	. = ..()
	if(linked)
		icon_state = "[base_icon_state]-[linked.smoothing_junction]" //Cheaper than smoothing ourselves
	else
		icon_state = initial(icon_state)

/obj/effect/clockwork/overlay/floor
	icon = 'icons/turf/floors.dmi'
	icon_state = "clockwork_floor"
	layer = TURF_LAYER
	plane = FLOOR_PLANE

/obj/effect/clockwork/overlay/floor/bloodcult //this is used by BLOOD CULT, it shouldn't use such a path...
	icon_state = "cult"
