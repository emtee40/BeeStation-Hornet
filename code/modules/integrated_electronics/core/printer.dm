#define MAX_CIRCUIT_CLONE_TIME 3 MINUTES //circuit slow-clones can only take up this amount of time to complete

/obj/machinery/integrated_circuit_printer
	name = "integrated circuit printer"
	desc = "A portable(ish) machine made to print tiny modular circuitry out of iron."
	icon = 'icons/obj/assemblies/electronic_tools.dmi'
	icon_state = "circuit_printer"
	var/upgraded = FALSE		// When hit with an upgrade disk, will turn true, allowing it to print the higher tier circuits.
	var/can_clone = TRUE		// Allows the printer to clone circuits, either instantly or over time depending on upgrade. Set to FALSE to disable entirely.
	var/fast_clone = FALSE		// If this is false, then cloning will take an amount of deciseconds equal to the iron cost divided by 100.
	var/debug = FALSE			// If it's upgraded and can clone, even without config settings.
	var/current_category = null
	var/cloning = FALSE			// If the printer is currently creating a circuit
	var/recycling = FALSE		// If an assembly is being emptied into this printer
	var/list/program			// Currently loaded save, in form of list
	var/datum/weakref/idlock = null
	var/rmat

/obj/machinery/integrated_circuit_printer/proc/check_interactivity(mob/user)
	return user.canUseTopic(src, BE_CLOSE)

/obj/machinery/integrated_circuit_printer/upgraded
	upgraded = TRUE
	can_clone = TRUE
	fast_clone = TRUE

/obj/machinery/integrated_circuit_printer/debug //translation: "integrated_circuit_printer/local_server"
	name = "debug circuit printer"
	debug = TRUE
	upgraded = TRUE
	can_clone = TRUE
	fast_clone = TRUE

/obj/machinery/integrated_circuit_printer/Initialize()
	. = ..()
	rmat = AddComponent(/datum/component/remote_materials, "circuit_printer")
/obj/machinery/integrated_circuit_printer/proc/print_program(mob/user)
	if(!cloning)
		return

	visible_message("<span class='notice'>[src] has finished printing its assembly!</span>")
	playsound(src, 'sound/items/poster_being_created.ogg', 50, TRUE)
	var/obj/item/electronic_assembly/assembly = SScircuit.load_electronic_assembly(get_turf(src), program)
	if(idlock)
		assembly.idlock = idlock
	assembly.creator = key_name(user)
	assembly.investigate_log("was printed by [assembly.creator].", INVESTIGATE_CIRCUIT)
	cloning = FALSE

/obj/machinery/integrated_circuit_printer/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/electronic_assembly))
		insert_assembly(O)
		return
	if(istype(O, /obj/item/integrated_electronics/debugger))
		var/obj/item/integrated_electronics/debugger/debugger = O
		if(!debugger.idlock)
			return

		if(!idlock)
			idlock = debugger.idlock
			debugger.idlock = null
			to_chat(user, "<span class='notice'>You set \the [src] to print out id-locked assemblies only.</span>")
			return

		if(debugger.idlock.resolve() == idlock.resolve())
			idlock = null
			debugger.idlock = null
			to_chat(user, "<span class='notice'>You reset \the [src]'s protection settings.</span>")
			return

	return ..()

/obj/machinery/integrated_circuit_printer/MouseDrop_T(atom/movable/O, mob/user)
	if(istype(O, /obj/item/electronic_assembly))
		insert_assembly(O)
		return

/obj/machinery/integrated_circuit_printer/proc/insert_assembly(obj/item/O)
	if(!contents.len >= 1)
		O.forceMove(src)
	else
		visible_message("<span class='notice'>Please eject assembly before inserting another one!</span>")

