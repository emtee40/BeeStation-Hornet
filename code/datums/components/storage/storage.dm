#define COLLECT_ONE 0
#define COLLECT_EVERYTHING 1
#define COLLECT_SAME 2

// External storage-related logic:
// /mob/proc/ClickOn() in /_onclick/click.dm - clicking items in storages
// /mob/living/Move() in /modules/mob/living/living.dm - hiding storage boxes on mob movement

/datum/component/storage
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/datum/component/storage/concrete/master		//If not null, all actions act on master and this is just an access point.

	var/list/can_hold								//if this is set, only things in this typecache will fit, unless
	var/list/cant_hold								//if this is set, anything in this typecache will not be able to fit.
	var/list/exception_hold							//if this is set, items in this typecache will ignore size limitations, only respecting max_items
	/// If set can only contain stuff with this single trait present.
	var/list/can_hold_trait

	var/list/mob/is_using							//lazy list of mobs looking at the contents of this storage.

	var/locked = FALSE								//when locked nothing can see inside or use it.

	var/max_w_class = WEIGHT_CLASS_SMALL			//max size of objects that will fit.
	var/max_combined_w_class = 14					//max combined sizes of objects that will fit.
	var/max_items = 7								//max number of objects that will fit.

	var/emp_shielded = FALSE

	var/silent = FALSE								//whether this makes a message when things are put in.
	var/click_gather = FALSE						//whether this can be clicked on items to pick it up rather than the other way around.
	var/rustle_sound = TRUE							//play rustle sound on interact.
	var/allow_quick_empty = FALSE					//allow empty verb which allows dumping on the floor of everything inside quickly.
	var/allow_quick_gather = FALSE					//allow toggle mob verb which toggles collecting all items from a tile.
	var/insert_while_closed = TRUE					//the user can insert items while the storage is closed, if not the user will have to click/alt click to open it before they can insert items
	var/can_be_opened = TRUE						//if FALSE, the container cannot be opened to look inside

	var/collection_mode = COLLECT_EVERYTHING

	var/insert_preposition = "in"					//you put things "in" a bag, but "on" a tray.

	var/display_numerical_stacking = FALSE			//stack things of the same type and show as a single object with a number.

	var/atom/movable/screen/storage/boxes					//storage display object
	var/atom/movable/screen/close/closer						//close button object

	var/allow_big_nesting = FALSE					//allow storage objects of the same or greater size.

	var/attack_hand_interact = TRUE					//interact on attack hand.
	var/quickdraw = FALSE							//altclick interact

	var/datum/action/item_action/storage_gather_mode/modeswitch_action

	/// whether or not we should have those cute little animations
	var/animated = TRUE

	//Screen variables: Do not mess with these vars unless you know what you're doing. They're not defines so storage that isn't in the same location can be supported in the future.
	var/screen_max_columns = 7							//These two determine maximum screen sizes.
	var/screen_max_rows = INFINITY
	var/screen_pixel_x = 16								//These two are pixel values for screen loc of boxes and closer
	var/screen_pixel_y = 16
	var/screen_start_x = 4								//These two are where the storage starts being rendered, screen_loc wise.
	var/screen_start_y = 2
	//End

/datum/component/storage/Initialize(datum/component/storage/concrete/master)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(master)
		change_master(master)
	boxes = new(null, src)
	closer = new(null, src)
	orient2hud()

	RegisterSignal(parent, COMSIG_CONTAINS_STORAGE, PROC_REF(on_check))
	RegisterSignal(parent, COMSIG_IS_STORAGE_LOCKED, PROC_REF(check_locked))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_SHOW, PROC_REF(signal_show_attempt))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_INSERT, PROC_REF(signal_insertion_attempt))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_CAN_INSERT, PROC_REF(signal_can_insert))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_TAKE_TYPE, PROC_REF(signal_take_type))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_FILL_TYPE, PROC_REF(signal_fill_type))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_SET_LOCKSTATE, PROC_REF(set_locked))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_TAKE, PROC_REF(signal_take_obj))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_QUICK_EMPTY, PROC_REF(signal_quick_empty))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_HIDE_FROM, PROC_REF(signal_hide_attempt))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_HIDE_ALL, PROC_REF(close_all))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_RETURN_INVENTORY, PROC_REF(signal_return_inv))

	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, PROC_REF(attackby))

	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_PAW, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_ATOM_EMP_ACT, PROC_REF(emp_act))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_GHOST, PROC_REF(show_to_ghost))
	RegisterSignal(parent, COMSIG_ATOM_ENTERED, PROC_REF(refresh_mob_views))
	RegisterSignal(parent, COMSIG_ATOM_EXITED, PROC_REF(_remove_and_refresh))
	RegisterSignal(parent, COMSIG_ATOM_CANREACH, PROC_REF(canreach_react))

	RegisterSignal(parent, COMSIG_ITEM_PRE_ATTACK, PROC_REF(preattack_intercept))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(attack_self))
	RegisterSignal(parent, COMSIG_ITEM_PICKUP, PROC_REF(signal_on_pickup))

	RegisterSignal(parent, COMSIG_MOVABLE_POST_THROW, PROC_REF(close_all))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

	RegisterSignal(parent, COMSIG_CLICK_ALT, PROC_REF(on_alt_click))
	RegisterSignal(parent, COMSIG_MOUSEDROP_ONTO, PROC_REF(mousedrop_onto))
	RegisterSignal(parent, COMSIG_MOUSEDROPPED_ONTO, PROC_REF(mousedrop_receive))

	update_actions()

