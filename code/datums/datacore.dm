/datum/datacore
	var/medical[] = list()
	var/medicalPrintCount = 0
	var/general[] = list()
	var/security[] = list()
	var/securityPrintCount = 0
	var/securityCrimeCounter = 0
	//This list tracks characters spawned in the world and cannot be modified in-game. Currently referenced by respawn_character().
	var/locked[] = list()

/datum/data
	var/name = "data"

/datum/data/record
	name = "record"
	var/list/fields = list()

/datum/data/record/Destroy()
	if(src in GLOB.data_core.medical)
		GLOB.data_core.medical -= src
	if(src in GLOB.data_core.security)
		GLOB.data_core.security -= src
	if(src in GLOB.data_core.general)
		GLOB.data_core.general -= src
	if(src in GLOB.data_core.locked)
		GLOB.data_core.locked -= src
	. = ..()

/datum/data/crime
	name = "crime"
	var/crimeName = ""
	var/crimeDetails = ""
	var/author = ""
	var/time = ""
	var/fine = 0
	var/paid = 0
	var/dataId = 0

/datum/datacore/proc/createCrimeEntry(cname = "", cdetails = "", author = "", time = "", fine = 0)
	var/datum/data/crime/c = new /datum/data/crime
	c.crimeName = cname
	c.crimeDetails = cdetails
	c.author = author
	c.time = time
	c.fine = fine
	c.paid = 0
	c.dataId = ++securityCrimeCounter
	return c

/datum/datacore/proc/addCitation(id = "", datum/data/crime/crime)
	for(var/datum/data/record/R in security)
		if(R.fields["id"] == id)
			var/list/crimes = R.fields["citation"]
			crimes |= crime
			return

/datum/datacore/proc/removeCitation(id, cDataId)
	for(var/datum/data/record/R in security)
		if(R.fields["id"] == id)
			var/list/crimes = R.fields["citation"]
			for(var/datum/data/crime/crime in crimes)
				if(crime.dataId == text2num(cDataId))
					crimes -= crime
					return

/datum/datacore/proc/payCitation(id, cDataId, amount)
	for(var/datum/data/record/R in security)
		if(R.fields["id"] == id)
			var/list/crimes = R.fields["citation"]
			for(var/datum/data/crime/crime in crimes)
				if(crime.dataId == text2num(cDataId))
					crime.paid = crime.paid + amount
					var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_SEC)
					D.adjust_money(amount)
					return

/**
  * Adds crime to security record.
  *
  * Is used to add single crime to someone's security record.
  * Arguments:
  * * id - record id.
  * * datum/data/crime/crime - premade array containing every variable, usually created by createCrimeEntry.
  */
/datum/datacore/proc/addCrime(id = "", datum/data/crime/crime)
	for(var/datum/data/record/R in security)
		if(R.fields["id"] == id)
			var/list/crimes = R.fields["crim"]
			crimes |= crime
			return

/**
  * Deletes crime from security record.
  *
  * Is used to delete single crime to someone's security record.
  * Arguments:
  * * id - record id.
  * * cDataId - id of already existing crime.
  */
/datum/datacore/proc/removeCrime(id, cDataId)
	for(var/datum/data/record/R in security)
		if(R.fields["id"] == id)
			var/list/crimes = R.fields["crim"]
			for(var/datum/data/crime/crime in crimes)
				if(crime.dataId == text2num(cDataId))
					crimes -= crime
					return

/**
  * Adds details to a crime.
  *
  * Is used to add or replace details to already existing crime.
  * Arguments:
  * * id - record id.
  * * cDataId - id of already existing crime.
  * * details - data you want to add.
  */
/datum/datacore/proc/addCrimeDetails(id, cDataId, details)
	for(var/datum/data/record/R in security)
		if(R.fields["id"] == id)
			var/list/crimes = R.fields["crim"]
			for(var/datum/data/crime/crime in crimes)
				if(crime.dataId == text2num(cDataId))
					crime.crimeDetails = details
					return

/datum/datacore/proc/manifest()
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/N = i
		if(N.new_character)
			log_manifest(N.ckey,N.new_character.mind,N.new_character)
		if(ishuman(N.new_character))
			manifest_inject(N.new_character, N.client)
		CHECK_TICK

/datum/datacore/proc/manifest_modify(obj/item/card/id/I)
	var/datum/data/record/foundrecord = find_datacore_individual(I.registered_name, I.registered_age, I.registered_gender, DATACORE_RETURNS_GENERAL)
	if(foundrecord)
		foundrecord.fields["rank"] = I.assignment
		foundrecord.fields["hud"] = I.hud_state

