GLOBAL_LIST_INIT(bluespace_drives, list())
GLOBAL_VAR(main_bluespace_drive)


/obj/machinery/bluespace_drive
	name = "bluespace drive"
	icon = 'icons/obj/bluespace_drive.dmi'
	icon_state = "bluespace_drive"
	var/cooldown_world_time
	var/shuttle_id = "exploration"
	var/drive_type = BLUESPACE_DRIVE_BSLEVEL
	var/cooldown = 900

/obj/machinery/bluespace_drive/regular
	drive_type = BLUESPACE_DRIVE_SPACELEVEL

/obj/machinery/bluespace_drive/Initialize()
	. = ..()
	GLOB.bluespace_drives += src
	if(istype(get_area(src), /area/shuttle/exploration))
		GLOB.main_bluespace_drive = src

/obj/machinery/bluespace_drive/proc/engage(datum/star_system/target)
	if(world.time < cooldown_world_time)
		say("Bluespace Drive is currently recharging.")
		return
	if(target.visited)
		say("Bluespace instability detected. Cannot return to selected sector.")
		return
	//Find what shuttle we are on
	cooldown_world_time = world.time + cooldown
	say("Initiating bluespace translation protocols...")
	SSbluespace_exploration.request_ship_transit_to(shuttle_id, target)