/datum/component/storage/Destroy()
	close_all()
	QDEL_NULL(boxes)
	QDEL_NULL(closer)
	LAZYCLEARLIST(is_using)
	return ..()

/datum/component/storage/PreTransfer()
	update_actions()

/datum/component/storage/proc/update_actions()
	QDEL_NULL(modeswitch_action)
	if(!isitem(parent) || !allow_quick_gather)
		return
	var/obj/item/I = parent
	modeswitch_action = new(I)
	RegisterSignal(modeswitch_action, COMSIG_ACTION_TRIGGER, PROC_REF(action_trigger))
	if(I.item_flags & PICKED_UP)
		var/mob/M = I.loc
		if(!istype(M))
			return
		modeswitch_action.Grant(M)

/datum/component/storage/proc/change_master(datum/component/storage/concrete/new_master)
	if(new_master == src || (!isnull(new_master) && !istype(new_master)))
		return FALSE
	if(master)
		master.on_slave_unlink(src)
	master = new_master
	if(master)
		master.on_slave_link(src)
	return TRUE

/datum/component/storage/proc/master()
	if(master == src)
		return			//infinite loops yo.
	return master

/datum/component/storage/proc/real_location()
	var/datum/component/storage/concrete/master = master()
	return master? master.real_location() : null

/datum/component/storage/proc/canreach_react(datum/source, list/next)
	SIGNAL_HANDLER

	var/datum/component/storage/concrete/master = master()
	if(!master)
		return
	. = COMPONENT_BLOCK_REACH
	next += master.parent
	for(var/i in master.slaves)
		var/datum/component/storage/slave = i
		next += slave.parent

/datum/component/storage/proc/on_move()
	SIGNAL_HANDLER

	var/atom/A = parent
	for(var/mob/living/L in can_see_contents())
		if(!L.CanReach(A))
			hide_from(L)

/datum/component/storage/proc/attack_self(datum/source, mob/M)
	SIGNAL_HANDLER

	if(locked)
		var/atom/host = parent
		host.balloon_alert(M, "[host] is locked.")
		return FALSE
	if((M.get_active_held_item() == parent) && allow_quick_empty)
		INVOKE_ASYNC(src, PROC_REF(quick_empty), M)

/datum/component/storage/proc/preattack_intercept(datum/source, obj/O, mob/M, params)
	SIGNAL_HANDLER

	if(!isitem(O) || !click_gather || SEND_SIGNAL(O, COMSIG_CONTAINS_STORAGE))
		return FALSE
	. = COMPONENT_NO_ATTACK
	if(locked)
		var/atom/host = parent
		host.balloon_alert(M, "[host] is locked.")
		return FALSE
	var/obj/item/I = O
	if(collection_mode == COLLECT_ONE)
		if(can_be_inserted(I, null, M))
			handle_item_insertion(I, null, M)
		return
	if(!isturf(I.loc))
		return
	INVOKE_ASYNC(src, PROC_REF(async_preattack_intercept), I, M)

