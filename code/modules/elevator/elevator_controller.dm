SUBSYSTEM_DEF(elevator_controller)
	name = "Elevator Controller"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_ELEVATOR
	///List of elevator groups
	var/list/elevator_groups = list()
	///List of elevator group positional stuff
	var/list/elevator_group_positions = list()
	///List of elevator group timers - stops them being spammed
	var/list/elevator_group_timers = list()

/datum/controller/subsystem/elevator_controller/Initialize(start_timeofday)
	. = ..()

/datum/controller/subsystem/elevator_controller/proc/append_id(id, obj/structure/elevator_segment/EV)
	//append positions
	if(!elevator_group_positions[id])
		elevator_group_positions[id] += list("bar" = list("x", "y"), "floor" = list("x", "y"), "middle" = list("x", "y"))
	//Bar
	elevator_group_positions[id]["bar"]["x"] = max(elevator_group_positions[id]["bar"]["x"], EV.x)
	elevator_group_positions[id]["bar"]["y"] = max(elevator_group_positions[id]["bar"]["y"], EV.y)
	//Floor
	elevator_group_positions[id]["floor"]["x"] = elevator_group_positions[id]["floor"]["x"] ? min(elevator_group_positions[id]["floor"]["x"], EV.x) : EV.x
	elevator_group_positions[id]["floor"]["y"] = elevator_group_positions[id]["floor"]["y"] ? min(elevator_group_positions[id]["floor"]["y"], EV.y) : EV.y
	//Middle
	elevator_group_positions[id]["middle"]["x"] = (elevator_group_positions[id]["bar"]["x"] + elevator_group_positions[id]["floor"]["x"]) / 2
	elevator_group_positions[id]["middle"]["y"] = (elevator_group_positions[id]["bar"]["y"] + elevator_group_positions[id]["floor"]["y"]) / 2
	//Append id
	if(!elevator_groups[id])
		elevator_groups[id] = list()
	elevator_groups[id] |= EV
	
/datum/controller/subsystem/elevator_controller/proc/move_elevator(id, destination_z, calltime, force)
	. = TRUE
	elevator_group_timers[id] = addtimer(CALLBACK(src, .proc/finish_timer, id), calltime || 2 SECONDS, TIMER_STOPPABLE)
	//Loop through group ID, to assure there isn't anything blocking us
	var/crashing = FALSE
	var/obj/structure/elevator_segment/S = elevator_groups[id][1]
	if((abs(destination_z - S.z) > 1 || destination_z > S.z))
		for(var/i in min(S.z, destination_z) to max(S.z, destination_z))
			for(var/obj/structure/elevator_segment/ES as() in elevator_groups[id])
				if(!isopenspace(locate(ES.x, ES.y, i)) && i != ES.z && !(ES.z > destination_z && abs(ES.z - destination_z) <= 1)) //2 is default bottom ground floor
					if(!force)
						destination_z = i-1
						if(destination_z == ES.z)
							return
						. =  FALSE
					else
						var/turf/T = locate(ES.x, ES.y, i)
						T.ChangeTurf(/turf/open/openspace)
						crashing = TRUE
					
	SEND_SIGNAL(src, COMSIG_ELEVATOR_MOVE, id, destination_z, calltime, crashing)
	return .

/datum/controller/subsystem/elevator_controller/proc/finish_timer(id)
	QDEL_NULL(elevator_group_timers[id])
