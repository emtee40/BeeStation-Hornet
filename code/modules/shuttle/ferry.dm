/obj/machinery/computer/shuttle_flight/ferry
	name = "transport ferry console"
	desc = "A console that controls the transport ferry."
	circuit = /obj/item/circuitboard/computer/ferry
	shuttleId = "ferry"
	possible_destinations = "ferry_home;ferry_away"
	req_access = list(ACCESS_CENT_GENERAL)
	obj_flags = CAN_BE_HIT

	var/allow_silicons = FALSE
	var/allow_emag = FALSE

/obj/machinery/computer/shuttle_flight/ferry/should_emag(mob/user)
	if(!..())
		return FALSE
	if(!allow_emag)
		to_chat(user, "<span class='warning'>[src]'s security firewall is far too powerful for you to bypass.</span>")
		return FALSE
	return TRUE

/obj/machinery/computer/shuttle_flight/ferry/attack_ai()
	return allow_silicons ? ..() : FALSE

/obj/machinery/computer/shuttle_flight/ferry/attack_robot()
	return allow_silicons ? ..() : FALSE

/obj/machinery/computer/shuttle_flight/ferry/request
	name = "ferry console"
	circuit = /obj/item/circuitboard/computer/ferry/request
	var/last_request //prevents spamming admins
	var/cooldown = 600
	possible_destinations = "ferry_home;ferry_away"
	req_access = list(ACCESS_CENT_GENERAL)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/machinery/computer/shuttle_flight/ferry/request/Topic(href, href_list)
	..()
	if(href_list["request"])
		if(last_request && (last_request + cooldown > world.time))
			return
		last_request = world.time
		to_chat(usr, "<span class='notice'>Your request has been received by CentCom.</span>")
		to_chat(GLOB.admins, "<b>FERRY: <font color='#3d5bc3'>[ADMIN_LOOKUPFLW(usr)] (<A HREF='?_src_=holder;[HrefToken()];secrets=moveferry'>Move Ferry</a>)</b> is requesting to move the transport ferry to CentCom.</font>")
