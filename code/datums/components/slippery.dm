/datum/component/slippery
	var/force_drop_items = FALSE
	var/knockdown_time = 0
	var/paralyze_time = 0
	var/lube_flags
	var/datum/callback/callback

	///what we give to connect_loc by default, makes slippable mobs moving over us slip
	var/static/list/default_connections = list(
		COMSIG_ATOM_ENTERED = .proc/Slip,
	)


/datum/component/slippery/Initialize(_knockdown, _lube_flags = NONE, datum/callback/_callback, _paralyze, _force_drop = FALSE)
	knockdown_time = max(_knockdown, 0)
	paralyze_time = max(_paralyze, 0)
	force_drop_items = _force_drop
	lube_flags = _lube_flags
	callback = _callback
	if(ismovable(parent))
		AddElement(/datum/element/connect_loc, parent, default_connections)

/datum/component/slippery/proc/Slip(datum/source, atom/movable/arrived, direction)
	if(!isliving(arrived))
		return
	var/mob/living/victim = arrived
	if(!(victim.movement_type & FLYING) && victim.slip(knockdown_time, parent, lube_flags, paralyze_time, force_drop_items) && callback)
		callback.Invoke(victim)

/datum/component/slippery/UnregisterFromParent()
	. = ..()
	RemoveElement(/datum/element/connect_loc, parent, default_connections)
