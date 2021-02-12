//#define SHADOW_DEBUG
//Lighting texture scales in world units (divide by 32)
//256 = 8,4,2
//1024 = 32,16,8
#define LIGHTING_SHADOW_TEX_SIZE 8

#define COORD_LIST_ADD(listtoadd, x, y) \
	if(islist(listtoadd["[x]"])) { \
		BINARY_INSERT_NUM(y, listtoadd["[x]"]); \
	} else { \
		listtoadd["[x]"] = list(y);\
	}

#ifdef SHADOW_DEBUG
#define DEBUG_HIGHLIGHT(x, y, colour) \
	do { \
		var/turf/T = locate(x, y, 2); \
		if(T) { \
			T.color = colour; \
		}\
	} while (0)
#define DO_SOMETHING_IF_DEBUGGING_SHADOWS(something) something
#else
#define DEBUG_HIGHLIGHT(x, y, colour)
#define DO_SOMETHING_IF_DEBUGGING_SHADOWS(something)
#endif

/atom/movable/lighting_mask/alpha
	var/rbo_m = 0
	var/rbo_c = 3.5
	var/list/affecting_turfs

/atom/movable/lighting_mask/alpha/Destroy()
	if(affecting_turfs)
		for(var/turf/thing as() in affecting_turfs)
			LAZYREMOVE(thing.lights_affecting, src)
		affecting_turfs = null
	. = ..()

/atom/movable/lighting_mask/alpha/proc/link_turf_to_light(turf/T)
	LAZYOR(affecting_turfs, T)
	LAZYOR(T.lights_affecting, src)

/atom/movable/lighting_mask/alpha/proc/unlink_turf_from_light(turf/T)
	LAZYREMOVE(affecting_turfs, T)
	LAZYREMOVE(T.lights_affecting, src)

