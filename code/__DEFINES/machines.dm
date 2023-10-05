// channel numbers for power
// These are indexes in a list, and indexes for "dynamic" and static channels should be kept contiguous
#define AREA_USAGE_EQUIP			1
#define AREA_USAGE_LIGHT			2
#define AREA_USAGE_ENVIRON			3
#define AREA_USAGE_STATIC_EQUIP 	4
#define AREA_USAGE_STATIC_LIGHT	5
#define AREA_USAGE_STATIC_ENVIRON	6
#define AREA_USAGE_LEN AREA_USAGE_STATIC_ENVIRON // largest idx
/// Index of the first dynamic usage channel
#define AREA_USAGE_DYNAMIC_START AREA_USAGE_EQUIP
/// Index of the last dynamic usage channel
#define AREA_USAGE_DYNAMIC_END AREA_USAGE_ENVIRON
/// Index of the first static usage channel
#define AREA_USAGE_STATIC_START AREA_USAGE_STATIC_EQUIP
/// Index of the last static usage channel
#define AREA_USAGE_STATIC_END AREA_USAGE_STATIC_ENVIRON

#define DYNAMIC_TO_STATIC_CHANNEL(dyn_channel) (dyn_channel + (AREA_USAGE_STATIC_START - AREA_USAGE_DYNAMIC_START))
#define STATIC_TO_DYNAMIC_CHANNEL(static_channel) (static_channel - (AREA_USAGE_STATIC_START - AREA_USAGE_DYNAMIC_START))

//Power use
#define NO_POWER_USE 0
#define IDLE_POWER_USE 1
#define ACTIVE_POWER_USE 2

/// Bitflags for a machine's preferences on when it should start processing. For use with machinery's `processing_flags` var.
#define START_PROCESSING_ON_INIT	(1<<0) /// Indicates the machine will automatically start processing right after it's `Initialize()` is ran.
#define START_PROCESSING_MANUALLY	(1<<1) /// Machines with this flag will not start processing when it's spawned. Use this if you want to manually control when a machine starts processing.

//bitflags for door switches.
#define OPEN	(1<<0)
#define IDSCAN	(1<<1)
#define BOLTS	(1<<2)
#define SHOCK	(1<<3)
#define SAFE	(1<<4)

//used in design to specify which machine can build it
#define IMPRINTER		(1<<0)	//For circuits. Uses glass/chemicals.
#define PROTOLATHE		(1<<1)	//New stuff. Uses glass/iron/chemicals
#define AUTOLATHE		(1<<2)	//Uses glass/iron only.
#define CRAFTLATHE		(1<<3)	//Uses fuck if I know. For use eventually.
#define MECHFAB			(1<<4) 	//Remember, objects utilising this flag should have construction_time and construction_cost vars.
#define BIOGENERATOR	(1<<5) 	//Uses biomass
#define LIMBGROWER		(1<<6) 	//Uses synthetic flesh
#define SMELTER			(1<<7) 	//uses various minerals
#define NANITE_COMPILER  (1<<8) //Prints nanite disks
/// For wiremod/integrated circuits. Uses various minerals.
#define COMPONENT_PRINTER (1<<10)
//Note: More than one of these can be added to a design but imprinter and lathe designs are incompatable.

//Modular computer/NTNet defines

//Modular computer part defines
#define MC_CPU "CPU"
#define MC_HDD "HDD"
#define MC_HDD_JOB "HDD_JOB"
#define MC_SDD "SDD"
#define MC_CARD "CARD"
#define MC_CARD2 "CARD2"
#define MC_CART "CART"
#define MC_NET "NET"
#define MC_PRINT "PRINT"
#define MC_CELL "CELL"
#define MC_CHARGE "CHARGE"
#define MC_AI "AI"
#define MC_SENSORS "SENSORS"
#define MC_SIGNALLER "SIGNALER"
#define MC_IDENTIFY "IDENTIFY"

//! ## NTNet stuff, for modular computers
//!  **NTNet module-configuration values. Do not change these. If you need to add another use larger number (5..6..7 etc)**
#define NTNET_SOFTWAREDOWNLOAD 1 	//! Downloads of software from NTNet
#define NTNET_PEERTOPEER 2			//! P2P transfers of files between devices
#define NTNET_COMMUNICATION 3		//! Communication (messaging)
#define NTNET_SYSTEMCONTROL 4		//! Control of various systems, RCon, air alarm control, etc.

//! **NTNet transfer speeds, used when downloading/uploading a file/program.**
#define NTNETSPEED_LOWSIGNAL 0.5	//! GQ/s transfer speed when the device is wirelessly connected and on Low signal
#define NTNETSPEED_HIGHSIGNAL 1	//! GQ/s transfer speed when the device is wirelessly connected and on High signal
#define NTNETSPEED_ETHERNET 2		//! GQ/s transfer speed when the device is using wired connection

