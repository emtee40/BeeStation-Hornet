/obj/structure/chair/fancy/sofa //like it's brother fancy chair, this is the father of all sofas
	name = "old father sofa"
	desc = "Now extint, this kind of sofa shouldn't even exist anymore, if you see this rouge specimen, contact your local Nanotransen Anti-couch surfer department."
	icon_state = "sofamiddle"
	icon = 'icons/obj/sofa.dmi'
	color = rgb(141,70,0)
	buildstackamount = 1
	item_chair = null

/*
/obj/structure/chair/sofa/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(!colorable)
		return
	if(istype(I, /obj/item/toy/crayon))
		var/obj/item/toy/crayon/C = I
		var/new_color = C.paint_color
		var/list/hsl = rgb2hsl(hex2num(copytext(new_color, 2, 4)), hex2num(copytext(new_color, 4, 6)), hex2num(copytext(new_color, 6, 8)))
		hsl[3] = max(hsl[3], 0.4)
		var/list/rgb = hsl2rgb(arglist(hsl))
		color = "#[num2hex(rgb[1], 2)][num2hex(rgb[2], 2)][num2hex(rgb[3], 2)]"
	if(color)
		cut_overlay(armrest)
		armrest = GetArmrest()
		update_armrest()
*/

/obj/structure/chair/fancy/sofa/old
	name = "old sofa"
	desc = "A bit dated, but still does the job of being a sofa."
	icon_state = "sofamiddle"
	colorable = TRUE

/obj/structure/chair/fancy/sofa/old/left
	icon_state = "sofaend_left"

/obj/structure/chair/fancy/sofa/old/right
	icon_state = "sofaend_right"

/obj/structure/chair/fancy/sofa/old/corner
	icon_state = "sofacorner"
	possible_dirs = 8

// Original icon ported from Eris(?) and updated to work here.
/obj/structure/chair/fancy/sofa/corp
	name = "sofa"
	desc = "Soft and cushy."
	icon_state = "corp_sofamiddle"

/obj/structure/chair/fancy/sofa/corp/left
	icon_state = "corp_sofaend_left"
/obj/structure/chair/fancy/sofa/corp/right
	icon_state = "corp_sofaend_right"
/obj/structure/chair/fancy/sofa/corp/corner
	icon_state = "corp_sofacorner"

// Bamboo benches
/obj/structure/chair/fancy/sofa/bamboo
	name = "bamboo bench"
	desc = "A makeshift bench with a rustic aesthetic."
	icon_state = "bamboo_sofamiddle"
	resistance_flags = FLAMMABLE
	max_integrity = 60
	buildstacktype = /obj/item/stack/sheet/mineral/bamboo
	buildstackamount = 3

/obj/structure/chair/fancy/sofa/bamboo/left
	icon_state = "bamboo_sofaend_left"
/obj/structure/chair/fancy/sofa/bamboo/right
	icon_state = "bamboo_sofaend_right"

// Ported from tg ported from Skyrat
/obj/structure/chair/fancy/sofa/bench
	name = "bench"
	desc = "Perfectly designed to be comfortable to sit on, and hellish to sleep on."
	icon_state = "bench_middle"
	greyscale_config = /datum/greyscale_config/bench_middle
	greyscale_colors = "#af7d28"
	color = rgb(255,255,255)
	colorable = TRUE

/obj/structure/chair/fancy/sofa/bench/left
	icon_state = "bench_left"
	greyscale_config = /datum/greyscale_config/bench_left
	greyscale_colors = "#af7d28"

/obj/structure/chair/fancy/sofa/bench/right
	icon_state = "bench_right"
	greyscale_config = /datum/greyscale_config/bench_right
	greyscale_colors = "#af7d28"

/obj/structure/chair/fancy/sofa/bench/corner
	icon_state = "bench_corner"
	greyscale_config = /datum/greyscale_config/bench_corner
	greyscale_colors = "#af7d28"

/obj/structure/chair/fancy/sofa/bench/handle_layer()
	return
