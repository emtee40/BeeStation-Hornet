//Preference toggles
///Publicly display BYOND membership (OOC icon/colour)
#define TOGGLE_MEMBER_PUBLIC				(1<<0)
///Select or rotate intents
#define TOGGLE_INTENT_STYLE				    (1<<1)
///Midround antag (ghostrole) popups
#define TOGGLE_MIDROUND_ANTAG				(1<<2)
///Announce login to admins (if an admin)
#define TOGGLE_ANNOUNCE_LOGIN				(1<<3)
///Disable deadchat alerts for people dying
#define TOGGLE_DISABLE_DEATHRATTLE			(1<<4)
///Disable deadchat alerts for people joining station
#define TOGGLE_DISABLE_ARRIVALRATTLE		(1<<5)
///Toggles whether mobs should be made fullbright when admin combo hud on
#define TOGGLE_COMBOHUD_LIGHTING			(1<<6)
///Always de-admin when playing (IT'S NOT DEAD-MIN)
#define TOGGLE_DEADMIN_ALWAYS				(1<<7)
///De-admin when playing an antag role
#define TOGGLE_DEADMIN_ANTAGONIST			(1<<8)
///De-admin when playing a head role
#define TOGGLE_DEADMIN_POSITION_HEAD		(1<<9)
///De-admin when playing a sec role
#define TOGGLE_DEADMIN_POSITION_SECURITY	(1<<10)
///De-admin when playing a silicon role
#define TOGGLE_DEADMIN_POSITION_SILICON	    (1<<11)
///Enable outline for mouse hover on items
#define TOGGLE_OBJECT_OUTLINE				(1<<12)
///Lock action buttons (top left) in place
#define TOGGLE_BUTTON_LOCK					(1<<13)
///Enable hotkey mode
#define TOGGLE_HOTKEYS						(1<<14)
///Enable runechat (maptext chat messages)
#define TOGGLE_RUNECHAT						(1<<15)
///Enable runechat display for non-mob atoms (machinery)
#define TOGGLE_NON_MOB_RUNECHAT				(1<<16)
///Enable emote display with runechat
#define TOGGLE_EMOTES_RUNECHAT				(1<<17)
///Enable crew objectives
#define TOGGLE_CREW_OBJECTIVES				(1<<18)
///Enable window flashing for certain events (ahelps, ghost role prompts etc)
#define TOGGLE_WINDOW_FLASH					(1<<19)
///Enable fancy TGUI
#define TOGGLE_FANCY_TGUI					(1<<20)
///Enable TGUI lock for monitors
#define TOGGLE_LOCK_TGUI					(1<<21)
///Show credits at end of round
#define TOGGLE_CREDITS						(1<<22)
///Show HUD for ghosts
#define TOGGLE_GHOST_HUD					(1<<23)

///Default toggles settings
#define TOGGLES_DEFAULT (TOGGLE_MEMBER_PUBLIC|TOGGLE_INTENT_STYLE|TOGGLE_MIDROUND_ANTAG|TOGGLE_OBJECT_OUTLINE|TOGGLE_RUNECHAT|TOGGLE_NON_MOB_RUNECHAT|TOGGLE_EMOTES_RUNECHAT|TOGGLE_CREW_OBJECTIVES|TOGGLE_WINDOW_FLASH|TOGGLE_FANCY_TGUI|TOGGLE_LOCK_TGUI|TOGGLE_CREDITS|TOGGLE_GHOST_HUD)

//Secondary preference toggles
///Examine everything clicked as a ghost
#define TOGGLE_2_INQUISITIVE_GHOST			(1<<0)
///Ambient occlusion (shadows)
#define TOGGLE_2_AMBIENT_OCCLUSION			(1<<1)
///Auto fit viewport
#define TOGGLE_2_AUTOFIT_VIEWPORT			(1<<2)

///Default toggles_2 settings
#define TOGGLES_2_DEFAULT (TOGGLE_2_INQUISITIVE_GHOST|TOGGLE_2_AMBIENT_OCCLUSION|TOGGLE_2_AUTOFIT_VIEWPORT)

// Sound toggles
#define SOUND_ADMINHELP				(1<<0)
#define SOUND_MIDI					(1<<1)
#define SOUND_AMBIENCE				(1<<2)
#define SOUND_LOBBY					(1<<3)
#define SOUND_INSTRUMENTS			(1<<4)
#define SOUND_SHIP_AMBIENCE			(1<<5)
#define SOUND_PRAYERS				(1<<6)
#define SOUND_ANNOUNCEMENTS			(1<<7)

