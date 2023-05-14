#define DEPT_NAME_COMMAND "Command"
#define DEPT_BITFLAG_COMMAND (1<<0)

#define DEPT_NAME_CIVILIAN "Civilian"
#define DEPT_BITFLAG_CIVILIAN (1<<1)

#define DEPT_NAME_SERVICE "Service"
#define DEPT_BITFLAG_SERVICE (1<<2)

#define DEPT_NAME_SUPPLY "Supply"
#define DEPT_BITFLAG_SUPPLY (1<<3)

#define DEPT_NAME_SCIENCE "Science"
#define DEPT_BITFLAG_SCIENCE (1<<4)

#define DEPT_NAME_ENGINEERING "Engineering"
#define DEPT_BITFLAG_ENGINEERING (1<<5)

#define DEPT_NAME_MEDICAL "Medical"
#define DEPT_BITFLAG_MEDICAL (1<<6)

#define DEPT_NAME_SECURITY "Security"
#define DEPT_BITFLAG_SECURITY (1<<7)

#define DEPT_NAME_MUNITION "Munition" // dedicated for NSV
#define DEPT_BITFLAG_NUNITION (1<<8)

#define DEPT_NAME_SILICON "Silicon"
#define DEPT_BITFLAG_SILICON (1<<9)

#define DEPT_NAME_VIP "VIP"
#define DEPT_BITFLAG_VIP (1<<10)

#define DEPT_NAME_CENTCOM "CentCom"
#define DEPT_BITFLAG_CENTCOM (1<<11)

#define DEPT_NAME_OTHER "Other"
#define DEPT_BITFLAG_OTHER (1<<12)



#define DEPT_DATACORE_ORDER_COMMAND 10
#define DEPT_DATACORE_ORDER_CENTCOM 11 // generally it won't be used
#define DEPT_DATACORE_ORDER_VIP 12
#define DEPT_DATACORE_ORDER_SECURITY 20
#define DEPT_DATACORE_ORDER_ENGINEERING 30
#define DEPT_DATACORE_ORDER_MEDICAL 40
#define DEPT_DATACORE_ORDER_SCIENCE 50
#define DEPT_DATACORE_ORDER_SUPPLY 60
#define DEPT_DATACORE_ORDER_SERVICE 70
#define DEPT_DATACORE_ORDER_CIVILIAN 80
#define DEPT_DATACORE_ORDER_SILICON 90 // not used - can be used if we want silicons in datacore
#define DEPT_DATACORE_ORDER_OTHER 999 // not used but just in case
