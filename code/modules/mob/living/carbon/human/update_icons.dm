	///////////////////////
	//UPDATE_ICONS SYSTEM//
	///////////////////////
/* Keep these comments up-to-date if you -insist- on hurting my code-baby ;_;
This system allows you to update individual mob-overlays, without regenerating them all each time.
When we generate overlays we generate the standing version and then rotate the mob as necessary..

As of the time of writing there are 20 layers within this list. Please try to keep this from increasing. //22 and counting, good job guys
	var/overlays_standing[20]		//For the standing stance

Most of the time we only wish to update one overlay:
	e.g. - we dropped the fireaxe out of our left hand and need to remove its icon from our mob
	e.g.2 - our hair colour has changed, so we need to update our hair icons on our mob
In these cases, instead of updating every overlay using the old behaviour (regenerate_icons), we instead call
the appropriate update_X proc.
	e.g. - update_l_hand()
	e.g.2 - update_hair()

Note: Recent changes by aranclanos+carn:
	update_icons() no longer needs to be called.
	the system is easier to use. update_icons() should not be called unless you absolutely -know- you need it.
	IN ALL OTHER CASES it's better to just call the specific update_X procs.

Note: The defines for layer numbers is now kept exclusvely in __DEFINES/misc.dm instead of being defined there,
	then redefined and undefiend everywhere else. If you need to change the layering of sprites (or add a new layer)
	that's where you should start.

All of this means that this code is more maintainable, faster and still fairly easy to use.

There are several things that need to be remembered:
>	Whenever we do something that should cause an overlay to update (which doesn't use standard procs
	( i.e. you do something like l_hand = /obj/item/something new(src), rather than using the helper procs)
	You will need to call the relevant update_inv_* proc

	All of these are named after the variable they update from. They are defined at the mob/ level like
	update_clothing was, so you won't cause undefined proc runtimes with usr.update_inv_wear_id() if the usr is a
	slime etc. Instead, it'll just return without doing any work. So no harm in calling it for slimes and such.


>	There are also these special cases:
		update_damage_overlays()	//handles damage overlays for brute/burn damage
		update_body()				//Handles updating your mob's body layer and mutant bodyparts
									as well as sprite-accessories that didn't really fit elsewhere (underwear, undershirts, socks, lips, eyes)
									//NOTE: update_mutantrace() is now merged into this!
		update_hair()				//Handles updating your hair overlay (used to be update_face, but mouth and
									eyes were merged into update_body())


*/

//HAIR OVERLAY
/mob/living/carbon/human/update_hair()
	dna.species.handle_hair(src)

//used when putting/removing clothes that hide certain mutant body parts to just update those and not update the whole body.
/mob/living/carbon/human/proc/update_mutant_bodyparts()
	dna.species.handle_mutant_bodyparts(src)


/mob/living/carbon/human/update_body()
	remove_overlay(BODY_LAYER)
	dna.species.handle_body(src)
	..()

/mob/living/carbon/human/update_fire()
	..((fire_stacks > HUMAN_FIRE_STACK_ICON_NUM) ? "Standing" : "Generic_mob_burning")


/* --------------------------------------- */
//For legacy support.
/mob/living/carbon/human/regenerate_icons()

	if(!..())
		icon_render_key = null //invalidate bodyparts cache
		update_body()
		update_hair()
		update_inv_w_uniform()
		update_inv_wear_id()
		update_inv_gloves()
		update_inv_glasses()
		update_inv_ears()
		update_inv_shoes()
		update_inv_s_store()
		update_inv_wear_mask()
		update_inv_head()
		update_inv_belt()
		update_inv_back()
		update_inv_wear_suit()
		update_inv_pockets()
		update_inv_neck()
		update_transform()
		//mutations
		update_mutations_overlay()
		//damage overlays
		update_damage_overlays()

/* --------------------------------------- */
//vvvvvv UPDATE_INV PROCS vvvvvv

