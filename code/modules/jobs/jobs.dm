GLOBAL_LIST_INIT(command_positions, list(
	JOB_CAPTAIN,
	JOB_HEAD_OF_PERSONNEL,
	JOB_HEAD_OF_SECURITY,
	JOB_CHIEF_ENGINEER,
	JOB_RESEARCH_DIRECTOR,
	JOB_CHIEF_MEDICAL_OFFICER))


GLOBAL_LIST_INIT(engineering_positions, list(
	JOB_CHIEF_ENGINEER,
	JOB_STATION_ENGINEER,
	JOB_ATMOSPHERIC_TECHNICIAN))


GLOBAL_LIST_INIT(medical_positions, list(
	JOB_CHIEF_MEDICAL_OFFICER,
	JOB_MEDICAL_DOCTOR,
	JOB_GENETICIST,
	JOB_VIROLOGIST,
	JOB_PARAMEDIC,
	JOB_CHEMIST,
	JOB_BRIGPHYSICIAN))


GLOBAL_LIST_INIT(science_positions, list(
	JOB_RESEARCH_DIRECTOR,
	JOB_SCIENTIST,
	JOB_EXPLORATIONCREW,
	JOB_ROBOTICIST))


GLOBAL_LIST_INIT(supply_positions, list(
	JOB_QUARTERMASTER,
	JOB_CARGO_TECHNICIAN,
	JOB_SHAFT_MINER))


GLOBAL_LIST_INIT(civilian_positions, list(
	"Head of Personnel",
	"Bartender",
	"Botanist",
	"Cook",
	"Janitor",
	"Lawyer",
	"Curator",
	"Chaplain",
	"Mime",
	"Clown",
	"Assistant"))

GLOBAL_LIST_INIT(gimmick_positions, list(
	JOB_GIMMICK,
	JOB_BARBER,
	JOB_STAGE_MAGICIAN,
	JOB_PSYCHIATRIST,
	JOB_VIP))

GLOBAL_LIST_INIT(security_positions, list(
	JOB_HEAD_OF_SECURITY,
	JOB_WARDEN,
	JOB_DETECTIVE,
	JOB_SECURITY_OFFICER,
	JOB_DEPUTY))


GLOBAL_LIST_INIT(nonhuman_positions, list(
	JOB_CYBORG,
	JOB_CYBORG,
	ROLE_PAI))


// they are for hud_icon-based crew manifest
// we don't use 'gimmick' here. use common sense here.
GLOBAL_LIST_INIT(command_positions_hud, list(
	JOB_HUD_CAPTAIN,
	JOB_HUD_ACTINGCAPTAIN ,
	JOB_HUD_HEADOFPERSONNEL,
	JOB_HUD_HEADOFSECURITY,
	JOB_HUD_CHIEFENGINEER,
	JOB_HUD_RESEARCHDIRECTOR,
	JOB_HUD_CHEIFMEDICALOFFICIER,
	JOB_HUD_RAWCOMMAND))

GLOBAL_LIST_INIT(important_positions_hud, list(
	JOB_HUD_VIP,
	JOB_HUD_KING))

GLOBAL_LIST_INIT(engineering_positions_hud, list(
	JOB_HUD_CHIEFENGINEER,
	JOB_HUD_STATIONENGINEER,
	JOB_HUD_ATMOSPHERICTECHNICIAN,
	JOB_HUD_RAWENGINEERING))

GLOBAL_LIST_INIT(medical_positions_hud, list(
	JOB_HUD_CHEIFMEDICALOFFICIER,
	JOB_HUD_MEDICALDOCTOR,
	JOB_HUD_GENETICIST,
	JOB_HUD_VIROLOGIST,
	JOB_HUD_PARAMEDIC,
	JOB_HUD_CHEMIST,
	JOB_HUD_BRIGPHYSICIAN,
	JOB_HUD_PSYCHIATRIST,
	JOB_HUD_RAWMEDICAL))

GLOBAL_LIST_INIT(science_positions_hud, list(
	JOB_HUD_RESEARCHDIRECTOR,
	JOB_HUD_SCIENTIST,
	JOB_HUD_EXPLORATIONCREW,
	JOB_HUD_ROBOTICIST,
	JOB_HUD_RAWSCIENCE))

GLOBAL_LIST_INIT(supply_positions_hud, list(
	JOB_HUD_QUARTERMASTER,
	JOB_HUD_CARGOTECHNICIAN,
	JOB_HUD_SHAFTMINER,
	JOB_HUD_RAWCARGO))

