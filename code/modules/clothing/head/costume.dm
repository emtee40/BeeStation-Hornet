/obj/item/clothing/head/costume
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'

/obj/item/clothing/head/costume/powdered_wig
	name = "powdered wig"
	desc = "A powdered wig."
	icon_state = "pwig"
	item_state = "pwig"

/obj/item/clothing/head/hooded/hasturhood
	name = "hastur's hood"
	desc = "It's <i>unspeakably</i> stylish."
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "hasturhood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/syndicatefake
	name = "black space-helmet replica"
	icon = 'icons/obj/clothing/head/spacehelm.dmi'
	worn_icon = 'icons/mob/clothing/head/spacehelm.dmi'
	icon_state = "syndicate-helm-black-red"
	item_state = "syndicate-helm-black-red"
	desc = "A plastic replica of a Syndicate agent's space helmet. You'll look just like a real murderous Syndicate agent in this! This is a toy, it is not made for use in space!"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/costume/cueball
	name = "cueball helmet"
	desc = "A large, featureless white orb meant to be worn on your head. How do you even see out of this thing?"
	icon_state = "cueball"
	item_state = null
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/costume/snowman
	name = "Snowman Head"
	desc = "A ball of white styrofoam. So festive."
	icon_state = "snowman_h"
	item_state = null
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/costume/witchwig
	name = "witch costume wig"
	desc = "Eeeee~heheheheheheh!"
	icon_state = "witch"
	item_state = null
	flags_inv = HIDEHAIR

/obj/item/clothing/head/costume/maidheadband
	name = "maid headband"
	desc = "Just like from one of those chinese cartoons!"
	icon_state = "maid_headband"

/obj/item/clothing/head/costume/chicken
	name = "chicken suit head"
	desc = "Bkaw!"
	icon_state = "chickenhead"
	item_state = "chickensuit"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/costume/griffin
	name = "griffon head"
	desc = "Why not 'eagle head'? Who knows."
	icon_state = "griffinhat"
	item_state = null
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/costume/xenos
	name = "xenos helmet"
	icon_state = "xenos"
	item_state = "xenos_helm"
	desc = "A helmet made out of chitinous alien hide."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/costume/lobsterhat
	name = "foam lobster head"
	desc = "When everything's going to crab, protecting your head is the best choice."
	icon_state = "lobster_hat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/costume/drfreezehat
	name = "doctor freeze's wig"
	desc = "A cool wig for cool people."
	icon_state = "drfreeze_hat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/costume/cardborg
	name = "cardborg helmet"
	desc = "A helmet made out of a box."
	icon_state = "cardborg_h"
	item_state = "cardborg_h"
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

	dog_fashion = /datum/dog_fashion/head/cardborg

/obj/item/clothing/head/costume/cardborg/equipped(mob/living/user, slot)
	..()
	if(ishuman(user) && slot == ITEM_SLOT_HEAD)
		var/mob/living/carbon/human/H = user
		if(istype(H.wear_suit, /obj/item/clothing/suit/costume/cardborg))
			var/obj/item/clothing/suit/costume/cardborg/CB = H.wear_suit
			CB.disguise(user, src)

/obj/item/clothing/head/costume/cardborg/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("standard_borg_disguise")

/obj/item/clothing/head/costume/bronze
	name = "bronze hat"
	desc = "A crude helmet made out of bronze plates. It offers very little in the way of protection."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_helmet_old"
	flags_inv = HIDEEARS|HIDEHAIR
	armor = list(MELEE = 5,  BULLET = 0, LASER = -5, ENERGY = 0, BOMB = 10, BIO = 0, RAD = 0, FIRE = 20, ACID = 20, STAMINA = 30)
