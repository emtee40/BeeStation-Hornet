
#define ENGSEC			(1<<0)

#define CAPTAIN			(1<<0)
#define HOS				(1<<1)
#define WARDEN			(1<<2)
#define DETECTIVE		(1<<3)
#define OFFICER			(1<<4)
#define CHIEF			(1<<5)
#define ENGINEER		(1<<6)
#define ATMOSTECH		(1<<7)
#define ROBOTICIST		(1<<8)
#define AI_JF			(1<<9)
#define CYBORG			(1<<10)
#define BRIG_PHYS		(1<<11)
#define DEPUTY  		(1<<12)


#define MEDSCI			(1<<1)

#define RD_JF			(1<<0)
#define SCIENTIST		(1<<1)
#define EXPLORATION_CREW (1<<2)
#define CHEMIST			(1<<3)
#define CMO_JF			(1<<4)
#define DOCTOR			(1<<5)
#define GENETICIST		(1<<6)
#define VIROLOGIST		(1<<7)
#define EMT				(1<<8)


#define CIVILIAN		(1<<2)

#define HOP				(1<<0)
#define BARTENDER		(1<<1)
#define BOTANIST		(1<<2)
#define COOK			(1<<3)
#define JANITOR			(1<<4)
#define CURATOR			(1<<5)
#define QUARTERMASTER	(1<<6)
#define CARGOTECH		(1<<7)
#define MINER			(1<<8)
#define LAWYER			(1<<9)
#define CHAPLAIN		(1<<10)
#define CLOWN			(1<<11)
#define MIME			(1<<12)
#define ASSISTANT		(1<<13)
#define GIMMICK 		(1<<14)
#define BARBER		    (1<<15)
#define MAGICIAN        (1<<16)
#define HOBO            (1<<17)
#define SHRINK          (1<<18)
#define CELEBRITY       (1<<19)

#define JOB_AVAILABLE 0
#define JOB_UNAVAILABLE_GENERIC 1
#define JOB_UNAVAILABLE_BANNED 2
#define JOB_UNAVAILABLE_PLAYTIME 3
#define JOB_UNAVAILABLE_ACCOUNTAGE 4
#define JOB_UNAVAILABLE_SLOTFULL 5

#define DEFAULT_RELIGION "Christianity"
#define DEFAULT_DEITY "Space Jesus"

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define JOB_DISPLAY_ORDER_ASSISTANT 1
#define JOB_DISPLAY_ORDER_CAPTAIN 2
#define JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL 3
#define JOB_DISPLAY_ORDER_QUARTERMASTER 4
#define JOB_DISPLAY_ORDER_CARGO_TECHNICIAN 5
#define JOB_DISPLAY_ORDER_SHAFT_MINER 6
#define JOB_DISPLAY_ORDER_BARTENDER 7
#define JOB_DISPLAY_ORDER_COOK 8
#define JOB_DISPLAY_ORDER_BOTANIST 9
#define JOB_DISPLAY_ORDER_JANITOR 10
#define JOB_DISPLAY_ORDER_CLOWN 11
#define JOB_DISPLAY_ORDER_MIME 12
#define JOB_DISPLAY_ORDER_CURATOR 13
#define JOB_DISPLAY_ORDER_LAWYER 14
#define JOB_DISPLAY_ORDER_CHAPLAIN 15
#define JOB_DISPLAY_ORDER_CHIEF_ENGINEER 16
#define JOB_DISPLAY_ORDER_STATION_ENGINEER 17
#define JOB_DISPLAY_ORDER_ATMOSPHERIC_TECHNICIAN 18
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 19
#define JOB_DISPLAY_ORDER_MEDICAL_DOCTOR 20
#define JOB_DISPLAY_ORDER_CHEMIST 21
#define JOB_DISPLAY_ORDER_GENETICIST 22
#define JOB_DISPLAY_ORDER_VIROLOGIST 23
#define JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR 24
#define JOB_DISPLAY_ORDER_SCIENTIST 25
#define JOB_DISPLAY_ORDER_EXPLORATION 26
#define JOB_DISPLAY_ORDER_ROBOTICIST 27
#define JOB_DISPLAY_ORDER_HEAD_OF_SECURITY 28
#define JOB_DISPLAY_ORDER_WARDEN 29
#define JOB_DISPLAY_ORDER_DETECTIVE 30
#define JOB_DISPLAY_ORDER_SECURITY_OFFICER 31
#define JOB_DISPLAY_ORDER_BRIG_PHYS 32
#define JOB_DISPLAY_ORDER_DEPUTY 33
#define JOB_DISPLAY_ORDER_AI 34
#define JOB_DISPLAY_ORDER_CYBORG 35