///async functionality from preattack_intercept
/datum/component/storage/proc/async_preattack_intercept(obj/item/attack_item, mob/pre_attack_mob)
	var/list/things = attack_item.loc.contents.Copy()
	if(collection_mode == COLLECT_SAME)
		for(var/A in things)
			if(!istype(A, attack_item))
				things -= A
	var/len = length(things)
	if(!len)
		to_chat(pre_attack_mob, "<span class='warning'>You failed to pick up anything with [parent]!</span>")
		return
	var/datum/progressbar/progress = new(pre_attack_mob, len, attack_item.loc)
	var/list/rejections = list()
	while(do_after(pre_attack_mob, 1 SECONDS, parent, NONE, FALSE, CALLBACK(src, PROC_REF(handle_mass_pickup), things, attack_item.loc, rejections, progress)))
		stoplag(1)
	progress.end_progress()
	to_chat(pre_attack_mob, "<span class='notice'>You put everything you could [insert_preposition] [parent].</span>")
	animate_parent()

/datum/component/storage/proc/handle_mass_item_insertion(list/things, datum/component/storage/src_object, mob/user, datum/progressbar/progress)
	var/atom/source_real_location = src_object.real_location()
	for(var/obj/item/I in things)
		things -= I
		if(I.loc != source_real_location)
			continue
		if(user.active_storage != src_object)
			if(I.on_found(user))
				break
		if(can_be_inserted(I,FALSE,user))
			handle_item_insertion(I, TRUE, user)
		if (TICK_CHECK)
			progress.update(progress.goal - things.len)
			return TRUE

	progress.update(progress.goal - things.len)
	return FALSE

/datum/component/storage/proc/handle_mass_pickup(list/things, atom/thing_loc, list/rejections, datum/progressbar/progress)
	var/atom/real_location = real_location()
	for(var/obj/item/I in things)
		things -= I
		if(I.loc != thing_loc)
			continue
		if(I.type in rejections) // To limit bag spamming: any given type only complains once
			continue
		if(!can_be_inserted(I, stop_messages = TRUE))	// Note can_be_inserted still makes noise when the answer is no
			if(real_location.contents.len >= max_items)
				break
			rejections += I.type	// therefore full bags are still a little spammy
			continue

		handle_item_insertion(I, TRUE)	//The TRUE stops the "You put the [parent] into [S]" insertion message from being displayed.

		if (TICK_CHECK)
			progress.update(progress.goal - things.len)
			return TRUE

	progress.update(progress.goal - things.len)
	return FALSE

/datum/component/storage/proc/quick_empty(mob/M)
	var/atom/A = parent
	if(!M.canUseStorage() || !A.Adjacent(M) || M.incapacitated())
		return
	if(locked)
		var/atom/host = parent
		host.balloon_alert(M, "[host] is locked.")
		return FALSE
	A.add_fingerprint(M)
	var/atom/host = parent
	host.balloon_alert(M, "You start dumping out the contents...")
	var/turf/T = get_turf(A)
	var/list/things = contents()
	var/datum/progressbar/progress = new(M, length(things), T)
	while (do_after(M, 1 SECONDS, T, NONE, FALSE, CALLBACK(src, PROC_REF(mass_remove_from_storage), T, things, progress)))
		stoplag(1)
	progress.end_progress()

/datum/component/storage/proc/mass_remove_from_storage(atom/target, list/things, datum/progressbar/progress, trigger_on_found = TRUE)
	var/atom/real_location = real_location()
	for(var/obj/item/I in things)
		things -= I
		if(I.loc != real_location)
			continue
		remove_from_storage(I, target)
		I.pixel_x = rand(-10,10)
		I.pixel_y = rand(-10,10)
		if(trigger_on_found && I.on_found())
			return FALSE
		if(TICK_CHECK)
			progress.update(progress.goal - length(things))
			return TRUE
	progress.update(progress.goal - length(things))
	return FALSE

/datum/component/storage/proc/do_quick_empty(atom/_target)
	if(!_target)
		_target = get_turf(parent)
	if(usr)
		hide_from(usr)
	var/list/contents = contents()
	var/atom/real_location = real_location()
	for(var/obj/item/I in contents)
		if(I.loc != real_location)
			continue
		remove_from_storage(I, _target)
	return TRUE

/datum/component/storage/proc/set_locked(datum/source, new_state)
	SIGNAL_HANDLER

	locked = new_state
	if(locked)
		close_all()

