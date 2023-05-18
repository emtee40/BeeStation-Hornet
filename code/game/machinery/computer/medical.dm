

/obj/machinery/computer/med_data//TODO:SANITY
	name = "medical records console"
	desc = "This can be used to check medical records."
	icon_screen = "medcomp"
	icon_keyboard = "med_key"
	req_one_access = list(ACCESS_MEDICAL, ACCESS_FORENSICS_LOCKERS)
	circuit = /obj/item/circuitboard/computer/med_data
	var/rank = null
	var/screen = null
	var/datum/data/record/active1
	var/datum/data/record/active2
	var/a_id = null
	var/temp = null
	var/printing = null
	//Sorting Variables
	var/sortBy = "name"
	var/order = 1 // -1 = Descending - 1 = Ascending

	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/med_data/syndie
	icon_keyboard = "syndie_key"

/obj/machinery/computer/med_data/ui_interact(mob/user)
	. = ..()
	if(isliving(user))
		playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, FALSE)
	var/dat
	if(temp)
		dat = text("<TT>[temp]</TT><BR><BR><A href='?src=[REF(src)];temp=1'>Clear Screen</A>")
	else
		if(authenticated)
			switch(screen)
				if(1)
					dat += {"
<A href='?src=[REF(src)];search=1'>Search Records</A>
<BR><A href='?src=[REF(src)];screen=2'>List Records</A>
<BR>
<BR><A href='?src=[REF(src)];screen=5'>Virus Database</A>
<BR><A href='?src=[REF(src)];screen=6'>Medbot Tracking</A>
<BR>
<BR><A href='?src=[REF(src)];screen=3'>Record Maintenance</A>
<BR><A href='?src=[REF(src)];logout=1'>{Log Out}</A><BR>
"}
				if(2)
					dat += {"
</p>
<table style="text-align:center;" cellspacing="0" width="100%">
<tr>
<th>Records:</th>
</tr>
</table>
<table style="text-align:center;" border="1" cellspacing="0" width="100%">
<tr>
<th><A href='?src=[REF(src)];choice=Sorting;sort=name'>Name</A></th>
<th><A href='?src=[REF(src)];choice=Sorting;sort=id'>ID</A></th>
<th>Fingerprints (F) | DNA (D)</th>
<th><A href='?src=[REF(src)];choice=Sorting;sort=bloodtype'>Blood Type</A></th>
<th>Physical Status</th>
<th>Mental Status</th>
</tr>"}


					if(!isnull(GLOB.data_core.general))
						for(var/datum/data/record/R in sort_record(GLOB.data_core.general, sortBy, order))
							var/blood_type = ""
							var/b_dna = ""
							for(var/datum/data/record/E in GLOB.data_core.medical)
								if((E.fields["name"] == R.fields["name"] && E.fields["id"] == R.fields["id"]))
									blood_type = E.fields["blood_type"]
									b_dna = E.fields["b_dna"]
							var/background

							if(R.fields["m_stat"] == "*Insane*" || R.fields["p_stat"] == "*Deceased*")
								background = "'background-color:#990000;'"
							else if(R.fields["p_stat"] == "*Unconscious*" || R.fields["m_stat"] == "*Unstable*")
								background = "'background-color:#CD6500;'"
							else if(R.fields["p_stat"] == "Physically Unfit" || R.fields["m_stat"] == "*Watch*")
								background = "'background-color:#3BB9FF;'"
							else
								background = "'background-color:#4F7529;'"

							dat += text("<tr style=[]><td><A href='?src=[REF(src)];d_rec=[]'>[]</a></td>", background, R.fields["id"], R.fields["name"])
							dat += text("<td>[]</td>", R.fields["id"])
							dat += text("<td><b>F:</b> []<BR><b>D:</b> []</td>", R.fields["fingerprint"], b_dna)
							dat += text("<td>[]</td>", blood_type)
							dat += text("<td>[]</td>", R.fields["p_stat"])
							dat += text("<td>[]</td></tr>", R.fields["m_stat"])
					dat += "</table><hr width='75%' />"
					dat += "<HR><A href='?src=[REF(src)];screen=1'>Back</A>"
				if(3)
					dat += "<B>Records Maintenance</B><HR>\n<A href='?src=[REF(src)];back=1'>Backup To Disk</A><BR>\n<A href='?src=[REF(src)];u_load=1'>Upload From Disk</A><BR>\n<A href='?src=[REF(src)];del_all=1'>Delete All Records</A><BR>\n<BR>\n<A href='?src=[REF(src)];screen=1'>Back</A>"
				if(4)

					dat += "<table><tr><td><b><font size='4'>Medical Record</font></b></td></tr>"
					if(active1 in GLOB.data_core.general)
						var/front_photo = active1.get_front_photo()
						if(istype(front_photo, /obj/item/photo))
							var/obj/item/photo/photo_front = front_photo
							user << browse_rsc(photo_front.picture.picture_image, "photo_front")
						var/side_photo = active1.get_side_photo()
						if(istype(side_photo, /obj/item/photo))
							var/obj/item/photo/photo_side = side_photo
							user << browse_rsc(photo_side.picture.picture_image, "photo_side")
						dat += "<tr><td>Name:</td><td>[active1.fields["name"]]</td>"
						dat += "<td><a href='?src=[REF(src)];field=show_photo_front'><img src=photo_front height=96 width=96 border=4 style=\"-ms-interpolation-mode:nearest-neighbor\"></a></td>"
						dat += "<td><a href='?src=[REF(src)];field=show_photo_side'><img src=photo_side height=96 width=96 border=4 style=\"-ms-interpolation-mode:nearest-neighbor\"></a></td></tr>"
						dat += "<tr><td>ID:</td><td>[active1.fields["id"]]</td></tr>"
						dat += "<tr><td>Gender:</td><td><A href='?src=[REF(src)];field=gender'>&nbsp;[active1.fields["gender"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Age:</td><td><A href='?src=[REF(src)];field=age'>&nbsp;[active1.fields["age"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Species:</td><td><A href='?src=[REF(src)];field=species'>&nbsp;[active1.fields["species"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Fingerprint:</td><td><A href='?src=[REF(src)];field=fingerprint'>&nbsp;[active1.fields["fingerprint"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Physical Status:</td><td><A href='?src=[REF(src)];field=p_stat'>&nbsp;[active1.fields["p_stat"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Mental Status:</td><td><A href='?src=[REF(src)];field=m_stat'>&nbsp;[active1.fields["m_stat"]]&nbsp;</A></td></tr>"
					else
						dat += "<tr><td>General Record Lost!</td></tr>"

					dat += "<tr><td><br><b><font size='4'>Medical Data</font></b></td></tr>"
					if(active2 in GLOB.data_core.medical)
						dat += "<tr><td>Blood Type:</td><td><A href='?src=[REF(src)];field=blood_type'>&nbsp;[active2.fields["blood_type"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>DNA:</td><td><A href='?src=[REF(src)];field=b_dna'>&nbsp;[active2.fields["b_dna"]]&nbsp;</A></td></tr>"
						dat += "<tr><td><br>Minor Disabilities:</td><td><br><A href='?src=[REF(src)];field=mi_dis'>&nbsp;[active2.fields["mi_dis"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Details:</td><td><A href='?src=[REF(src)];field=mi_dis_d'>&nbsp;[active2.fields["mi_dis_d"]]&nbsp;</A></td></tr>"
						dat += "<tr><td><br>Major Disabilities:</td><td><br><A href='?src=[REF(src)];field=ma_dis'>&nbsp;[active2.fields["ma_dis"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Details:</td><td><A href='?src=[REF(src)];field=ma_dis_d'>&nbsp;[active2.fields["ma_dis_d"]]&nbsp;</A></td></tr>"
						dat += "<tr><td><br>Allergies:</td><td><br><A href='?src=[REF(src)];field=alg'>&nbsp;[active2.fields["alg"]]&nbsp;</A></td></tr>"
						dat += "<tr><td>Details:</td><td><A href='?src=[REF(src)];field=alg_d'>&nbsp;[active2.fields["alg_d"]]&nbsp;</A></td></tr>"
						dat += "<tr><td><br>Current Diseases:</td><td><br><A href='?src=[REF(src)];field=cdi'>&nbsp;[active2.fields["cdi"]]&nbsp;</A></td></tr>" //(per disease info placed in log/comment section)
						dat += "<tr><td>Details:</td><td><A href='?src=[REF(src)];field=cdi_d'>&nbsp;[active2.fields["cdi_d"]]&nbsp;</A></td></tr>"
						dat += "<tr><td><br>Important Notes:</td><td><br><A href='?src=[REF(src)];field=notes'>&nbsp;[active2.fields["notes"]]&nbsp;</A></td></tr>"

						dat += "<tr><td><br><b><font size='4'>Comments/Log</font></b></td></tr>"
						var/counter = 1
						while(src.active2.fields[text("com_[]", counter)])
							dat += "<tr><td>[active2.fields[text("com_[]", counter)]]</td></tr><tr><td><A href='?src=[REF(src)];del_c=[counter]'>Delete Entry</A></td></tr>"
							counter++
						dat += "<tr><td><A href='?src=[REF(src)];add_c=1'>Add Entry</A></td></tr>"

						dat += "<tr><td><br><A href='?src=[REF(src)];del_r=1'>Delete Record (Medical Only)</A></td></tr>"
					else
						dat += "<tr><td>Medical Record Lost!</tr>"
						dat += "<tr><td><br><A href='?src=[REF(src)];new=1'>New Record</A></td></tr>"
					dat += "<tr><td><A href='?src=[REF(src)];print_p=1'>Print Record</A></td></tr>"
					dat += "<tr><td><A href='?src=[REF(src)];screen=2'>Back</A></td></tr>"
					dat += "</table>"
				if(5)
					dat += "<CENTER><B>Virus Database</B></CENTER>"
					for(var/Dt in typesof(/datum/disease/))
						var/datum/disease/Dis = new Dt(0)
						if(istype(Dis, /datum/disease/advance))
							continue // TODO (tm): Add advance diseases to the virus database which no one uses.
						if(!Dis.desc)
							continue
						dat += "<br><a href='?src=[REF(src)];vir=[Dt]'>[Dis.name]</a>"
					dat += "<br><a href='?src=[REF(src)];screen=1'>Back</a>"
				if(6)
					dat += "<center><b>Medical Robot Monitor</b></center>"
					dat += "<a href='?src=[REF(src)];screen=1'>Back</a>"
					dat += "<br><b>Medical Robots:</b>"
					var/bdat = null
					for(var/mob/living/simple_animal/bot/medbot/M in GLOB.alive_mob_list)
						if(M.get_virtual_z_level() != src.get_virtual_z_level())
							continue	//only find medibots on the same z-level as the computer
						var/turf/bl = get_turf(M)
						if(bl)	//if it can't find a turf for the medibot, then it probably shouldn't be showing up
							bdat += "[M.name] - <b>\[[bl.x],[bl.y]\]</b> - [M.on ? "Online" : "Offline"]<br>"
					if(!bdat)
						dat += "<br><center>None detected</center>"
					else
						dat += "<br>[bdat]"

				else
		else
			dat += "<A href='?src=[REF(src)];login=1'>{Log In}</A>"
	var/datum/browser/popup = new(user, "med_rec", "Medical Records Console", 600, 400)
	popup.set_content(dat)
	popup.open()

/obj/machinery/computer/med_data/Topic(href, href_list)
	. = ..()
	if(.)
		return .
	if(!(active1 in GLOB.data_core.general))
		src.active1 = null
	if(!(active2 in GLOB.data_core.medical))
		src.active2 = null

	if(usr.contents.Find(src) || (in_range(src, usr) && isturf(loc)) || issilicon(usr) || IsAdminGhost(usr))
		usr.set_machine(src)
		if(href_list["temp"])
			src.temp = null
		else if(href_list["logout"])
			src.authenticated = null
			src.screen = null
			src.active1 = null
			src.active2 = null
		else if(href_list["choice"])
			// SORTING!
			if(href_list["choice"] == "Sorting")
				// Reverse the order if clicked twice
				if(sortBy == href_list["sort"])
					if(order == 1)
						order = -1
					else
						order = 1
				else
				// New sorting order!
					sortBy = href_list["sort"]
					order = initial(order)
		else if(href_list["login"])
			var/mob/M = usr
			var/obj/item/card/id/I = M.get_idcard(TRUE)
			if(issilicon(M))
				active1 = null
				active2 = null
				authenticated = 1
				rank = JOB_NAME_AI
				screen = 1
			else if(IsAdminGhost(M))
				active1 = null
				active2 = null
				authenticated = 1
				rank = JOB_CENTCOM_CENTRAL_COMMAND
				screen = 1
			else if(istype(I) && check_access(I))
				active1 = null
				active2 = null
				authenticated = I.registered_name
				rank = I.assignment
				screen = 1
			else
				to_chat(usr, "<span class='danger'>Unauthorized access.</span>")
			playsound(src, 'sound/machines/terminal_on.ogg', 50, FALSE)
		if(src.authenticated)

			if(href_list["screen"])
				src.screen = text2num(href_list["screen"])
				if(src.screen < 1)
					src.screen = 1

				src.active1 = null
				src.active2 = null

			else if(href_list["vir"])
				var/href_type = text2path(href_list["vir"])
				if(ispath(href_type, /datum/disease))
					var/datum/disease/type = href_type
					src.temp = {"<b>Name:</b> [initial(type.name)]
<BR><b>Number of stages:</b> [initial(type.max_stages)]
<BR><b>Spread:</b> [initial(type.spread_text)] Transmission
<BR><b>Possible Cure:</b> [(initial(type.cure_text)||"none")]
<BR>
<BR><b>Notes:</b> [initial(type.desc)]
<BR>
<BR><b>Danger:</b> [initial(type.danger)]"}

			else if(href_list["del_all"])
				src.temp = "Are you sure you wish to delete all records?<br>\n\t<A href='?src=[REF(src)];temp=1;del_all2=1'>Yes</A><br>\n\t<A href='?src=[REF(src)];temp=1'>No</A><br>"

			else if(href_list["del_all2"])
				investigate_log("[key_name(usr)] has deleted all medical records.", INVESTIGATE_RECORDS)
				GLOB.data_core.medical.Cut()
				src.temp = "All records deleted."

			else if(href_list["field"])
				var/a1 = src.active1
				var/a2 = src.active2
				switch(href_list["field"])
					if("fingerprint")
						if(active1)
							var/t1 = stripped_input(usr, "Please input fingerprint hash:", "Med. records", src.active1.fields["fingerprint"])
							if(!canUseMedicalRecordsConsole(usr, t1, a1))
								return
							src.active1.fields["fingerprint"] = t1
					if("gender")
						if(active1)
							var/t1 = input(usr, "Select gender", "Med. records", src.active1.fields["gender"]) as null|anything in list(MALE, FEMALE, "other")
							if(!canUseMedicalRecordsConsole(usr, t1, a1))
								return
							src.active1.fields["gender"] = capitalize(t1)
					if("age")
						if(active1)
							var/t1 = input("Please input age:", "Med. records", src.active1.fields["age"], null)  as num
							if(!canUseMedicalRecordsConsole(usr, t1, a1))
								return
							src.active1.fields["age"] = t1
					if("species")
						if(active1)
							var/t1 = stripped_input(usr, "Please input species name", "Med. records", src.active1.fields["species"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, a1))
								return
							active1.fields["species"] = t1
					if("mi_dis")
						if(active2)
							var/t1 = stripped_input(usr, "Please input minor disabilities list:", "Med. records", src.active2.fields["mi_dis"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["mi_dis"] = t1
					if("mi_dis_d")
						if(active2)
							var/t1 = stripped_input(usr, "Please summarize minor dis.:", "Med. records", src.active2.fields["mi_dis_d"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["mi_dis_d"] = t1
					if("ma_dis")
						if(active2)
							var/t1 = stripped_input(usr, "Please input major disabilities list:", "Med. records", src.active2.fields["ma_dis"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["ma_dis"] = t1
					if("ma_dis_d")
						if(active2)
							var/t1 = stripped_input(usr, "Please summarize major dis.:", "Med. records", src.active2.fields["ma_dis_d"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["ma_dis_d"] = t1
					if("alg")
						if(active2)
							var/t1 = stripped_input(usr, "Please state allergies:", "Med. records", src.active2.fields["alg"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["alg"] = t1
					if("alg_d")
						if(active2)
							var/t1 = stripped_input(usr, "Please summarize allergies:", "Med. records", src.active2.fields["alg_d"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["alg_d"] = t1
					if("cdi")
						if(active2)
							var/t1 = stripped_input(usr, "Please state diseases:", "Med. records", src.active2.fields["cdi"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["cdi"] = t1
					if("cdi_d")
						if(active2)
							var/t1 = stripped_input(usr, "Please summarize diseases:", "Med. records", src.active2.fields["cdi_d"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["cdi_d"] = t1
					if("notes")
						if(active2)
							var/t1 = stripped_input(usr, "Please summarize notes:", "Med. records", src.active2.fields["notes"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["notes"] = t1
					if("p_stat")
						if(active1)
							src.temp = "<B>Physical Condition:</B><BR>\n\t<A href='?src=[REF(src)];temp=1;p_stat=deceased'>*Deceased*</A><BR>\n\t<A href='?src=[REF(src)];temp=1;p_stat=unconscious'>*Unconscious*</A><BR>\n\t<A href='?src=[REF(src)];temp=1;p_stat=active'>Active</A><BR>\n\t<A href='?src=[REF(src)];temp=1;p_stat=unfit'>Physically Unfit</A><BR>"
					if("m_stat")
						if(active1)
							src.temp = "<B>Mental Condition:</B><BR>\n\t<A href='?src=[REF(src)];temp=1;m_stat=insane'>*Insane*</A><BR>\n\t<A href='?src=[REF(src)];temp=1;m_stat=unstable'>*Unstable*</A><BR>\n\t<A href='?src=[REF(src)];temp=1;m_stat=watch'>*Watch*</A><BR>\n\t<A href='?src=[REF(src)];temp=1;m_stat=stable'>Stable</A><BR>"
					if("blood_type")
						if(active2)
							src.temp = "<B>Blood Type:</B><BR>\n\t<A href='?src=[REF(src)];temp=1;blood_type=an'>A-</A> <A href='?src=[REF(src)];temp=1;blood_type=ap'>A+</A><BR>\n\t<A href='?src=[REF(src)];temp=1;blood_type=bn'>B-</A> <A href='?src=[REF(src)];temp=1;blood_type=bp'>B+</A><BR>\n\t<A href='?src=[REF(src)];temp=1;blood_type=abn'>AB-</A> <A href='?src=[REF(src)];temp=1;blood_type=abp'>AB+</A><BR>\n\t<A href='?src=[REF(src)];temp=1;blood_type=on'>O-</A> <A href='?src=[REF(src)];temp=1;blood_type=op'>O+</A><BR>"
					if("b_dna")
						if(active2)
							var/t1 = stripped_input(usr, "Please input DNA hash:", "Med. records", src.active2.fields["b_dna"], null)
							if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
								return
							src.active2.fields["b_dna"] = t1
					if("show_photo_front")
						if(active1)
							var/front_photo = active1.get_front_photo()
							if(istype(front_photo, /obj/item/photo))
								var/obj/item/photo/photo = front_photo
								photo.show(usr)
					if("show_photo_side")
						if(active1)
							var/side_photo = active1.get_side_photo()
							if(istype(side_photo, /obj/item/photo))
								var/obj/item/photo/photo = side_photo
								photo.show(usr)
					else

			else if(href_list["p_stat"])
				if(active1)
					switch(href_list["p_stat"])
						if("deceased")
							src.active1.fields["p_stat"] = "*Deceased*"
						if("unconscious")
							src.active1.fields["p_stat"] = "*Unconscious*"
						if("active")
							src.active1.fields["p_stat"] = "Active"
						if("unfit")
							src.active1.fields["p_stat"] = "Physically Unfit"

			else if(href_list["m_stat"])
				if(active1)
					switch(href_list["m_stat"])
						if("insane")
							src.active1.fields["m_stat"] = "*Insane*"
						if("unstable")
							src.active1.fields["m_stat"] = "*Unstable*"
						if("watch")
							src.active1.fields["m_stat"] = "*Watch*"
						if("stable")
							src.active1.fields["m_stat"] = "Stable"


			else if(href_list["blood_type"])
				if(active2)
					switch(href_list["blood_type"])
						if("an")
							src.active2.fields["blood_type"] = "A-"
						if("bn")
							src.active2.fields["blood_type"] = "B-"
						if("abn")
							src.active2.fields["blood_type"] = "AB-"
						if("on")
							src.active2.fields["blood_type"] = "O-"
						if("ap")
							src.active2.fields["blood_type"] = "A+"
						if("bp")
							src.active2.fields["blood_type"] = "B+"
						if("abp")
							src.active2.fields["blood_type"] = "AB+"
						if("op")
							src.active2.fields["blood_type"] = "O+"


			else if(href_list["del_r"])
				if(active2)
					src.temp = "Are you sure you wish to delete the record (Medical Portion Only)?<br>\n\t<A href='?src=[REF(src)];temp=1;del_r2=1'>Yes</A><br>\n\t<A href='?src=[REF(src)];temp=1'>No</A><br>"

			else if(href_list["del_r2"])
				investigate_log("[key_name(usr)] has deleted the medical records for [active1.fields["name"]].", INVESTIGATE_RECORDS)
				if(active2)
					qdel(active2)
					active2 = null

			else if(href_list["d_rec"])
				active1 = find_record("id", href_list["d_rec"], GLOB.data_core.general)
				if(active1)
					active2 = find_record("id", href_list["d_rec"], GLOB.data_core.medical)
				if(!active2)
					active1 = null
				screen = 4

			else if(href_list["new"])
				if((istype(src.active1, /datum/data/record) && !( istype(src.active2, /datum/data/record) )))
					var/datum/data/record/R = new /datum/data/record(  )
					R.fields["name"] = src.active1.fields["name"]
					R.fields["id"] = src.active1.fields["id"]
					R.name = text("Medical Record #[]", R.fields["id"])
					R.fields["blood_type"] = "Unknown"
					R.fields["b_dna"] = "Unknown"
					R.fields["mi_dis"] = "None"
					R.fields["mi_dis_d"] = "No minor disabilities have been diagnosed."
					R.fields["ma_dis"] = "None"
					R.fields["ma_dis_d"] = "No major disabilities have been diagnosed."
					R.fields["alg"] = "None"
					R.fields["alg_d"] = "No allergies have been detected in this patient."
					R.fields["cdi"] = "None"
					R.fields["cdi_d"] = "No diseases have been diagnosed at the moment."
					R.fields["notes"] = "No notes."
					GLOB.data_core.medical += R
					src.active2 = R
					src.screen = 4

			else if(href_list["add_c"])
				if(!(active2 in GLOB.data_core.medical))
					return
				var/a2 = src.active2
				var/t1 = stripped_multiline_input(usr, "Add Comment:", "Med. records", null, null)
				if(!canUseMedicalRecordsConsole(usr, t1, null, a2))
					return
				var/counter = 1
				while(src.active2.fields[text("com_[]", counter)])
					counter++
				src.active2.fields[text("com_[]", counter)] = text("Made by [] ([]) on [] [], []<BR>[]", src.authenticated, src.rank, station_time_timestamp(), time2text(world.realtime, "MMM DD"), GLOB.year_integer+YEAR_OFFSET, t1)

			else if(href_list["del_c"])
				if((istype(src.active2, /datum/data/record) && src.active2.fields[text("com_[]", href_list["del_c"])]))
					src.active2.fields[text("com_[]", href_list["del_c"])] = "<B>Deleted</B>"

			else if(href_list["search"])
				var/t1 = stripped_input(usr, "Search String: (Name, DNA, or ID)", "Med. records")
				if(!canUseMedicalRecordsConsole(usr, t1))
					return
				src.active1 = null
				src.active2 = null
				t1 = lowertext(t1)
				for(var/datum/data/record/R in GLOB.data_core.medical)
					if((lowertext(R.fields["name"]) == t1 || t1 == lowertext(R.fields["id"]) || t1 == lowertext(R.fields["b_dna"])))
						src.active2 = R
					else
						//Foreach continue //goto(3229)
				if(!( src.active2 ))
					src.temp = text("Could not locate record [].", sanitize(t1))
				else
					for(var/datum/data/record/E in GLOB.data_core.general)
						if((E.fields["name"] == src.active2.fields["name"] || E.fields["id"] == src.active2.fields["id"]))
							src.active1 = E
						else
							//Foreach continue //goto(3334)
					src.screen = 4

			else if(href_list["print_p"])
				if(!( src.printing ))
					src.printing = 1
					GLOB.data_core.medicalPrintCount++
					playsound(loc, 'sound/items/poster_being_created.ogg', 100, 1)
					sleep(30)
					var/obj/item/paper/printed_paper = new /obj/item/paper( src.loc )
					var/final_paper_text = "<CENTER><B>Medical Record - (MR-[GLOB.data_core.medicalPrintCount])</B></CENTER><BR>"
					if(active1 in GLOB.data_core.general)
						final_paper_text += text("Name: [] ID: []<BR>\nGender: []<BR>\nAge: []<BR>", src.active1.fields["name"], src.active1.fields["id"], src.active1.fields["gender"], src.active1.fields["age"])
						final_paper_text += "\nSpecies: [active1.fields["species"]]<BR>"
						final_paper_text += text("\nFingerprint: []<BR>\nPhysical Status: []<BR>\nMental Status: []<BR>", src.active1.fields["fingerprint"], src.active1.fields["p_stat"], src.active1.fields["m_stat"])
					else
						final_paper_text += "<B>General Record Lost!</B><BR>"
					if(active2 in GLOB.data_core.medical)
						final_paper_text += text("<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\nBlood Type: []<BR>\nDNA: []<BR>\n<BR>\nMinor Disabilities: []<BR>\nDetails: []<BR>\n<BR>\nMajor Disabilities: []<BR>\nDetails: []<BR>\n<BR>\nAllergies: []<BR>\nDetails: []<BR>\n<BR>\nCurrent Diseases: [] (per disease info placed in log/comment section)<BR>\nDetails: []<BR>\n<BR>\nImportant Notes:<BR>\n\t[]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", src.active2.fields["blood_type"], src.active2.fields["b_dna"], src.active2.fields["mi_dis"], src.active2.fields["mi_dis_d"], src.active2.fields["ma_dis"], src.active2.fields["ma_dis_d"], src.active2.fields["alg"], src.active2.fields["alg_d"], src.active2.fields["cdi"], src.active2.fields["cdi_d"], src.active2.fields["notes"])
						var/counter = 1
						while(src.active2.fields[text("com_[]", counter)])
							final_paper_text += text("[]<BR>", src.active2.fields[text("com_[]", counter)])
							counter++
						printed_paper.name = text("MR-[] '[]'", GLOB.data_core.medicalPrintCount, src.active1.fields["name"])
					else
						final_paper_text += "<B>Medical Record Lost!</B><BR>"
						printed_paper.name = text("MR-[] '[]'", GLOB.data_core.medicalPrintCount, "Record Lost")
					final_paper_text += "</TT>"
					printed_paper.add_raw_text(final_paper_text)
					printed_paper.update_appearance()
					src.printing = null

	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return

/obj/machinery/computer/med_data/emp_act(severity)
	. = ..()
	if(!(machine_stat & (BROKEN|NOPOWER)) && !(. & EMP_PROTECT_SELF))
		for(var/datum/data/record/R in GLOB.data_core.medical)
			if(prob(10/severity))
				switch(rand(1,6))
					if(1)
						R.fields["name"] = random_unique_name(R.fields["gender"],1)
					if(2)
						R.fields["gender"]	= pick("Male", "Female", "Other")
					if(3)
						R.fields["age"] = rand(AGE_MIN, AGE_MAX)
					if(4)
						R.fields["blood_type"] = random_blood_type()
					if(5)
						R.fields["p_stat"] = pick("*Unconscious*", "Active", "Physically Unfit")
					if(6)
						R.fields["m_stat"] = pick("*Insane*", "*Unstable*", "*Watch*", "Stable")
				continue

			else if(prob(1))
				qdel(R)
				continue

/obj/machinery/computer/med_data/proc/canUseMedicalRecordsConsole(mob/user, message = 1, record1, record2)
	if(user)
		if(message)
			if(authenticated)
				if(user.canUseTopic(src, !issilicon(user)))
					if(!record1 || record1 == active1)
						if(!record2 || record2 == active2)
							return 1
	return 0

/obj/machinery/computer/med_data/laptop
	name = "medical laptop"
	desc = "A cheap Nanotrasen medical laptop, it functions as a medical records computer. It's bolted to the table."
	icon_state = "laptop"
	icon_screen = "medlaptop"
	icon_keyboard = "laptop_key"
	clockwork = TRUE //it'd look weird
	broken_overlay_emissive = TRUE
	pass_flags = PASSTABLE
