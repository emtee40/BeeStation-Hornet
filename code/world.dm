//This file is just for the necessary /world definition
//Try looking in game/world.dm

/world
	mob = /mob/dead/new_player
	turf = /turf/open/space/basic
	area = /area/space
	view = "17x15"
	hub = "Exadv1.spacestation13"
	hub_password = "kMZy3U5jJHSiBQjr"
	name = "BeeStation 13"
	fps = 20

#ifdef FIND_REF_NO_CHECK_TICK
	loop_checks = FALSE
#endif

/// makes `world.log << txt` pretty.
/proc/log_info(txt) // It should be here because of dme include order.
	world.log << "[txt]"