GLOBAL_LIST_INIT(civilian_positions_hud, list(
	JOB_HUD_HEADOFPERSONNEL,
	JOB_HUD_BARTENDER,
	JOB_HUD_BOTANIST,
	JOB_HUD_COOK,
	JOB_HUD_JANITOR,
	JOB_HUD_CURATOR,
	JOB_HUD_LAWYER,
	JOB_HUD_CHAPLAIN,
	JOB_HUD_CLOWN,
	JOB_HUD_MIME,
	JOB_HUD_BARBER,
	JOB_HUD_STAGEMAGICIAN,
	JOB_HUD_ASSISTANT,
	JOB_HUD_RAWSERVICE))

//GLOBAL_LIST_INIT(gimmick_positions_hud, list()
// NO. don't use this.

GLOBAL_LIST_INIT(security_positions_hud, list(
	JOB_HUD_HEADOFSECURITY,
	JOB_HUD_WARDEN,
	JOB_HUD_DETECTIVE,
	JOB_HUD_SECURITYOFFICER,
	JOB_HUD_DEPUTY,
	JOB_HUD_RAWSECURITY))



GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_CREW = list("titles" = command_positions | engineering_positions | medical_positions | science_positions | supply_positions | security_positions | civilian_positions | gimmick_positions | list(JOB_CYBORG,JOB_CYBORG)), // crew positions
	EXP_TYPE_COMMAND = list("titles" = command_positions),
	EXP_TYPE_ENGINEERING = list("titles" = engineering_positions),
	EXP_TYPE_MEDICAL = list("titles" = medical_positions),
	EXP_TYPE_SCIENCE = list("titles" = science_positions),
	EXP_TYPE_SUPPLY = list("titles" = supply_positions),
	EXP_TYPE_SECURITY = list("titles" = security_positions),
	EXP_TYPE_SILICON = list("titles" = list(JOB_CYBORG,JOB_CYBORG)),
	EXP_TYPE_SERVICE = list("titles" = civilian_positions | gimmick_positions),
	EXP_TYPE_GIMMICK = list("titles" = gimmick_positions)
))

GLOBAL_LIST_INIT(exp_specialmap, list(
	EXP_TYPE_LIVING = list(), // all living mobs
	EXP_TYPE_ANTAG = list(),
	EXP_TYPE_SPECIAL = list("Lifebringer","Ash Walker","Exile","Servant Golem","Free Golem","Hermit","Translocated Vet","Escaped Prisoner","Hotel Staff","SuperFriend","Space Syndicate","Ancient Crew","Space Doctor","Space Bartender","Beach Bum","Skeleton","Zombie","Space Bar Patron","Lavaland Syndicate",JOB_PERSONAL_AI,"Ghost Role"), // Ghost roles
	EXP_TYPE_GHOST = list() // dead people, observers
))
GLOBAL_PROTECT(exp_jobsmap)
GLOBAL_PROTECT(exp_specialmap)

/proc/guest_jobbans(job)
	return ((job in GLOB.command_positions) || (job in GLOB.nonhuman_positions) || (job in GLOB.security_positions))



//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(var/job_title)
	if(!job_title)
		return list()

	for(var/datum/job/J in SSjob.occupations)
		if(J.title == job_title)
			return J.department_head //this is a list

/proc/get_full_job_name(job)
	var/static/regex/cap_expand = new("cap(?!tain)")
	var/static/regex/cmo_expand = new("cmo")
	var/static/regex/hos_expand = new("hos")
	var/static/regex/hop_expand = new("hop")
	var/static/regex/rd_expand = new("rd")
	var/static/regex/ce_expand = new("ce")
	var/static/regex/qm_expand = new("qm")
	var/static/regex/sec_expand = new("(?<!security )officer")
	var/static/regex/engi_expand = new("(?<!station )engineer")
	var/static/regex/atmos_expand = new("atmos tech")
	var/static/regex/doc_expand = new("(?<!medical )doctor|medic(?!al)")
	var/static/regex/mine_expand = new("(?<!shaft )miner")
	var/static/regex/chef_expand = new("chef")
	var/static/regex/borg_expand = new("(?<!cy)borg")

	job = lowertext(job)
	job = cap_expand.Replace(job, "captain")
	job = cmo_expand.Replace(job, "chief medical officer")
	job = hos_expand.Replace(job, "head of security")
	job = hop_expand.Replace(job, "head of personnel")
	job = rd_expand.Replace(job, "research director")
	job = ce_expand.Replace(job, "chief engineer")
	job = qm_expand.Replace(job, "quartermaster")
	job = sec_expand.Replace(job, "security officer")
	job = engi_expand.Replace(job, "station engineer")
	job = atmos_expand.Replace(job, "atmospheric technician")
	job = doc_expand.Replace(job, "medical doctor")
	job = mine_expand.Replace(job, "shaft miner")
	job = chef_expand.Replace(job, "cook")
	job = borg_expand.Replace(job, "cyborg")
	return job
