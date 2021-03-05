// VERSION

// Update topic version whenever changes are made
// The Version Number follows SemVer http://semver.org/
#define TOPIC_VERSION_MAJOR		2	//	Major Version Number --> Increment when implementing breaking changes
#define TOPIC_VERSION_MINOR		0	//	Minor Version Number --> Increment when adding features
#define TOPIC_VERSION_PATCH		0	//	Patchlevel --> Increment when fixing bugs

// SETUP

/proc/InitTopics()
	for(var/path in subtypesof(/datum/world_topic))
		var/datum/world_topic/T = new path()
		GLOB.topic_commands[T.key] = T

	var/list/tokens = CONFIG_GET(keyed_list/comms_key)
	for(var/token in tokens)
		var/list/keys = list()
		if(tokens[token] == "all")
			for(var/key in GLOB.topic_commands)
				keys[key] = TRUE
		else
			for(var/key in splittext(tokens[token], ","))
				keys[trim(key)] = TRUE
			// Grant access to informational topic calls (version, authed functions etc.) by default
			for(var/datum/world_topic/api/path in subtypesof(/datum/world_topic/api))
				keys[initial(path.key)] = TRUE
		GLOB.topic_tokens[token] = keys

// DATUM

/datum/world_topic
	var/key
	var/list/required_params = list()
	var/statuscode = null
	var/response = null
	var/data = null

/datum/world_topic/proc/CheckParams(list/params)
	var/list/missing_params = list()
	var/errorcount = 0

	for(var/param in required_params)
		if(!params[param])
			errorcount++
			missing_params += param

	if(errorcount)
		statuscode = 400
		response = "Bad Request - Missing parameters"
		data = missing_params
		return errorcount

/datum/world_topic/proc/Run(list/input)
	// Always returns true; actual details in statuscode, response and data variables
	return TRUE

// API INFO TOPICS

///datum/world_topic/api

/datum/world_topic/api/get_version
	key = "api_get_version"

/datum/world_topic/api/get_version/Run(list/input)
	. = ..()
	var/list/version = list()
	var/versionstring = null

	version["major"] = TOPIC_VERSION_MAJOR
	version["minor"] = TOPIC_VERSION_MINOR
	version["patch"] = TOPIC_VERSION_PATCH

	versionstring = "[version["major"]].[version["minor"]].[version["patch"]]"

	statuscode = 200
	response = versionstring
	data = version

/datum/world_topic/api/get_authed_functions
	key = "api_get_authed_functions"

/datum/world_topic/api/get_authed_functions/Run(list/input)
	. = ..()
	statuscode = 200
	response = "Authorized functions retrieved"
	data = GLOB.topic_tokens[input["auth"]]

// TOPICS

/datum/world_topic/ping
	key = "ping"

/datum/world_topic/ping/Run(list/input)
	. = ..()
	var/count = 0
	for (var/client/C in GLOB.clients)
		count++
	statuscode = 200
	response = "Pong!"
	data = count

/datum/world_topic/playing
	key = "playing"

/datum/world_topic/playing/Run(list/input)
	. = ..()
	statuscode = 200
	response = "Player count retrieved"
	data = GLOB.player_list.len

/datum/world_topic/pr_announce
	key = "announce"
	var/static/list/PRcounts = list()	//PR id -> number of times announced this round

/datum/world_topic/pr_announce/Run(list/input)
	. = ..()
	var/list/payload = json_decode(input["payload"])
	if(!PRcounts[input["id"]])
		PRcounts[input["id"]] = 1
	else
		++PRcounts[input["id"]]
		if(PRcounts[input["id"]] > PR_ANNOUNCEMENTS_PER_ROUND)
			statuscode = 429
			response = "PR Spam blocked"
			return

	var/final_composed = "<span class='announce'>PR: [input[key]]</span>"
	for(var/client/C in GLOB.clients)
		C.AnnouncePR(final_composed)
	statuscode = 200
	response = "PR Announced"

/datum/world_topic/ahelp_relay
	key = "ahelp"

/datum/world_topic/ahelp_relay/Run(list/input)
	. = ..()
	relay_msg_admins("<span class='adminnotice'><b><font color=red>HELP: </font> [input["source"]] [input["message_sender"]]: [input["message"]]</b></span>")
	statuscode = 200
	response = "Ahelp relayed"

/datum/world_topic/comms_console
	key = "comms_console"

/datum/world_topic/comms_console/Run(list/input)
	. = ..()
	if(CHAT_FILTER_CHECK(input["message"])) // prevents any.. diplomatic incidents
		minor_announce("In the interest of station productivity and mental hygiene, a message from [input["message_sender"]] was intercepted by the CCC and determined to be unfit for crew-level access.", "CentCom Communications Commission")
		message_admins("Incomming cross-comms message from [input["message_sender"]] blocked: [input["message"]]")
		statuscode = 451 // "Unavailable for legal reasons" ahaha; i.e. censored
		response = "Message blocked by chat filter"
		return

	minor_announce(input["message"], "Incoming message from [input["message_sender"]]")
	for(var/obj/machinery/computer/communications/CM in GLOB.machines)
		CM.overrideCooldown()
	statuscode = 200
	response = "Message received"

/datum/world_topic/news_report
	key = "news_report"

/datum/world_topic/news_report/Run(list/input)
	. = ..()
	minor_announce(input["message"], "Breaking Update From [input["message_sender"]]")
	statuscode = 200
	response = "Message received"

/datum/world_topic/adminmsg
	key = "adminmsg"