/datum/datacore/proc/get_manifest()
	var/list/manifest_out = list()
	var/list/departments = list(
		"Command" = GLOB.command_positions_hud,
		"Very Important People" = GLOB.important_positions_hud,
		"Security" = GLOB.security_positions_hud,
		"Engineering" = GLOB.engineering_positions_hud,
		"Medical" = GLOB.medical_positions_hud,
		"Science" = GLOB.science_positions_hud,
		"Supply" = GLOB.supply_positions_hud,
		"Civilian" = GLOB.civilian_positions_hud,
		"Silicon" = GLOB.nonhuman_positions // this is something that doesn't work. need to fix.
	)
	for(var/datum/data/record/t in GLOB.data_core.general)
		var/name = t.fields["name"]
		var/rank = t.fields["rank"]
		var/hud = t.fields["hud"]
		var/has_department = FALSE
		for(var/department in departments)
			var/list/jobs_hud = departments[department]
			if(hud in jobs_hud)
				if(!manifest_out[department])
					manifest_out[department] = list()
				manifest_out[department] += list(list(
					"name" = name,
					"rank" = rank
					// note: `"hud" = hud` is not needed. that is used to sort, not used to display. check `if(hud in jobs_hud)`
				))
				has_department = TRUE
				if(department != "Command") //List heads in both command and their own department.
					break
		if(!has_department)
			if(!manifest_out["Misc"])
				manifest_out["Misc"] = list()
			manifest_out["Misc"] += list(list(
				"name" = name,
				"rank" = rank
			))
	//Sort the list by 'departments' primarily so command is on top.
	var/list/sorted_out = list()
	for(var/department in (departments += "Misc"))
		if(!isnull(manifest_out[department]))
			sorted_out[department] = manifest_out[department]
	return sorted_out

