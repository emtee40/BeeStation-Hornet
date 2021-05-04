GLOBAL_LIST_EMPTY(allfaxes)
GLOBAL_LIST_INIT(admin_departments, list("Central Command"))
GLOBAL_LIST_INIT(hidden_admin_departments, list("Syndicate"))
GLOBAL_LIST_EMPTY(alldepartments)
GLOBAL_LIST_EMPTY(hidden_departments)
GLOBAL_LIST_EMPTY(fax_blacklist)

/obj/machinery/photocopier/faxmachine
	name = "fax machine"
	icon = 'icons/obj/library.dmi'
	icon_state = "fax"
	pass_flags = PASSTABLE
	var/fax_network = "Local Fax Network"
	/// If true, prevents fax machine from sending messages to NT machines
	var/syndie_restricted = FALSE

	/// Can we send messages off-station?
	var/long_range_enabled = FALSE
	req_one_access = list(ACCESS_LAWYER, ACCESS_HEADS, ACCESS_ARMORY)

	use_power = IDLE_POWER_USE
	idle_power_usage = 30
	active_power_usage = 200

	/// ID card inserted into the machine, used to log in with
	var/obj/item/card/id/scan

	var/emaged = FALSE

	/// Whether the machine is "logged in" or not
	var/authenticated = FALSE
	/// Next world.time at which this fax machine can send a message to CC/syndicate
	var/sendcooldown = 0
	/// After sending a message to CC/syndicate, cannot send another to them for this many deciseconds
	var/cooldown_time = 600

	/// Our department, determines whether this machine gets faxes sent to a department
	var/department = "Unknown"

	/// Target department to send outgoing faxes to
	var/destination

/obj/machinery/photocopier/faxmachine/New()
	..()
	GLOB.allfaxes += src
	update_network()

/obj/machinery/photocopier/faxmachine/do_insertion(obj/item/O, mob/user)
	O.forceMove(src)
	to_chat(user, "<span class ='notice'>You insert [O] into [src].</span>")
	flick("faxsend", src)
	updateUsrDialog()

/obj/machinery/photocopier/faxmachine/proc/update_network()
	if(department != "Unknown")
		if(!(("[department]" in GLOB.alldepartments) || ("[department]" in GLOB.hidden_departments) || ("[department]" in GLOB.admin_departments) || ("[department]" in GLOB.hidden_admin_departments)))
			GLOB.alldepartments |= department

/obj/machinery/photocopier/faxmachine/longrange
	name = "long range fax machine"
	fax_network = "Central Command Quantum Entanglement Network"
	long_range_enabled = TRUE

/obj/machinery/photocopier/faxmachine/longrange/syndie
	name = "syndicate long range fax machine"
	emaged = TRUE
	syndie_restricted = TRUE
	req_one_access = list(ACCESS_SYNDICATE)
	//No point setting fax network, being emaged overrides that anyway.

/obj/machinery/photocopier/faxmachine/longrange/syndie/update_network()
	if(department != "Unknown")
		GLOB.hidden_departments |= department

/obj/machinery/photocopier/faxmachine/attack_hand(mob/user)
	ui_interact(user)

/obj/machinery/photocopier/faxmachine/attack_ghost(mob/user)
	ui_interact(user)

/obj/machinery/photocopier/faxmachine/attackby(obj/item/item, mob/user, params)
	if(istype(item,/obj/item/card/id) && !scan)
		scan(item)
	else if(istype(item, /obj/item/paper) || istype(item, /obj/item/photo))
		..()
		SStgui.update_uis(src)
	else
		return ..()

/obj/machinery/photocopier/faxmachine/emag_act(mob/user)
	if(!emaged)
		emaged = 1
		req_one_access = list()
		to_chat(user, "<span class='notice'>The transmitters realign to an unknown source!</span>")
	else
		to_chat(user, "<span class='warning'>You swipe the card through [src], but nothing happens.</span>")

/obj/machinery/photocopier/faxmachine/proc/is_authenticated(mob/user)
	if(authenticated || user.has_unlimited_silicon_privilege)
		return TRUE
	return FALSE

/obj/machinery/photocopier/faxmachine/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = TRUE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FaxMachine")
		ui.open()

/obj/machinery/photocopier/faxmachine/ui_data(mob/user)
	var/list/data = list()
	data["authenticated"] = is_authenticated(user)
	data["realauth"] = authenticated
	data["scan_name"] = scan ? scan.name : FALSE
	data["nologin"] = !data["scan_name"] && !data["realauth"]
	if(!data["authenticated"])
		data["network"] = "Disconnected"
	else if(!emaged)
		data["network"] = fax_network
	else
		data["network"] = "ERR*?*%!*"
	data["paper"] = copy ? copy.name : FALSE
	data["paperinserted"] = copy ? TRUE : FALSE
	data["destination"] = destination ? destination : FALSE
	data["sendError"] = FALSE
	if(stat & (BROKEN|NOPOWER))
		data["sendError"] = "No Power"
	else if(!data["authenticated"])
		data["sendError"] = "Not Logged In"
	else if(!data["paper"])
		data["sendError"] = "Nothing Inserted"
	else if(!data["destination"])
		data["sendError"] = "Destination Not Set"
	else if((destination in GLOB.admin_departments) || (destination in GLOB.hidden_admin_departments))
		var/cooldown_seconds = cooldown_seconds()
		if(cooldown_seconds)
			data["sendError"] = "Re-aligning in [cooldown_seconds] seconds..."
	return data


