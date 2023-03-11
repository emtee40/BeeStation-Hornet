// timed_action_flags parameter for `/proc/do_mob` and `/proc/do_after`
#define IGNORE_TARGET_IN_DOAFTERS (1<<0)
#define IGNORE_USER_LOC_CHANGE (1<<1)
#define IGNORE_TARGET_LOC_CHANGE (1<<2)
#define IGNORE_HELD_ITEM (1<<3)
#define IGNORE_INCAPACITATED (1<<4)

// Combined parameters to replace the uninterruptible flag
#define UNINTERRUPTIBLE IGNORE_TARGET_IN_DOAFTERS|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM|IGNORE_INCAPACITATED
#define UNINTERRUPTIBLE_CONSCIOUS IGNORE_TARGET_IN_DOAFTERS|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM
