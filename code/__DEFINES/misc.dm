//  The highest number of "for()" loop iterations before infinite loop detection triggers
// +1 for "while()" loops, for some reason
#define INFINITE_LOOP_DETECTION_THRESHOLD 1048574

//Human Overlays Indexes/////////
#define MUTATIONS_LAYER			29		//! mutations. Tk headglows, cold resistance glow, etc
#define BODY_BEHIND_LAYER		28		//! certain mutantrace features (tail when looking south) that must appear behind the body parts
#define BODYPARTS_LAYER			27		//! Initially "AUGMENTS", this was repurposed to be a catch-all bodyparts flag
#define BODY_ADJ_LAYER			26		//! certain mutantrace features (snout, body markings) that must appear above the body parts
#define BODY_LAYER				25		//! underwear, undershirts, socks, eyes, lips(makeup)
#define FRONT_MUTATIONS_LAYER	24		//! mutations that should appear above body, body_adj and bodyparts layer (e.g. laser eyes)
#define DAMAGE_LAYER			23		//! damage indicators (cuts and burns)
#define UNIFORM_LAYER			22
#define ID_LAYER				21 		//! lmao at the idiot who put both ids and hands on the same layer
#define HANDS_PART_LAYER		20
#define GLOVES_LAYER			19
#define SHOES_LAYER				18
#define EARS_LAYER				17
#define SUIT_LAYER				16
#define GLASSES_LAYER			15
#define BELT_LAYER				14		//! Possible make this an overlay of somethign required to wear a belt?
#define SUIT_STORE_LAYER		13
#define NECK_LAYER				12
#define BACK_LAYER				11
#define HAIR_LAYER				10		//! TODO: make part of head layer?
#define FACEMASK_LAYER			9
#define HEAD_LAYER				8
#define HANDCUFF_LAYER			7
#define LEGCUFF_LAYER			6
#define HANDS_LAYER				5
#define BODY_FRONT_LAYER		4
#define HALO_LAYER				3		//! blood cult ascended halo, because there's currently no better solution for adding/removing
#define TYPING_LAYER			2
#define FIRE_LAYER				1		//! If you're on fire
#define TOTAL_LAYERS			29		//! KEEP THIS UP-TO-DATE OR SHIT WILL BREAK ;_;

//Human Overlay Index Shortcuts for alternate_worn_layer, layers
//Because I *KNOW* somebody will think layer+1 means "above"
//IT DOESN'T OK, IT MEANS "UNDER"
#define UNDER_SUIT_LAYER			(SUIT_LAYER+1)
#define UNDER_HEAD_LAYER			(HEAD_LAYER+1)

//AND -1 MEANS "ABOVE", OK?, OK!?!
#define ABOVE_SHOES_LAYER			(SHOES_LAYER-1)
#define ABOVE_BODY_FRONT_LAYER		(BODY_FRONT_LAYER-1)


//Security levels
#define SEC_LEVEL_GREEN	0
#define SEC_LEVEL_BLUE	1
#define SEC_LEVEL_RED	2
#define SEC_LEVEL_DELTA	3

//some arbitrary defines to be used by self-pruning global lists. (see master_controller)
#define PROCESS_KILL 26	//Used to trigger removal from a processing list

// Cargo-related stuff.
#define MANIFEST_ERROR_CHANCE		5
#define MANIFEST_ERROR_NAME			1
#define MANIFEST_ERROR_CONTENTS		2
#define MANIFEST_ERROR_ITEM			4

#define TRANSITIONEDGE			7 //! Distance from edge to move to another z-level

#define BE_CLOSE TRUE		//! in the case of a silicon, to select if they need to be next to the atom
#define NO_DEXTERY TRUE		//! if other mobs (monkeys, aliens, etc) can use this
#define NO_TK TRUE
//used by canUseTopic()

//singularity defines
#define STAGE_ONE 1
#define STAGE_TWO 3
#define STAGE_THREE 5
#define STAGE_FOUR 7
#define STAGE_FIVE 9
#define STAGE_SIX 11 //! From supermatter shard

//SSticker.current_state values
#define GAME_STATE_STARTUP		0
#define GAME_STATE_PREGAME		1
#define GAME_STATE_SETTING_UP	2
#define GAME_STATE_PLAYING		3
#define GAME_STATE_FINISHED		4

