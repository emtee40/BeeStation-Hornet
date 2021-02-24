/obj/item/implant/camera
	name = "camera implant"
	desc = "Watchful eye inside you."
	activated = FALSE
	var/obj/machinery/camera/camera = null

/obj/item/implant/camera/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Camera Implant<BR>
				<b>Life:</b> 24 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Remote surveillance of implanted subject."}
	return dat

/obj/item/implant/camera/on_implanted(mob/user)
	camera = new (src)
	var/rand_number = rand(1, 1000)
	camera.c_tag = "IMPLANT #[rand_number]"
	camera.network = list("ss13")
	camera.internal_light = FALSE		//No AI camera light

/obj/item/implant/camera/removed(mob/living/source, silent, special)
	. = ..()
	if(.)
		QDEL_NULL(camera)
		return TRUE
	return FALSE

/obj/item/implanter/camera
	name = "implanter (camera)"
	imp_type = /obj/item/implant/camera

/obj/item/implantcase/camera
	name = "implant case - 'Camera'"
	desc = "A glass case containing a camera implant."
	imp_type = /obj/item/implant/camera