/mob/living/carbon/human/update_inv_w_uniform()
	remove_overlay(UNIFORM_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ICLOTHING) + 1]
		inv.update_icon()

	if(istype(w_uniform, /obj/item/clothing/under))
		var/obj/item/clothing/under/U = w_uniform
		U.screen_loc = ui_iclothing
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += w_uniform
		update_observer_view(w_uniform,1)

		if(wear_suit && (wear_suit.flags_inv & HIDEJUMPSUIT))
			return


		var/t_color = U.item_color
		if(!t_color)
			t_color = U.icon_state
		if(U.adjusted == ALT_STYLE)
			t_color = "[t_color]_d"
		else if(U.adjusted == DIGITIGRADE_STYLE)
			t_color = "[t_color]_l"

		var/mutable_appearance/uniform_overlay

		if(dna && dna.species.sexes)
			var/G = (gender == FEMALE) ? "f" : "m"
			if(G == "f" && U.fitted != NO_FEMALE_UNIFORM)
				uniform_overlay = U.build_worn_icon(state = "[t_color]", default_layer = UNIFORM_LAYER, default_icon_file = 'icons/mob/uniform.dmi', isinhands = FALSE, femaleuniform = U.fitted)

		var/icon_file = 'icons/mob/uniform.dmi'
		if(!uniform_overlay)
			if(U.sprite_sheets & (dna?.species.bodyflag))
				icon_file = dna.species.get_custom_icons("uniform")
			uniform_overlay = U.build_worn_icon(state = "[t_color]", default_layer = UNIFORM_LAYER, default_icon_file = icon_file, isinhands = FALSE)


		if(OFFSET_UNIFORM in dna.species.offset_features)
			uniform_overlay.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
			uniform_overlay.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
		overlays_standing[UNIFORM_LAYER] = uniform_overlay

	apply_overlay(UNIFORM_LAYER)
	update_mutant_bodyparts()


/mob/living/carbon/human/update_inv_wear_id()
	remove_overlay(ID_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ID) + 1]
		inv.update_icon()

	var/mutable_appearance/id_overlay = overlays_standing[ID_LAYER]

	if(wear_id)
		var/icon_file = 'icons/mob/mob.dmi'
		wear_id.screen_loc = ui_id
		if(client && hud_used && hud_used.hud_shown)
			client.screen += wear_id
		update_observer_view(wear_id)
		if(istype(wear_id, /obj/item))
			var/obj/item/I = wear_id
			if(I.sprite_sheets & dna?.species.bodyflag)
				icon_file = dna.species.get_custom_icons("generic")
		//TODO: add an icon file for ID slot stuff, so it's less snowflakey
		id_overlay = wear_id.build_worn_icon(state = wear_id.item_state, default_layer = ID_LAYER, default_icon_file = icon_file)
		if(OFFSET_ID in dna.species.offset_features)
			id_overlay.pixel_x += dna.species.offset_features[OFFSET_ID][1]
			id_overlay.pixel_y += dna.species.offset_features[OFFSET_ID][2]
		overlays_standing[ID_LAYER] = id_overlay

	apply_overlay(ID_LAYER)


/mob/living/carbon/human/update_inv_gloves()
	remove_overlay(GLOVES_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1]
		inv.update_icon()

	if(!gloves && bloody_hands)
		var/mutable_appearance/bloody_overlay = mutable_appearance('icons/effects/blood.dmi', "bloodyhands", -GLOVES_LAYER)
		if(get_num_arms(FALSE) < 2)
			if(has_left_hand(FALSE))
				bloody_overlay.icon_state = "bloodyhands_left"
			else if(has_right_hand(FALSE))
				bloody_overlay.icon_state = "bloodyhands_right"

		overlays_standing[GLOVES_LAYER] = bloody_overlay

	var/mutable_appearance/gloves_overlay = overlays_standing[GLOVES_LAYER]
	if(gloves)
		var/icon_file = 'icons/mob/hands.dmi'
		if(istype(gloves, /obj/item/clothing/gloves))
			var/obj/item/clothing/gloves/G = gloves
			if(G.sprite_sheets & (dna?.species.bodyflag))
				icon_file = dna.species.get_custom_icons("gloves")
		gloves.screen_loc = ui_gloves
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += gloves
		update_observer_view(gloves,1)
		var/t_state = gloves.item_state
		if(!t_state)
			t_state = gloves.icon_state
		overlays_standing[GLOVES_LAYER] = gloves.build_worn_icon(state = t_state, default_layer = GLOVES_LAYER, default_icon_file = icon_file)
		gloves_overlay = overlays_standing[GLOVES_LAYER]
		if(OFFSET_GLOVES in dna.species.offset_features)
			gloves_overlay.pixel_x += dna.species.offset_features[OFFSET_GLOVES][1]
			gloves_overlay.pixel_y += dna.species.offset_features[OFFSET_GLOVES][2]
	overlays_standing[GLOVES_LAYER] = gloves_overlay
	apply_overlay(GLOVES_LAYER)


