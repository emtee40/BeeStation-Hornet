// This proc is only used in `PDApainter.dm`, but for better readability, it's declared as global proc and stored here.
// This returns a card icon style by given job name. Check `card.dmi` for the card list.
/proc/get_cardstyle_by_jobname(jobname)
	if(!jobname)
		CRASH("The proc has taken a null value")

	var/static/id_style = list(
		// Command
		"Command (Custom)" = "captain",
		JOB_NAME_CAPTAIN = "captain",
		"Acting Captain" = "captain",
		// Service
		"Service (Custom)" = "rawservice",
		JOB_NAME_HEADOFPERSONNEL = "hop",
		JOB_NAME_ASSISTANT = "id",
		JOB_NAME_BOTANIST = "serv",
		JOB_NAME_BARTENDER = "serv",
		JOB_NAME_COOK = "serv",
		JOB_NAME_JANITOR = "janitor",
		JOB_NAME_CURATOR = "chap",
		JOB_NAME_CHAPLAIN = "chap",
		JOB_NAME_LAWYER = "lawyer",
		JOB_NAME_CLOWN = "clown",
		JOB_NAME_MIME = "mime",
		JOB_NAME_STAGEMAGICIAN = "serv",
		JOB_NAME_BARBER = "serv",
		// Cargo
		"Cargo (Custom)" = "rawcargo",
		JOB_NAME_QUARTERMASTER = "qm",
		JOB_NAME_CARGOTECHNICIAN = "cargo",
		JOB_NAME_SHAFTMINER = "miner",
		// R&D
		"Science (Custom)" = "rawscience",
		JOB_NAME_RESEARCHDIRECTOR = "rd",
		JOB_NAME_SCIENTIST = "sci",
		JOB_NAME_ROBOTICIST = "roboticist",
		JOB_NAME_EXPLORATIONCREW = "exploration",
		// Engineering
		"Engineering (Custom)" = "rawengineering",
		JOB_NAME_CHIEFENGINEER = "ce",
		JOB_NAME_STATIONENGINEER = "engi",
		JOB_NAME_ATMOSPHERICTECHNICIAN = "atmos",
		// Medical
		"Medical (Custom)" = "rawmedical",
		JOB_NAME_CHIEFMEDICALOFFICER = "cmo",
		JOB_NAME_MEDICALDOCTOR = "med",
		JOB_NAME_PARAMEDIC = "paramed",
		JOB_NAME_GENETICIST = "gene",
		JOB_NAME_CHEMIST = "chemist",
		JOB_NAME_PSYCHIATRIST = "med",
		// Security
		"Security (Custom)" = "rawsecurity",
		JOB_NAME_HEADOFSECURITY = "hos",
		JOB_NAME_WARDEN = "warden",
		JOB_NAME_SECURITYOFFICER = "sec",
		JOB_NAME_DETECTIVE = "detective",
		JOB_NAME_BRIGPHYSICIAN = "brigphys",
		JOB_NAME_DEPUTY = "deputy",
		// ETC
		"Unassigned" = "id",
		JOB_NAME_PRISONER = "orange",
		// EMAG
		"CentCom (Custom)" = "centcom",
		"CentCom" = "centcom",
		"ERT" = "ert",
		JOB_NAME_VIP = "gold",
		JOB_NAME_KING = "gold",
		"Syndicate Agent" = "syndicate",
		"Clown Operative" = "clown_op",
		"Unknown" = "unknown",
		// ETC2
		"Ratvar" = "ratvar"
	)
	return id_style[jobname] || "noname" // default: a card with no shape

