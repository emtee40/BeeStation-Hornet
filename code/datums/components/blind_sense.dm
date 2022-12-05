/datum/component/blind_sense
	///The range we can hear-ping things from
	var/hear_range = 9
	///List of things we can't sense
	var/list/sense_blacklist
	///The amount of time you can sense things for
	var/sense_time = 5 SECONDS
	///Reference to the users ears
	var/obj/item/organ/ears/ears
	///Type casted to access client, owner
	var/mob/owner
	///What texture we use
	var/texture = "texture_2"

/datum/component/blind_sense/New(list/raw_args)
	. = ..()
	//Register signal for sensing voices
	RegisterSignal(SSdcs, COMSIG_GLOB_LIVING_SAY_SPECIAL, .proc/handle_hear)
	//Register signal for sensing sounds
	RegisterSignal(SSdcs, COMSIG_GLOB_SOUND_PLAYED, .proc/handle_hear)
	//typecast to access client
	owner = parent
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		ears = C.ears
		RegisterSignal(ears, COMSIG_PARENT_QDELETING, .proc/handle_ears)

/datum/component/blind_sense/proc/handle_hear(datum/source, atom/speaker, message)
	SIGNAL_HANDLER

	//Stop us from hearing ourselves or if we're deaf
	if(owner == speaker || ears?.deaf)
		return
	//Preset types for things without icons / fucky icons
	var/type
	if(isliving(speaker))
		type = "mob"
		if(isfile(message)) //becuase turfs play the footstep sound
			type = "footstep"
	//Do dist checks
	var/turf/T = get_turf(speaker)
	var/dist = get_dist(get_turf(owner), T)
	if(dist <= hear_range && dist > 1)
		highlight_object(speaker, type, speaker.dir || 1)

/datum/component/blind_sense/proc/highlight_object(atom/target, type, dir)
	//setup icon
	var/icon/I = icon('icons/mob/psychic.dmi', texture)

	//mask icon
	var/icon/mask = icon('icons/mob/psychic.dmi', type || "sound", dir)
	//If the mob has an icon we can use, use it
	if(type == "mob" && target.icon && (target.icon_state || initial(target.icon_state)))
		mask = icon(target.icon, (target.icon_state || initial(target.icon_state)), target.dir)
	I.AddAlphaMask(mask)

	//Setup display image
	var/image/M = image(I, get_turf(target), layer = BLIND_LAYER+1, pixel_x = target.pixel_x, pixel_y = target.pixel_y)
	M.plane = FULLSCREEN_PLANE+1
	M.filters += filter(type = "bloom", size = 2, threshold = rgb(1,1,1))
	//Animate fade & delete
	animate(M, alpha = 0, time = sense_time + 1 SECONDS, easing = QUAD_EASING, flags = EASE_IN)
	addtimer(CALLBACK(src, .proc/handle_image, M), sense_time)

	//Add image to client
	owner.client?.images += M

//handle deleting the image from client
/datum/component/blind_sense/proc/handle_image(image/image_ref)
	SIGNAL_HANDLER

	owner.client?.images -= image_ref
	qdel(image_ref)

//Handle eyes deleting
/datum/component/blind_sense/proc/handle_ears()
	SIGNAL_HANDLER

	ears = null

//Psychich variant for psyphoza
/datum/component/blind_sense/psychic
	texture = "texture_1"