/mob/living/carbon/human/update_inv_glasses()
	remove_overlay(GLASSES_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EYES) + 1]
		inv.update_icon()
	if(glasses)
		glasses.screen_loc = ui_glasses		//...draw the item in the inventory screen
	if(istype(glasses, /obj/item/clothing/glasses))
		var/obj/item/clothing/glasses/G = glasses
		var/icon_file = 'icons/mob/eyes.dmi'
		if(G.sprite_sheets & (dna?.species.bodyflag))
			icon_file = dna.species.get_custom_icons("glasses")
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open ...
				client.screen += glasses				//Either way, add the item to the HUD
		update_observer_view(glasses,1)
		if(!(head && (head.flags_inv & HIDEEYES)) && !(wear_mask && (wear_mask.flags_inv & HIDEEYES)))
			overlays_standing[GLASSES_LAYER] = glasses.build_worn_icon(state = glasses.icon_state, default_layer = GLASSES_LAYER, default_icon_file = icon_file)

		var/mutable_appearance/glasses_overlay = overlays_standing[GLASSES_LAYER]
		if(glasses_overlay)
			if(OFFSET_GLASSES in dna.species.offset_features)
				glasses_overlay.pixel_x += dna.species.offset_features[OFFSET_GLASSES][1]
				glasses_overlay.pixel_y += dna.species.offset_features[OFFSET_GLASSES][2]
			overlays_standing[GLASSES_LAYER] = glasses_overlay
	apply_overlay(GLASSES_LAYER)


/mob/living/carbon/human/update_inv_ears()
	remove_overlay(EARS_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EARS) + 1]
		inv.update_icon()

	if(ears)
		var/icon_file = 'icons/mob/ears.dmi'
		if(istype(ears, /obj/item))
			var/obj/item/E = ears
			if(E.sprite_sheets & (dna?.species.bodyflag))
				icon_file = dna.species.get_custom_icons("ears")
		ears.screen_loc = ui_ears	//move the item to the appropriate screen loc
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open
				client.screen += ears					//add it to the client's screen
		update_observer_view(ears,1)

		overlays_standing[EARS_LAYER] = ears.build_worn_icon(state = ears.icon_state, default_layer = EARS_LAYER, default_icon_file = icon_file)
		var/mutable_appearance/ears_overlay = overlays_standing[EARS_LAYER]
		if(OFFSET_EARS in dna.species.offset_features)
			ears_overlay.pixel_x += dna.species.offset_features[OFFSET_EARS][1]
			ears_overlay.pixel_y += dna.species.offset_features[OFFSET_EARS][2]
		overlays_standing[EARS_LAYER] = ears_overlay
	apply_overlay(EARS_LAYER)

/mob/living/carbon/human/update_inv_neck()
	remove_overlay(NECK_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1]
		inv.update_icon()

	if(wear_neck)
		if(!(ITEM_SLOT_NECK in check_obscured_slots()))
			var/icon_file = 'icons/mob/neck.dmi'
			if(istype(wear_neck, /obj/item))
				var/obj/item/N = wear_neck
				if(N.sprite_sheets & dna?.species.bodyflag)
					icon_file = dna.species.get_custom_icons("neck")
			overlays_standing[NECK_LAYER] = wear_neck.build_worn_icon(state = wear_neck.icon_state, default_layer = NECK_LAYER, default_icon_file = icon_file)
			var/mutable_appearance/neck_overlay = overlays_standing[NECK_LAYER]
			if(OFFSET_NECK in dna.species.offset_features)
				neck_overlay.pixel_x += dna.species.offset_features[OFFSET_NECK][1]
				neck_overlay.pixel_y += dna.species.offset_features[OFFSET_NECK][2]
			overlays_standing[NECK_LAYER] = neck_overlay
	apply_overlay(NECK_LAYER)

/mob/living/carbon/human/update_inv_shoes()
	remove_overlay(SHOES_LAYER)

	if(get_num_legs(FALSE) <2)
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_FEET) + 1]
		inv.update_icon()

	if(shoes)
		var/icon_file = 'icons/mob/feet.dmi'
		if(istype(shoes, /obj/item/clothing/shoes))
			var/obj/item/clothing/shoes/S = shoes
			if(S.sprite_sheets & (dna?.species.bodyflag))
				icon_file = dna.species.get_custom_icons("shoes")
		shoes.screen_loc = ui_shoes					//move the item to the appropriate screen loc
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open
				client.screen += shoes					//add it to client's screen
		update_observer_view(shoes,1)
		overlays_standing[SHOES_LAYER] = shoes.build_worn_icon(state = shoes.icon_state, default_layer = SHOES_LAYER, default_icon_file = icon_file)
		var/mutable_appearance/shoes_overlay = overlays_standing[SHOES_LAYER]
		if(OFFSET_SHOES in dna.species.offset_features)
			shoes_overlay.pixel_x += dna.species.offset_features[OFFSET_SHOES][1]
			shoes_overlay.pixel_y += dna.species.offset_features[OFFSET_SHOES][2]
		overlays_standing[SHOES_LAYER] = shoes_overlay

	apply_overlay(SHOES_LAYER)


