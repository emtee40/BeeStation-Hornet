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
	var/mob/living/l_user = isliving(user) ? user : null
	. = list(
		"outfits" = list(),
		"presets" = list(),
		"icons" = list(
			"outfits" = list(),
			"presets" = list()
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
	if(l_user?.mind)
		var/list/user_presets = l_user.mind.chameleon_presets
		if(LAZYLEN(user_presets))
			for(var/preset_name in user_presets)
				var/list/preset = user_presets[preset_name]
				var/list/preset_contents = list()
				for(var/slot in preset)
					var/obj/item/item = preset[slot]
					preset_contents += list(list(
						"slot_name" = GLOB.slot_names[slot] || "other",
						"slot_id" = text2num(slot),
						"name" = "[initial(item.name)] ([initial(item.icon_state)])",
						"type" = "[item]"
					))
				sortTim(preset_contents, GLOBAL_PROC_REF(cmp_list_slot_id_asc))
				.["presets"] += list(list(
					"name" = preset_name,
					"contents" = preset_contents
				))
				var/preset_asset = get_preset_icon(l_user.mind, preset_name)
				if(preset_asset)
					.["icons"]["presets"]["[preset_name]"] = SSassets.transport.get_asset_url(preset_asset)
					assets_to_send += preset_asset
				CHECK_TICK
			sortTim(.["presets"], GLOBAL_PROC_REF(cmp_list_name_asc))
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
			"ref" = REF(chameleon),
			"type" = "[chameleon.parent.type]",
			"extra_actions" = assoc_list_strip_value(chameleon.extra_actions),
			"disguises" = disguise_choices,
			"current_disguise" = "[chameleon.current_disguise]"
		))
		CHECK_TICK
	if(LAZYLEN(user?.mind?.chameleon_presets))
		var/list/user_presets = user.mind.chameleon_presets
		for(var/preset_name in user_presets)
			var/list/raw_preset = user_presets[preset_name]
			var/list/preset = list()
			for(var/slot in raw_preset)
				var/slot_name = GLOB.slot_names[slot] || "unknown slot"
				var/disguise_path = raw_preset[slot]
				var/obj/item/disguise_item = disguise_path
				preset += list(list(
					"slot_id" = text2num(slot),
					"name" = slot_name,
					"item_name" = "[initial(disguise_item.name)] ([initial(disguise_item.icon_state)])",
					"item_type" = "[disguise_path]"
				))
				CHECK_TICK
			sortTim(preset, GLOBAL_PROC_REF(cmp_list_name_asc))
			.["presets"] += list(list(
				"name" = preset_name,
				"preset" = preset
			))
			CHECK_TICK
		sortTim(.["presets"], GLOBAL_PROC_REF(cmp_list_name_asc))
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
		if("save_preset")
			. = TRUE
			save_preset(user)
		if("load_preset")
			. = TRUE
			var/preset = params["preset"]
			if(!istext(preset) || !LAZYLEN(user.mind?.chameleon_presets))
				return FALSE
			load_preset(user, preset)
		if("delete_preset")
			. = TRUE
			var/preset = params["preset"]
			if(!istext(preset) || !LAZYLEN(user.mind?.chameleon_presets))
				return FALSE
			user.mind.chameleon_presets -= preset
			to_chat(usr, "<span class='notice'>Your chameleon preset '[preset]' was deleted.</span>")
		if("rename_preset")
			. = TRUE
			var/from_preset = params["from"]
			var/to_preset = params["from"]
			if(!istext(from_preset) || !istext(to_preset) || !LAZYLEN(user.mind?.chameleon_presets) || !user.mind.chameleon_presets[from_preset] || user.mind.chameleon_presets[to_preset])
				return FALSE
			user.mind.chameleon_presets[to_preset] = user.mind.chameleon_presets[from_preset]
			user.mind.chameleon_presets -= from_preset
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

/datum/action/chameleon_panel/proc/get_preset_icon(datum/mind/user, preset_name)
	if(!user || !istype(user) || !istext(preset_name) || !LAZYLEN(user.chameleon_presets))
		return
	var/asset_name = SANITIZE_FILENAME("preset_[rustg_hash_string(RUSTG_HASH_XXH64, REF(user))]_[rustg_hash_string(RUSTG_HASH_XXH64, preset_name)].png")
	if(SSassets.cache[asset_name])
		return asset_name
	var/list/preset = user.chameleon_presets[preset_name]
	if(!LAZYLEN(preset))
		return
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_OUTFIT)
	for(var/I in mannequin.get_equipped_items(TRUE))
		qdel(I)
	mannequin.set_species(/datum/species/human, TRUE)
	mannequin.setDir(SOUTH)
	for(var/slot in preset)
		var/item = preset[slot]
		if(!ispath(item, /obj/item))
			continue
		mannequin.equip_to_slot_or_del(new item, slot)
	COMPILE_OVERLAYS(mannequin)
	var/asset = fcopy_rsc(getFlatIcon(mannequin, no_anim=TRUE))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_OUTFIT)
	if(!asset)
		return
	if(!SSassets.transport.register_asset(asset_name, asset))
		return
	return asset_name

/datum/action/chameleon_panel/proc/save_preset(mob/living/user)
	var/static/slots_to_save = list(
		ITEM_SLOT_OCLOTHING, ITEM_SLOT_ICLOTHING, ITEM_SLOT_GLOVES, ITEM_SLOT_EYES, ITEM_SLOT_EARS,
		ITEM_SLOT_MASK, ITEM_SLOT_HEAD, ITEM_SLOT_FEET, ITEM_SLOT_ID, ITEM_SLOT_BELT, ITEM_SLOT_BACK,
		ITEM_SLOT_NECK
	)
	if(!istype(user) || !user?.mind)
		return
	var/list/preset = list()
	for(var/slot in slots_to_save)
		var/obj/item/item = user.get_item_by_slot(slot)
		if(!item || !istype(item) || !(item.type in GLOB.all_available_chameleon_types))
			continue
		var/datum/component/chameleon/chameleon = item.GetComponent(/datum/component/chameleon)
		to_chat(user, "<span class='notice'>Saving \the [item] to the new preset!</span>")
		if(chameleon?.current_disguise)
			preset["[slot]"] = chameleon.current_disguise
		else
			preset["[slot]"] = item.type
	if(!LAZYLEN(preset))
		to_chat(user, "<span class='warning'>Could not find any valid clothes to save to a new chameleon preset!</span>")
		return
	var/suffix = 1
	var/name
	while(!name || (LAZYLEN(user.mind?.chameleon_presets) && user.mind.chameleon_presets[name]))
		name = "New Preset #[suffix++]"
	LAZYSET(user.mind.chameleon_presets, name, preset)
	update_static_data(user)

/datum/action/chameleon_panel/proc/load_preset(mob/living/user, preset_name)
	. = TRUE
	if(!istype(user) || !user.mind || !istext(preset_name) || !LAZYLEN(user.mind.chameleon_presets))
		return FALSE
	var/list/preset = user.mind.chameleon_presets[preset_name]
	for(var/slot in preset)
		var/item = preset[slot]
		if(!ispath(item, /obj/item))
			continue
		var/obj/item/slot_item = user.get_item_by_slot(text2num(slot))
		if(!istype(slot_item))
			continue
		var/datum/component/chameleon/chameleon = slot_item.GetComponent(/datum/component/chameleon)
		if(!chameleon?.can_use(user))
			continue
		chameleon.disguise(user, item)

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
	var/slot_name = user.get_inventory_slot_name(chameleon.parent)
	if(slot_name)
		base_name = "[chameleon.original_name] on [slot_name]"
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
