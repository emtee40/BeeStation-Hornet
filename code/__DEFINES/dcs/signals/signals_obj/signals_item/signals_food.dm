//Food

// Eating stuff
/// From datum/component/edible/proc/TakeBite: (mob/living/eater, mob/feeder, bitecount, bitesize)
#define COMSIG_FOOD_EATEN "food_eaten"
/// From base of datum/component/edible/on_entered: (mob/crosser, bitecount)
#define COMSIG_FOOD_CROSSED "food_crossed"
/// From base of Component/edible/On_Consume: (mob/living/eater, mob/living/feeder)
#define COMSIG_FOOD_CONSUMED "food_consumed"

// Deep frying foods
/// An item becomes fried - From /datum/element/fried_item/Attach: (fry_time)
#define COMSIG_ITEM_FRIED "item_fried"
/// An item entering the deep frying (not fried yet) - From obj/machinery/deepfryer/start_fry: ()
#define COMSIG_ITEM_ENTERED_FRYER "item_entered_fryer"

// Microwaving foods
///called on item when microwaved (): (obj/machinery/microwave/microwave, mob/microwaver)
#define COMSIG_ITEM_MICROWAVE_ACT "microwave_act"
	#define COMPONENT_SUCCESFUL_MICROWAVE (1<<0)
///called on item when created through microwaving (): (obj/machinery/microwave/M, cooking_efficiency)
#define COMSIG_ITEM_MICROWAVE_COOKED "microwave_cooked"

///From /datum/component/edible/on_compost(source, /mob/living/user)
#define COMSIG_EDIBLE_ON_COMPOST "on_compost"
	// Used to stop food from being composted.
	#define COMPONENT_EDIBLE_BLOCK_COMPOST 1