/mob/living/carbon/human/update_inv_s_store()
	remove_overlay(SUIT_STORE_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_SUITSTORE) + 1]
		inv.update_icon()

	if(s_store)
		s_store.screen_loc = ui_sstore1
		if(client && hud_used && hud_used.hud_shown)
			client.screen += s_store
		update_observer_view(s_store)
		var/t_state = s_store.item_state
		if(!t_state)
			t_state = s_store.icon_state
		overlays_standing[SUIT_STORE_LAYER]	= mutable_appearance('icons/mob/belt_mirror.dmi', t_state, -SUIT_STORE_LAYER)
		var/mutable_appearance/s_store_overlay = overlays_standing[SUIT_STORE_LAYER]
		if(OFFSET_S_STORE in dna.species.offset_features)
			s_store_overlay.pixel_x += dna.species.offset_features[OFFSET_S_STORE][1]
			s_store_overlay.pixel_y += dna.species.offset_features[OFFSET_S_STORE][2]
		overlays_standing[SUIT_STORE_LAYER] = s_store_overlay
	apply_overlay(SUIT_STORE_LAYER)


/mob/living/carbon/human/update_inv_head()
	remove_overlay(HEAD_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1]
		inv.update_icon()

	update_mutant_bodyparts()
	if(head)
		update_hud_head(head)
		var/icon_file = 'icons/mob/head.dmi'
		if(istype(head, /obj/item/clothing/head))
			var/obj/item/clothing/head/HE = head
			if(HE.sprite_sheets & (dna?.species.bodyflag))
				icon_file = dna.species.get_custom_icons("head")
		overlays_standing[HEAD_LAYER] = head.build_worn_icon(state = head.icon_state, default_layer = HEAD_LAYER, default_icon_file = icon_file)
	var/mutable_appearance/head_overlay = overlays_standing[HEAD_LAYER]
	if(head_overlay)
		remove_overlay(HEAD_LAYER)
		if(OFFSET_HEAD in dna.species.offset_features)
			head_overlay.pixel_x += dna.species.offset_features[OFFSET_HEAD][1]
			head_overlay.pixel_y += dna.species.offset_features[OFFSET_HEAD][2]
			overlays_standing[HEAD_LAYER] = head_overlay
	apply_overlay(HEAD_LAYER)

/mob/living/carbon/human/update_inv_belt()
	remove_overlay(BELT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BELT) + 1]
		inv.update_icon()

	if(belt)
		var/icon_file = 'icons/mob/belt.dmi'
		if(istype(belt, /obj/item/storage/belt))
			var/obj/item/storage/belt/B = belt
			if(B.sprite_sheets & (dna?.species.bodyflag))
				icon_file = dna.species.get_custom_icons("belt")
		belt.screen_loc = ui_belt
		if(client && hud_used && hud_used.hud_shown)
			client.screen += belt
		update_observer_view(belt)

		var/t_state = belt.item_state
		if(!t_state)
			t_state = belt.icon_state

		overlays_standing[BELT_LAYER] = belt.build_worn_icon(state = t_state, default_layer = BELT_LAYER, default_icon_file = icon_file)
		var/mutable_appearance/belt_overlay = overlays_standing[BELT_LAYER]
		if(OFFSET_BELT in dna.species.offset_features)
			belt_overlay.pixel_x += dna.species.offset_features[OFFSET_BELT][1]
			belt_overlay.pixel_y += dna.species.offset_features[OFFSET_BELT][2]
			overlays_standing[BELT_LAYER] = belt_overlay

	apply_overlay(BELT_LAYER)