// Caps for NTNet logging. Less than 10 would make logging useless anyway, more than 500 may make the log browser too laggy. Defaults to 100 unless user changes it.
#define MAX_NTNET_LOGS 300
#define MIN_NTNET_LOGS 10

//Program bitflags
#define PROGRAM_ALL		(~0)
#define PROGRAM_CONSOLE	(1<<0)
#define PROGRAM_LAPTOP	(1<<1)
#define PROGRAM_TABLET	(1<<2)
//Program states
#define PROGRAM_STATE_KILLED 0
#define PROGRAM_STATE_BACKGROUND 1
#define PROGRAM_STATE_ACTIVE 2
//Program categories
#define PROGRAM_CATEGORY_CREW "Crew"
#define PROGRAM_CATEGORY_ENGI "Engineering"
#define PROGRAM_CATEGORY_ROBO "Robotics"
#define PROGRAM_CATEGORY_SUPL "Supply"
#define PROGRAM_CATEGORY_MISC "Other"

#define FIREDOOR_OPEN 1
#define FIREDOOR_CLOSED 2



// These are used by supermatter and supermatter monitor program, mostly for UI updating purposes. Higher should always be worse!
#define SUPERMATTER_ERROR -1		// Unknown status, shouldn't happen but just in case.
#define SUPERMATTER_INACTIVE 0		// No or minimal energy
#define SUPERMATTER_NORMAL 1		// Normal operation
#define SUPERMATTER_NOTIFY 2		// Ambient temp > 80% of CRITICAL_TEMPERATURE
#define SUPERMATTER_WARNING 3		// Ambient temp > CRITICAL_TEMPERATURE OR integrity damaged
#define SUPERMATTER_DANGER 4		// Integrity < 50%
#define SUPERMATTER_EMERGENCY 5		// Integrity < 25%
#define SUPERMATTER_DELAMINATING 6	// Pretty obvious.

//Nuclear bomb stuff
#define NUKESTATE_INTACT		5
#define NUKESTATE_UNSCREWED		4
#define NUKESTATE_PANEL_REMOVED		3
#define NUKESTATE_WELDED		2
#define NUKESTATE_CORE_EXPOSED	1
#define NUKESTATE_CORE_REMOVED	0

#define NUKEUI_AWAIT_DISK 0
#define NUKEUI_AWAIT_CODE 1
#define NUKEUI_AWAIT_TIMER 2
#define NUKEUI_AWAIT_ARM 3
#define NUKEUI_TIMING 4
#define NUKEUI_EXPLODED 5

#define NUKE_OFF_LOCKED		0
#define NUKE_OFF_UNLOCKED	1
#define NUKE_ON_TIMING		2
#define NUKE_ON_EXPLODING	3

#define MACHINE_NOT_ELECTRIFIED 0
#define MACHINE_ELECTRIFIED_PERMANENT -1
#define MACHINE_DEFAULT_ELECTRIFY_TIME 30

//cloning defines. These are flags.
#define CLONING_SUCCESS (1<<0)
#define CLONING_DELETE_RECORD (1<<1)
#define CLONING_SUCCESS_EXPERIMENTAL (1<<2)

#define ERROR_NO_SYNTHFLESH 101
#define ERROR_PANEL_OPENED 102
#define ERROR_MESS_OR_ATTEMPTING 103
#define ERROR_MISSING_EXPERIMENTAL_POD 104
#define ERROR_NOT_MIND 201
#define ERROR_PRESAVED_CLONE 202
#define ERROR_OUTDATED_CLONE 203
#define ERROR_ALREADY_ALIVE 204
#define ERROR_COMMITED_SUICIDE 205
#define ERROR_SOUL_DEPARTED 206
#define ERROR_SUICIDED_BODY 207
#define ERROR_SOUL_DAMNED 666
#define ERROR_UNCLONABLE 901

//these flags are used to tell the DNA modifier if a plant gene cannot be extracted or modified.
#define PLANT_GENE_REMOVABLE	(1<<0)
#define PLANT_GENE_EXTRACTABLE	(1<<1)

#define CLICKSOUND_INTERVAL (0.1 SECONDS)	//clicky noises, how much time needed in between clicks on the machine for the sound to play on click again.

// From code/game/machinery/computer/communications.dm
// ---------------------------------------------------

// for setting status display. Used in modpc status app as well.
#define MAX_STATUS_LINE_LENGTH 40
// approvied pictures, also used in modpc app
GLOBAL_LIST_INIT(approved_status_pictures, list(
	"biohazard",
	"blank",
	"default",
	"lockdown",
	"redalert",
	"shuttle",
))