/datum/datacore/proc/get_manifest_html(monochrome = FALSE)
	var/list/manifest = get_manifest()
	var/dat = {"
	<head><style>
		.manifest {border-collapse:collapse;}
		.manifest td, th {border:1px solid [monochrome?"black":"#DEF; background-color:white; color:black"]; padding:.25em}
		.manifest th {height: 2em; [monochrome?"border-top-width: 3px":"background-color: #48C; color:white"]}
		.manifest tr.head th { [monochrome?"border-top-width: 1px":"background-color: #488;"] }
		.manifest tr.alt td {[monochrome?"border-top-width: 2px":"background-color: #DEF"]}
	</style></head>
	<table class="manifest" width='350px'>
	<tr class='head'><th>Name</th><th>Rank</th></tr>
	"}
	for(var/department in manifest)
		var/list/entries = manifest[department]
		dat += "<tr><th colspan=3>[department]</th></tr>"
		//JUST
		var/even = FALSE
		for(var/entry in entries)
			var/list/entry_list = entry
			dat += "<tr[even ? " class='alt'" : ""]><td>[entry_list["name"]]</td><td>[entry_list["rank"]]</td></tr>"
			even = !even

	dat += "</table>"
	dat = replacetext(dat, "\n", "")
	dat = replacetext(dat, "\t", "")
	return dat


/datum/datacore/proc/manifest_inject(mob/living/carbon/human/H, client/C)
	set waitfor = FALSE
	var/static/list/show_directions = list(SOUTH, WEST)
	if(H.mind && (H.mind.assigned_role != H.mind.special_role))
		var/assignment
		if(H.mind.assigned_role)
			assignment = H.mind.assigned_role
		else if(H.job)
			assignment = H.job
		else
			assignment = "Unassigned"

		var/static/record_id_num = 1001
		var/id = num2hex(record_id_num++,6)
		if(!C)
			C = H.client
		var/image = get_id_photo(H, C, show_directions)
		var/datum/picture/pf = new
		var/datum/picture/ps = new
		pf.picture_name = "[H]"
		ps.picture_name = "[H]"
		pf.picture_desc = "This is [H]."
		ps.picture_desc = "This is [H]."
		pf.picture_image = icon(image, dir = SOUTH)
		ps.picture_image = icon(image, dir = WEST)
		var/obj/item/photo/photo_front = new(null, pf)
		var/obj/item/photo/photo_side = new(null, ps)

		//These records should ~really~ be merged or something
		//General Record
		var/datum/data/record/G = new()
		G.fields["id"]			= id
		G.fields["name"]		= H.real_name
		G.fields["age"]			= H.real_age
		G.fields["sex"]			= H.real_gender
		G.fields["rank"]		= assignment
		G.fields["hud"]			= get_hud_by_jobname(assignment)
		G.fields["species"]	= H.dna.species.name
		G.fields["fingerprint"]	= rustg_hash_string(RUSTG_HASH_MD5, H.dna.uni_identity)
		G.fields["p_stat"]		= "Active"
		G.fields["m_stat"]		= "Stable"
		G.fields["photo_front"]	= photo_front
		G.fields["photo_side"]	= photo_side
		general += G

		//Medical Record
		var/datum/data/record/M = new()
		M.fields["id"]			= id
		M.fields["name"]		= H.real_name
		M.fields["blood_type"]	= H.dna.blood_type
		M.fields["b_dna"]		= H.dna.unique_enzymes
		M.fields["mi_dis"]		= "None"
		M.fields["mi_dis_d"]	= "No minor disabilities have been declared."
		M.fields["ma_dis"]		= "None"
		M.fields["ma_dis_d"]	= "No major disabilities have been diagnosed."
		M.fields["alg"]			= "None"
		M.fields["alg_d"]		= "No allergies have been detected in this patient."
		M.fields["cdi"]			= "None"
		M.fields["cdi_d"]		= "No diseases have been diagnosed at the moment."
		M.fields["notes"]		= "No notes."
		medical += M

		//Security Record
		var/datum/data/record/S = new()
		S.fields["id"]			= id
		S.fields["name"]		= H.real_name
		S.fields["criminal"]	= "None"
		S.fields["citation"]	= list()
		S.fields["crim"]		= list()
		S.fields["notes"]		= "No notes."
		security += S

		//Locked Record
		var/datum/data/record/L = new()
		L.fields["id"]			= rustg_hash_string(RUSTG_HASH_MD5, "[H.real_name][H.mind.assigned_role]")	//surely this should just be id, like the others?
		L.fields["spawn_id"]	= id
		L.fields["name"]		= H.real_name
		L.fields["age"]			= H.real_age
		L.fields["sex"]			= H.real_gender
		L.fields["rank"] 		= H.mind.assigned_role
		L.fields["blood_type"]	= H.dna.blood_type
		L.fields["b_dna"]		= H.dna.unique_enzymes
		L.fields["identity"]	= H.dna.uni_identity
		L.fields["species"]		= H.dna.species.type
		L.fields["features"]	= H.dna.features
		L.fields["image"]		= image
		L.fields["mindref"]		= H.mind
		locked += L
	return

/datum/datacore/proc/get_id_photo(mob/living/carbon/human/H, client/C, show_directions = list(SOUTH))
	var/datum/job/J = SSjob.GetJob(H.mind.assigned_role)
	var/datum/preferences/P
	if(!C)
		C = H.client
	if(C)
		P = C.prefs
	return get_flat_human_icon(null, J, P, DUMMY_HUMAN_SLOT_MANIFEST, show_directions)

/proc/find_datacore_individual(name, age, gender, return_type, find_similar=FALSE)
	if(!length(GLOB.data_core.general))
		return FALSE
	if(!(return_type in list(DATACORE_RETURNS_GENERAL, DATACORE_RETURNS_SECURITY, DATACORE_RETURNS_MEDICAL, DATACORE_RETURNS_LOCKED)))
		return FALSE
	if(!name || !gender)
		return FALSE
	age = text2num(age)
	if(!isnum(age))
		return FALSE

	var/datum/data/record/A
	var/age_gap = INFINITY // if "age=20, datacore age=30", age_gap is 10. so having 0 is best
	/* return priority:
		1. [full match] name & age & gender matched
		2. [half match] name & age matched / gender not matched
		3. [similar match] name matched / age is similar / gender check passed
		4. [single match] name matched / doesn't care age
		x. [no match] name not matched (no return)  */
	for(var/datum/data/record/R in GLOB.data_core.general)
		if(R.fields["name"] != name) // [no match]
			continue
		else
			if(!A)
				A = R // [single match]
		if(age_gap) // being 0 means you have a best case for the age. no need to compare age.
			var/age_abs = abs(age-R.fields["age"])
			if(age_abs < age_gap)
				age_gap = age_abs
				A = R   // [half match], but...↓
			if(age_gap) // [similar match], if age_gap exists.  (and, indentation is correct. don't change.)
				continue
		if(R.fields["sex"] == gender && !age_gap) // if it didn't get continue, [half match] will check gender integrity to be [full match]
			A = R // [full match]
			. = TRUE

	if(!A || (!find_similar && !.)) // failed to find something, or failed to find full match
		return FALSE

	switch(return_type)
		if(DATACORE_RETURNS_GENERAL)
			return A // You're already returning data_core.general
		if(DATACORE_RETURNS_SECURITY)
			A = find_record("id", A.fields["id"], GLOB.data_core.security)
		if(DATACORE_RETURNS_MEDICAL)
			A = find_record("id", A.fields["id"], GLOB.data_core.medical)
		if(DATACORE_RETURNS_LOCKED)
			A = find_record("spawn_id", A.fields["spawn_id"], GLOB.data_core.locked)
	return A