/mob/living/carbon/human/update_inv_wear_suit()
	remove_overlay(SUIT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_OCLOTHING) + 1]
		inv.update_icon()

	if(istype(wear_suit, /obj/item/clothing/suit))
		var/icon_file = 'icons/mob/suit.dmi'
		var/obj/item/clothing/suit/S = wear_suit
		if(S.sprite_sheets & (dna?.species.bodyflag))
			icon_file = dna.species.get_custom_icons("suit")
		wear_suit.screen_loc = ui_oclothing
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += wear_suit
		update_observer_view(wear_suit,1)

		overlays_standing[SUIT_LAYER] = wear_suit.build_worn_icon(state = wear_suit.icon_state, default_layer = SUIT_LAYER, default_icon_file = icon_file)
		var/mutable_appearance/suit_overlay = overlays_standing[SUIT_LAYER]
		if(OFFSET_SUIT in dna.species.offset_features)
			suit_overlay.pixel_x += dna.species.offset_features[OFFSET_SUIT][1]
			suit_overlay.pixel_y += dna.species.offset_features[OFFSET_SUIT][2]
			overlays_standing[SUIT_LAYER] = suit_overlay
	update_hair()
	update_mutant_bodyparts()

	apply_overlay(SUIT_LAYER)


/mob/living/carbon/human/update_inv_pockets()
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv

		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_LPOCKET) + 1]
		inv.update_icon()

		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_RPOCKET) + 1]
		inv.update_icon()

		if(l_store)
			l_store.screen_loc = ui_storage1
			if(hud_used.hud_shown)
				client.screen += l_store
			update_observer_view(l_store)

		if(r_store)
			r_store.screen_loc = ui_storage2
			if(hud_used.hud_shown)
				client.screen += r_store
			update_observer_view(r_store)


/mob/living/carbon/human/update_inv_wear_mask()
	remove_overlay(FACEMASK_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1]
		inv.update_icon()

	if(wear_mask)
		var/icon_file = 'icons/mob/mask.dmi'
		if(istype(wear_mask, /obj/item/clothing/mask))
			var/obj/item/clothing/mask/M = wear_mask
			if(M.sprite_sheets & dna?.species.bodyflag)
				icon_file = dna.species.get_custom_icons("mask")
		overlays_standing[FACEMASK_LAYER] = wear_mask.build_worn_icon(state = wear_mask.icon_state, default_layer = FACEMASK_LAYER, default_icon_file = icon_file)
		var/mutable_appearance/mask_overlay = overlays_standing[FACEMASK_LAYER]
		if(mask_overlay)
			remove_overlay(FACEMASK_LAYER)
			if(OFFSET_FACEMASK in dna.species.offset_features)
				mask_overlay.pixel_x += dna.species.offset_features[OFFSET_FACEMASK][1]
				mask_overlay.pixel_y += dna.species.offset_features[OFFSET_FACEMASK][2]
				overlays_standing[FACEMASK_LAYER] = mask_overlay
		apply_overlay(FACEMASK_LAYER)
	update_mutant_bodyparts() //e.g. upgate needed because mask now hides lizard snout

/mob/living/carbon/human/update_inv_back()
	remove_overlay(BACK_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1]
		inv.update_icon()

	if(back)
		update_hud_back(back)
		var/icon_file = 'icons/mob/back.dmi'
		if(istype(back, /obj/item))
			var/obj/item/I = back
			if(I.sprite_sheets & dna?.species.bodyflag)
				icon_file = dna.species.get_custom_icons("back")
		overlays_standing[BACK_LAYER] = back.build_worn_icon(state = back.icon_state, default_layer = BACK_LAYER, default_icon_file = icon_file)
		var/mutable_appearance/back_overlay = overlays_standing[BACK_LAYER]
		if(back_overlay)
			remove_overlay(BACK_LAYER)
			if(OFFSET_BACK in dna.species.offset_features)
				back_overlay.pixel_x += dna.species.offset_features[OFFSET_BACK][1]
				back_overlay.pixel_y += dna.species.offset_features[OFFSET_BACK][2]
			overlays_standing[BACK_LAYER] = back_overlay
		apply_overlay(BACK_LAYER)

/mob/living/carbon/human/update_inv_legcuffed()
	remove_overlay(LEGCUFF_LAYER)
	clear_alert("legcuffed")
	if(legcuffed)
		var/path = dna?.species.get_custom_icons("generic")
		if(!path)
			path = 'icons/mob/mob.dmi'
		overlays_standing[LEGCUFF_LAYER] = mutable_appearance(path, "legcuff1", -LEGCUFF_LAYER)
		apply_overlay(LEGCUFF_LAYER)
		throw_alert("legcuffed", /atom/movable/screen/alert/restrained/legcuffed, new_master = src.legcuffed)