#define RESIZE_DEFAULT_SIZE 1

//transfer_ai() defines. Main proc in ai_core.dm
#define AI_TRANS_TO_CARD	1 //! Downloading AI to InteliCard.
#define AI_TRANS_FROM_CARD	2 //! Uploading AI from InteliCard
#define AI_MECH_HACK		3 //! Malfunctioning AI hijacking mecha

//check_target_facings() return defines
#define FACING_SAME_DIR											1
#define FACING_EACHOTHER										2
#define FACING_INIT_FACING_TARGET_TARGET_FACING_PERPENDICULAR	3 //! Do I win the most informative but also most stupid define award?


//Cache of bloody footprint images
//Key:
//"entered-[blood_state]-[dir_of_image]"
//or: "exited-[blood_state]-[dir_of_image]"
GLOBAL_LIST_EMPTY(bloody_footprints_cache)

//Bloody shoes/footprints
#define MAX_SHOE_BLOODINESS			100
#define BLOODY_FOOTPRINT_BASE_ALPHA	150
#define BLOOD_GAIN_PER_STEP			100
#define BLOOD_LOSS_PER_STEP			5
#define BLOOD_LOSS_IN_SPREAD		20
#define BLOOD_AMOUNT_PER_DECAL		20

//Bloody shoe blood states
#define BLOOD_STATE_HUMAN			"blood"
#define BLOOD_STATE_XENO			"xeno"
#define BLOOD_STATE_OIL				"oil"
#define BLOOD_STATE_NOT_BLOODY		"no blood whatsoever"

//suit sensors: sensor_mode defines

#define SENSOR_NOT_SET -1
#define SENSOR_OFF 0
#define SENSOR_LIVING 1
#define SENSOR_VITALS 2
#define SENSOR_COORDS 3

//suit sensors: has_sensor defines

#define BROKEN_SENSORS -1
#define NO_SENSORS 0
#define HAS_SENSORS 1
#define LOCKED_SENSORS 2

//Wet floor type flags. Stronger ones should be higher in number.
#define TURF_DRY			(0)
#define TURF_WET_WATER		(1<<0)
#define TURF_WET_PERMAFROST	(1<<1)
#define TURF_WET_ICE 		(1<<2)
#define TURF_WET_LUBE		(1<<3)
#define TURF_WET_SUPERLUBE	(1<<4)

//Maximum amount of time, (in deciseconds) a tile can be wet for.
#define MAXIMUM_WET_TIME 5 MINUTES

//unmagic-strings for types of polls
#define POLLTYPE_OPTION		"OPTION"
#define POLLTYPE_TEXT		"TEXT"
#define POLLTYPE_RATING		"NUMVAL"
#define POLLTYPE_MULTI		"MULTICHOICE"
#define POLLTYPE_IRV		"IRV"

//subtypesof(), typesof() without the parent path
#define subtypesof(typepath) ( typesof(typepath) - typepath )

//Gets the turf this atom inhabits
#define get_turf(A) (get_step(A, 0))

//Same as above except gets the area instead
#define get_area(A) (isarea(A) ? A : get_step(A, 0)?.loc)

//Ghost orbit types:
#define GHOST_ORBIT_CIRCLE		"circle"
#define GHOST_ORBIT_TRIANGLE	"triangle"
#define GHOST_ORBIT_HEXAGON		"hexagon"
#define GHOST_ORBIT_SQUARE		"square"
#define GHOST_ORBIT_PENTAGON	"pentagon"

//Ghost showing preferences:
#define GHOST_ACCS_NONE		1
#define GHOST_ACCS_DIR		50
#define GHOST_ACCS_FULL		100

#define GHOST_ACCS_NONE_NAME		"default sprites"
#define GHOST_ACCS_DIR_NAME			"only directional sprites"
#define GHOST_ACCS_FULL_NAME		"full accessories"

#define GHOST_ACCS_DEFAULT_OPTION	GHOST_ACCS_FULL

GLOBAL_LIST_INIT(ghost_accs_options, list(GHOST_ACCS_NONE, GHOST_ACCS_DIR, GHOST_ACCS_FULL)) //So save files can be sanitized properly.

