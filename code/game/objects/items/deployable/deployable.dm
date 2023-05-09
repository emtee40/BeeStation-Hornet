/obj/item/deployable
	name = "Capsule" //This is intended to be an unused subtype, but you do you.
	desc = "Tell admins they forgot to edit the description when spawning this in."
	icon = 'icons/obj/mining.dmi'
	icon_state = "capsule"
	w_class = WEIGHT_CLASS_NORMAL
	///This is what the item will deploy as. This will be a one-way conversion unless the deployed item has its own code for converting back
	var/atom/movable/deployed_object
	///Should be true if the item is deploying itself when set up, should be false if it's deploying other objects
	var/consumed = TRUE
	///For when consumed is false, is the carrier object currently loaded and ready to deploy its payload item?
	var/loaded
	///The amount of time it takes to deploy
	var/time_to_deploy
	///Set to true to allow deployment on top of dense objects
	var/dense_deployment = FALSE

/obj/item/deployable/attack_self(mob/user)
	try_deploy(user, user.loc)

/obj/item/deployable/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(proximity)
		try_deploy(user, target)

///Checks to see if object can deploy, either in a passed location or within its own location if none was passed and deploys if it can be.
/obj/item/deployable/proc/try_deploy(mob/user, atom/location)
	if(!consumed && !loaded)
		to_chat(user, "<span class='warning'>[src] has nothing to deploy!</span>")
		return FALSE
	if(!location) //if no location was passed we use the current location.
		location = loc
	if(isopenturf(location))
		if(dense_deployment)
			return deploy_after(user, location)
		else
			var/dense_location
			for(var/atom/movable/AM in location)
				if(AM.density)
					dense_location = TRUE
					break
			if(!dense_location)
				return deploy_after(user, location)
	if(user)
		to_chat(user, "<span class='warning'>[src] can only be deployed in an open area!</span>")
	visible_message("<span class='warning'>[src] fails to deploy!</span>")
	return FALSE

///Delays deployment for things which take time to set up
/obj/item/deployable/proc/deploy_after(mob/user, atom/location)
	if(!time_to_deploy || !user)
		deploy(user, location)
		return TRUE

	user.visible_message("<span class='notice'>[user] begins to deploy [src]...</span>")
	if(do_after(user, time_to_deploy, src))
		deploy(user, location)
		return TRUE
	else
		return FALSE

///Do not call this directly, use try_deploy instead
/obj/item/deployable/proc/deploy(mob/user, atom/location)
	var/atom/R = new deployed_object(location)
	for(var/atom/movable/A in contents)
		A.forceMove(R)
	R.add_fingerprint(user)
	if(istype(R, /obj/structure/closet/))
		var/obj/structure/closet/sesame = R
		sesame.open()
	if(consumed)
		qdel(src)
	else
		loaded = FALSE
		update_icon()

/obj/item/deployable/container_resist(mob/living/user)
	if(user.incapacitated())
		to_chat(user, "<span class='warning'>You can't get out while you're restrained like this!</span>")
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, "<span class='notice'>You try to force your way out of [src]...</span>")
	to_chat(loc, "<span class='warning'>Someone starts trying to break free of [src]!</span>")
	if(!do_after(user, 200, target = src))
		to_chat(loc, "<span class='warning'>It seems that they've stopped resisting...</span>")
		return
	loc.visible_message("<span class='warning'>[user] breaks free from the [src]!</span>", "<span class='userdanger'>You manage to break free from the [src]!</span>")
	qdel(src)


