#define CHAMELEON_MANUAL_COOLDOWN 2 MINUTES

/// The action for the chameleon panel.
/datum/action/chameleon_panel
	name = "Chameleon Outfit Panel"
	button_icon_state = "chameleon_outfit"
	COOLDOWN_DECLARE(next_manual)

/datum/action/chameleon_panel/Trigger()
	if(!IsAvailable())
		return
	ui_interact(owner)

/datum/action/chameleon_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChameleonPanel")
		ui.set_autoupdate(TRUE)
		ui.open()

/datum/action/chameleon_panel/ui_state(mob/user)
	return GLOB.not_incapacitated_state

/datum/action/chameleon_panel/ui_static_data(mob/user)
	. = list(
		"outfits" = list(),
		"icons" = list(
			"outfits" = list()
		)
	)
	var/list/assets_to_send = list()
	for(var/outfit_path in subtypesof(/datum/outfit/job))
		var/datum/outfit/outfit = outfit_path
		if(initial(outfit.can_be_admin_equipped))
			.["outfits"] += list(list(
				"name" = initial(outfit.name),
				"type" = "[outfit]"
			))
			var/outfit_asset = get_outfit_icon(outfit_path)
			if(outfit_asset)
				.["icons"]["outfits"]["[outfit]"] = SSassets.transport.get_asset_url(outfit_asset)
				assets_to_send += outfit_asset
			CHECK_TICK
	sortTim(.["outfits"], GLOBAL_PROC_REF(cmp_list_name_asc))
	if(user.client && LAZYLEN(assets_to_send))
		SSassets.transport.send_assets(user.client, assets_to_send)

/datum/action/chameleon_panel/ui_data(mob/user)
	var/mob/living/l_user = isliving(user) ? user : null
	. = list(
		"chameleon_items" = list(),
		"manual" = list(
			"can_craft" = HAS_TRAIT(user, TRAIT_CHAMELEON_USER) || (l_user?.mind && HAS_TRAIT(l_user.mind, TRAIT_CHAMELEON_USER)),
			"cooldown" = round(max(COOLDOWN_TIMELEFT(src, next_manual) / 10, 0))
		)
	)
	var/list/names = list()
	for(var/C in get_chameleon_items(user))
		var/datum/component/chameleon/chameleon = C
		var/item_name = name_slot(user, names, chameleon)
		var/slot_name = user.get_inventory_slot_name(chameleon.parent)
		names += item_name
		var/list/disguise_choices = list()
		for(var/D in chameleon.disguise_paths)
			var/obj/item/disguise = D
			disguise_choices += list(list(
				"name" = initial(disguise.name),
				"icon_name" = initial(disguise.icon_state),
				"type" = "[D]"
			))
			CHECK_TICK
		sortTim(disguise_choices, GLOBAL_PROC_REF(cmp_list_name_asc))
		.["chameleon_items"] += list(list(
			"name" = item_name,
			"slot" = slot_name,
			"ref" = REF(chameleon),
			"type" = "[chameleon.parent.type]",
			"extra_actions" = assoc_list_strip_value(chameleon.extra_actions),
			"disguises" = disguise_choices,
			"current_disguise" = "[chameleon.current_disguise]"
		))
		CHECK_TICK
	sortTim(.["chameleon_items"], GLOBAL_PROC_REF(cmp_list_name_asc))

/datum/action/chameleon_panel/ui_act(action, list/params)
	if(..())
		return
	if(!isliving(usr))
		return FALSE
	var/mob/living/user = usr
	switch(action)
		if("extra_action")
			. = TRUE
			var/ref = params["ref"]
			var/action_name = params["action"]
			if(!istext(ref) || !istext(action_name))
				return FALSE
			var/datum/component/chameleon/chameleon = locate(ref)
			if(!chameleon || !istype(chameleon) || !chameleon?.can_use(user))
				return FALSE
			var/datum/callback/callback = chameleon.extra_actions[action_name]
			if(!callback)
				return FALSE
			callback.InvokeAsync(user, chameleon)
		if("disguise")
			. = TRUE
			var/ref = params["ref"]
			var/slot = params["slot"]
			var/disguise = params["type"]
			if((!istext(ref) && !isnum(slot)) || !istext(disguise))
				return FALSE
			var/disguise_path = text2path(disguise)
			if(!disguise_path)
				return FALSE
			var/datum/component/chameleon/chameleon
			if(istext(ref))
				chameleon = locate(ref)
			else if(isnum(slot))
				var/obj/item/slot_item = user.get_item_by_slot(slot)
				chameleon = slot_item?.GetComponent(/datum/component/chameleon)
			if(!chameleon || !istype(chameleon) || !chameleon?.can_use(user) || !(disguise_path in chameleon.disguise_paths))
				return FALSE
			chameleon.disguise(user, disguise_path)
		if("equip_outfit")
			. = TRUE
			var/outfit = params["outfit"]
			if(!istext(outfit))
				return FALSE
			var/outfit_path = text2path(outfit)
			if(!ispath(outfit_path, /datum/outfit))
				return FALSE
			load_outfit(usr, outfit_path)
		if("create_manual")
			. = TRUE
			if(!HAS_TRAIT(usr, TRAIT_CHAMELEON_USER) && !HAS_TRAIT(usr.mind, TRAIT_CHAMELEON_USER))
				to_chat(usr, "<span class='warning'>You don't know how to make a chameleon manual!</span>")
				return FALSE
			if(!COOLDOWN_FINISHED(src, next_manual))
				to_chat(usr, "<span class='warning'>Please wait [DisplayTimeText(next_manual - world.time)] before creating another manual!</span>")
				return FALSE
			var/obj/item/book/granter/chameleon/manual = new(usr.drop_location())
			usr.put_in_hands(manual)
			to_chat(usr, "<span class='notice'>You swiftly put together a manual to teach others how to use chameleon items!</span>")
			COOLDOWN_START(src, next_manual, CHAMELEON_MANUAL_COOLDOWN)