/obj/machinery/photocopier/faxmachine/ui_act(action, params)
	if(..())
		return
	var/is_authenticated = is_authenticated(usr)
	. = TRUE
	switch(action)
		if("scan") // insert/remove your ID card
			scan()
		if("auth") // log in/out
			if(!is_authenticated && scan)
				if(scan.registered_name in GLOB.fax_blacklist)
					to_chat(usr, "<span class='warning'>Login rejected: individual is blacklisted from fax network.</span>")
					playsound(loc, 'sound/machines/buzz-sigh.ogg', 50, 0)
					. = FALSE
				else if(check_access(scan))
					authenticated = TRUE
				else // ID doesn't have access to this machine
					to_chat(usr, "<span class='warning'>Login rejected: ID card does not have required access.</span>")
					playsound(loc, 'sound/machines/buzz-sigh.ogg', 50, 0)
					. = FALSE
			else if(is_authenticated)
				authenticated = FALSE
		if("paper") // insert/eject paper/paperbundle/photo
			if(copy)
				copy.forceMove(get_turf(src))
				if(ishuman(usr))
					if(!usr.get_active_hand() && Adjacent(usr))
						usr.put_in_hands(copy)
				to_chat(usr, "<span class='notice'>You eject [copy] from [src].</span>")
				copy = null
			else
				var/obj/item/I = usr.get_active_hand()
				if(istype(I, /obj/item/paper) || istype(I, /obj/item/photo))
					copy = I
					I.forceMove(src)
					to_chat(usr, "<span class='notice'>You insert [I] into [src].</span>")
					flick("faxsend", src)
				else
					to_chat(usr, "<span class='warning'>[src] only accepts paper, and photos.</span>")
					. = FALSE
		if("rename") // rename the item that is currently in the fax machine
			if(copy)
				var/n_name = sanitize(copytext(input(usr, "What would you like to label the fax?", "Fax Labelling", copy.name)  as text, 1, MAX_MESSAGE_LEN))
				if((copy && copy.loc == src && usr.stat == 0))
					if(istype(copy, /obj/item/paper))
						copy.name = "[(n_name ? text("[n_name]") : initial(copy.name))]"
						copy.desc = "This is a paper titled '" + copy.name + "'."
					else if(istype(copy, /obj/item/photo))
						copy.name = "[(n_name ? text("[n_name]") : "photo")]"
					else
						. = FALSE
				else
					. = FALSE
			else
				. = FALSE
		if("dept") // choose which department receives the fax
			if(is_authenticated)
				var/lastdestination = destination
				var/list/combineddepartments = GLOB.alldepartments.Copy()
				if(long_range_enabled)
					combineddepartments += GLOB.admin_departments.Copy()
				if(emaged)
					combineddepartments += GLOB.hidden_admin_departments.Copy()
					combineddepartments += GLOB.hidden_departments.Copy()
				if(syndie_restricted)
					combineddepartments = GLOB.hidden_admin_departments.Copy()
					combineddepartments += GLOB.hidden_departments.Copy()
					for(var/obj/machinery/photocopier/faxmachine/F in GLOB.allfaxes)
						if(F.emaged)//we can contact emaged faxes on the station
							combineddepartments |= F.department
				destination = input(usr, "To which department?", "Choose a department", "") as null|anything in combineddepartments
				if(!destination)
					destination = lastdestination
		if("send") // actually send the fax
			if(!copy || !is_authenticated || !destination)
				return
			if(stat & (BROKEN|NOPOWER))
				return
			if((destination in GLOB.admin_departments) || (destination in GLOB.hidden_admin_departments))
				var/cooldown_seconds = cooldown_seconds()
				if(cooldown_seconds > 0)
					playsound(loc, 'sound/machines/buzz-sigh.ogg', 50, 0)
					to_chat(usr, "<span class='warning'>[src] is not ready for another [cooldown_seconds] seconds.</span>")
					return
				send_admin_fax(usr, destination)
				sendcooldown = world.time + cooldown_time
			else
				sendfax(destination, usr)
	if(.)
		add_fingerprint(usr)