/datum/component/storage/proc/_process_numerical_display()
	. = list()
	var/atom/real_location = real_location()
	for(var/obj/item/I in real_location.contents)
		if(QDELETED(I))
			continue
		if(!.["[I.type]-[I.name]"])
			.["[I.type]-[I.name]"] = new /datum/numbered_display(I, 1)
		else
			var/datum/numbered_display/ND = .["[I.type]-[I.name]"]
			ND.number++

//This proc determines the size of the inventory to be displayed. Please touch it only if you know what you're doing.
/datum/component/storage/proc/orient2hud()
	var/atom/real_location = real_location()
	var/adjusted_contents = real_location.contents.len

	//Numbered contents display
	var/list/datum/numbered_display/numbered_contents
	if(display_numerical_stacking)
		numbered_contents = _process_numerical_display()
		adjusted_contents = numbered_contents.len

	var/columns = clamp(max_items, 1, screen_max_columns)
	var/rows = clamp(CEILING(adjusted_contents / columns, 1), 1, screen_max_rows)
	standard_orient_objs(rows, columns, numbered_contents)

//This proc draws out the inventory and places the items on it. It uses the standard position.
/datum/component/storage/proc/standard_orient_objs(rows, cols, list/obj/item/numerical_display_contents)
	boxes.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+cols-1]:[screen_pixel_x],[screen_start_y+rows-1]:[screen_pixel_y]"
	var/cx = screen_start_x
	var/cy = screen_start_y
	if(islist(numerical_display_contents))
		for(var/type in numerical_display_contents)
			var/datum/numbered_display/ND = numerical_display_contents[type]
			ND.sample_object.mouse_opacity = MOUSE_OPACITY_OPAQUE
			ND.sample_object.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			ND.sample_object.maptext = MAPTEXT("<font color='white'>[(ND.number > 1)? "[ND.number]" : ""]</font>")
			ND.sample_object.plane = ABOVE_HUD_PLANE
			cx++
			if(cx - screen_start_x >= cols)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break
	else
		var/atom/real_location = real_location()
		for(var/obj/O in real_location)
			if(QDELETED(O))
				continue
			O.mouse_opacity = MOUSE_OPACITY_OPAQUE //This is here so storage items that spawn with contents correctly have the "click around item to equip"
			O.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			O.maptext = ""
			O.plane = ABOVE_HUD_PLANE
			cx++
			if(cx - screen_start_x >= cols)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break
	closer.screen_loc = "[screen_start_x + cols]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y]"

/datum/component/storage/proc/show_to(mob/M)
	if(!can_be_opened)
		to_chat(M, "<span class='warning'>You shouldn't rummage through garbage!</span>")
		return FALSE
	if(!M.client)
		return FALSE
	var/atom/real_location = real_location()
	if(M.active_storage != src && (M.stat == CONSCIOUS))
		for(var/obj/item/I in real_location)
			if(I.on_found(M))
				return FALSE
	if(M.active_storage)
		M.active_storage.hide_from(M)
	if(!istype(M, /mob/dead/observer))
		animate_parent()
	orient2hud()
	M.client.screen |= boxes
	M.client.screen |= closer
	M.client.screen |= real_location.contents
	M.set_active_storage(src)
	LAZYOR(is_using, M)
	RegisterSignal(M, COMSIG_PARENT_QDELETING, PROC_REF(mob_deleted))
	return TRUE

/datum/component/storage/proc/mob_deleted(datum/source)
	SIGNAL_HANDLER
	hide_from(source)

/datum/component/storage/proc/hide_from(mob/M)
	if(M.active_storage == src)
		M.set_active_storage(null)
	LAZYREMOVE(is_using, M)

	UnregisterSignal(M, COMSIG_PARENT_QDELETING)
	if(!M.client)
		return TRUE
	var/atom/real_location = real_location()
	M.client.screen -= boxes
	M.client.screen -= closer
	M.client.screen -= real_location.contents
	if(!istype(M, /mob/dead/observer))
		animate_parent()
	return TRUE

/datum/component/storage/proc/close(mob/M)
	hide_from(M)

/datum/component/storage/proc/close_all()
	SIGNAL_HANDLER

	. = FALSE
	for(var/mob/M in can_see_contents())
		close(M)
		. = TRUE //returns TRUE if any mobs actually got a close(M) call

/datum/component/storage/proc/emp_act(datum/source, severity)
	SIGNAL_HANDLER

	if(emp_shielded)
		return
	var/datum/component/storage/concrete/master = master()
	master.emp_act(source, severity)