/obj/machinery/integrated_circuit_printer/interact(mob/user)
	if(!(in_range(src, user) || issilicon(user)))
		return

	if(isnull(current_category))
		current_category = SScircuit.circuit_fabricator_recipe_list[1]

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

	//Preparing the browser
	var/datum/browser/popup = new(user, "printernew", "Integrated Circuit Printer", 800, 630) // Set up the popup browser window

	var/HTML = "<center><h2>Integrated Circuit Printer</h2></center><br>"
	if(debug)
		HTML += "<center><h3>DEBUG PRINTER -- Infinite materials. Cloning available.</h3></center>"
	else
		HTML += "Iron: [materials.total_amount]/[materials.max_amount].<br><br>"

	HTML += "Identity-lock: "
	if(idlock)
		var/obj/item/card/id = idlock.resolve()
		HTML+= "[id.name] | <A href='?src=[REF(src)];id-lock=TRUE'>Reset</a><br>"
	else
		HTML += "None | Reset<br>"

	if(CONFIG_GET(flag/ic_printing) || debug)
		HTML += "Assembly cloning: [can_clone ? (fast_clone ? "Instant" : "Available") : "Unavailable"].<br>"

	HTML += "Circuits available: [upgraded || debug ? "Advanced":"Regular"]."
	if(!upgraded)
		HTML += "<br>Crossed out circuits mean that the printer is not sufficiently upgraded to create that circuit."

	HTML += "<hr>"
	if((can_clone && CONFIG_GET(flag/ic_printing)) || debug)
		HTML += "Here you can load script for your assembly.<br>"
		if(!cloning)
			HTML += " <A href='?src=[REF(src)];print=load'>Load Old Program</a> "
		else
			HTML += " Load Program"
		HTML += " <A href='?src=[REF(src)];print=loadnew'>Load new Program</a> "
		if(!program)
			HTML += " [fast_clone ? "Print" : "Begin Printing"] Assembly"
		else if(cloning)
			HTML += " <A href='?src=[REF(src)];print=cancel'>Cancel Print</a>"
		else
			HTML += " <A href='?src=[REF(src)];print=print'>[fast_clone ? "Print" : "Begin Printing"] Assembly</a>"

		HTML += "<br><hr>"
	HTML += "Categories:"
	for(var/category in SScircuit.circuit_fabricator_recipe_list)
		if(category != current_category)
			HTML += " <a href='?src=[REF(src)];category=[category]'>[category]</a> "
		else // Bold the button if it's already selected.
			HTML += " <b>[category]</b> "
	HTML += "<hr>"
	HTML += "<center><h4>[current_category]</h4></center>"

	var/list/current_list = SScircuit.circuit_fabricator_recipe_list[current_category]
	for(var/path in current_list)
		var/obj/O = path
		var/can_build = TRUE
		if(ispath(path, /obj/item/integrated_circuit))
			var/obj/item/integrated_circuit/IC = path
			if((initial(IC.spawn_flags) & IC_SPAWN_RESEARCH) && (!(initial(IC.spawn_flags) & IC_SPAWN_DEFAULT)) && !upgraded)
				can_build = FALSE
		if(can_build)
			HTML += "<a href='?src=[REF(src)];build=[path]'>[initial(O.name)]</a>: [initial(O.desc)]<br>"
		else
			HTML += "<s>[initial(O.name)]</s>: [initial(O.desc)]<br>"

	popup.set_content(HTML)
	popup.open()

/obj/machinery/integrated_circuit_printer/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/circuits),
	)
/obj/machinery/integrated_circuit_printer/ui_state(mob/user)
	return GLOB.physical_state

