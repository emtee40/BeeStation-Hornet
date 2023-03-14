//Beam Datum and effect
/datum/beam
	var/atom/origin = null
	var/atom/target = null
	var/list/elements = list()
	var/icon/base_icon = null
	var/icon
	var/icon_state = "" //icon state of the main segments of the beam
	var/max_distance = 0
	var/sleep_time = 3
	var/finished = 0
	var/target_oldloc = null
	var/origin_oldloc = null
	var/static_beam = 0
	var/beam_type = /obj/effect/ebeam //must be subtype
	var/timing_id = null
	var/recalculating = FALSE

/datum/beam/New(beam_origin,beam_target,beam_icon='icons/effects/beam.dmi',beam_icon_state="b_beam",time=50,maxdistance=10,btype = /obj/effect/ebeam,beam_sleep_time=3)
	origin = beam_origin
	origin_oldloc =	get_turf(origin)
	target = beam_target
	target_oldloc = get_turf(target)
	sleep_time = beam_sleep_time
	if(origin_oldloc == origin && target_oldloc == target)
		static_beam = 1
	max_distance = maxdistance
	base_icon = new(beam_icon,beam_icon_state)
	icon = beam_icon
	icon_state = beam_icon_state
	beam_type = btype
	if(time < INFINITY)
		addtimer(CALLBACK(src,PROC_REF(End)), time)

/datum/beam/proc/Start()
	Draw()
	recalculate_in(sleep_time)

/datum/beam/proc/recalculate()
	if(recalculating)
		recalculate_in(sleep_time)
		return
	recalculating = TRUE
	timing_id = null
	if(origin && target && get_dist(origin,target)<max_distance && origin.get_virtual_z_level() == target.get_virtual_z_level())
		var/origin_turf = get_turf(origin)
		var/target_turf = get_turf(target)
		if(!static_beam && (origin_turf != origin_oldloc || target_turf != target_oldloc))
			origin_oldloc = origin_turf //so we don't keep checking against their initial positions, leading to endless Reset()+Draw() calls
			target_oldloc = target_turf
			Reset()
			Draw()
		after_calculate()
		recalculating = FALSE
	else
		End()

/datum/beam/proc/afterDraw()
	return

/datum/beam/proc/recalculate_in(time)
	if(QDELETED(src))
		return
	if(timing_id)
		deltimer(timing_id)
	timing_id = addtimer(CALLBACK(src, PROC_REF(recalculate)), time, TIMER_STOPPABLE)

/datum/beam/proc/after_calculate()
	if((sleep_time == null) || finished)	//Does not automatically recalculate.
		return
	if(isnull(timing_id))
		timing_id = addtimer(CALLBACK(src, PROC_REF(recalculate)), sleep_time, TIMER_STOPPABLE)

/datum/beam/proc/End(destroy_self = TRUE)
	finished = TRUE
	if(!isnull(timing_id))
		deltimer(timing_id)
	if(!QDELETED(src) && destroy_self)
		qdel(src)

/datum/beam/proc/Reset()
	for(var/obj/effect/ebeam/B in elements)
		qdel(B)
	elements.Cut()

/datum/beam/Destroy()
	Reset()
	target = null
	origin = null
	return ..()

/datum/beam/proc/Draw()
	var/Angle = round(get_angle(origin,target))
	var/matrix/rot_matrix = matrix()
	rot_matrix.Turn(Angle)

	//Translation vector for origin and target
	var/DX = (32*target.x+target.pixel_x)-(32*origin.x+origin.pixel_x)
	var/DY = (32*target.y+target.pixel_y)-(32*origin.y+origin.pixel_y)
	var/N = 0
	var/length = round(sqrt((DX)**2+(DY)**2)) //hypotenuse of the triangle formed by target and origin's displacement

	for(N in 0 to length-1 step 32)//-1 as we want < not <=, but we want the speed of X in Y to Z and step X
		if(QDELETED(src) || finished)
			break
		var/obj/effect/ebeam/X = new beam_type(origin_oldloc)
		X.owner = src
		elements += X

		//Assign icon, for main segments it's base_icon, for the end, it's icon+icon_state
		//cropped by a transparent box of length-N pixel size
		if(N+32>length)
			var/icon/II = new(icon, icon_state)
			II.DrawBox(null,1,(length-N),32,32)
			X.icon = II
		else
			X.icon = base_icon
		X.transform = rot_matrix

		//Calculate pixel offsets (If necessary)
		var/Pixel_x
		var/Pixel_y
		if(DX == 0)
			Pixel_x = 0
		else
			Pixel_x = round(sin(Angle)+32*sin(Angle)*(N+16)/32)
		if(DY == 0)
			Pixel_y = 0
		else
			Pixel_y = round(cos(Angle)+32*cos(Angle)*(N+16)/32)

		//Position the effect so the beam is one continous line
		var/a
		if(abs(Pixel_x)>32)
			a = Pixel_x > 0 ? round(Pixel_x/32) : CEILING(Pixel_x/32, 1)
			X.x += a
			Pixel_x %= 32
		if(abs(Pixel_y)>32)
			a = Pixel_y > 0 ? round(Pixel_y/32) : CEILING(Pixel_y/32, 1)
			X.y += a
			Pixel_y %= 32

		X.pixel_x = Pixel_x
		X.pixel_y = Pixel_y
		CHECK_TICK
	afterDraw()

/obj/effect/ebeam
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE
	var/datum/beam/owner

/obj/effect/ebeam/Destroy()
	owner = null
	return ..()

/obj/effect/ebeam/singularity_pull()
	return
/obj/effect/ebeam/singularity_act()
	return

/**
 * This is what you use to start a beam. Example: origin.Beam(target, args). **Store the return of this proc if you don't set maxdist or time, you need it to delete the beam.**
 *
 * Unless you're making a custom beam effect (see the beam_type argument), you won't actually have to mess with any other procs. Make sure you store the return of this Proc, you'll need it
 * to kill the beam.
 * **Arguments:**
 * BeamTarget: Where you're beaming from. Where do you get origin? You didn't read the docs, fuck you.
 * icon_state: What the beam's icon_state is. The datum effect isn't the ebeam object, it doesn't hold any icon and isn't type dependent.
 * icon: What the beam's icon file is. Don't change this, man. All beam icons should be in beam.dmi anyways.
 * maxdistance: how far the beam will go before stopping itself. Used mainly for two things: preventing lag if the beam may go in that direction and setting a range to abilities that use beams.
 * beam_type: The type of your custom beam. This is for adding other wacky stuff for your beam only. Most likely, you won't (and shouldn't) change it.
 */
/atom/proc/Beam(atom/BeamTarget,icon_state="b_beam",icon='icons/effects/beam.dmi',time=INFINITY,maxdistance=INFINITY,beam_type=/obj/effect/ebeam, beam_color = null, beam_type=/obj/effect/ebeam,beam_sleep_time = 3)
	var/datum/beam/newbeam = new(src,BeamTarget,icon,icon_state,time,maxdistance,beam_type, beam_color,beam_sleep_time)
	INVOKE_ASYNC(newbeam, /datum/beam/.proc/Start)
	return newbeam