/datum/action/chameleon_panel/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/chameleon)
	)

/datum/action/chameleon_panel/proc/get_outfit_icon(outfit_path)
	if(!ispath(outfit_path))
		return
	var/datum/outfit/outfit = outfit_path
	if(!initial(outfit.can_be_admin_equipped))
		return
	var/asset_name = SANITIZE_FILENAME("outfit_[replacetext(replacetext("[outfit_path]", "/datum/outfit/job/", ""), "/", "-")].png")
	if(SSassets.cache[asset_name])
		return asset_name
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_OUTFIT)
	for(var/I in mannequin.get_equipped_items(TRUE))
		qdel(I)
	mannequin.set_species(/datum/species/human, TRUE)
	mannequin.setDir(SOUTH)
	mannequin.equipOutfit(outfit_path, visualsOnly=TRUE)
	COMPILE_OVERLAYS(mannequin)
	var/asset = fcopy_rsc(getFlatIcon(mannequin, no_anim=TRUE))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_OUTFIT)
	if(!asset)
		return
	if(!SSassets.transport.register_asset(asset_name, asset))
		return
	return asset_name

/datum/action/chameleon_panel/proc/load_outfit(mob/living/user, outfit_path)
	. = TRUE
	if(!istype(user) || !ispath(outfit_path, /datum/outfit))
		return FALSE
	var/datum/outfit/outfit = outfit_path
	if(!initial(outfit.can_be_admin_equipped))
		return FALSE
	if(initial(outfit.uniform))
		attempt_to_disguise_slot(user, ITEM_SLOT_ICLOTHING, initial(outfit.uniform))
	if(initial(outfit.suit))
		attempt_to_disguise_slot(user, ITEM_SLOT_OCLOTHING, initial(outfit.suit))
	if(initial(outfit.back))
		attempt_to_disguise_slot(user, ITEM_SLOT_BACK, initial(outfit.back))
	if(initial(outfit.belt))
		attempt_to_disguise_slot(user, ITEM_SLOT_BELT, initial(outfit.belt))
	if(initial(outfit.gloves))
		attempt_to_disguise_slot(user, ITEM_SLOT_GLOVES, initial(outfit.gloves))
	if(initial(outfit.shoes))
		attempt_to_disguise_slot(user, ITEM_SLOT_FEET, initial(outfit.shoes))
	if(initial(outfit.head))
		attempt_to_disguise_slot(user, ITEM_SLOT_HEAD, initial(outfit.head))
	if(initial(outfit.mask))
		attempt_to_disguise_slot(user, ITEM_SLOT_MASK, initial(outfit.mask))
	if(initial(outfit.neck))
		attempt_to_disguise_slot(user, ITEM_SLOT_NECK, initial(outfit.neck))
	if(initial(outfit.ears))
		attempt_to_disguise_slot(user, ITEM_SLOT_EARS, initial(outfit.ears))
	if(initial(outfit.glasses))
		attempt_to_disguise_slot(user, ITEM_SLOT_EYES, initial(outfit.glasses))
	if(initial(outfit.id))
		attempt_to_disguise_slot(user, ITEM_SLOT_ID, initial(outfit.id))

/datum/action/chameleon_panel/proc/attempt_to_disguise_slot(mob/living/user, slot, disguise_path)
	. = TRUE
	if(!istype(user) || !ispath(disguise_path, /obj/item))
		return FALSE
	var/obj/item/item_in_slot = user.get_item_by_slot(slot)
	if(!item_in_slot || !istype(item_in_slot))
		return FALSE
	var/datum/component/chameleon/chameleon = item_in_slot.GetComponent(/datum/component/chameleon)
	if(!chameleon?.can_use(user))
		return FALSE
	chameleon.disguise(user, disguise_path)

/datum/action/chameleon_panel/proc/name_slot(mob/living/user, names_so_far, datum/component/chameleon/chameleon)
	var/base_name = chameleon.original_name
	var/name = base_name
	var/suffix = 1
	while(name in names_so_far)
		name = "[base_name] ([suffix++])"
	return name

/datum/action/chameleon_panel/proc/get_chameleon_items(mob/user)
	. = list()
	for(var/O in user.contents)
		if(!isitem(O))
			continue
		var/obj/item/item = O
		var/datum/component/chameleon/chameleon = item.GetComponent(/datum/component/chameleon)
		if(chameleon?.can_use(user))
			. += chameleon

#undef CHAMELEON_MANUAL_COOLDOWN