/obj/machinery/integrated_circuit_printer/ui_interact(mob/user,datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Circuit_Printer", name)
		ui.open()

/obj/machinery/integrated_circuit_printer/ui_data(mob/user)
	var/list/data = list()
	data["materials"] = rmat
	data["program"] = program
	data["upgrade"] = upgraded
	data["categories"] = current_category
	data["cloning"] = cloning
	return data

/obj/machinery/integrated_circuit_printer/ui_act(action, params)
	. = ..()
	if(.)
		return
	add_fingerprint(usr)
	switch(action)
		if("category")
			current_category = params["categories"]
			. = TRUE
		if("build")
			var/build_type = text2path(params["build"])
			if(!build_type || !ispath(build_type))
				return
			var/cost = 400
			if(ispath(build_type, /obj/item/electronic_assembly))
				var/obj/item/electronic_assembly/E = SScircuit.cached_assemblies[build_type]
				cost = E.materials[/datum/material/iron]
			else
				var/obj/item/integrated_circuit/IC = SScircuit.cached_components[build_type]
				cost = IC.materials[/datum/material/iron]
			var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
			if(!debug && !materials.use_amount_mat(cost, /datum/material/iron))
				to_chat(usr, "<span class='warning'>You need [cost] iron to build that!</span>")
				return
			var/obj/item/built = new build_type(drop_location())
			if(contents.len >= 1 && istype(built, /obj/item/electronic_assembly))
				built.forceMove(src)
			else if (contents.len >= 1 && istype(built, /obj/item/integrated_circuit))
				var/obj/item/electronic_assembly/E = contents
				E.add_component(built)
			else
				usr.put_in_hands(built)
			if(istype(built, /obj/item/electronic_assembly))
				var/obj/item/electronic_assembly/E = built
				E.creator = key_name(usr)
				E.opened = TRUE
				E.update_icon()
				//reupdate diagnostic hud because it was put_in_hands() and not pickup()'ed
				E.diag_hud_set_circuithealth()
				E.diag_hud_set_circuitcell()
				E.diag_hud_set_circuitstat()
				E.diag_hud_set_circuittracking()
				E.investigate_log("was printed by [E.creator].", INVESTIGATE_CIRCUIT)
			to_chat(usr, "<span class='notice'>[capitalize(built.name)] printed.</span>")
			playsound(src, 'sound/items/jaws_pry.ogg', 50, TRUE)

/obj/machinery/integrated_circuit_printer/Topic(href, href_list)
	if(!check_interactivity(usr))
		return
	if(..())
		return TRUE
	add_fingerprint(usr)

	if(href_list["id-lock"])
		idlock = null

	// if(href_list["category"])
	// 	current_category = href_list["category"]

	// if(href_list["build"])
	// 	var/build_type = text2path(href_list["build"])
	// 	if(!build_type || !ispath(build_type))
	// 		return TRUE

	// 	var/cost = 400
	// 	if(ispath(build_type, /obj/item/electronic_assembly))
	// 		var/obj/item/electronic_assembly/E = SScircuit.cached_assemblies[build_type]
	// 		cost = E.materials[/datum/material/iron]
	// 	else if(ispath(build_type, /obj/item/integrated_circuit))
	// 		var/obj/item/integrated_circuit/IC = SScircuit.cached_components[build_type]
	// 		cost = IC.materials[/datum/material/iron]
	// 	else if(!(build_type in SScircuit.circuit_fabricator_recipe_list["Tools"]))
	// 		log_href_exploit(usr)
	// 		return

	// 	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

	// 	if(!debug && !materials.use_amount_mat(cost, /datum/material/iron))
	// 		to_chat(usr, "<span class='warning'>You need [cost] iron to build that!</span>")
	// 		return TRUE

	// 	var/obj/item/built = new build_type(drop_location())
	// 	usr.put_in_hands(built)

	// 	if(istype(built, /obj/item/electronic_assembly))
	// 		var/obj/item/electronic_assembly/E = built
	// 		E.creator = key_name(usr)
	// 		E.opened = TRUE
	// 		E.update_icon()
	// 		//reupdate diagnostic hud because it was put_in_hands() and not pickup()'ed
	// 		E.diag_hud_set_circuithealth()
	// 		E.diag_hud_set_circuitcell()
	// 		E.diag_hud_set_circuitstat()
	// 		E.diag_hud_set_circuittracking()
	// 		E.investigate_log("was printed by [E.creator].", INVESTIGATE_CIRCUIT)

	// 	to_chat(usr, "<span class='notice'>[capitalize(built.name)] printed.</span>")
	// 	playsound(src, 'sound/items/jaws_pry.ogg', 50, TRUE)

	if(href_list["print"])
		if(!CONFIG_GET(flag/ic_printing) && !debug)
			to_chat(usr, "<span class='warning'>CentCom has disabled printing of custom circuitry due to recent allegations of copyright infringement.</span>")
			return
		if(!can_clone) // Copying and printing ICs is cloning
			to_chat(usr, "<span class='warning'>This printer does not have the cloning upgrade.</span>")
			return
		switch(href_list["print"])
			if("load")
				if(cloning)
					return
				var/input = capped_multiline_input(usr, "Put your code there:", "loading", max_length = MAX_SIZE_CIRCUIT)
				if(!check_interactivity(usr) || cloning)
					return
				if(!input)
					program = null
					return

				var/validation = SScircuit.validate_electronic_assembly(input, TRUE)
				validate_circuit(validation)

			if("loadnew")
				var/savefile/S = new /savefile("data/player_saves/[usr.ckey[1]]/[usr.ckey]/circuits.sav")
				var/templist
				S >> templist
				var/name = tgui_input_list(usr,"Choose a Circuit from the list.","Choose",templist)
				var/validation = SScircuit.validate_electronic_assembly(templist["[name]"], FALSE)
				validate_circuit(validation)
			if("print")
				if(!program || cloning)
					return

				if(program["requires_upgrades"] && !upgraded && !debug)
					to_chat(usr, "<span class='warning'>This program uses unknown component designs. Printer upgrade is required to proceed.</span>")
					return
				if(program["unsupported_circuit"] && !debug)
					to_chat(usr, "<span class='warning'>This program uses components not supported by the specified assembly. Please change the assembly type in the save file to a supported one.</span>")
					return
				else if(fast_clone)
					var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
					if(debug || materials.use_amount_mat(program["iron_cost"], /datum/material/iron))
						cloning = TRUE
						print_program(usr)
					else
						to_chat(usr, "<span class='warning'>You need [program["iron_cost"]] iron to build that!</span>")
				else
					var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
					if(!materials.use_amount_mat(program["iron_cost"], /datum/material/iron))
						to_chat(usr, "<span class='warning'>You need [program["iron_cost"]] iron to build that!</span>")
						return
					var/cloning_time = round(program["iron_cost"] / 15)
					cloning_time = min(cloning_time, MAX_CIRCUIT_CLONE_TIME)
					cloning = TRUE
					to_chat(usr, "<span class='notice'>You begin printing a custom assembly. This will take approximately [DisplayTimeText(cloning_time)]. You can still print \
					off normal parts during this time.</span>")
					playsound(src, 'sound/items/poster_being_created.ogg', 50, TRUE)
					addtimer(CALLBACK(src, .proc/print_program, usr), cloning_time)

			if("cancel")
				if(!cloning || !program)
					return

				to_chat(usr, "<span class='notice'>Cloning has been canceled. Iron cost has been refunded.</span>")
				cloning = FALSE
				var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
				materials.use_amount_mat(-program["iron_cost"], /datum/material/iron) //use negative amount to regain the cost


	interact(usr)


// FUKKEN UPGRADE DISKS
/obj/item/disk/integrated_circuit/upgrade
	name = "integrated circuit printer upgrade disk"
	desc = "Install this into your integrated circuit printer to enhance it."
	icon = 'icons/obj/assemblies/electronic_tools.dmi'
	icon_state = "upgrade_disk"
	item_state = "card-id"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/disk/integrated_circuit/upgrade/advanced
	name = "integrated circuit printer upgrade disk - advanced designs"
	desc = "Install this into your integrated circuit printer to enhance it.  This one adds new, advanced designs to the printer."

/obj/item/disk/integrated_circuit/upgrade/clone
	name = "integrated circuit printer upgrade disk - instant cloner"
	desc = "Install this into your integrated circuit printer to enhance it.  This one allows the printer to duplicate assemblies instantaneously."
	icon_state = "upgrade_disk_clone"

/obj/machinery/integrated_circuit_printer/proc/load_circuit(var/saved_data)
	var/validation = SScircuit.validate_electronic_assembly(saved_data, FALSE)
	validate_circuit(validation)

/obj/machinery/integrated_circuit_printer/proc/validate_circuit(var/validation)
	// Validation error codes are returned as text.
	if(istext(validation))
		to_chat(usr, "<span class='warning'>Error: [validation]</span>")
		return
	else if(islist(validation))
		program = validation
		to_chat(usr, "<span class='notice'>This is a valid program for [program["assembly"]["type"]].</span>")
		if(program["requires_upgrades"])
			if(upgraded)
				to_chat(usr, "<span class='notice'>It uses advanced component designs.</span>")
			else
				to_chat(usr, "<span class='warning'>It uses unknown component designs. Printer upgrade is required to proceed.</span>")
		if(program["unsupported_circuit"])
			to_chat(usr, "<span class='warning'>This program uses components not supported by the specified assembly. Please change the assembly type in the save file to a supported one.</span>")
		to_chat(usr, "<span class='notice'>Used space: [program["used_space"]]/[program["max_space"]].</span>")
		to_chat(usr, "<span class='notice'>Complexity: [program["complexity"]]/[program["max_complexity"]].</span>")
		to_chat(usr, "<span class='notice'>Iron cost: [program["iron_cost"]].</span>")
