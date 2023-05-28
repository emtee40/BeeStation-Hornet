////////////////////////////////////////////////////////////////////////////////
/// Food.
////////////////////////////////////////////////////////////////////////////////
/// Note: When adding food items with dummy parents, make sure to add
/// the parent to the exclusion list in code/__HELPERS/unsorted.dm's
/// get_random_food proc.
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/food
	possible_transfer_amounts = list()
	volume = 50	//Sets the default container amount for all food items.
	reagent_flags = INJECTABLE
	resistance_flags = FLAMMABLE
	var/foodtype = NONE
	var/last_check_time
	var/in_container = FALSE //currently just stops "was bitten X times!" messages on canned food

/obj/item/reagent_containers/food/Initialize(mapload)
	. = ..()
	if(!mapload)
		pixel_x = rand(-5, 5)
		pixel_y = rand(-5, 5)

/obj/item/reagent_containers/food/attack(mob/M, mob/user, def_zone)
	if(istype(M,/mob/living/carbon))
		var/mob/living/carbon/C = M
		if(C.allergen == FOOD_ALLERGY && foodtype & C.food_allergen)
			C.reagents.add_reagent(/datum/reagent/toxin/histamine, 10)
	..()

/obj/item/reagent_containers/food/proc/checkLiked(var/fraction, mob/M)
	if(last_check_time + 50 < world.time)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/obj/item/organ/tongue/T = H.getorganslot(ORGAN_SLOT_TONGUE)

			if((foodtype & BREAKFAST) && world.time - SSticker.round_start_time < STOP_SERVING_BREAKFAST)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "breakfast", /datum/mood_event/breakfast)
			last_check_time = world.time

			if(!T) //if you don't have a tongue you don't taste..
				return

			if(!HAS_TRAIT(H, TRAIT_AGEUSIA))
				if(foodtype & T.toxic_food)
					to_chat(H,"<span class='warning'>What the hell was that thing?!</span>")
					H.adjust_disgust(25 + 30 * fraction)
					SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "toxic_food", /datum/mood_event/disgusting_food)
				else if(foodtype & T.disliked_food)
					to_chat(H,"<span class='notice'>That didn't taste very good...</span>")
					H.adjust_disgust(11 + 15 * fraction)
					SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "gross_food", /datum/mood_event/gross_food)
				else if(foodtype & T.liked_food)
					to_chat(H,"<span class='notice'>I love this taste!</span>")
					H.adjust_disgust(-5 + -2.5 * fraction)
					SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "fav_food", /datum/mood_event/favorite_food)
			else
				if(foodtype & T.toxic_food)
					to_chat(H, "<span class='warning'>You don't feel so good...</span>")
					H.adjust_disgust(25 + 30 * fraction)