//This proc draws out the inventory and places the items on it. tx and ty are the upper left tile and mx, my are the bottm right.
//The numbers are calculated from the bottom-left The bottom-left slot being 1,1.
/datum/component/storage/proc/orient_objs(tx, ty, mx, my)
	var/atom/real_location = real_location()
	var/cx = tx
	var/cy = ty
	boxes.screen_loc = "[tx]:,[ty] to [mx],[my]"
	for(var/obj/O in real_location)
		if(QDELETED(O))
			continue
		O.screen_loc = "[cx],[cy]"
		O.plane = ABOVE_HUD_PLANE
		cx++
		if(cx > mx)
			cx = tx
			cy--
	closer.screen_loc = "[mx+1],[my]"

//Resets something that is being removed from storage.
/datum/component/storage/proc/_removal_reset(atom/movable/thing)
	if(!istype(thing))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master._removal_reset(thing)

/datum/component/storage/proc/_remove_and_refresh(datum/source, atom/movable/gone, direction)
	SIGNAL_HANDLER

	_removal_reset(gone)
	refresh_mob_views()

//Call this proc to handle the removal of an item from the storage item. The item will be moved to the new_location target, if that is null it's being deleted
/datum/component/storage/proc/remove_from_storage(atom/movable/AM, atom/new_location)
	if(!istype(AM))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.remove_from_storage(AM, new_location)

/datum/component/storage/proc/refresh_mob_views()
	SIGNAL_HANDLER

	var/list/seeing = can_see_contents()
	for(var/i in seeing)
		show_to(i)
	return TRUE

/datum/component/storage/proc/can_see_contents()
	var/list/cansee = list()
	for(var/mob/M in is_using)
		if(M.active_storage == src && M.client)
			cansee |= M
		else
			LAZYREMOVE(is_using, M)
			UnregisterSignal(M, COMSIG_PARENT_QDELETING)
	return cansee

//Tries to dump content
/datum/component/storage/proc/dump_content_at(atom/dest_object, mob/M)
	var/atom/A = parent
	var/atom/dump_destination = dest_object.get_dumping_location()
	if(A.Adjacent(M) && dump_destination && M.Adjacent(dump_destination))
		if(locked)
			var/atom/host = parent
			host.balloon_alert(M, "[host] is locked.")
			return FALSE
		if(dump_destination.storage_contents_dump_act(src, M))
			playsound(A, "rustle", 50, 1, -5)
			return TRUE
	return FALSE

//This proc is called when you want to place an item into the storage item.
/datum/component/storage/proc/attackby(datum/source, obj/item/I, mob/M, params)
	SIGNAL_HANDLER

	if(istype(I, /obj/item/hand_labeler))
		var/obj/item/hand_labeler/labeler = I
		if(labeler.mode)
			return FALSE
	. = TRUE //no afterattack
	if(iscyborg(M))
		return
	if(!can_be_inserted(I, FALSE, M))
		return FALSE
	handle_item_insertion(I, FALSE, M)

/datum/component/storage/proc/return_inv(recursive)
	var/list/ret = list()
	ret |= contents()
	if(recursive)
		for(var/i in ret.Copy())
			var/atom/A = i
			SEND_SIGNAL(A, COMSIG_TRY_STORAGE_RETURN_INVENTORY, ret, TRUE)
	return ret

/datum/component/storage/proc/contents()			//ONLY USE IF YOU NEED TO COPY CONTENTS OF REAL LOCATION, COPYING IS NOT AS FAST AS DIRECT ACCESS!
	var/atom/real_location = real_location()
	return real_location.contents.Copy()

//Abuses the fact that lists are just references, or something like that.
/datum/component/storage/proc/signal_return_inv(datum/source, list/interface, recursive = TRUE)
	SIGNAL_HANDLER

	if(!islist(interface))
		return FALSE
	interface |= return_inv(recursive)
	return TRUE