#define TOGGLES_DEFAULT_SOUND (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|SOUND_INSTRUMENTS|SOUND_SHIP_AMBIENCE|SOUND_PRAYERS|SOUND_ANNOUNCEMENTS)

//Chat toggles
#define CHAT_OOC			(1<<0)
#define CHAT_DEAD			(1<<1)
#define CHAT_GHOSTEARS		(1<<2)
#define CHAT_GHOSTSIGHT		(1<<3)
#define CHAT_PRAYER			(1<<4)
#define CHAT_RADIO			(1<<5)
#define CHAT_PULLR			(1<<6)
#define CHAT_GHOSTWHISPER	(1<<7)
#define CHAT_GHOSTPDA		(1<<8)
#define CHAT_GHOSTRADIO 	(1<<9)
#define CHAT_BANKCARD  		(1<<10)
#define CHAT_GHOSTLAWS		(1<<11)

#define TOGGLES_DEFAULT_CHAT (CHAT_OOC|CHAT_DEAD|CHAT_GHOSTEARS|CHAT_GHOSTSIGHT|CHAT_PRAYER|CHAT_RADIO|CHAT_PULLR|CHAT_GHOSTWHISPER|CHAT_GHOSTPDA|CHAT_GHOSTRADIO|CHAT_BANKCARD|CHAT_GHOSTLAWS)

#define PARALLAX_INSANE -1 //for show offs
#define PARALLAX_HIGH    0 //default.
#define PARALLAX_MED     1
#define PARALLAX_LOW     2
#define PARALLAX_DISABLE 3 //this option must be the highest number

#define PIXEL_SCALING_AUTO 0
#define PIXEL_SCALING_1X 1
#define PIXEL_SCALING_1_2X 1.5
#define PIXEL_SCALING_2X 2
#define PIXEL_SCALING_3X 3
#define PIXEL_SCALING_4X 4

#define SCALING_METHOD_NORMAL "normal"
#define SCALING_METHOD_DISTORT "distort"
#define SCALING_METHOD_BLUR "blur"

#define PARALLAX_DELAY_DEFAULT world.tick_lag
#define PARALLAX_DELAY_MED     1
#define PARALLAX_DELAY_LOW     2

#define SEC_DEPT_NONE "None"
#define SEC_DEPT_RANDOM "Random"
#define SEC_DEPT_ENGINEERING "Engineering"
#define SEC_DEPT_MEDICAL "Medical"
#define SEC_DEPT_SCIENCE "Science"
#define SEC_DEPT_SUPPLY "Supply"

// Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING			"Living"
#define EXP_TYPE_CREW			"Crew"
#define EXP_TYPE_COMMAND		"Command"
#define EXP_TYPE_ENGINEERING	"Engineering"
#define EXP_TYPE_MEDICAL		"Medical"
#define EXP_TYPE_SCIENCE		"Science"
#define EXP_TYPE_SUPPLY			"Supply"
#define EXP_TYPE_SECURITY		"Security"
#define EXP_TYPE_SILICON		"Silicon"
#define EXP_TYPE_SERVICE		"Service"
#define EXP_TYPE_GIMMICK		"Gimmick"
#define EXP_TYPE_ANTAG			"Antag"
#define EXP_TYPE_SPECIAL		"Special"
#define EXP_TYPE_GHOST			"Ghost"
#define EXP_TYPE_ADMIN			"Admin"

//Flags in the players table in the db
#define DB_FLAG_EXEMPT 1

#define DEFAULT_CYBORG_NAME "Default Cyborg Name"


//Job preferences levels
#define JP_LOW 1
#define JP_MEDIUM 2
#define JP_HIGH 3

//Backpacks
#define GBACKPACK "Grey Backpack"
#define GSATCHEL "Grey Satchel"
#define GDUFFELBAG "Grey Duffel Bag"
#define LSATCHEL "Leather Satchel"
#define DBACKPACK "Department Backpack"
#define DSATCHEL "Department Satchel"
#define DDUFFELBAG "Department Duffel Bag"

//Suit/Skirt
#define PREF_SUIT "Jumpsuit"
#define PREF_SKIRT "Jumpskirt"

//Uplink spawn loc
#define UPLINK_PDA "PDA"
#define UPLINK_RADIO "Radio"
#define UPLINK_PEN "Pen" //like a real spy!
#define UPLINK_IMPLANT "Implant"
#define UPLINK_IMPLANT_WITH_PRICE "[UPLINK_IMPLANT] (-[UPLINK_IMPLANT_TELECRYSTAL_COST] TC)"

//Plasmamen helmet styles, when you edit those remember to edit list in preferences.dm
#define HELMET_DEFAULT "Default"
#define HELMET_MK2 "Mark II"
#define HELMET_PROTECTIVE "Protective"
