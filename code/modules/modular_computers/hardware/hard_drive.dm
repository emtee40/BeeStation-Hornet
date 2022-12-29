/obj/item/computer_hardware/hard_drive
	name = "hard disk drive"
	desc = "A small HDD, for use in basic computers where power efficiency is desired."
	power_usage = 25
	icon_state = "harddisk_mini"
	critical = 1
	w_class = WEIGHT_CLASS_TINY
	device_type = MC_HDD
	var/max_capacity = 128
	var/used_capacity = 0
	/// List of stored files on this drive. DO NOT MODIFY DIRECTLY!
	var/list/stored_files = list()
	/// If we should install the default programs
	var/default_installs = TRUE
	/// If the drive has been installed before (used to prevent re-setting initial ringtone)
	var/has_been_installed = FALSE
	/// List of airlocks this disk can control with program/remote_airlock
	var/list/controllable_airlocks

/obj/item/computer_hardware/hard_drive/on_remove(obj/item/modular_computer/remove_from, mob/user)
	remove_from.shutdown_computer()

/obj/item/computer_hardware/hard_drive/on_install(obj/item/modular_computer/install_into, mob/living/user)
	// We don't want to install again if they remove the drive
	if(has_been_installed)
		return
	has_been_installed = TRUE
	// Add default programs now, instead of Initialize (this is important so they have a reference to "holder" and thus "computer")
	if(default_installs)
		install_default_programs()

/obj/item/computer_hardware/hard_drive/proc/install_default_programs()
	store_file(new/datum/computer_file/program/ntnetdownload(src))		// NTNet Downloader Utility, allows users to download more software from NTNet repository
	store_file(new/datum/computer_file/program/computerconfig(src)) 	// Computer configuration utility, allows hardware control and displays more info than status bar
	store_file(new/datum/computer_file/program/filemanager(src))		// File manager, allows text editor functions and basic file manipulation.
	store_file(new/datum/computer_file/program/databank_uplink(src))	// Wiki Uplink, allows the user to access the Wiki from in-game!

/obj/item/computer_hardware/hard_drive/examine(user)
	. = ..()
	. += "<span class='notice'>It has [max_capacity] GQ of storage capacity.</span>"

/obj/item/computer_hardware/hard_drive/diagnostics(var/mob/user)
	..()
	// 999 is a byond limit that is in place. It's unlikely someone will reach that many files anyway, since you would sooner run out of space.
	to_chat(user, "NT-NFS File Table Status: [stored_files.len]/999")
	to_chat(user, "Storage capacity: [used_capacity]/[max_capacity]GQ")

// Use this proc to add file to the drive. Returns 1 on success and 0 on failure. Contains necessary sanity checks.
/obj/item/computer_hardware/hard_drive/proc/store_file(var/datum/computer_file/F)
	if(!F || !istype(F))
		return 0

	if(!can_store_file(F))
		return 0

	if(!check_functionality())
		return 0

	if(!stored_files)
		return 0

	// This file is already stored. Don't store it again.
	if(F in stored_files)
		return 0

	F.holder = src
	if(holder && istype(F, /datum/computer_file/program))
		var/datum/computer_file/program/P = F
		P.computer = holder
	stored_files.Add(F)
	recalculate_size()
	return 1

// Use this proc to remove file from the drive. Returns 1 on success and 0 on failure. Contains necessary sanity checks.
/obj/item/computer_hardware/hard_drive/proc/remove_file(var/datum/computer_file/F)
	if(!F || !istype(F))
		return 0

	if(!stored_files)
		return 0

	if(!check_functionality())
		return 0

	if(F in stored_files)
		stored_files -= F
		recalculate_size()
		return 1
	else
		return 0

// Loops through all stored files and recalculates used_capacity of this drive
/obj/item/computer_hardware/hard_drive/proc/recalculate_size()
	var/total_size = 0
	for(var/datum/computer_file/F in stored_files)
		total_size += F.size

	used_capacity = total_size

// Checks whether file can be stored on the hard drive. We can only store unique files, so this checks whether we wouldn't get a duplicity by adding a file.
/obj/item/computer_hardware/hard_drive/proc/can_store_file(var/datum/computer_file/F)
	if(!F || !istype(F))
		return 0

	if(F in stored_files)
		return 0

	var/name = F.filename + "." + F.filetype
	for(var/datum/computer_file/file in stored_files)
		if((file.filename + "." + file.filetype) == name)
			return 0

	// In the unlikely event someone manages to create that many files.
	// BYOND is acting weird with numbers above 999 in loops (infinite loop prevention)
	if(stored_files.len >= 999)
		return 0
	if((used_capacity + F.size) > max_capacity)
		return 0
	else
		return 1