/datum/component/storage/proc/mousedrop_onto(datum/source, atom/over_object, mob/M)
	SIGNAL_HANDLER

	set waitfor = FALSE
	. = COMPONENT_NO_MOUSEDROP
	var/atom/A = parent
	if(istype(A, /obj/item))
		var/obj/item/I = A
		I.remove_outline()	//Removes the outline when we drag
	if(!ismob(M))
		return
	if(!over_object)
		return
	if(ismecha(M.loc)) // stops inventory actions in a mech
		return
	if(M.incapacitated() || !M.canUseStorage())
		return
	A.add_fingerprint(M)
	// this must come before the screen objects only block, dunno why it wasn't before
	if(over_object == M)
		user_show_to_mob(M)
	if(!istype(over_object, /atom/movable/screen))
		INVOKE_ASYNC(src, PROC_REF(dump_content_at), over_object, M)
		return
	if(A.loc != M)
		return
	playsound(A, "rustle", 50, 1, -5)
	if(istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(A, H.held_index)
		return
	A.add_fingerprint(M)

/datum/component/storage/proc/user_show_to_mob(mob/M, force = FALSE)
	var/atom/A = parent
	if(!istype(M))
		return FALSE
	A.add_fingerprint(M)
	if(locked && !force)
		var/atom/host = parent
		host.balloon_alert(M, "[host] is locked.")
		return FALSE
	if(force || M.CanReach(parent, view_only = TRUE))
		show_to(M)

/datum/component/storage/proc/mousedrop_receive(datum/source, atom/movable/O, mob/M)
	SIGNAL_HANDLER

	if(isitem(O))
		var/obj/item/I = O
		if(iscarbon(M) || isdrone(M))
			var/mob/living/L = M
			if(!L.incapacitated() && I == L.get_active_held_item())
				if(!SEND_SIGNAL(I, COMSIG_CONTAINS_STORAGE) && can_be_inserted(I, FALSE, L))	//If it has storage it should be trying to dump, not insert.
					handle_item_insertion(I, FALSE, L)

//This proc return 1 if the item can be picked up and 0 if it can't.
//Set the stop_messages to stop it from printing messages
/datum/component/storage/proc/can_be_inserted(obj/item/I, stop_messages = FALSE, mob/M)
	if(!istype(I) || I.anchored || (I.item_flags & ABSTRACT))
		return FALSE //Not an item
	if(I == parent)
		return FALSE	//no paradoxes for you
	var/atom/real_location = real_location()
	var/atom/host = parent
	if(real_location == I.loc)
		return FALSE //Means the item is already in the storage item
	if(!insert_while_closed && !(M in is_using))
		return FALSE
	if(locked)
		if(M && !stop_messages)
			host.add_fingerprint(M)
			host.balloon_alert(M, "[host] is locked.")
		return FALSE
	if(real_location.contents.len >= max_items)
		if(!stop_messages)
			host.balloon_alert(M, "[host] is full")
		return FALSE //Storage item is full
	if(length(can_hold))
		if(!is_type_in_typecache(I, can_hold))
			if(!stop_messages)
				host.balloon_alert(M, "It doesn't fit")
			return FALSE
	if(is_type_in_typecache(I, cant_hold) || HAS_TRAIT(I, TRAIT_NO_STORAGE_INSERT) || (can_hold_trait && !HAS_TRAIT(I, can_hold_trait))) //Items which this container can't hold.
		if(!stop_messages)
			host.balloon_alert(M, "It doesn't fit")
		return FALSE
	if(!length(exception_hold) || !is_type_in_typecache(I, exception_hold))
		if(I.w_class > max_w_class)
			if(!stop_messages)
				host.balloon_alert(M, "[I] is too big")
			return FALSE
		var/sum_w_class = I.w_class
		for(var/obj/item/_I in real_location)
			if(!length(exception_hold) || !is_type_in_typecache(I, exception_hold)) //we want to exclude items that are part of the exception list from counting toward capacity.
				sum_w_class += _I.w_class //Adds up the combined w_classes which will be in the storage item if the item is added to it.
		if(sum_w_class > max_combined_w_class)
			if(!stop_messages)
				host.balloon_alert(M, "[host] is full")
			return FALSE
	if(isitem(host))
		var/obj/item/IP = host
		var/datum/component/storage/STR_I = I.GetComponent(/datum/component/storage)
		if((I.w_class >= IP.w_class) && STR_I && !allow_big_nesting)
			if(!stop_messages)
				host.balloon_alert(M, "It's too big")
			return FALSE //To prevent the stacking of same sized storage items.
	if(HAS_TRAIT(I, TRAIT_NODROP)) //SHOULD be handled in unEquip, but better safe than sorry.
		if(!stop_messages)
			host.balloon_alert(M, "[I] is stuck to your hand")
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.slave_can_insert_object(src, I, stop_messages, M)

/datum/component/storage/proc/_insert_physical_item(obj/item/I, override = FALSE)
	return FALSE

//This proc handles items being inserted. It does not perform any checks of whether an item can or can't be inserted. That's done by can_be_inserted()
//The prevent_warning parameter will stop the insertion message from being displayed. It is intended for cases where you are inserting multiple items at once,
//such as when picking up all the items on a tile with one click.
/datum/component/storage/proc/handle_item_insertion(obj/item/I, prevent_warning = FALSE, mob/M, datum/component/storage/remote)
	var/atom/parent = src.parent
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	if(silent)
		prevent_warning = TRUE
	if(M)
		parent.add_fingerprint(M)
	. = master.handle_item_insertion_from_slave(src, I, prevent_warning, M)

/datum/component/storage/proc/mob_item_insertion_feedback(mob/user, mob/M, obj/item/I, override = FALSE)
	if(silent && !override)
		return
	if(rustle_sound)
		playsound(parent, "rustle", 50, 1, -5)
	if(!istype(user, /mob/dead/observer))
		animate_parent()
	for(var/mob/viewing as() in viewers(user))
		if(M == viewing)
			to_chat(usr, "<span class='notice'>You put [I] [insert_preposition]to [parent].</span>")
		else if(in_range(M, viewing)) //If someone is standing close enough, they can tell what it is...
			viewing.show_message("<span class='notice'>[M] puts [I] [insert_preposition]to [parent].</span>", MSG_VISUAL)
		else if(I && I.w_class >= 3) //Otherwise they can only see large or normal items from a distance...
			viewing.show_message("<span class='notice'>[M] puts [I] [insert_preposition]to [parent].</span>", MSG_VISUAL)

/datum/component/storage/proc/update_icon()
	if(isobj(parent))
		var/obj/O = parent
		O.update_icon()

/datum/component/storage/proc/signal_insertion_attempt(datum/source, obj/item/I, mob/M, silent = FALSE, force = FALSE)
	SIGNAL_HANDLER

	if((!force && !can_be_inserted(I, TRUE, M)) || (I == parent))
		return FALSE
	return handle_item_insertion(I, silent, M)

/datum/component/storage/proc/signal_can_insert(datum/source, obj/item/I, mob/M, silent = FALSE)
	SIGNAL_HANDLER

	return can_be_inserted(I, silent, M)

/datum/component/storage/proc/show_to_ghost(datum/source, mob/dead/observer/M)
	SIGNAL_HANDLER

	return user_show_to_mob(M, TRUE)

/datum/component/storage/proc/signal_show_attempt(datum/source, mob/showto, force = FALSE)
	SIGNAL_HANDLER

	return user_show_to_mob(showto, force)

/datum/component/storage/proc/on_check()
	SIGNAL_HANDLER

	return TRUE

/datum/component/storage/proc/check_locked()
	SIGNAL_HANDLER

	return locked

/datum/component/storage/proc/signal_take_type(datum/source, typecache, atom/destination, amount = INFINITY, check_adjacent = FALSE, force = FALSE, mob/user, list/inserted)
	SIGNAL_HANDLER

	if(!force)
		if(check_adjacent)
			if(!user || !user.CanReach(destination) || !user.CanReach(parent))
				return FALSE
	var/list/taking = typecache_filter_list(contents(), typecache)
	if(taking.len > amount)
		taking.len = amount
	if(inserted)			//duplicated code for performance, don't bother checking retval/checking for list every item.
		for(var/i in taking)
			if(remove_from_storage(i, destination))
				inserted |= i
	else
		for(var/i in taking)
			remove_from_storage(i, destination)
	return TRUE

/datum/component/storage/proc/remaining_space_items()
	var/atom/real_location = real_location()
	return max(0, max_items - real_location.contents.len)

/datum/component/storage/proc/signal_fill_type(datum/source, type, amount = 20, force = FALSE)
	SIGNAL_HANDLER

	var/atom/real_location = real_location()
	if(!force)
		amount = min(remaining_space_items(), amount)
	for(var/i in 1 to amount)
		handle_item_insertion(new type(real_location), TRUE)
		if(QDELETED(src))
			return TRUE
	return TRUE

/datum/component/storage/proc/on_attack_hand(datum/source, mob/user)
	SIGNAL_HANDLER

	var/atom/A = parent
	if(!attack_hand_interact)
		return
	if(user.active_storage == src && A.loc == user) //if you're already looking inside the storage item
		user.active_storage.close(user)
		close(user)
		. = COMPONENT_NO_ATTACK_HAND
		return

	if(rustle_sound)
		playsound(A, "rustle", 50, 1, -5)

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.l_store == A && !H.get_active_held_item())	//Prevents opening if it's in a pocket.
			. = COMPONENT_NO_ATTACK_HAND
			INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, put_in_hands), A)
			H.l_store = null
			return
		if(H.r_store == A && !H.get_active_held_item())
			. = COMPONENT_NO_ATTACK_HAND
			INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, put_in_hands), A)
			H.r_store = null
			return

	if(A.loc == user)
		. = COMPONENT_NO_ATTACK_HAND
		if(locked)
			var/atom/host = parent
			host.balloon_alert(user, "[host] is locked.")
		else if(!can_be_opened)
			user.doUnEquip(parent, FALSE, null, TRUE, silent = TRUE)
			user.put_in_active_hand(parent)
		else
			show_to(user)

