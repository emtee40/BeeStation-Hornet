/datum/status_effect/freon
	id = "frozen"
	duration = 100
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/freon
	var/icon/cube
	var/can_melt = TRUE

/atom/movable/screen/alert/status_effect/freon
	name = "Frozen Solid"
	desc = "You're frozen inside an ice cube, and cannot move! You can still do stuff, like shooting. Resist out of the cube!"
	icon_state = "frozen"

/datum/status_effect/freon/on_apply()
	RegisterSignal(owner, COMSIG_LIVING_RESIST, .proc/owner_resist)
	if(owner.is_conscious())
		to_chat(owner, "<span class='userdanger'>You become frozen in a cube!</span>")
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	owner.add_overlay(cube)
	owner.update_mobility()
	return ..()

/datum/status_effect/freon/tick()
	owner.update_mobility()
	if(can_melt && owner.bodytemperature >= BODYTEMP_NORMAL)
		qdel(src)

/datum/status_effect/freon/proc/owner_resist()
	SIGNAL_HANDLER


	INVOKE_ASYNC(src, .proc/do_resist)

/datum/status_effect/freon/proc/do_resist()
	to_chat(owner, "You start breaking out of the ice cube!")
	if(do_mob(owner, owner, 40))
		if(!QDELETED(src))
			to_chat(owner, "You break out of the ice cube!")
			owner.remove_status_effect(/datum/status_effect/freon)
			owner.update_mobility()

/datum/status_effect/freon/on_remove()
	if(owner.is_conscious())
		to_chat(owner, "The cube melts!")
	owner.cut_overlay(cube)
	owner.adjust_bodytemperature(100)
	owner.update_mobility()
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)

/datum/status_effect/freon/watcher
	duration = 8
	can_melt = FALSE