/obj/machinery/photocopier/faxmachine/proc/scan(obj/item/card/id/card = null)
	if(scan) // Card is in machine
		if(ishuman(usr))
			scan.forceMove(get_turf(src))
			if(!usr.get_active_hand() && Adjacent(usr))
				usr.put_in_hands(scan)
			scan = null
		else
			scan.forceMove(get_turf(src))
			scan = null
	else if(Adjacent(usr))
		if(!card)
			var/obj/item/I = usr.get_active_hand()
			if(istype(I, /obj/item/card/id))
				usr.dropItemToGround(I)
				I.forceMove(src)
				scan = I
		else if(istype(card))
			var/obj/item/I = usr.get_active_hand()
			usr.dropItemToGround(I)
			card.forceMove(src)
			scan = card
	SStgui.update_uis(src)

/obj/machinery/photocopier/faxmachine/verb/eject_id()
	set category = null
	set name = "Eject ID Card"
	set src in oview(1)

	if(usr.incapacitated())
		return

	if(scan)
		to_chat(usr, "You remove [scan] from [src].")
		scan.forceMove(get_turf(src))
		if(!usr.get_active_hand() && Adjacent(usr))
			usr.put_in_hands(scan)
		scan = null
	else
		to_chat(usr, "There is nothing to remove from [src].")

/obj/machinery/photocopier/faxmachine/proc/sendfax(destination, mob/sender)
	use_power(active_power_usage)
	var/success = 0
	for(var/obj/machinery/photocopier/faxmachine/F in GLOB.allfaxes)
		if(F.department == destination)
			success = F.receivefax(copy)
	if(success)
		var/datum/fax/F = new /datum/fax()
		F.name = copy.name
		F.from_department = department
		F.to_department = destination
		F.origin = src
		F.message = copy
		F.sent_by = sender
		F.sent_at = world.time

		visible_message("[src] beeps, \"Message transmitted successfully.\"")
	else
		visible_message("[src] beeps, \"Error transmitting message.\"")

/obj/machinery/photocopier/faxmachine/proc/receivefax(obj/item/incoming)
	if(stat & (BROKEN|NOPOWER))
		return FALSE

	if(department == "Unknown")
		return FALSE //You can't send faxes to "Unknown"

	flick("faxreceive", src)

	playsound(loc, 'sound/machines/printer_dotmatrix.ogg', 50, 1)

	// give the sprite some time to flick
	sleep(20)

	if(istype(incoming, /obj/item/paper))
		incoming.forceMove(drop_location())
	else if(istype(incoming, /obj/item/photo))
		incoming.forceMove(drop_location())
	else
		return FALSE

	use_power(active_power_usage)
	return TRUE

/obj/machinery/photocopier/faxmachine/proc/send_admin_fax(mob/sender, destination)
	use_power(active_power_usage)

	if(!(istype(copy, /obj/item/paper) || istype(copy, /obj/item/photo)))
		visible_message("[src] beeps, \"Error transmitting message.\"")
		return

	var/datum/fax/admin/A = new /datum/fax/admin()
	A.name = copy.name
	A.from_department = department
	A.to_department = destination
	A.origin = src
	A.message = copy
	A.sent_by = sender
	A.sent_at = world.time

	//message badmins that a fax has arrived
	switch(destination)
		if("Central Command")
			message_admins(sender, "CENTCOM FAX", destination, copy, "#006100")
		if("Syndicate")
			message_admins(sender, "SYNDICATE FAX", destination, copy, "#DC143C")
	for(var/obj/machinery/photocopier/faxmachine/F in GLOB.allfaxes)
		if(F.department == destination)
			F.receivefax(copy)
	visible_message("[src] beeps, \"Message transmitted successfully.\"")

/obj/machinery/photocopier/faxmachine/proc/cooldown_seconds()
	if(sendcooldown < world.time)
		return 0
	return round((sendcooldown - world.time) / 10)

/obj/machinery/photocopier/faxmachine/proc/message_admins(mob/sender, faxname, faxtype, obj/item/sent, font_colour="#9A04D1")
	var/msg = "<span class='boldnotice'><font color='[font_colour]'>[faxname]: </font> [key_name_admin(sender)] | REPLY: (<a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxCreate=\ref[sender];originfax=\ref[src];faxtype=[faxtype];replyto=\ref[sent]'>FAX</a>) [ADMIN_SM(sender)] | REJECT: (<A HREF='?_src_=holder;[HrefToken(TRUE)];FaxReplyTemplate=\ref[sender];originfax=\ref[src]'>TEMPLATE</A>) [ADMIN_SMITE(sender)] </span>: Receiving '[sent.name]' via secure connection... <a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxView=\ref[sent]'>view message(must aghost to view)</a>"
	var/fax_sound = sound('sound/effects/adminhelp.ogg')
	for(var/client/C in GLOB.admins)
		to_chat(C, msg)
		if(SOUND_ADMINHELP)
			SEND_SOUND(C, fax_sound)

/obj/machinery/photocopier/faxmachine/proc/become_mimic()
	if(scan)
		scan.forceMove(get_turf(src))
	var/mob/living/simple_animal/hostile/mimic/copy/M = new(loc, src, null, 1) // it will delete src on creation and override any machine checks
	M.name = "angry fax machine"