/datum/component/storage/proc/signal_on_pickup(datum/source, mob/user)
	SIGNAL_HANDLER

	var/atom/A = parent
	update_actions()
	for(var/mob/M as() in hearers(1, A))
		if(M.active_storage == src)
			close(M)

/datum/component/storage/proc/signal_take_obj(datum/source, atom/movable/AM, new_loc, force = FALSE)
	SIGNAL_HANDLER

	if(!(AM in real_location()))
		return FALSE
	return remove_from_storage(AM, new_loc)

/datum/component/storage/proc/signal_quick_empty(datum/source, atom/loctarget)
	SIGNAL_HANDLER

	return do_quick_empty(loctarget)

/datum/component/storage/proc/signal_hide_attempt(datum/source, mob/target)
	SIGNAL_HANDLER

	return hide_from(target)

/datum/component/storage/proc/on_alt_click(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!isliving(user) || !user.CanReach(parent))
		return
	if(locked)
		var/atom/host = parent
		host.balloon_alert(user, "[host] is locked.")
		return COMPONENT_INTERCEPT_ALT

	var/atom/A = parent
	if(!quickdraw)
		A.add_fingerprint(user)
		user_show_to_mob(user)
		playsound(A, "rustle", 50, 1, -5)
		return COMPONENT_INTERCEPT_ALT

	if(user.incapacitated())
		return

	var/obj/item/to_remove = locate() in real_location()
	if(!to_remove)
		return COMPONENT_INTERCEPT_ALT
	INVOKE_ASYNC(src, PROC_REF(attempt_put_in_hands), to_remove, user)
	return COMPONENT_INTERCEPT_ALT