#define GHOST_OTHERS_SIMPLE 			1
#define GHOST_OTHERS_DEFAULT_SPRITE		50
#define GHOST_OTHERS_THEIR_SETTING 		100

#define GHOST_OTHERS_SIMPLE_NAME 			"white ghost"
#define GHOST_OTHERS_DEFAULT_SPRITE_NAME 	"default sprites"
#define GHOST_OTHERS_THEIR_SETTING_NAME 	"their setting"

#define GHOST_OTHERS_DEFAULT_OPTION			GHOST_OTHERS_THEIR_SETTING

#define GHOST_MAX_VIEW_RANGE_DEFAULT 10
#define GHOST_MAX_VIEW_RANGE_MEMBER 14


GLOBAL_LIST_INIT(ghost_others_options, list(GHOST_OTHERS_SIMPLE, GHOST_OTHERS_DEFAULT_SPRITE, GHOST_OTHERS_THEIR_SETTING)) //Same as ghost_accs_options.

// Consider these images/atoms as part of the UI/HUD
#define APPEARANCE_UI_IGNORE_ALPHA			(RESET_COLOR|RESET_TRANSFORM|NO_CLIENT_COLOR|RESET_ALPHA|PIXEL_SCALE)
#define APPEARANCE_UI						(RESET_COLOR|RESET_TRANSFORM|NO_CLIENT_COLOR|PIXEL_SCALE)

//Just space
#define SPACE_ICON_STATE	"[((x + y) ^ ~(x * y) + z) % 25]"

// Maploader bounds indices
#define MAP_MINX 1
#define MAP_MINY 2
#define MAP_MINZ 3
#define MAP_MAXX 4
#define MAP_MAXY 5
#define MAP_MAXZ 6

// Defib stats
#define DEFIB_TIME_LIMIT 900
#define DEFIB_TIME_LOSS 60

// Diagonal movement
#define FIRST_DIAG_STEP 1
#define SECOND_DIAG_STEP 2

#define DEADCHAT_ARRIVALRATTLE "arrivalrattle"
#define DEADCHAT_DEATHRATTLE "deathrattle"
#define DEADCHAT_LAWCHANGE "lawchange"
#define DEADCHAT_REGULAR "regular-deadchat"

// Bluespace shelter deploy checks
#define SHELTER_DEPLOY_ALLOWED "allowed"
#define SHELTER_DEPLOY_BAD_TURFS "bad turfs"
#define SHELTER_DEPLOY_BAD_AREA "bad area"
#define SHELTER_DEPLOY_ANCHORED_OBJECTS "anchored objects"

//debug printing macros
#define debug_world(msg) if (GLOB.Debug2) to_chat(world, \
	type = MESSAGE_TYPE_DEBUG, \
	text = "DEBUG: [msg]")
#define debug_usr(msg) if (GLOB.Debug2&&usr) to_chat(usr, \
	type = MESSAGE_TYPE_DEBUG, \
	text = "DEBUG: [msg]")
#define debug_admins(msg) if (GLOB.Debug2) to_chat(GLOB.admins, \
	type = MESSAGE_TYPE_DEBUG, \
	text = "DEBUG: [msg]")
#define debug_world_log(msg) if (GLOB.Debug2) log_world("DEBUG: [msg]")

//TODO Move to a pref
#define STATION_GOAL_BUDGET  1

//Luma coefficients suggested for HDTVs. If you change these, make sure they add up to 1.
#define LUMA_R 0.213
#define LUMA_G 0.715
#define LUMA_B 0.072

//different types of atom colorations
#define ADMIN_COLOUR_PRIORITY 		1 //! only used by rare effects like greentext coloring mobs and when admins varedit color
#define TEMPORARY_COLOUR_PRIORITY 	2 //! e.g. purple effect of the revenant on a mob, black effect when mob electrocuted
#define WASHABLE_COLOUR_PRIORITY 	3 //! color splashed onto an atom (e.g. paint on turf)
#define FIXED_COLOUR_PRIORITY 		4 //! color inherent to the atom (e.g. blob color)
#define COLOUR_PRIORITY_AMOUNT 4 //! how many priority levels there are.