// Tries to find the file by filename. Returns null on failure
/obj/item/computer_hardware/hard_drive/proc/find_file_by_name(var/filename)
	if(!check_functionality())
		return null

	if(!filename)
		return null

	if(!stored_files)
		return null

	for(var/datum/computer_file/F in stored_files)
		if(F.filename == filename)
			return F
	return null

/obj/item/computer_hardware/hard_drive/Destroy()
	QDEL_LIST(stored_files)
	return ..()

/obj/item/computer_hardware/hard_drive/advanced
	name = "advanced hard disk drive"
	desc = "A hybrid HDD, for use in higher grade computers where balance between power efficiency and capacity is desired."
	max_capacity = 256
	power_usage = 50 					// Hybrid, medium capacity and medium power storage
	icon_state = "harddisk_mini"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/computer_hardware/hard_drive/super
	name = "super hard disk drive"
	desc = "A high capacity HDD, for use in cluster storage solutions where capacity is more important than power efficiency."
	max_capacity = 512
	power_usage = 100					// High-capacity but uses lots of power, shortening battery life. Best used with APC link.
	icon_state = "harddisk_mini"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/computer_hardware/hard_drive/cluster
	name = "cluster hard disk drive"
	desc = "A large storage cluster consisting of multiple HDDs for usage in dedicated storage systems."
	power_usage = 500
	max_capacity = 2048
	icon_state = "harddisk"
	w_class = WEIGHT_CLASS_NORMAL

// For tablets, etc. - highly power efficient.
/obj/item/computer_hardware/hard_drive/small
	name = "solid state drive"
	desc = "An efficient SSD for portable devices."
	power_usage = 10
	max_capacity = 64
	icon_state = "ssd_mini"
	w_class = WEIGHT_CLASS_TINY
	custom_price = 15

/obj/item/computer_hardware/hard_drive/small/install_default_programs()
	store_file(new /datum/computer_file/program/messenger(src))
	store_file(new /datum/computer_file/program/notepad(src))
	..()

/obj/item/computer_hardware/hard_drive/small/on_install(obj/item/modular_computer/install_into, mob/living/user = null)
	. = ..()
	if(!.)
		return
	// Set the default ringtone
	for(var/datum/computer_file/program/messenger/messenger in stored_files)
		messenger.ringer_status = install_into.init_ringer_on
		messenger.ringtone = install_into.init_ringtone


// For borg integrated tablets. No downloader.
/obj/item/computer_hardware/hard_drive/small/ai/install_default_programs()
	var/datum/computer_file/program/messenger/messenger = new(src)
	messenger.is_silicon = TRUE
	store_file(messenger)

/obj/item/computer_hardware/hard_drive/small/robot/install_default_programs()
	store_file(new /datum/computer_file/program/borg_self_monitor(src))
	store_file(new /datum/computer_file/program/computerconfig(src)) // Computer configuration utility, allows hardware control and displays more info than status bar
	store_file(new /datum/computer_file/program/filemanager(src)) // File manager, allows text editor functions and basic file manipulation.

// Syndicate variant - very slight better
/obj/item/computer_hardware/hard_drive/small/syndicate
	desc = "An efficient SSD for portable devices developed by a rival organisation."
	power_usage = 8
	max_capacity = 70
	var/datum/antagonist/traitor/traitor_data // Syndicate hard drive has the user's data baked directly into it on creation

/// For tablets given to nuke ops
/obj/item/computer_hardware/hard_drive/small/nukeops
	power_usage = 8
	max_capacity = 70
	// Make sure this matches the syndicate shuttle's shield/door id in _maps/shuttles/infiltrator/infiltrator_basic.dmm
	controllable_airlocks = list("smindicate")

/obj/item/computer_hardware/hard_drive/small/nukeops/install_default_programs()
	store_file(new /datum/computer_file/program/computerconfig(src))
	store_file(new /datum/computer_file/program/ntnetdownload/syndicate(src)) // Syndicate version; automatic access to syndicate apps and no NT apps
	store_file(new /datum/computer_file/program/filemanager(src))
	store_file(new /datum/computer_file/program/radar/fission360(src)) //I am legitimately afraid if I don't do this, Ops players will think they just don't get a pinpointer anymore.
	store_file(new /datum/computer_file/program/remote_airlock(src)) // Remote control for the shuttle door
	store_file(new/datum/computer_file/program/borg_monitor/syndicate(src))

/obj/item/computer_hardware/hard_drive/micro
	name = "micro solid state drive"
	desc = "A highly efficient SSD chip for portable devices."
	power_usage = 2
	max_capacity = 32
	icon_state = "ssd_micro"
	w_class = WEIGHT_CLASS_TINY