//Returns a list of matrices corresponding to the matrices that should be applied to triangles of
//coordinates (0,0),(1,0),(0,1) to create a triangcalculate_shadows_matricesle that respresents the shadows
//takes in the old turf to smoothly animate shadow movement
/atom/movable/lighting_mask/alpha/proc/calculate_lighting_shadows()

	if(!SSlighting.started)
		SSlighting.sources_that_need_updating |= src
		return

	//Dont bother calculating at all for small shadows
	var/range = radius * 0.5

	if(range < 1)
		return

	SSlighting.total_shadow_calculations ++

	var/unrounded_range = range
	range = FLOOR(unrounded_range, 1)
	if(unrounded_range > range)
		range ++
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/timer = TICK_USAGE)

	//Remove the old shadows
	overlays.Cut()

	//Optimise grouping by storing as
	// Key : x (AS A STRING BECAUSE BYOND DOESNT ALLOW FOR INT KEY DICTIONARIES)
	// Value: List(y values)
	var/list/opaque_atoms_in_view = list()

	//Reset the list
	if(islist(affecting_turfs))
		for(var/turf/T in affecting_turfs)
			T?.lights_affecting -= src

	//Clear the list
	LAZYCLEARLIST(affecting_turfs)

	//Rebuild the list
	for(var/turf/thing in view(range, get_turf(src)))
		link_turf_to_light(thing)
		if(thing.has_opaque_atom || thing.opacity)
			//At this point we no longer care about
			//the atom itself, only the position values
			COORD_LIST_ADD(opaque_atoms_in_view, thing.x, thing.y)
			DEBUG_HIGHLIGHT(thing.x, thing.y, "#0000FF")

	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("[TICK_USAGE_TO_MS(timer)]ms to process view([range], src)."))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/temp_timer = TICK_USAGE)

	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("[TICK_USAGE_TO_MS(timer)]ms to remove ourselves from invalid turfs."))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

	//Group atoms together for optimisation
	var/list/grouped_atoms = group_atoms(opaque_atoms_in_view)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("[TICK_USAGE_TO_MS(temp_timer)]ms to process group_atoms"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/total_coordgroup_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/total_cornergroup_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/triangle_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/culling_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/triangle_to_matrix_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/matrix_division_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/MA_new_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/MA_vars_time = 0)
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(var/overlays_add_time = 0)

	var/list/overlays_to_add = list()
	for(var/group in grouped_atoms)
		DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

		var/list/coordgroup = calculate_corners_in_group(group)
		DO_SOMETHING_IF_DEBUGGING_SHADOWS(total_coordgroup_time += TICK_USAGE_TO_MS(temp_timer))
		DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

		//This is where the lines are made
		var/list/cornergroup = get_corners_from_coords(coordgroup)
		DO_SOMETHING_IF_DEBUGGING_SHADOWS(total_cornergroup_time += TICK_USAGE_TO_MS(temp_timer))
		DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

		//var/list/culledlinegroup = cull_blocked_in_group(cornergroup, opaque_atoms_in_view)
		//DO_SOMETHING_IF_DEBUGGING_SHADOWS(culling_time += TICK_USAGE_TO_MS(temp_timer))
		//DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

		var/list/triangles = calculate_triangle_vertices(cornergroup)
		DO_SOMETHING_IF_DEBUGGING_SHADOWS(triangle_time += TICK_USAGE_TO_MS(temp_timer))
		DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

		for(var/triangle in triangles)
			var/matrix/M = triangle_to_matrix(triangle)

			DO_SOMETHING_IF_DEBUGGING_SHADOWS(triangle_to_matrix_time += TICK_USAGE_TO_MS(temp_timer))
			DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

			M /= transform

			DO_SOMETHING_IF_DEBUGGING_SHADOWS(matrix_division_time += TICK_USAGE_TO_MS(temp_timer))
			DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

			var/mutable_appearance/shadow = new(src)

			DO_SOMETHING_IF_DEBUGGING_SHADOWS(MA_new_time += TICK_USAGE_TO_MS(temp_timer))
			DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

			shadow.icon = LIGHTING_ICON_BIG
			shadow.icon_state = "triangle"
			shadow.layer = layer + 1
			shadow.blend_mode = BLEND_DEFAULT
			shadow.color = "#000"
			shadow.alpha = 255
			shadow.appearance_flags = RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA
			shadow.transform = M

			DO_SOMETHING_IF_DEBUGGING_SHADOWS(MA_vars_time += TICK_USAGE_TO_MS(temp_timer))
			DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

			overlays_to_add += shadow

			DO_SOMETHING_IF_DEBUGGING_SHADOWS(overlays_add_time += TICK_USAGE_TO_MS(temp_timer))
			DO_SOMETHING_IF_DEBUGGING_SHADOWS(temp_timer = TICK_USAGE)

	overlays += overlays_to_add
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("total_coordgroup_time: [total_coordgroup_time]ms"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("total_cornergroup_time: [total_cornergroup_time]ms"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("triangle_time calculation: [triangle_time]ms"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("triangle_to_matrix_time: [triangle_to_matrix_time]"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("Culling Time: [culling_time]ms"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("matrix_division_time: [matrix_division_time]"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("MA_new_time: [MA_new_time]"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("MA_vars_time: [MA_vars_time]"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("overlays_add_time: [overlays_add_time]"))
	DO_SOMETHING_IF_DEBUGGING_SHADOWS(log_game("[TICK_USAGE_TO_MS(timer)]ms to process total."))

//Converts a triangle into a matrix that can be applied to a standardized triangle
//to make it represent the points.
//Note: Ignores translation because
/atom/movable/lighting_mask/alpha/proc/triangle_to_matrix(list/triangle)
	var/turf/our_turf = get_turf(src)
	var/ourx = our_turf.x
	var/oury = our_turf.y

	var/originx = triangle[1][1] - ourx						//~Simultaneous Variable: U~ <-- no thats 0 dummy
	var/originy = triangle[1][2] - oury						//~Simultaneous Variable: V~ <-- No thats 0 dummy
	//Get points translating the first point to (0, 0)
	var/translatedPoint2x = triangle[2][1] - ourx	//Simultaneous Variable: W
	var/translatedPoint2y = triangle[2][2] - oury	//Simultaneous Variable: X
	var/translatedPoint3x = triangle[3][1] - ourx	//Simultaneous Variable: Y
	var/translatedPoint3y = triangle[3][2] - oury	//Simultaneous Variable: Z
	//message_admins("Point 1: ([originx], [originy])")
	//message_admins("Point 2: ([translatedPoint2x], [translatedPoint2y])")
	//message_admins("Point 3: ([translatedPoint3x], [translatedPoint3y])")
	//Assumption that is incorrect
	//Triangle points are
	// (-4, -4)
	// (-4,  4)
	// ( 4, -4)
	//Would be much easier if it was (0, 0) instead of (-4, -4) but since we have 6 inputs and 6 unknowns
	//we can solve the values of the matrix pretty easilly simultaneously.
	//In fact since variables U,W,Y,A,B,C are separate to V,X,Z,D,E,F its easy since its 2 identical tri-variable simultaneous equations.
	//By solving the equations simultaneously we get these results:
	//a = (y-u)/8
	var/a = (translatedPoint3x - originx) / LIGHTING_SHADOW_TEX_SIZE
	//b = (w-u)/ 8
	var/b = (translatedPoint2x - originx) / LIGHTING_SHADOW_TEX_SIZE
	//c = (y+w)/2
	var/c = (translatedPoint3x + translatedPoint2x) / 2
	//d = (z-v)/8
	var/d = (translatedPoint3y - originy) / LIGHTING_SHADOW_TEX_SIZE
	//e = (x-v)/8
	var/e = (translatedPoint2y - originy) / LIGHTING_SHADOW_TEX_SIZE
	//f = (z+x)/2
	var/f = (translatedPoint3y + translatedPoint2y) / 2
	//Matrix time g
	//a,b,d and e can be used to define the shape, C and F can be used for translation god matrices are so beautiful
	//Completely random offset that I didnt derive, I just trialled and errored for about 4 hours until it randomly worked
	//var/radius_based_offset = radius * 3 + 3.5 <-- for 1024x1024 lights DO NOT USE 1024x1024 SHADOWS UNLESS YOU ARE PLAYING WITH RTX200000 OR SOMETHING
	var/radius_based_offset = (radius * rbo_m) + rbo_c
	var/matrix/M = matrix(a, b, (c * 32) - ((radius_based_offset) * 32), d, e, (f * 32) - ((radius_based_offset) * 32))
	//message_admins("[M.a], [M.d], 0")
	//message_admins("[M.b], [M.e], 0")
	//message_admins("[M.c], [M.f], 1")
	return M

//Basically takes the 2-4 corners, extends them and then generates triangle coordinates representing shadows
//Input: list(list(list(x, y), list(x, y)))
// Layer 1: Lines
// Layer 2: Vertex
// Layer 3: X/Y value
//OUTPUT: The same thing but with 3 lists embedded rather than 2 because they are triangles not lines now.
/atom/movable/lighting_mask/alpha/proc/calculate_triangle_vertices(list/cornergroup)
	//Get the origin poin's
	var/turf/our_turf = get_turf(src)
	var/ourx = our_turf.x
	var/oury = our_turf.y
	//The output
	. = list()
	//Every line has 2 triangles innit
	for(var/list/line in cornergroup)
		//Get the corner vertices
		var/vertex1 = line[1]
		var/vertex2 = line[2]
		//Extend them and get end vertices
		//Calculate vertex 3 position
		var/delta_x = abs(vertex1[1] - ourx)
		var/delta_y = abs(vertex1[2] - oury)
		var/extension = 0
		if(delta_x < delta_y)
			extension = radius / delta_x
		else
			extension = radius / delta_y
		var/vertex3 = list(
			(vertex1[1] - ourx) * extension + ourx,
			(vertex1[2] - oury) * extension + oury
			)
		//For vertex 4
		delta_x = abs(vertex2[1] - ourx)
		delta_y = abs(vertex2[2] - oury)
		if(delta_x < delta_y)
			extension = radius / delta_x
		else
			extension = radius / delta_y
		var/vertex4 = list(
			(vertex2[1] - ourx) * extension + ourx,
			(vertex2[2] - oury) * extension + oury
			)
		//Generate triangles
		var/triangle1 = list(vertex1, vertex2, vertex3)
		var/triangle2 = list(vertex2, vertex3, vertex4)
		. += list(triangle1)
		. += list(triangle2)

//Converts the corners into the 3 (or 2) valid points
//For example if a wall is top right of the source, the bottom left wall corner
//can be removed otherwise the wall itself will be in the shadow.
//Input: list(list(x1, y1), list(x2, y2))
//Output: list(list(list(x, y), list(x, y))) <-- 2 coordinates that form a line
/atom/movable/lighting_mask/alpha/proc/get_corners_from_coords(list/coordgroup)
	//Get the raw numbers
	var/xlow = coordgroup[1][1]
	var/ylow = coordgroup[1][2]
	var/xhigh = coordgroup[2][1]
	var/yhigh = coordgroup[2][2]

	//Cache this for speed I guess
	var/turf/our_turf = get_turf(src)
	if(!our_turf)
		stack_trace("Lighting Fatal Error: Light is in an invalid location. Destroying")
		return
	var/ourx = our_turf.x
	var/oury = our_turf.y

	//The source is above the point (Bottom Quad)
	if(oury > yhigh)
		//Bottom Right
		if(ourx < xlow)
			return list(
				list(list(xlow, ylow), list(xhigh, ylow)),
				list(list(xhigh, ylow), list(xhigh, yhigh)),
			)
		//Bottom Left
		else if(ourx > xhigh)
			return list(
				list(list(xlow, yhigh), list(xlow, ylow)),
				list(list(xlow, ylow), list(xhigh, ylow)),
			)
		//Bottom Middle
		else
			return list(
				list(list(xlow, yhigh), list(xlow, ylow)),
				list(list(xlow, ylow), list(xhigh, ylow)),
				list(list(xhigh, ylow), list(xhigh, yhigh))
			)
	//The source is below the point (Top quad)
	else if(oury < ylow)
		//Top Right
		if(ourx < xlow)
			return list(
				list(list(xlow, yhigh), list(xhigh, yhigh)),
				list(list(xhigh, yhigh), list(xhigh, ylow)),
			)
		//Top Left
		else if(ourx > xhigh)
			return list(
				list(list(xlow, ylow), list(xlow, yhigh)),
				list(list(xlow, yhigh), list(xhigh, yhigh)),
			)
		//Top Middle
		else
			return list(
				list(list(xlow, ylow), list(xlow, yhigh)),
				list(list(xlow, yhigh), list(xhigh, yhigh)),
				list(list(xhigh, yhigh), list(xhigh, ylow))
			)
	//the source is between the group Middle something
	else
		//Middle Right
		if(ourx < xlow)
			return list(
				list(list(xlow, yhigh), list(xhigh, yhigh)),
				list(list(xhigh, yhigh), list(xhigh, ylow)),
				list(list(xhigh, ylow), list(xlow, ylow))
			)
		//Middle Left
		else if(ourx > xhigh)
			return list(
				list(list(xhigh, ylow), list(xlow, ylow)),
				list(list(xlow, ylow), list(xlow, yhigh)),
				list(list(xlow, yhigh), list(xhigh, yhigh))
			)
		//Middle Middle (Why?????????)
		else
			return list(
				list(list(xhigh, ylow), list(xlow, ylow)),
				list(list(xlow, ylow), list(xlow, yhigh)),
				list(list(xlow, yhigh), list(xhigh, yhigh)),
				list(list(xlow, yhigh), list(xhigh, ylow))
			)

//Calculates the coordinates of the corner
//Input: Group list(list(list(x,y), list(x,y)), list(list(x, y)))
//Output: Coordinates list(list(left, bottom), list(right, top))
/atom/movable/lighting_mask/alpha/proc/calculate_corners_in_group(list/group)
	if(length(group) == 0)
		CRASH("Calculate_corners_in_group called on a group of length 0. Critical error.")
	if(length(group) == 1)
		var/x = group[1][1]
		var/y = group[1][2]
		return list(
			list(x - 0.5, y - 0.5),
			list(x + 0.5, y + 0.5)
		)
	//Group is multiple length, find top left and bottom right
	var/first = group[1]
	var/second = group[2]
	var/group_direction = NORTH
	if(first[1] != second[1])
		group_direction = EAST
#ifdef SHADOW_DEBUG6
	else if(first[2] != second[2])
		message_admins("Major error, group is not 1xN or Nx1")
#endif
	var/lowest = INFINITY
	var/highest = 0
	for(var/vector in group)
		var/value_to_comp = vector[1]
		if(group_direction == NORTH)
			value_to_comp = vector[2]
		lowest = min(lowest, value_to_comp)
		highest = max(highest, value_to_comp)
	//done ez
	if(group_direction == NORTH)
		return list(
			list(first[1] - 0.5, lowest - 0.5),
			list(first[1] + 0.5, highest + 0.5)
		)
	else
		return list(
			list(lowest - 0.5, first[2] - 0.5),
			list(highest + 0.5, first[2] + 0.5)
		)

//Groups things into vertical and horizontal lines.
//Input: All atoms ungrouped list(atom1, atom2, atom3)
//Output: List(List(Group), list(group2), ... , list(groupN))
//Output: List(List(atom1, atom2), list(atom3, atom4...), ... , list(atomN))
/atom/movable/lighting_mask/alpha/proc/group_atoms(list/ungrouped_things)
	. = list()
	//Ungrouped things comes in as
	// Key: X
	// Value = list(y values)
	//This makes sorting vertically easy, however sorting horizontally is harder
	//While grouping elements vertically, we can put them into a new list with
	// Key: Y
	// Value = list(x values)
	//to make it much easier.
	//=================================================
	var/list/horizontal_atoms = list()
	//Group vertically first because its quick and easy
	for(var/x_key in ungrouped_things)
		//Collect all y elements on that x plane
		var/list/y_elements = ungrouped_things[x_key]
		//Too few elements to group
		if(LAZYLEN(y_elements) <= 1)
			if(LAZYLEN(y_elements) == 1)
				DEBUG_HIGHLIGHT(text2num(x_key), y_elements[1], "#FFFF00")
				COORD_LIST_ADD(horizontal_atoms, y_elements[1], text2num(x_key))
			continue
		//Loop through elements and check if they are new to each other
		var/previous_y_element = y_elements[1]
		//Grouping check
		var/list/group = list()
		for(var/i in 2 to length(y_elements))
			var/actual_y_value = y_elements[i]
			if(actual_y_value == previous_y_element + 1)
				//Start creating a group, remove grouped elements
				if(LAZYLEN(group))
					group += list(list(text2num(x_key), actual_y_value))
					DEBUG_HIGHLIGHT(text2num(x_key), actual_y_value, "#FF0000")
				else
					group += list(list(text2num(x_key), actual_y_value))
					DEBUG_HIGHLIGHT(text2num(x_key), actual_y_value, "#FF0000")
					group += list(list(text2num(x_key), previous_y_element))
					DEBUG_HIGHLIGHT(text2num(x_key), previous_y_element, "#FF0000")
			else
				if(LAZYLEN(group))
					//Add the group to the output groups
					. += list(group)
					group = list()
				if(i == 2)
					DEBUG_HIGHLIGHT(text2num(x_key), previous_y_element, "#FF00FF")
					COORD_LIST_ADD(horizontal_atoms, previous_y_element, text2num(x_key))
				DEBUG_HIGHLIGHT(text2num(x_key), actual_y_value, "#FF00FF")
				COORD_LIST_ADD(horizontal_atoms, actual_y_value, text2num(x_key))
			previous_y_element = actual_y_value
		if(LAZYLEN(group))
			. += list(group)
	//=================================================
	//Bug somewhere in here
	for(var/y_key in horizontal_atoms)
		//Collect all y elements on that x plane
		var/list/x_elements = horizontal_atoms[y_key]
		//Too few elements to group
		if(LAZYLEN(x_elements) <= 1)
			if(LAZYLEN(x_elements) == 1)
				//Single alone atom, add as its own group
				DEBUG_HIGHLIGHT(x_elements[1], text2num(y_key), "#0055FF")
				. += list(list(list(x_elements[1], text2num(y_key))))
			continue
		//Loop through elements and check if they are new to each other
		var/previous_x_element = x_elements[1]
		//Grouping check
		var/list/group = list()
		for(var/i in 2 to length(x_elements))
			var/actual_x_value = x_elements[i]
			if(actual_x_value == previous_x_element + 1)
				//Start creating a group, remove grouped elements
				if(LAZYLEN(group))
					//Horizontal Grouping
					group += list(list(actual_x_value, text2num(y_key)))
					DEBUG_HIGHLIGHT(actual_x_value, text2num(y_key), "#00FF00")
				else
					//Horizontal Grouping
					group += list(list(actual_x_value, text2num(y_key)))
					DEBUG_HIGHLIGHT(actual_x_value, text2num(y_key), "#00FF00")
					group += list(list(previous_x_element, text2num(y_key)))
					DEBUG_HIGHLIGHT(previous_x_element, text2num(y_key), "#00FF00")
			else
				if(LAZYLEN(group))
					//Add the group to the output groups
					. += list(group)
					group = list()
				if(i == 2)
					//Single, alone atom = Add in own group
					DEBUG_HIGHLIGHT(previous_x_element, text2num(y_key), "#00FFFF")
					. += list(list(list(previous_x_element, text2num(y_key))))
				//Single, alone atom = Add in own group
				DEBUG_HIGHLIGHT(actual_x_value, text2num(y_key), "#00FFFF")
				. += list(list(list(actual_x_value, text2num(y_key))))
			previous_x_element = actual_x_value
		if(LAZYLEN(group))
			. += list(group)

#undef LIGHTING_SHADOW_TEX_SIZE
#undef COORD_LIST_ADD
#undef DEBUG_HIGHLIGHT
#undef DO_SOMETHING_IF_DEBUGGING_SHADOWS