//Endgame Results
#define NUKE_NEAR_MISS 1
#define NUKE_MISS_STATION 2
#define NUKE_SYNDICATE_BASE 3
#define STATION_DESTROYED_NUKE 4
#define STATION_EVACUATED 5
#define GANG_LOSS 6
#define GANG_TAKEOVER 7
#define BLOB_WIN 8
#define BLOB_NUKE 9
#define BLOB_DESTROYED 10
#define CULT_ESCAPE 11
#define CULT_FAILURE 12
#define CULT_SUMMON 13
#define NUKE_MISS 14
#define OPERATIVES_KILLED 15
#define OPERATIVE_SKIRMISH 16
#define REVS_WIN 17
#define REVS_LOSE 18
#define WIZARD_KILLED 19
#define STATION_NUKED 20
#define CLOCK_SUMMON 21
#define CLOCK_SILICONS 22
#define CLOCK_PROSELYTIZATION 23
#define SHUTTLE_HIJACK 24

#define FIELD_TURF 1
#define FIELD_EDGE 2

//gibtonite state defines
#define GIBTONITE_UNSTRUCK 0
#define GIBTONITE_ACTIVE 1
#define GIBTONITE_STABLE 2
#define GIBTONITE_DETONATE 3

//for obj explosion block calculation
#define EXPLOSION_BLOCK_PROC -1

//for determining which type of heartbeat sound is playing
#define BEAT_FAST 1
#define BEAT_SLOW 2
#define BEAT_NONE 0

//world/proc/shelleo
#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDOUT 2
#define SHELLEO_STDERR 3

//server security mode
#define SECURITY_SAFE 1
#define SECURITY_ULTRASAFE 2
#define SECURITY_TRUSTED 3

//Dummy mob reserve slots
#define DUMMY_HUMAN_SLOT_PREFERENCES "dummy_preference_preview"
#define DUMMY_HUMAN_SLOT_ADMIN "admintools"
#define DUMMY_HUMAN_SLOT_MANIFEST "dummy_manifest_generation"

#define PR_ANNOUNCEMENTS_PER_ROUND 5 //The number of unique PR announcements allowed per round
									//This makes sure that a single person can only spam 3 reopens and 3 closes before being ignored

#define MAX_PROC_DEPTH 195 // 200 proc calls deep and shit breaks, this is a bit lower to give some safety room

#define SYRINGE_DRAW 0
#define SYRINGE_INJECT 1

//gold slime core spawning
#define NO_SPAWN 0
#define HOSTILE_SPAWN 1
#define FRIENDLY_SPAWN 2

//slime core activation type
#define SLIME_ACTIVATE_MINOR 1
#define SLIME_ACTIVATE_MAJOR 2

#define LUMINESCENT_DEFAULT_GLOW 2

#define RIDING_OFFSET_ALL "ALL"

//stack recipe placement check types
#define STACK_CHECK_CARDINALS "cardinals" //! checks if there is an object of the result type in any of the cardinal directions
#define STACK_CHECK_ADJACENT "adjacent" //! checks if there is an object of the result type within one tile

//Fullscreen overlay resolution in tiles.
#define FULLSCREEN_OVERLAY_RESOLUTION_X 15
#define FULLSCREEN_OVERLAY_RESOLUTION_Y 15

#define SUMMON_GUNS "guns"
#define SUMMON_MAGIC "magic"

#define TELEPORT_CHANNEL_BLUESPACE "bluespace"	//! Classic bluespace teleportation, requires a sender but no receiver
#define TELEPORT_CHANNEL_QUANTUM "quantum"		//! Quantum-based teleportation, requires both sender and receiver, but is free from normal disruption
#define TELEPORT_CHANNEL_WORMHOLE "wormhole"	//! Wormhole teleportation, is not disrupted by bluespace fluctuations but tends to be very random or unsafe
#define TELEPORT_CHANNEL_MAGIC "magic"			//! Magic teleportation, does whatever it wants (unless there's antimagic)
#define TELEPORT_CHANNEL_CULT "cult"			//! Cult teleportation, does whatever it wants (unless there's holiness)
#define TELEPORT_CHANNEL_BLINK "blink"			//! Teleportation with only a sender, but not disrupted by the BOH
#define TELEPORT_CHANNEL_FREE "free"			//! Anything else