/datum/world_topic/adminmsg/Run(list/input)
	. = ..()
	var/msg_response = IrcPm(input[key], input["msg"], input["sender"])
	statuscode = response == "Message Successful" ? 200 : 400 // Todo rework the irc message thingo to not need string comp
	response = msg_response

/datum/world_topic/namecheck
	key = "namecheck"

/datum/world_topic/namecheck/Run(list/input)
	. = ..()
	statuscode = 200
	response = "Names fetched"
	data = keywords_lookup(input["namecheck"], 1)

/datum/world_topic/adminwho
	key = "adminwho"

/datum/world_topic/adminwho/Run(list/input)
	. = ..()
	statuscode = 200
	response = "Admin list fetched"
	data = ircadminwho()

/datum/world_topic/playerlist
	key = "playerlist"

/datum/world_topic/playerlist/Run(list/input)
	. = ..()
	data = list()
	for(var/client/C as() in GLOB.clients)
		data += C.ckey
	statuscode = 200
	response = "Player list fetched"

/datum/world_topic/status
	key = "status"

/datum/world_topic/status/Run(list/input)
	. = ..()
	data = list()
	data["version"] = GLOB.game_version
	data["mode"] = GLOB.master_mode
	data["respawn"] = config ? !CONFIG_GET(flag/norespawn) : FALSE
	data["enter"] = GLOB.enter_allowed
	data["vote"] = CONFIG_GET(flag/allow_vote_mode)
	data["ai"] = CONFIG_GET(flag/allow_ai)
	data["host"] = world.host ? world.host : null
	data["round_id"] = GLOB.round_id
	data["players"] = GLOB.clients.len
	data["revision"] = GLOB.revdata.commit
	data["revision_date"] = GLOB.revdata.date
	data["hub"] = GLOB.hub_visibility

	var/list/adm = get_admin_counts()
	var/list/presentmins = adm["present"]
	var/list/afkmins = adm["afk"]
	data["admins"] = presentmins.len + afkmins.len //equivalent to the info gotten from adminwho
	data["gamestate"] = SSticker.current_state

	data["map_name"] = SSmapping.config?.map_name || "Loading..."

	data["security_level"] = get_security_level()
	data["round_duration"] = SSticker ? round((world.time-SSticker.round_start_time)/10) : 0
	// Amount of world's ticks in seconds, useful for calculating round duration

	//Time dilation stats.
	data["time_dilation_current"] = SStime_track.time_dilation_current
	data["time_dilation_avg"] = SStime_track.time_dilation_avg
	data["time_dilation_avg_slow"] = SStime_track.time_dilation_avg_slow
	data["time_dilation_avg_fast"] = SStime_track.time_dilation_avg_fast

	//pop cap stats
	data["soft_popcap"] = CONFIG_GET(number/soft_popcap) || 0
	data["hard_popcap"] = CONFIG_GET(number/hard_popcap) || 0
	data["extreme_popcap"] = CONFIG_GET(number/extreme_popcap) || 0
	data["popcap"] = max(CONFIG_GET(number/soft_popcap), CONFIG_GET(number/hard_popcap), CONFIG_GET(number/extreme_popcap)) //generalized field for this concept for use across ss13 codebases

	if(SSshuttle?.emergency)
		data["shuttle_mode"] = SSshuttle.emergency.mode
		// Shuttle status, see /__DEFINES/stat.dm
		data["shuttle_timer"] = SSshuttle.emergency.timeLeft()
		// Shuttle timer, in seconds
	statuscode = 200
	response = "Status retrieved"

/datum/world_topic/status/authed
	key = "status_authed"

/datum/world_topic/status/authed/Run()
	. = ..()
	// Add on a little extra data for our "special" patrons
	data["active_players"] = get_active_player_count()
	if(SSticker.HasRoundStarted())
		data["real_mode"] = SSticker.mode.name

/datum/world_topic/identify_uuid
	key = "identify_uuid"

/datum/world_topic/identify_uuid/Run(list/input)
	var/uuid = input["uuid"]
	data = list()

	if(!SSdbcore.Connect())
		statuscode = 500
		response = "Failed to reach database"
		return

	var/datum/DBQuery/query_ckey_lookup = SSdbcore.NewQuery(
		"SELECT ckey FROM [format_table_name("player")] WHERE uuid = :uuid",
		list("uuid" = uuid)
	)
	if(!query_ckey_lookup.Execute())
		qdel(query_ckey_lookup)
		statuscode = 500
		response = "Database query failed"
		return

	statuscode = 200
	response = "UUID Checked against database"
	data["identified_ckey"] = null
	if(query_ckey_lookup.NextRow())
		data["identified_ckey"] = query_ckey_lookup.item[1]
	qdel(query_ckey_lookup)

/datum/world_topic/d_ooc_send
	key = "discord_send"

/datum/world_topic/d_ooc_send/Run(list/input)
	. = ..()
	var/msg = input["message"]
	var/unm = input["user"]
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	unm = copytext(sanitize(unm), 1, MAX_MESSAGE_LEN)
	msg = emoji_parse(msg)
	log_ooc("DISCORD: [unm]: [msg]")
	for(var/client/C in GLOB.clients)
		if(C.prefs.chat_toggles & CHAT_OOC)
			if(!("discord-[unm]" in C.prefs.ignoring))
				to_chat(C, "<span class='dooc'><b><span class='prefix'>OOC: </span> <EM>[unm]:</EM> <span class='message linkify'>[msg]</span></b></span>")
	statuscode = 200
	response = "Message forwarded to OOC"


#undef TOPIC_VERSION_MAJOR
#undef TOPIC_VERSION_MINOR
#undef TOPIC_VERSION_PATCH
