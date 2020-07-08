/obj/structure/destructible/clockwork/gear_base/tinkerers_cache
	name = "tinkerer's cache"
	desc = "A bronze store filled with parts and components."
	clockwork_desc = "A bronze store filled with parts and components. Can be used to forge powerful Ratvarian items."
	default_icon_state = "tinkerers_cache"
	anchored = FALSE
	var/cooldowntime = 0

/obj/structure/destructible/clockwork/gear_base/tinkerers_cache/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!is_servant_of_ratvar(user))
		to_chat(user, "<span class='warning'>You try to put your hand into \the [src], but almost burn yourself!</span>")
		return
	if(!anchored)
		to_chat(user, "<span class='brass'>You need to anchor [src] to the floor with your dagger first.</span>")
		return
	if(cooldowntime > world.time)
		to_chat(user, "<span class='brass'>The [src] is still warming up, it will be ready in [DisplayTimeText(cooldowntime - world.time)].</span>")
		return
	var/choice = alert(user,"You begin putting components together in the forge.",,"Robes of Divinity","Shrouding Cloak","Something Else")
	var/list/pickedtype = list()
	switch(choice)
		if("Robes of Divinity")
			pickedtype += /obj/item/clothing/suit/clockwork/speed
		if("Shrouding Cloak")
			pickedtype += /obj/item/clothing/suit/clockwork/cloak
		if("Mirror Shield")
			pickedtype += /obj/item/shield/mirror
	if(src && !QDELETED(src) && anchored && pickedtype && Adjacent(user) && !user.incapacitated() && is_servant_of_ratvar(user) && cooldowntime <= world.time)
		cooldowntime = world.time + 2400
		for(var/N in pickedtype)
			new N(get_turf(src))
			to_chat(user, "<span class='brass'>You craft a [choice] to near perfection, the [src] burning down.</span>")
