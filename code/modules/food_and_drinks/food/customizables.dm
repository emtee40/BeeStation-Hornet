#define INGREDIENTS_FILL 1
#define INGREDIENTS_SCATTER 2
#define INGREDIENTS_STACK 3
#define INGREDIENTS_STACKPLUSTOP 4
#define INGREDIENTS_LINE 5

//**************************************************************
//
// Customizable Food
//
//**************************************************************


/obj/item/reagent_containers/food/snacks/customizable
	bitesize = 4
	w_class = WEIGHT_CLASS_SMALL
	volume = 80

	var/ingMax = 12
	var/list/ingredients = list()
	var/ingredients_placement = INGREDIENTS_FILL
	var/customname = "custom"

/obj/item/reagent_containers/food/snacks/customizable/examine(mob/user)
	. = ..()
	var/ingredients_listed = ""
	for(var/obj/item/reagent_containers/food/snacks/ING in ingredients)
		ingredients_listed += "[ING.name], "
	var/size = "standard"
	if(ingredients.len<2)
		size = "small"
	if(ingredients.len>5)
		size = "big"
	if(ingredients.len>8)
		size = "monster"
	. += "It contains [ingredients.len?"[ingredients_listed]":"no ingredient, "]making a [size]-sized [initial(name)]."

/obj/item/reagent_containers/food/snacks/customizable/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/reagent_containers/food/snacks/customizable) && istype(I, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = I
		if(I.w_class > WEIGHT_CLASS_SMALL)
			to_chat(user, "<span class='warning'>The ingredient is too big for [src]!</span>")
		else if((ingredients.len >= ingMax) || (reagents.total_volume >= volume))
			to_chat(user, "<span class='warning'>You can't add more ingredients to [src]!</span>")
		else
			if(!user.transferItemToLoc(I, src))
				return
			if(S.trash)
				S.generate_trash(get_turf(user))
			ingredients += S
			mix_filling_color(S)
			S.reagents.trans_to(src,min(S.reagents.total_volume, 15), transfered_by = user) //limit of 15, we don't want our custom food to be completely filled by just one ingredient with large reagent volume.
			foodtype |= S.foodtype
			update_customizable_overlays(S)
			to_chat(user, "<span class='notice'>You add the [I.name] to the [name].</span>")
			update_food_name(S)
	else
		. = ..()


/obj/item/reagent_containers/food/snacks/customizable/proc/update_food_name(obj/item/reagent_containers/food/snacks/S)
	for(var/obj/item/I in ingredients)
		if(!istype(S, I.type))
			customname = "custom"
			break
	if(ingredients.len == 1) //first ingredient
		if(istype(S, /obj/item/food/meat))
			var/obj/item/food/meat/M = S
			if(M.subjectname)
				customname = "[M.subjectname]"
			else if(M.subjectjob)
				customname = "[M.subjectjob]"
			else
				customname = S.name
		else
			customname = S.name
	name = "[customname] [initial(name)]"

/obj/item/reagent_containers/food/snacks/customizable/proc/initialize_custom_food(obj/item/BASE, obj/item/I, mob/user)
	if(istype(BASE, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/RC = BASE
		RC.reagents.trans_to(src,RC.reagents.total_volume, transfered_by = user)
	for(var/obj/O in BASE.contents)
		contents += O
	if(I && user)
		attackby(I, user)
	qdel(BASE)

/obj/item/reagent_containers/food/snacks/customizable/proc/mix_filling_color(obj/item/reagent_containers/food/snacks/S)
	if(ingredients.len == 1)
		filling_color = S.filling_color
	else
		var/list/rgbcolor = list(0,0,0,0)
		var/customcolor = GetColors(filling_color)
		var/ingcolor =  GetColors(S.filling_color)
		rgbcolor[1] = (customcolor[1]+ingcolor[1])/2
		rgbcolor[2] = (customcolor[2]+ingcolor[2])/2
		rgbcolor[3] = (customcolor[3]+ingcolor[3])/2
		rgbcolor[4] = (customcolor[4]+ingcolor[4])/2
		filling_color = rgb(rgbcolor[1], rgbcolor[2], rgbcolor[3], rgbcolor[4])

/obj/item/reagent_containers/food/snacks/customizable/update_customizable_overlays(obj/item/reagent_containers/food/snacks/S)
	var/mutable_appearance/filling = mutable_appearance(icon, "[initial(icon_state)]_filling")
	if(S.filling_color == "#FFFFFF")
		filling.color = pick("#FF0000","#0000FF","#008000","#FFFF00")
	else
		filling.color = S.filling_color

	switch(ingredients_placement)
		if(INGREDIENTS_SCATTER)
			filling.pixel_x = rand(-1,1)
			filling.pixel_y = rand(-1,1)
		if(INGREDIENTS_STACK)
			filling.pixel_x = rand(-1,1)
			filling.pixel_y = 2 * ingredients.len - 1
		if(INGREDIENTS_STACKPLUSTOP)
			filling.pixel_x = rand(-1,1)
			filling.pixel_y = 2 * ingredients.len - 1
			if(overlays && overlays.len >= ingredients.len) //remove the old top if it exists
				overlays -= overlays[ingredients.len]
			var/mutable_appearance/TOP = mutable_appearance(icon, "[icon_state]_top")
			TOP.pixel_y = 2 * ingredients.len + 3
			add_overlay(filling)
			add_overlay(TOP)
			return
		if(INGREDIENTS_FILL)
			cut_overlays()
			filling.color = filling_color
		if(INGREDIENTS_LINE)
			filling.pixel_x = filling.pixel_y = rand(-8,3)

	add_overlay(filling)


/obj/item/reagent_containers/food/snacks/customizable/initialize_slice(obj/item/reagent_containers/food/snacks/slice, reagents_per_slice)
	..()
	slice.filling_color = filling_color
	slice.update_customizable_overlays(src)


/obj/item/reagent_containers/food/snacks/customizable/Destroy()
	for(. in ingredients)
		qdel(.)
	return ..()





/////////////////////////////////////////////////////////////////////////////
//////////////      Customizable Food Types     /////////////////////////////
/////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/customizable/burger
	name = "burger"
	desc = "A timeless classic."
	ingredients_placement = INGREDIENTS_STACKPLUSTOP
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "custburg"
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/customizable/pie
	name = "pie"
	ingMax = 6
	icon = 'icons/obj/food/piecake.dmi'
	icon_state = "pie"
	foodtype = GRAIN | DAIRY

#undef INGREDIENTS_FILL
#undef INGREDIENTS_SCATTER
#undef INGREDIENTS_STACK
#undef INGREDIENTS_STACKPLUSTOP
#undef INGREDIENTS_LINE