/mob/living/carbon/human/update_inv_hands()
	remove_overlay(HANDS_LAYER)
	if (handcuffed)
		drop_all_held_items()
		return

	var/list/hands = list()
	for(var/obj/item/I in held_items)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			I.screen_loc = ui_hand_position(get_held_index_of_item(I))
			client.screen += I
			if(observers?.len)
				for(var/M in observers)
					var/mob/dead/observe = M
					if(observe.client && observe.client.eye == src)
						observe.client.screen += I
					else
						observers -= observe
						if(!observers.len)
							observers = null
							break

		var/t_state = I.item_state
		if(!t_state)
			t_state = I.icon_state

		var/icon_file = I.lefthand_file
		var/mutable_appearance/hand_overlay
		if(get_held_index_of_item(I) % 2 == 0)
			icon_file = I.righthand_file
			hand_overlay = I.build_worn_icon(state = t_state, default_layer = HANDS_LAYER, default_icon_file = icon_file, isinhands = TRUE)
			if(OFFSET_RIGHT_HAND in dna.species.offset_features)
				hand_overlay.pixel_x += dna.species.offset_features[OFFSET_RIGHT_HAND][1]
				hand_overlay.pixel_y += dna.species.offset_features[OFFSET_RIGHT_HAND][2]
		else
			hand_overlay = I.build_worn_icon(state = t_state, default_layer = HANDS_LAYER, default_icon_file = icon_file, isinhands = TRUE)
			if(OFFSET_LEFT_HAND in dna.species.offset_features)
				hand_overlay.pixel_x += dna.species.offset_features[OFFSET_LEFT_HAND][1]
				hand_overlay.pixel_y += dna.species.offset_features[OFFSET_LEFT_HAND][2]
		hands += hand_overlay
	overlays_standing[HANDS_LAYER] = hands
	apply_overlay(HANDS_LAYER)

/proc/wear_female_version(t_color, icon, layer, type)
	var/index = t_color
	var/icon/female_clothing_icon = GLOB.female_clothing_icons[index]
	if(!female_clothing_icon) 	//Create standing/laying icons if they don't exist
		generate_female_clothing(index,t_color,icon,type)
	return mutable_appearance(GLOB.female_clothing_icons[t_color], layer = -layer)

/mob/living/carbon/human/proc/get_overlays_copy(list/unwantedLayers)
	var/list/out = new
	for(var/i in 1 to TOTAL_LAYERS)
		if(overlays_standing[i])
			if(i in unwantedLayers)
				continue
			out += overlays_standing[i]
	return out


//human HUD updates for items in our inventory

