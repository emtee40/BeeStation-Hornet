#define VV_HTML_ENCODE(thing) ( sanitize ? html_encode(thing) : thing )
/// Get displayed variable in VV variable list
/proc/debug_variable(name, value, level, datum/D, sanitize = TRUE)			//if D is a list, name will be index, and value will be assoc value.
	var/header
	if(D)
		if(islist(D))
			var/index = name
			if (value)
				name = D[name] //name is really the index until this line
			else
				value = D[name]
			header = "<li style='backgroundColor:white'>([VV_HREF_TARGET_1V(D, VV_HK_LIST_EDIT, "E", index)]) ([VV_HREF_TARGET_1V(D, VV_HK_LIST_CHANGE, "C", index)]) ([VV_HREF_TARGET_1V(D, VV_HK_LIST_REMOVE, "-", index)]) "
		else
			header = "<li style='backgroundColor:white'>([VV_HREF_TARGET_1V(D, VV_HK_BASIC_EDIT, "E", name)]) ([VV_HREF_TARGET_1V(D, VV_HK_BASIC_CHANGE, "C", name)]) ([VV_HREF_TARGET_1V(D, VV_HK_BASIC_MASSEDIT, "M", name)]) "
	else
		header = "<li>"

	var/item
	if (isnull(value))
		item = "[VV_HTML_ENCODE(name)] = <span class='value'>null</span>"

	else if (istext(value))
		item = "[VV_HTML_ENCODE(name)] = <span class='value'>\"[VV_HTML_ENCODE(value)]\"</span>"

	else if (isicon(value))
		#ifdef VARSICON
		var/icon/I = icon(value)
		var/rnd = rand(1,10000)
		var/rname = "tmp[REF(I)][rnd].png"
		usr << browse_rsc(I, rname)
		item = "[VV_HTML_ENCODE(name)] = (<span class='value'>[value]</span>) <img class=icon src=\"[rname]\">"
		#else
		item = "[VV_HTML_ENCODE(name)] = /icon (<span class='value'>[value]</span>)"
		#endif

	else if (isfile(value))
		item = "[VV_HTML_ENCODE(name)] = <span class='value'>'[value]'</span>"

	else if(istype(value,/matrix)) // Needs to be before datum
		var/matrix/M = value
		item = {"[VV_HTML_ENCODE(name)] = <span class='value'>
			<table class='matrixbrak'><tbody><tr><td class='lbrak'>&nbsp;</td><td>
			<table class='matrix'>
			<tbody>
				<tr><td>[M.a]</td><td>[M.d]</td><td>0</td></tr>
				<tr><td>[M.b]</td><td>[M.e]</td><td>0</td></tr>
				<tr><td>[M.c]</td><td>[M.f]</td><td>1</td></tr>
			</tbody>
			</table></td><td class='rbrak'>&nbsp;</td></tr></tbody></table></span>"} //TODO link to modify_transform wrapper for all matrices
	else if (istype(value, /datum))
		var/datum/DV = value
		if ("[DV]" != "[DV.type]") //if the thing as a name var, lets use it.
			item = "<a href='?_src_=vars;[HrefToken()];Vars=[REF(value)]'>[VV_HTML_ENCODE(name)] [REF(value)]</a> = [DV] [DV.type]"
		else
			item = "<a href='?_src_=vars;[HrefToken()];Vars=[REF(value)]'>[VV_HTML_ENCODE(name)] [REF(value)]</a> = [DV.type]"

	else if (islist(value))
		var/list/L = value
		var/list/items = list()

		if (L.len > 0 && !(name == "underlays" || name == "overlays" || L.len > (IS_NORMAL_LIST(L) ? VV_NORMAL_LIST_NO_EXPAND_THRESHOLD : VV_SPECIAL_LIST_NO_EXPAND_THRESHOLD)))
			for (var/i in 1 to L.len)
				var/key = L[i]
				var/val
				if (IS_NORMAL_LIST(L) && !isnum(key))
					val = L[key]
				if (isnull(val))	// we still want to display non-null false values, such as 0 or ""
					val = key
					key = i

				items += debug_variable(key, val, level + 1, sanitize = sanitize)

			item = "<a href='?_src_=vars;[HrefToken()];Vars=[REF(value)]'>[VV_HTML_ENCODE(name)] = /list ([L.len])</a><ul>[items.Join()]</ul>"
		else
			item = "<a href='?_src_=vars;[HrefToken()];Vars=[REF(value)]'>[VV_HTML_ENCODE(name)] = /list ([L.len])</a>"

	else if (name in GLOB.bitfields)
		var/list/flags = list()
		for (var/i in GLOB.bitfields[name])
			if (value & GLOB.bitfields[name][i])
				flags += i
			item = "[VV_HTML_ENCODE(name)] = [VV_HTML_ENCODE(jointext(flags, ", "))]"
	else
		item = "[VV_HTML_ENCODE(name)] = <span class='value'>[VV_HTML_ENCODE(value)]</span>"

	return "[header][item]</li>"

/proc/debug_variable2(varname, value, level, datum/D, sanitize = TRUE)
	var/list/item
	var/index
	if(D && islist(D))
		//If D is a list, 'varname' will be index, and 'value' will be the associated value.
		//We're not really interested in that, however. So let's get what we want.
		//Can't just dump the index however, we'll need it in case the user wants to edit the list.
		index = varname //on the TGUI side we'll also use the presence of "index" to know if an item is under a list.

		if(value)
			varname = D[varname]
		else
			varname = D[varname]

	if (isnull(value))
		item = list(
			"name" = varname,
			"value" = "null"
		)

	else if (istext(value))
		item = list(
			"name" = varname,
			"value" = "\"[value]\""
		)

	//oh god looks like complex shit I'm skipping this
	else if (isicon(value))
		#ifdef VARSICON
		var/icon/I = icon(value)
		var/rnd = rand(1,10000)
		var/rname = "tmp[REF(I)][rnd].png"
		usr << browse_rsc(I, rname)
		item = "[VV_HTML_ENCODE(varname)] = (<span class='value'>[value]</span>) <img class=icon src=\"[rname]\">"
		#else
		item = "[VV_HTML_ENCODE(varname)] = /icon (<span class='value'>[value]</span>)"
		#endif
		item = list(
			"name" = varname,
			"value" = "((icon))"
		)

	else if (isfile(value))
		item = "[varname] = '[value]'"
		item = list(
			"name" = varname,
			"value" = "((file))"
		)

	else if(istype(value,/matrix)) // Needs to be before datum
		var/matrix/M = value
		item = list(
			"name" = varname,
			"value" = "((table))",
			"matrix" = list(M.a, M.b, M.c, M.d, M.e, M.f) //Matrices in DM always only have these 6 elements (for now?) so this hardcode should be fine
		)

	else if (istype(value, /datum))
		var/datum/DV = value
		if ("[DV]" != "[DV.type]") //if the thing as a name var, lets use it.
			item = list(
				"name" = "[varname] [REF(value)]",
				"value" = "[DV] [DV.type]",
				"ref" = REF(value)
			)
		else
			item = list(
				"name" = "[varname] [REF(value)]",
				"value" = DV.type,
				"ref" = REF(value)
			)

	else if (islist(value))
		var/list/L = value
		var/list/items = list()

		if (L.len > 0 && !(varname == "underlays" || varname == "overlays" || L.len > (IS_NORMAL_LIST(L) ? VV_NORMAL_LIST_NO_EXPAND_THRESHOLD : VV_SPECIAL_LIST_NO_EXPAND_THRESHOLD)))
			for (var/i in 1 to L.len)
				var/key = L[i]
				var/val
				if (IS_NORMAL_LIST(L) && !isnum(key))
					val = L[key]
				if (isnull(val)) // we still want to display non-null false values, such as 0 or ""
					val = key
					key = i

				items += list(debug_variable2(key, val, level + 1, sanitize = sanitize))

			//The TGUI side will treat it like a list if "items" is defined.
			item = list(
				"name" = varname,
				"value" = "/list ([L.len])",
				"items" = items,
				"ref" = REF(value)
			)
		else //Better to not render lists of these, they are usually pretty long
			item = list(
				"name" = varname,
				"value" = "/list ([L.len])",
				"items" = list(),
				"ref" = REF(value)
			)

	else if (varname in GLOB.bitfields)
		var/list/flags = list()
		for (var/i in GLOB.bitfields[varname])
			if (value & GLOB.bitfields[varname][i])
				flags += i
			item = list(
				"name" = varname,
				"value" = jointext(flags, ", ")
			)
	else
		item = list(
			"name" = varname,
			"value" = value
		)


	if(index)
		item += list("index" = varname)

	return item

#undef VV_HTML_ENCODE