//Teleport restriction modes (For areas)
#define TELEPORT_ALLOW_ALL 0
#define TELEPORT_ALLOW_NONE 1
#define TELEPORT_ALLOW_CLOCKWORK 2
#define TELEPORT_ALLOW_ABDUCTORS 3

//Teleport modes
#define TELEPORT_MODE_DEFAULT 0
#define TELEPORT_MODE_CLOCKWORK 2
#define TELEPORT_MODE_ABDUCTORS 3

/// Force the log directory to be something specific in the data/logs folder
#define OVERRIDE_LOG_DIRECTORY_PARAMETER "log-directory"
/// Prevent the master controller from starting automatically
#define NO_INIT_PARAMETER "no-init"
/// Force the config directory to be something other than "config"
#define OVERRIDE_CONFIG_DIRECTORY_PARAMETER "config-directory"

#define EGG_LAYING_MESSAGES list("lays an egg.","squats down and croons.","begins making a huge racket.","begins clucking raucously.")

//Filters
#define AMBIENT_OCCLUSION filter(type="drop_shadow", x=0, y=-2, size=4, color="#04080FAA")
#define GAUSSIAN_BLUR(filter_size) filter(type="blur", size=filter_size)

#define STANDARD_GRAVITY 1 //! Anything above this is high gravity, anything below no grav
#define GRAVITY_DAMAGE_TRESHOLD 3 //! Starting with this value gravity will start to damage mobs

#define CAMERA_NO_GHOSTS 0
#define CAMERA_SEE_GHOSTS_BASIC 1
#define CAMERA_SEE_GHOSTS_ORBIT 2

#define CLIENT_FROM_VAR(I) (ismob(I) ? I:client : (istype(I, /client) ? I : (istype(I, /datum/mind) ? I:current?:client : null)))

#define AREASELECT_CORNERA "corner A"
#define AREASELECT_CORNERB "corner B"

#define VARSET_FROM_LIST(L, V) if(L && L[#V]) V = L[#V]
#define VARSET_FROM_LIST_IF(L, V, C...) if(L && L[#V] && (C)) V = L[#V]
#define VARSET_TO_LIST(L, V) if(L) L[#V] = V
#define VARSET_TO_LIST_IF(L, V, C...) if(L && (C)) L[#V] = V

#define DICE_NOT_RIGGED 1
#define DICE_BASICALLY_RIGGED 2
#define DICE_TOTALLY_RIGGED 3

#define VOMIT_TOXIC 1
#define VOMIT_PURPLE 2

/// Misc text define. Does 4 spaces. Used as a makeshift tabulator.
#define FOURSPACES "&nbsp;&nbsp;&nbsp;&nbsp;"

//chem grenades defines
#define GRENADE_EMPTY 1
#define GRENADE_WIRED 2
#define GRENADE_READY 3

//guardian themes
#define GUARDIAN_TECH	"tech"
#define GUARDIAN_CARP	"carp"
#define GUARDIAN_MAGIC	"magic"
#define GUARDIAN_HIVE	"hive"

// possible bitflag return values of intercept_zImpact(atom/movable/AM, levels = 1) calls
#define FALL_INTERCEPTED		(1<<0) //Stops the movable from falling further and crashing on the ground
#define FALL_NO_MESSAGE			(1<<1) //Used to suppress the "[A] falls through [old_turf]" messages where it'd make little sense at all, like going downstairs.
#define FALL_STOP_INTERCEPTING	(1<<2) //Used in situations where halting the whole "intercept" loop would be better, like supermatter dusting (and thus deleting) the atom.

//Religion

#define HOLY_ROLE_DEACON 1 //role below priests, for losing most powers of priests but still being holy.
#define HOLY_ROLE_PRIEST 2 //default priestly role
#define HOLY_ROLE_HIGHPRIEST 3 //the one who designates the religion

#define ALIGNMENT_GOOD "good"
#define ALIGNMENT_NEUT "neutral"
#define ALIGNMENT_EVIL "evil"

///List of monkey_icons for clothing
GLOBAL_LIST_EMPTY(monkey_icon_cache)

// Pirates threat
#define PIRATE_RESPONSE_NO_PAY "pirate_answer_no_pay"
#define PIRATE_RESPONSE_PAY "pirate_answer_pay"