#define JOB_STRING_ASSISTANT    "Assistant"
#define JOB_STRING_JANITOR      "Janitor"
#define JOB_STRING_BARTENDER    "Bartender"
#define JOB_STRING_COOK         "Cook"
#define JOB_STRING_BOTANIST     "Botanist"
#define JOB_STRING_CURATOR      "Curator"
#define JOB_STRING_CHAPLAIN     "Chaplain"
#define JOB_STRING_BARBER       "Barber"
#define JOB_STRING_VIP          "VIP"
#define JOB_STRING_DEBTOR       "Debtor"
#define JOB_STRING_LAWYER       "Lawyer"
#define JOB_STRING_CLOWN        "Clown"
#define JOB_STRING_MIME         "Mime"
#define JOB_STRING_STAGE_MAGICIAN        "Stage Magician"
#define JOB_STRING_HEAD_OF_SECURITY      "Head of Security"
#define JOB_STRING_HOS                   JOB_STRING_HEAD_OF_SECURITY
#define JOB_STRING_WARDEN                "Warden"
#define JOB_STRING_SECURITY_OFFICER      "Security Officer"
#define JOB_STRING_DETECTIVE             "Detective"
#define JOB_STRING_DEPUTY                "Deputy"
#define JOB_STRING_RESEARCH_DIRECTOR     "Research Director"
#define JOB_STRING_RD                    JOB_STRING_RESEARCH_DIRECTOR
#define JOB_STRING_SCIENTIST             "Scientist"
#define JOB_STRING_EXPLORATION_CREW      "Exploration Crew"
#define JOB_STRING_ROBOTICIST            "Roboticist"
#define JOB_STRING_CHIEF_MEDICAL_OFFICIER    "Chief Medical Officer"
#define JOB_STRING_CMO                       JOB_STRING_CHIEF_MEDICAL_OFFICIER
#define JOB_STRING_BRIG_PHYSICIAN            "Brig Physician"
#define JOB_STRING_MEDICAL_DOCTOR            "Medical Doctor"
#define JOB_STRING_PARAMEDIC                 "Paramedic"
#define JOB_STRING_PSYCHIATRIST              "Psychiatrist"
#define JOB_STRING_CHEMIST                   "Chemist"
#define JOB_STRING_VIROLOGIST                "Virologist"
#define JOB_STRING_GENETICIST                "Geneticist"
#define JOB_STRING_CHIEF_ENGINEER            "Chief Engineer"
#define JOB_STRING_CE                        JOB_STRING_CHIEF_ENGINEER
#define JOB_STRING_STATION_ENGINEER          "Station Engineer"
#define JOB_STRING_ATMOSPHERIC_TECHNICIAN    "Atmospheric Technician"
#define JOB_STRING_QUARTERMASTER             "Quartermaster"
#define JOB_STRING_QM                        JOB_STRING_QUARTERMASTER
#define JOB_STRING_CARGO_TECHNICIAN          "Cargo Technician"
#define JOB_STRING_SHAFT_MINER               "Shaft Miner"
#define JOB_STRING_CAPTAIN                   "Captain"
#define JOB_STRING_HEAD_OF_PERSONNEL         "Head of Personnel"
#define JOB_STRING_HOP                       JOB_STRING_HEAD_OF_PERSONNEL


#define DEPARTMENT_SECURITY (1<<0)
#define DEPARTMENT_COMMAND (1<<1)
#define DEPARTMENT_SERVICE (1<<2)
#define DEPARTMENT_CARGO (1<<3)
#define DEPARTMENT_ENGINEERING (1<<4)
#define DEPARTMENT_SCIENCE (1<<5)
#define DEPARTMENT_MEDICAL (1<<6)
#define DEPARTMENT_SILICON (1<<7)
