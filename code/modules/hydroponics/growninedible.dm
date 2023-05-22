// **********************
// Other harvested materials from plants (that are not food)
// **********************

/obj/item/grown // Grown weapons
	name = "grown_weapon"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	resistance_flags = FLAMMABLE
	var/obj/item/seeds/seed = null // type path, gets converted to item on New(). It's safe to assume it's always a seed item.
	var/discovery_points = 0 //Amount of discovery points given for scanning

/obj/item/grown/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	create_reagents(50)

	if(new_seed)
		seed = new_seed.Copy()
	else if(ispath(seed))
		// This is for adminspawn or map-placed growns. They get the default stats of their seed type.
		seed = new seed()
		seed.adjust_potency(50-seed.potency)

	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

	if(seed)
		for(var/datum/plant_gene/trait/T in seed.genes)
			T.on_new(src, loc)

		if(istype(src, seed.product)) // no adding reagents if it is just a trash item
			seed.prepare_result(src)
		transform *= TRANSFORM_USING_VARIABLE(seed.potency, 100) + 0.5
		add_juice()

	if(discovery_points)
		AddComponent(/datum/component/discoverable, discovery_points)

/obj/item/grown/attackby(obj/item/O, mob/user, params)
	..()
	if (istype(O, /obj/item/plant_analyzer))
		var/msg = "<span class='info'>This is \a <span class='name'>[src]</span>\n"
		if(seed)
			msg += seed.get_analyzer_text()
		msg += "</span>"
		to_chat(usr, EXAMINE_BLOCK(msg))
		return

/* Moved to /item/ to support newfood
/obj/item/grown/proc/add_juice()
	if(reagents)
		return 1
	return 0
*/

/obj/item/grown/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_throw_impact(src, hit_atom)

/obj/item/grown/microwave_act(obj/machinery/microwave/M)
	return

/obj/item/grown/on_grind()
	. = ..()
	for(var/i in 1 to grind_results.len)
		grind_results[grind_results[i]] = round(seed.potency)
