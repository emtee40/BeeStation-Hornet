/*
	Series 1
*/

/obj/item/sticker/series_1/get_stats()
	. = "<span class='notice'>Series 1</span>\n"
	. += ..()

/obj/item/sticker/series_1/generate_unusual()
	var/obj/emitter/emitter = pick(list(/obj/emitter/electrified, /obj/emitter/snow, /obj/emitter/fire))
	if(prob(1))
		playsound(src, 'sound/effects/audience-gasp.ogg', 50)
		add_emitter(emitter, "unusual", 10)
		is_unusual = TRUE

/obj/item/sticker/series_1/smile
	sticker_flags = STICKER_SERIES_1 | STICKER_RARITY_COMMON

/obj/item/sticker/series_1/skub
	icon_state = "skub"
	sticker_icon_state = "skub_sticker"
	sticker_flags = STICKER_SERIES_1 | STICKER_RARITY_MYTHIC
	//Don't chance the drop weight for this, the joke is it's common

/obj/item/sticker/series_1/c4
	icon_state = "c4"
	sticker_icon_state = "c4_sticker"
	do_outline = FALSE
	sticker_flags = STICKER_SERIES_1 | STICKER_RARITY_RARE
	drop_rate = STICKER_WEIGHT_RARE

/obj/item/sticker/series_1/sad
	icon_state = "sad"
	sticker_icon_state = "sad_sticker"
	sticker_flags = STICKER_SERIES_1 | STICKER_RARITY_COMMON

/obj/item/sticker/series_1/moth
	icon_state = "moth"
	sticker_icon_state = "moth_sticker"
	sticker_flags = STICKER_SERIES_1 | STICKER_RARITY_UNCOMMON
	drop_rate = STICKER_WEIGHT_UNCOMMON

/obj/item/sticker/series_1/pride
	item_flags = ABSTRACT
	sticker_flags = STICKER_SERIES_1 | STICKER_RARITY_UNCOMMON
	drop_rate = STICKER_WEIGHT_UNCOMMON

/obj/item/sticker/series_1/pride/gay
	icon_state = "gay"
	sticker_icon_state = "gay_sticker"

/obj/item/sticker/series_1/pride/lesbian
	icon_state = "lesbian"
	sticker_icon_state = "lesbian_sticker"

/obj/item/sticker/series_1/pride/bi
	icon_state = "bi"
	sticker_icon_state = "bi_sticker"

/obj/item/sticker/series_1/pride/trans
	icon_state = "trans"
	sticker_icon_state = "trans_sticker"

//Mime pride?
/obj/item/sticker/series_1/pride/straight
	icon_state = "straight"
	sticker_icon_state = "straight_sticker"