///attempt to put an item from contents into the users hands
/datum/component/storage/proc/attempt_put_in_hands(obj/item/to_remove, mob/user)
	var/atom/parent_as_atom = parent

	parent_as_atom.add_fingerprint(user)
	remove_from_storage(to_remove, get_turf(user))
	if(!user.put_in_hands(to_remove))
		to_chat(user, "<span class='notice'>You fumble for [to_remove] and it falls on the floor.</span>")
		return
	user.visible_message("<span class='warning'>[user] draws [to_remove] from [parent]!</span>", "<span class='notice'>You draw [to_remove] from [parent].</span>")
	return

/datum/component/storage/proc/action_trigger(datum/signal_source, datum/action/source)
	SIGNAL_HANDLER

	gather_mode_switch(source.owner)
	return COMPONENT_ACTION_BLOCK_TRIGGER

/datum/component/storage/proc/gather_mode_switch(mob/user)
	collection_mode = (collection_mode+1)%3
	switch(collection_mode)
		if(COLLECT_SAME)
			user.balloon_alert(user, "[parent] now picks up all items of single type")
		if(COLLECT_EVERYTHING)
			user.balloon_alert(user, "[parent] now picks up all items")
		if(COLLECT_ONE)
			user.balloon_alert(user, "[parent] now picks up single item")

/datum/component/storage/proc/animate_parent()
	if(!animated)
		return
	var/atom/parent_atom = parent
	var/matrix/M = parent_atom.transform
	var/matrix/old_M = parent_atom.transform
	animate(parent, time = 1.5, loop = 0, transform = M.Scale(1.11, 0.85))
	animate(time = 2, transform = old_M)
