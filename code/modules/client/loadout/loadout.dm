GLOBAL_LIST_EMPTY(loadout_categories)
GLOBAL_LIST_EMPTY(gear_datums)

/datum/loadout_category
	var/category = ""
	var/list/gear = list()

/datum/loadout_category/New(cat)
	category = cat
	..()

/proc/populate_gear_list()
	//create a list of gear datums to sort
	var/list/used_ids = list()
	for(var/geartype in subtypesof(/datum/gear))
		var/datum/gear/G = geartype

		var/use_name = initial(G.display_name)
		var/use_id = initial(G.id)
		if(!use_id) //Not set, generate fallback
			use_id = md5(use_name)
		var/use_category = initial(G.sort_category)

		if(G == initial(G.subtype_path))
			continue

		if(!use_name)
			WARNING("Loadout - Missing display name: [G]")
			continue
		if(use_id in used_ids)
			WARNING("Loadout - ID Already Exists: [G], with ID:[use_id], Conflicts with: [used_ids[use_id]]")
			continue
		if(!initial(G.cost))
			WARNING("Loadout - Missing cost: [G]")
			continue
		if(!initial(G.path) && use_category != "OOC") //OOC category does not contain actual items
			WARNING("Loadout - Missing path definition: [G]")
			continue

		if(!GLOB.loadout_categories[use_category])
			GLOB.loadout_categories[use_category] = new /datum/loadout_category(use_category)
		used_ids[use_id] = G
		var/datum/loadout_category/LC = GLOB.loadout_categories[use_category]
		GLOB.gear_datums[use_id] = new geartype
		LC.gear[use_id] = GLOB.gear_datums[use_id]

	GLOB.loadout_categories = sortAssoc(GLOB.loadout_categories)

/datum/gear
	var/display_name       //Name. Should be unique.
	var/id                 //ID string. MUST be unique.
	var/description        //Description of this gear. If left blank will default to the description of the pathed item.
	var/path               //Path to item.
	var/cost = INFINITY    //Number of metacoins
	var/slot               //Slot to equip to.
	var/list/allowed_roles //Roles that can spawn with this item.
	var/list/species_blacklist //Stop certain species from receiving this gear
	var/list/species_whitelist //Only allow certain species to receive this gear
	var/sort_category = "General"
	var/subtype_path = /datum/gear //for skipping organizational subtypes (optional)
	var/max_purchases = 1 //Max number of times this gear can be purchased.

/datum/gear/New()
	..()
	id = md5(display_name)
	if(!description)
		var/obj/O = path
		description = initial(O.desc)

/datum/gear/proc/purchase(var/client/C, var/donor = FALSE) //Called when the gear is first purchased
	SHOULD_CALL_PARENT(TRUE)
	var/fail_message = donor ? "<span class='warning'>Failed to equip donor gear.</span>" : "<span class='warning'>Failed to add purchase to database. You have not been charged.</span>"
	if(!SSdbcore.IsConnected())
		to_chat(C, fail_message)
		return FALSE
	if(!C?.prefs)
		return FALSE
	if(!C.prefs.purchased_gear[id])
		C.prefs.purchased_gear[id] = 1
		var/datum/DBQuery/query_add_gear_purchase = SSdbcore.NewQuery({"
			INSERT INTO [format_table_name("metacoin_item_purchases")] (`ckey`, `item_id`, `amount`) VALUES (:ckey, :item_id, :amount)"},
			list("ckey" = C.ckey, "item_id" = id, "amount" = 1))
		if(!query_add_gear_purchase.Execute())
			to_chat(C, fail_message)
			qdel(query_add_gear_purchase)
			return FALSE
		qdel(query_add_gear_purchase)
	else
		C.prefs.purchased_gear[id] += 1
		var/amount = C.prefs.purchased_gear[id]
		var/datum/DBQuery/query_add_gear_purchase = SSdbcore.NewQuery({"
			UPDATE [format_table_name("metacoin_item_purchases")] SET amount = :amount WHERE ckey = :ckey AND item_id = :item_id"},
			list("ckey" = C.ckey, "item_id" = id, "amount" = amount))
		if(!query_add_gear_purchase.Execute())
			to_chat(C, fail_message)
			qdel(query_add_gear_purchase)
			return FALSE
		qdel(query_add_gear_purchase)

	return TRUE

/datum/gear_data
	var/path
	var/location

/datum/gear_data/New(npath, nlocation)
	path = npath
	location = nlocation

/datum/gear/proc/spawn_item(location, metadata)
	var/datum/gear_data/gd = new(path, location)
	var/item = new gd.path(gd.location)
	return item
