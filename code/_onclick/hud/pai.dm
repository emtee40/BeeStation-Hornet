#define PAI_MISSING_SOFTWARE_MESSAGE "<span class='warning'>You must download the required software to use this.</span>"

/atom/movable/screen/pai
	icon = 'icons/mob/screen_pai.dmi'
	var/required_software

/atom/movable/screen/pai/Click()
	if(isobserver(usr) || usr.incapacitated())
		return FALSE
	var/mob/living/silicon/pai/pAI = usr
	if(required_software && !pAI.software.Find(required_software))
		to_chat(pAI, PAI_MISSING_SOFTWARE_MESSAGE)
		return FALSE
	return TRUE

/atom/movable/screen/pai/software
	name = "Software Interface"
	icon_state = "pai"

/atom/movable/screen/pai/software/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.ui_interact(pAI)

/atom/movable/screen/pai/shell
	name = "Toggle Holoform"
	icon_state = "pai_holoform"

/atom/movable/screen/pai/shell/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	if(pAI.holoform)
		pAI.fold_in(0)
	else
		pAI.fold_out()

/atom/movable/screen/pai/chassis
	name = "Holochassis Appearance Composite"
	icon_state = "pai_chassis"

/atom/movable/screen/pai/chassis/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.choose_chassis()

/atom/movable/screen/pai/rest
	name = "Rest"
	icon_state = "pai_rest"

/atom/movable/screen/pai/rest/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.lay_down()

/atom/movable/screen/pai/light
	name = "Toggle Integrated Lights"
	icon_state = "light"

/atom/movable/screen/pai/light/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.toggle_integrated_light()

/atom/movable/screen/pai/newscaster
	name = "pAI Newscaster"
	icon_state = "newscaster"
	required_software = PAI_PROGRAM_NEWSCASTER

/atom/movable/screen/pai/newscaster/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.newscaster.ui_interact(usr)

/atom/movable/screen/pai/host_monitor
	name = "Host Health Scan"
	icon_state = "host_monitor"
	required_software = PAI_PROGRAM_HOST_SCAN

/atom/movable/screen/pai/host_monitor/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	var/mob/living/carbon/holder = get(pAI.card.loc, /mob/living/carbon)
	if(holder)
		pAI.hostscan.attack(holder, pAI)
	else
		to_chat(usr, "<span class='warning'>You are not being carried by anyone!</span>")
		return 0

/atom/movable/screen/pai/crew_manifest
	name = "Crew Manifest"
	icon_state = "manifest"
	required_software = PAI_PROGRAM_CREW_MANIFEST

/atom/movable/screen/pai/crew_manifest/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.ai_roster()

/atom/movable/screen/pai/state_laws
	name = "State Laws"
	icon_state = "state_laws"

/atom/movable/screen/pai/state_laws/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.checklaws()

/atom/movable/screen/pai/modpc
	name = "Messenger"
	icon_state = "pda_send"
	required_software = PAI_PROGRAM_DIGITAL_MESSENGER
	var/mob/living/silicon/pai/pAI

/atom/movable/screen/pai/modpc/Click()
	. = ..()
	if(!. || !pAI.modularInterface || !pAI.modularInterface.turn_on(pAI, open_ui = FALSE))
		return
	var/obj/item/computer_hardware/hard_drive/drive = pAI.modularInterface.all_components[MC_HDD]
	for(var/datum/computer_file/program/messenger/app in drive?.stored_files)
		pAI.modularInterface.open_program(pAI, app)
		pAI.modularInterface.interact(pAI)
		break

/atom/movable/screen/pai/internal_gps
	name = "Internal GPS"
	icon_state = "internal_gps"
	required_software = PAI_PROGRAM_INTERNAL_GPS

/atom/movable/screen/pai/internal_gps/Click()
	. = ..()
	if(!.)
		return
	var/mob/living/silicon/pai/pAI = usr
	if(!pAI.internal_gps)
		pAI.internal_gps = new(pAI)
	pAI.internal_gps.attack_self(pAI)

/atom/movable/screen/pai/image_take
	name = "Take Image"
	icon_state = "take_picture"
	required_software = PAI_PROGRAM_PHOTOGRAPHY_MODULE

/atom/movable/screen/pai/image_take/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.aicamera.toggle_camera_mode(usr)

/atom/movable/screen/pai/image_view
	name = "View Images"
	icon_state = "view_images"
	required_software = PAI_PROGRAM_PHOTOGRAPHY_MODULE

/atom/movable/screen/pai/image_view/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.aicamera.viewpictures(usr)

/atom/movable/screen/pai/radio
	name = "radio"
	icon = 'icons/mob/screen_cyborg.dmi'
	icon_state = "radio"

/atom/movable/screen/pai/radio/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	pAI.radio.interact(usr)

/datum/hud/pai/New(mob/living/silicon/pai/owner)
	..()
	var/atom/movable/screen/using
	var/mob/living/silicon/pai/mypai = mymob

// Software menu
	using = new /atom/movable/screen/pai/software
	using.screen_loc = ui_pai_software
	static_inventory += using

// Holoform
	using = new /atom/movable/screen/pai/shell
	using.screen_loc = ui_pai_shell
	static_inventory += using

// Chassis Select Menu
	using = new /atom/movable/screen/pai/chassis
	using.screen_loc = ui_pai_chassis
	static_inventory += using

// Rest
	using = new /atom/movable/screen/pai/rest
	using.screen_loc = ui_pai_rest
	static_inventory += using

// Integrated Light
	using = new /atom/movable/screen/pai/light
	using.screen_loc = ui_pai_light
	static_inventory += using

// Newscaster
	using = new /atom/movable/screen/pai/newscaster
	using.screen_loc = ui_pai_newscaster
	static_inventory += using

// Language menu
	using = new /atom/movable/screen/language_menu
	using.screen_loc = ui_borg_language_menu
	static_inventory += using

// Navigation
	using = new /atom/movable/screen/navigate
	using.screen_loc = ui_navigate_menu
	static_inventory += using

// Host Monitor
	using = new /atom/movable/screen/pai/host_monitor()
	using.screen_loc = ui_pai_host_monitor
	static_inventory += using

// Crew Manifest
	using = new /atom/movable/screen/pai/crew_manifest()
	using.screen_loc = ui_pai_crew_manifest
	static_inventory += using

// Laws
	using = new /atom/movable/screen/pai/state_laws()
	using.screen_loc = ui_pai_state_laws
	static_inventory += using

// Modular Interface
	using = new /atom/movable/screen/pai/modpc()
	using.screen_loc = ui_pai_mod_int
	static_inventory += using
	mypai.interface_button = using
	var/atom/movable/screen/pai/modpc/tablet_button = using
	tablet_button.pAI = mypai

// Internal GPS
	using = new /atom/movable/screen/pai/internal_gps()
	using.screen_loc = ui_pai_internal_gps
	static_inventory += using

// Take image
	using = new /atom/movable/screen/pai/image_take()
	using.screen_loc = ui_pai_take_picture
	static_inventory += using

// View images
	using = new /atom/movable/screen/pai/image_view()
	using.screen_loc = ui_pai_view_images
	static_inventory += using

// Radio
	using = new /atom/movable/screen/pai/radio()
	using.screen_loc = ui_borg_radio
	static_inventory += using

	update_software_buttons()

/datum/hud/pai/proc/update_software_buttons()
	var/mob/living/silicon/pai/owner = mymob
	for(var/atom/movable/screen/pai/button in static_inventory)
		if(button.required_software)
			button.color = owner.software.Find(button.required_software) ? null : "#808080"

#undef PAI_MISSING_SOFTWARE_MESSAGE