// You really shouldn't use this directly.
// Use get_hud_by_jobname unless you NEED direct access to this, i.e for the crew manifest tgui data
GLOBAL_LIST_INIT(id_to_hud, list(
	// Command
	JOB_NAME_CAPTAIN = JOB_HUD_CAPTAIN,
	"Acting Captain" = JOB_HUD_ACTINGCAPTAIN ,
	"Command (Custom)" = JOB_HUD_RAWCOMMAND,

	// Service
	JOB_NAME_HEADOFPERSONNEL = JOB_HUD_HEADOFPERSONNEL,
	JOB_NAME_ASSISTANT = JOB_HUD_ASSISTANT,
	JOB_NAME_BARTENDER = JOB_HUD_BARTENDER,
	JOB_NAME_COOK = JOB_HUD_COOK,
	JOB_NAME_BOTANIST = JOB_HUD_BOTANIST,
	JOB_NAME_CURATOR = JOB_HUD_CURATOR,
	JOB_NAME_CHAPLAIN = JOB_HUD_CHAPLAIN,
	JOB_NAME_JANITOR = JOB_HUD_JANITOR,
	JOB_NAME_LAWYER = JOB_HUD_LAWYER,
	JOB_NAME_MIME = JOB_HUD_MIME,
	JOB_NAME_CLOWN = JOB_HUD_CLOWN,
	JOB_NAME_STAGEMAGICIAN = JOB_HUD_STAGEMAGICIAN,
	JOB_NAME_BARBER = JOB_HUD_BARBER,
	"Service (Custom)" = JOB_HUD_RAWSERVICE,

	// Cargo
	JOB_NAME_QUARTERMASTER = JOB_HUD_QUARTERMASTER,
	JOB_NAME_CARGOTECHNICIAN = JOB_HUD_CARGOTECHNICIAN,
	JOB_NAME_SHAFTMINER = JOB_HUD_SHAFTMINER,
	"Cargo (Custom)" = JOB_HUD_RAWCARGO,

	// R&D
	JOB_NAME_RESEARCHDIRECTOR = JOB_HUD_RESEARCHDIRECTOR,
	JOB_NAME_SCIENTIST = JOB_HUD_SCIENTIST,
	JOB_NAME_ROBOTICIST = JOB_HUD_ROBOTICIST,
	JOB_NAME_EXPLORATIONCREW = JOB_HUD_EXPLORATIONCREW,
	"Science (Custom)" = JOB_HUD_RAWSCIENCE,

	// Engineering
	JOB_NAME_CHIEFENGINEER = JOB_HUD_CHIEFENGINEER,
	JOB_NAME_STATIONENGINEER = JOB_HUD_STATIONENGINEER,
	JOB_NAME_ATMOSPHERICTECHNICIAN = JOB_HUD_ATMOSPHERICTECHNICIAN,
	"Engineering (Custom)" = JOB_HUD_RAWENGINEERING,

	// Medical
	JOB_NAME_CHIEFMEDICALOFFICER = JOB_HUD_CHEIFMEDICALOFFICIER,
	JOB_NAME_MEDICALDOCTOR = JOB_HUD_MEDICALDOCTOR,
	JOB_NAME_PARAMEDIC = JOB_HUD_PARAMEDIC,
	JOB_NAME_VIROLOGIST = JOB_HUD_VIROLOGIST,
	JOB_NAME_CHEMIST = JOB_HUD_CHEMIST,
	JOB_NAME_GENETICIST = JOB_HUD_GENETICIST,
	JOB_NAME_PSYCHIATRIST = JOB_HUD_PSYCHIATRIST,
	"Medical (Custom)" = JOB_HUD_RAWMEDICAL,

	// Security
	JOB_NAME_HEADOFSECURITY = JOB_HUD_HEADOFSECURITY,
	JOB_NAME_SECURITYOFFICER = JOB_HUD_SECURITYOFFICER,
	JOB_NAME_WARDEN = JOB_HUD_WARDEN,
	JOB_NAME_DETECTIVE = JOB_HUD_DETECTIVE,
	JOB_NAME_BRIGPHYSICIAN = JOB_HUD_BRIGPHYSICIAN,
	JOB_NAME_DEPUTY = JOB_HUD_DEPUTY,
	"Security (Custom)" = JOB_HUD_RAWSECURITY,

	// CentCom
	"CentCom" = JOB_HUD_CENTCOM,
	"ERT" = JOB_HUD_CENTCOM,
	"CentCom (Custom)" = JOB_HUD_RAWCENTCOM,

	// ETC
	JOB_NAME_VIP = JOB_HUD_VIP,
	JOB_NAME_KING = JOB_HUD_KING,
	"Syndicate Agent" = JOB_HUD_SYNDICATE,
	"Clown Operative" = JOB_HUD_SYNDICATE,
	"Unassigned" = JOB_HUD_UNKNOWN,
	JOB_NAME_PRISONER = JOB_HUD_PRISONER
))