//update whether our head item appears on our hud.
/mob/living/carbon/human/update_hud_head(obj/item/I)
	I.screen_loc = ui_head
	if(client && hud_used && hud_used.hud_shown)
		if(hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

//update whether our mask item appears on our hud.
/mob/living/carbon/human/update_hud_wear_mask(obj/item/I)
	I.screen_loc = ui_mask
	if(client && hud_used && hud_used.hud_shown)
		if(hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

//update whether our neck item appears on our hud.
/mob/living/carbon/human/update_hud_neck(obj/item/I)
	I.screen_loc = ui_neck
	if(client && hud_used && hud_used.hud_shown)
		if(hud_used.inventory_shown)
			client.screen += I
	update_observer_view(I,1)

//update whether our back item appears on our hud.
/mob/living/carbon/human/update_hud_back(obj/item/I)
	I.screen_loc = ui_back
	if(client && hud_used && hud_used.hud_shown)
		client.screen += I
	update_observer_view(I)

//Update whether we smell
/mob/living/carbon/human/proc/update_smell(var/smelly_icon = "generic_mob_smell")
	remove_overlay(SMELL_LAYER)
	if(hygiene == HYGIENE_LEVEL_DISGUSTING) //You have literally ignored your stank for so long that you physically can't get dirtier.
		var/mutable_appearance/new_smell_overlay = mutable_appearance('icons/mob/smelly.dmi', smelly_icon, -SMELL_LAYER)
		overlays_standing[SMELL_LAYER] = new_smell_overlay
		apply_overlay(SMELL_LAYER)

/*
Does everything in relation to building the /mutable_appearance used in the mob's overlays list
covers:
 inhands and any other form of worn item
 centering large appearances
 layering appearances on custom layers
 building appearances from custom icon files

By Remie Richards (yes I'm taking credit because this just removed 90% of the copypaste in update_icons())

state: A string to use as the state, this is FAR too complex to solve in this proc thanks to shitty old code
so it's specified as an argument instead.

default_layer: The layer to draw this on if no other layer is specified

default_icon_file: The icon file to draw states from if no other icon file is specified

isinhands: If true then alternate_worn_icon is skipped so that default_icon_file is used,
in this situation default_icon_file is expected to match either the lefthand_ or righthand_ file var

femalueuniform: A value matching a uniform item's fitted var, if this is anything but NO_FEMALE_UNIFORM, we
generate/load female uniform sprites matching all previously decided variables


*/
/obj/item/proc/build_worn_icon(var/state = "", var/default_layer = 0, var/default_icon_file = null, var/isinhands = FALSE, var/femaleuniform = NO_FEMALE_UNIFORM)

	//Find a valid icon file from variables+arguments
	var/file2use
	if(!isinhands && alternate_worn_icon)
		file2use = alternate_worn_icon
	if(!file2use)
		file2use = default_icon_file

	//Find a valid layer from variables+arguments
	var/layer2use
	if(alternate_worn_layer)
		layer2use = alternate_worn_layer
	if(!layer2use)
		layer2use = default_layer

	var/mutable_appearance/standing
	if(femaleuniform)
		standing = wear_female_version(state,file2use,layer2use,femaleuniform)
	if(!standing)
		standing = mutable_appearance(file2use, state, -layer2use)

	//Get the overlays for this item when it's being worn
	//eg: ammo counters, primed grenade flashes, etc.
	var/list/worn_overlays = worn_overlays(isinhands, file2use)
	if(worn_overlays?.len)
		standing.overlays.Add(worn_overlays)

	standing = center_image(standing, isinhands ? inhand_x_dimension : worn_x_dimension, isinhands ? inhand_y_dimension : worn_y_dimension)

	//Handle held offsets
	var/mob/M = loc
	if(istype(M))
		var/list/L = get_held_offsets()
		if(L)
			standing.pixel_x += L["x"] //+= because of center()ing
			standing.pixel_y += L["y"]

	standing.alpha = alpha
	standing.color = color

	return standing


/obj/item/proc/get_held_offsets()
	var/list/L
	if(ismob(loc))
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			L = H.dna?.species.get_item_offsets_for_index(H.get_held_index_of_item(src))
			if(L)
				return L
		var/mob/M = loc
		L = M.get_item_offsets_for_index(M.get_held_index_of_item(src))

	return L


//Can't think of a better way to do this, sadly
/mob/proc/get_item_offsets_for_index(i)
	switch(i)
		if(3) //odd = left hands
			return list("x" = 0, "y" = 16)
		if(4) //even = right hands
			return list("x" = 0, "y" = 16)
		else //No offsets or Unwritten number of hands
			return list("x" = 0, "y" = 0)//Handle held offsets

//produces a key based on the human's limbs
/mob/living/carbon/human/generate_icon_render_key()
	. = "[dna.species.limbs_id]"

	if(dna.check_mutation(HULK))
		. += "-coloured-hulk"
	else if(dna.species.use_skintones)
		. += "-coloured-[skin_tone]"
	else if(dna.species.fixed_mut_color)
		. += "-coloured-[dna.species.fixed_mut_color]"
	else if(dna.features["mcolor"])
		. += "-coloured-[dna.features["mcolor"]]"
	else
		. += "-not_coloured"

	. += "-[gender]"

	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += "-[BP.body_zone]"
		if(BP.status == BODYPART_ORGANIC)
			. += "-organic"
		else
			. += "-robotic"
		if(BP.use_digitigrade)
			. += "-digitigrade[BP.use_digitigrade]"
		if(BP.dmg_overlay_type)
			. += "-[BP.dmg_overlay_type]"

	if(HAS_TRAIT(src, TRAIT_HUSK))
		. += "-husk"

/mob/living/carbon/human/load_limb_from_cache()
	..()
	update_hair()



/mob/living/carbon/human/proc/update_observer_view(obj/item/I, inventory)
	if(observers && observers.len)
		for(var/M in observers)
			var/mob/dead/observe = M
			if(observe.client && observe.client.eye == src)
				if(observe.hud_used)
					if(inventory && !observe.hud_used.inventory_shown)
						continue
					observe.client.screen += I
			else
				observers -= observe
				if(!observers.len)
					observers = null
					break

// Only renders the head of the human
/mob/living/carbon/human/proc/update_body_parts_head_only()
	if (!dna)
		return

	if (!dna.species)
		return

	var/obj/item/bodypart/HD = get_bodypart("head")

	if (!istype(HD))
		return

	HD.update_limb()

	add_overlay(HD.get_limb_icon())
	update_damage_overlays()

	if(HD && !(HAS_TRAIT(src, TRAIT_HUSK)))
		// lipstick
		if(lip_style && (LIPS in dna.species.species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/human_face.dmi', "lips_[lip_style]", -BODY_LAYER)
			lip_overlay.color = lip_color
			if(OFFSET_FACE in dna.species.offset_features)
				lip_overlay.pixel_x += dna.species.offset_features[OFFSET_FACE][1]
				lip_overlay.pixel_y += dna.species.offset_features[OFFSET_FACE][2]
			add_overlay(lip_overlay)

		// eyes
		if(!(NOEYESPRITES in dna.species.species_traits))
			var/obj/item/organ/eyes/E = getorganslot(ORGAN_SLOT_EYES)
			var/mutable_appearance/eye_overlay
			if(!E)
				eye_overlay = mutable_appearance('icons/mob/human_face.dmi', "eyes_missing", -BODY_LAYER)
			else
				eye_overlay = mutable_appearance('icons/mob/human_face.dmi', E.eye_icon_state, -BODY_LAYER)
			if((EYECOLOR in dna.species.species_traits) && E)
				eye_overlay.color = "#" + eye_color
			if(OFFSET_FACE in dna.species.offset_features)
				eye_overlay.pixel_x += dna.species.offset_features[OFFSET_FACE][1]
				eye_overlay.pixel_y += dna.species.offset_features[OFFSET_FACE][2]
			add_overlay(eye_overlay)

	dna.species.handle_hair(src)

	update_inv_head()
	update_inv_wear_mask()


////Extremely special handling for species with abnormal hand placement. This essentially rebuilds the hand overlay every
////rotation, with every direction having a unique pixel offset for in-hands.
////On species gain, a signal is registered to track direction changes.
/mob/living/carbon/human/proc/update_hands_on_rotate() //Required for unconventionally placed hands on species
	SIGNAL_HANDLER
	if(!is_updating_hands) //Defined in human_defines.dm
		RegisterSignal(src, COMSIG_ATOM_DIR_CHANGE, .proc/special_update_hands)
		is_updating_hands = TRUE
/mob/living/carbon/human/proc/stop_updating_hands()
	if(is_updating_hands)
		UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)
		is_updating_hands = FALSE
		to_chat(src, "<span class='warning'>Unregistered signal!</span>")
/mob/living/carbon/human/proc/special_update_hands(var/mob/living/carbon/human/H, var/olddir, var/newdir)
	if(olddir == newdir)
		return

	remove_overlay(HANDS_LAYER)
	if (handcuffed)
		drop_all_held_items()
		return

	var/list/hands = list()
	for(var/obj/item/I in held_items)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			I.screen_loc = ui_hand_position(get_held_index_of_item(I))
			client.screen += I
			if(observers?.len)
				for(var/M in observers)
					var/mob/dead/observe = M
					if(observe.client && observe.client.eye == src)
						observe.client.screen += I
					else
						observers -= observe
						if(!observers.len)
							observers = null
							break

		var/t_state = I.item_state
		if(!t_state)
			t_state = I.icon_state

		var/icon_file = I.lefthand_file
		var/mutable_appearance/hand_overlay
		if(get_held_index_of_item(I) % 2 == 0)
			icon_file = I.righthand_file
			hand_overlay = I.build_worn_icon(state = t_state, default_layer = HANDS_LAYER, default_icon_file = icon_file, isinhands = TRUE)
			if(OFFSET_RIGHT_HAND in dna.species.offset_features)
				hand_overlay.pixel_x += dna.species.offset_features[OFFSET_RIGHT_HAND][1]
				hand_overlay.pixel_y += dna.species.offset_features[OFFSET_RIGHT_HAND][2]
		else
			hand_overlay = I.build_worn_icon(state = t_state, default_layer = HANDS_LAYER, default_icon_file = icon_file, isinhands = TRUE)
			if(OFFSET_LEFT_HAND in dna.species.offset_features)
				hand_overlay.pixel_x += dna.species.offset_features[OFFSET_LEFT_HAND][1]
				hand_overlay.pixel_y += dna.species.offset_features[OFFSET_LEFT_HAND][2]
		hands += hand_overlay
	overlays_standing[HANDS_LAYER] = hands
	apply_overlay(HANDS_LAYER)