GLOBAL_LIST_INIT(command_huds, list(
	JOB_HUD_CAPTAIN,
	JOB_HUD_ACTINGCAPTAIN,
	JOB_HUD_RAWCOMMAND,
	JOB_HUD_HEADOFPERSONNEL,
	JOB_HUD_RESEARCHDIRECTOR,
	JOB_HUD_CHIEFENGINEER,
	JOB_HUD_CHEIFMEDICALOFFICIER,
	JOB_HUD_HEADOFSECURITY
))

// This returns a hud icon (from `hud.dmi`) by given job name.
// Some custom title is from `PDApainter.dm`. You neec to check it if you're going to remove custom job.
/proc/get_hud_by_jobname(jobname, returns_unknown=TRUE)
	if(!jobname)
		CRASH("The proc has taken a null value")
	if(returns_unknown)
		return GLOB.id_to_hud[jobname] || JOB_HUD_UNKNOWN // default: a grey unknown hud
	return GLOB.id_to_hud[jobname] // this will return null

// used to determine chat color by HUD in `chatmessage.dm`
// Note: custom colors are what I really didn't put much attention into. feel free to change its color when you feel off.
/proc/get_chatcolor_by_hud(jobname)
	if(!jobname)
		CRASH("The proc has taken a null value")

	var/static/hud_to_chatcolor = list(
		// Command
		JOB_HUD_RAWCOMMAND = JOB_CHATCOLOR_RAWCOMMAND,
		JOB_HUD_CAPTAIN = JOB_CHATCOLOR_CAPTAIN,
		JOB_HUD_ACTINGCAPTAIN  = JOB_CHATCOLOR_ACTINGCAPTAIN,

		// Service
		JOB_HUD_RAWSERVICE = JOB_CHATCOLOR_RAWSERVICE,
		JOB_HUD_HEADOFPERSONNEL = JOB_CHATCOLOR_HEADOFPERSONNEL,
		JOB_HUD_ASSISTANT = JOB_CHATCOLOR_ASSISTANT,
		JOB_HUD_BARTENDER = JOB_CHATCOLOR_BARTENDER,
		JOB_HUD_COOK = JOB_CHATCOLOR_COOK,
		JOB_HUD_BOTANIST = JOB_CHATCOLOR_BOTANIST,
		JOB_HUD_CURATOR = JOB_CHATCOLOR_CURATOR,
		JOB_HUD_CHAPLAIN = JOB_CHATCOLOR_CHAPLAIN,
		JOB_HUD_JANITOR = JOB_CHATCOLOR_JANITOR,
		JOB_HUD_LAWYER = JOB_CHATCOLOR_LAWYER,
		JOB_HUD_MIME = JOB_CHATCOLOR_MIME,
		JOB_HUD_CLOWN = JOB_CHATCOLOR_CLOWN,
		JOB_HUD_STAGEMAGICIAN = JOB_CHATCOLOR_STAGEMAGICIAN,
		JOB_HUD_BARBER = JOB_CHATCOLOR_BARBER,

		// Cargo
		JOB_HUD_RAWCARGO = JOB_CHATCOLOR_RAWCARGO,
		JOB_HUD_QUARTERMASTER = JOB_CHATCOLOR_QUARTERMASTER,
		JOB_HUD_CARGOTECHNICIAN = JOB_CHATCOLOR_CARGOTECHNICIAN,
		JOB_HUD_SHAFTMINER = JOB_CHATCOLOR_SHAFTMINER,

		// R&D
		JOB_HUD_RAWSCIENCE = JOB_CHATCOLOR_RAWSCIENCE,
		JOB_HUD_RESEARCHDIRECTOR = JOB_CHATCOLOR_RESEARCHDIRECTOR,
		JOB_HUD_SCIENTIST = JOB_CHATCOLOR_SCIENTIST,
		JOB_HUD_ROBOTICIST = JOB_CHATCOLOR_ROBOTICIST,
		JOB_HUD_EXPLORATIONCREW = JOB_CHATCOLOR_EXPLORATIONCREW,

		// Engineering
		JOB_HUD_RAWENGINEERING = JOB_CHATCOLOR_RAWENGINEERING,
		JOB_HUD_CHIEFENGINEER = JOB_CHATCOLOR_CHIEFENGINEER,
		JOB_HUD_STATIONENGINEER = JOB_CHATCOLOR_STATIONENGINEER,
		JOB_HUD_ATMOSPHERICTECHNICIAN = JOB_CHATCOLOR_ATMOSPHERICTECHNICIAN,

		// Medical
		JOB_HUD_RAWMEDICAL = JOB_CHATCOLOR_RAWMEDICAL,
		JOB_HUD_CHEIFMEDICALOFFICIER = JOB_CHATCOLOR_CHEIFMEDICALOFFICIER,
		JOB_HUD_MEDICALDOCTOR = JOB_CHATCOLOR_MEDICALDOCTOR,
		JOB_HUD_PARAMEDIC = JOB_CHATCOLOR_PARAMEDIC,
		JOB_HUD_CHEMIST = JOB_CHATCOLOR_CHEMIST,
		JOB_HUD_GENETICIST = JOB_CHATCOLOR_GENETICIST,
		JOB_HUD_PSYCHIATRIST = JOB_CHATCOLOR_PSYCHIATRIST,

		// Security
		JOB_HUD_RAWSECURITY = JOB_CHATCOLOR_RAWSECURITY,
		JOB_HUD_HEADOFSECURITY = JOB_CHATCOLOR_HEADOFSECURITY,
		JOB_HUD_WARDEN = JOB_CHATCOLOR_WARDEN,
		JOB_HUD_SECURITYOFFICER = JOB_CHATCOLOR_SECURITYOFFICER,
		JOB_HUD_DETECTIVE = JOB_CHATCOLOR_DETECTIVE,
		JOB_HUD_BRIGPHYSICIAN = JOB_CHATCOLOR_BRIGPHYSICIAN,
		JOB_HUD_DEPUTY = JOB_CHATCOLOR_DEPUTY,

		// CentCom
		JOB_HUD_RAWCENTCOM = JOB_CHATCOLOR_RAWCENTCOM,
		JOB_HUD_CENTCOM = JOB_CHATCOLOR_CENTCOM,

		// ETC
		JOB_HUD_VIP = JOB_CHATCOLOR_VIP,
		JOB_HUD_KING = JOB_CHATCOLOR_KING,
		JOB_HUD_SYNDICATE = JOB_CHATCOLOR_SYNDICATE,
		JOB_HUD_NOTCENTCOM = JOB_CHATCOLOR_NOTCENTCOM,
		JOB_HUD_PRISONER = JOB_CHATCOLOR_PRISONER,
		JOB_HUD_UNKNOWN = JOB_CHATCOLOR_UNKNOWN
	)
	return hud_to_chatcolor[jobname] || JOB_CHATCOLOR_UNKNOWN

/proc/get_job_departments(field)
	. = list()
	for(var/flag in GLOB.bitflags)
		var/key = "[flag]"
		var/department = GLOB.dept_bitflag_to_name[key]
		if(!department || !GLOB.departments[department])
			continue
		if(CHECK_BITFIELD(field, flag))
			. += department
