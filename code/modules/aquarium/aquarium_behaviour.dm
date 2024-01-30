//Fish breeding stops if fish count exceeds this.
#define AQUARIUM_MAX_BREEDING_POPULATION 20

// Configuration objects defining prop/fish behaviour in the aquarium
// These are used as a base for autogenerating the actual instances
/datum/aquarium_behaviour
	var/name = "base aquarium element"
	var/desc = "<insert funny description here>"

	var/unique = FALSE

	var/icon = 'icons/obj/aquarium.dmi'
	/// Icon state used for catalog/autogenerated fish item. Also used as basis for in aquarium visual if dedicated_in_aquarium_icon_state is not set.
	var/icon_state
	/// Applied and item/catalog for use with greyscaled icons.
	var/color

	/// How the thing will be layered
	var/layer_mode = AQUARIUM_LAYER_MODE_AUTO
	/// If the starting position is randomised within bounds.
	var/randomize_position = FALSE

	/**
	 *  Fish sprite how to:
	 *  Need to be centered on 16,16 in the dmi and facing left by default.
	 *  sprite_height/sprite_width is the size it will have in aquarium and used to control animation boundaries.
	 *  source_height/source_width is the size of the original icon (ideally only the non-empty parts)
	 */

	/// If this is set this icon state will be used for the holder while icon_state will only be used for item/catalog. Transformation from source_width/height WON'T be applied.
	var/dedicated_in_aquarium_icon_state
	/// Applied to vc object only for use with greyscaled icons.
	var/aquarium_vc_color

	//Target sprite size for path/position calculations.
	var/sprite_height = 3
	var/sprite_width = 3
	//This is the size of the source sprite. This will be used to calculate scale down factor.
	var/source_width = 32
	var/source_height = 32

	/// Current animation
	var/current_animation

	/// Does this behviour need additional processing in aquarium, will be added to SSobj processing on insertion
	var/processing = FALSE

	/// Our holder component
	var/datum/component/aquarium_content/parent

/// Applies icon,color and base scaling to our visual holder
/datum/aquarium_behaviour/proc/apply_appearance(obj/effect/holder)
	holder.icon = icon
	if(dedicated_in_aquarium_icon_state)
		holder.icon_state = dedicated_in_aquarium_icon_state
	else
		holder.icon_state = icon_state
	holder.transform = base_transform()
	if(aquarium_vc_color)
		holder.color = aquarium_vc_color

// Generates scaling matrix for our visual
/datum/aquarium_behaviour/proc/base_transform()
	var/matrix/matrix = matrix()
	if(!dedicated_in_aquarium_icon_state)
		var/x_scale = sprite_width / source_width
		var/y_scale = sprite_height / source_height
		matrix.Scale(x_scale, y_scale)
	return matrix

/// Called when fed.
/datum/aquarium_behaviour/proc/on_feeding(datum/reagents/feed_reagents)
	return

/// Called when aquarium fluid changes.
/datum/aquarium_behaviour/proc/on_fluid_changed()
	return

/// Called to update current animation based on state
/datum/aquarium_behaviour/proc/update_animation()
	return

/// Called when inserted into new aquarium
/datum/aquarium_behaviour/proc/on_inserted()
	if(processing)
		START_PROCESSING(SSobj, src)

/// Called just before the object gets removed from the aquarium
/datum/aquarium_behaviour/proc/before_removal()
	return

/datum/aquarium_behaviour/Destroy(force, ...)
	STOP_PROCESSING(SSobj, src)
	parent = null
	return ..()

/datum/aquarium_behaviour/prop
	name = "aquarium prop"
	unique = TRUE
	layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

	// Prop sprites do not need any scaling they go 1:1
	sprite_width = 32
	sprite_height = 32
	source_width = 32
	source_height = 32

/datum/aquarium_behaviour/prop/rocks
	name = "rocks"
	icon_state = "rocks"

/datum/aquarium_behaviour/prop/seaweed_top
	name = "dense seaweeds"
	icon_state = "seaweeds_front"
	layer_mode = AQUARIUM_LAYER_MODE_TOP

/datum/aquarium_behaviour/prop/seaweed
	name = "seaweeds"
	icon_state = "seaweeds_back"
	layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

/datum/aquarium_behaviour/prop/rockfloor
	name = "rock floor"
	icon_state = "rockfloor"
	layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

/datum/aquarium_behaviour/prop/treasure
	name = "tiny treasure chest"
	icon_state = "treasure"
	layer_mode = AQUARIUM_LAYER_MODE_BOTTOM

/datum/aquarium_behaviour/fish
	name = "generic fish"
	icon_state = "fish_greyscale"
	randomize_position = TRUE //We have random starting point of our swim path

	current_animation = AQUARIUM_ANIMATION_FISH_SWIM
	processing = TRUE

	// Default size of the "greyscale_fish" icon_state
	sprite_height = 3
	sprite_width = 3

	/// Required fluid type for this fish to live.
	var/required_fluid_type = AQUARIUM_FLUID_FRESHWATER

	/// Required minimum temperature for the fish to live.
	var/required_temperature_min = MIN_AQUARIUM_TEMP
	/// Maximum possible temperature for the fish to live.
	var/required_temperature_max = MAX_AQUARIUM_TEMP

	/// What type of reagent this fish needs to be fed.
	var/food = /datum/reagent/consumable/nutriment
	/// How often the fish needs to be fed
	var/feeding_frequency = 5 MINUTES
	/// Time of last feedeing
	var/last_feeding

	/// Fish status
	var/status = FISH_ALIVE

	/// Current fish health. Dies at 0.
	var/health = 100

	/// Should this fish type show in fish catalog
	var/show_in_catalog = TRUE
	/// Should this fish spawn in random fish cases
	var/availible_in_random_cases = TRUE
	/// How rare this fish is in the random cases
	var/random_case_rarity = FISH_RARITY_BASIC

	/// Fish autogenerated from this behaviour will be processable into this
	var/fillet_type = /obj/item/food/fishmeat

	/// Won't breed more than this amount in single aquarium.
	var/stable_population = 1
	/// Last time new fish was created
	var/last_breeding
	/// How long it takes to produce new fish
	var/breeding_timeout = 2 MINUTES

/datum/aquarium_behaviour/fish/on_inserted()
	. = ..()
	if(isnull(last_feeding)) //Fish start fed.
		last_feeding = world.time
	if(status == FISH_DEAD)
		parent.current_aquarium.dead_fish += 1
	else
		parent.current_aquarium.alive_fish += 1
	parent.stop_flopping()

/datum/aquarium_behaviour/fish/before_removal()
	. = ..()
	if(status == FISH_DEAD)
		parent.current_aquarium.dead_fish -= 1
	else
		parent.current_aquarium.alive_fish -= 1
	//We do not stop processing properties here. We want fish to die outside of aquariums after first insert. We only stop processing in properties.death or destroy
	if(!QDELETED(parent) && status != FISH_DEAD)
		parent.start_flopping()

/datum/aquarium_behaviour/fish/on_fluid_changed()
	//In case we'll flop to bottom from this or go back to swimming.
	update_animation()

/// Updates our animation variable based on state and prompts component to animate it.
/datum/aquarium_behaviour/fish/update_animation()
	var/obj/structure/aquarium/aquarium = parent.current_aquarium
	var/old_animation = current_animation
	if(!aquarium || aquarium.fluid_type == AQUARIUM_FLUID_AIR || status == FISH_DEAD)
		current_animation = AQUARIUM_ANIMATION_FISH_DEAD
	else
		current_animation = AQUARIUM_ANIMATION_FISH_SWIM
	if(aquarium && old_animation != current_animation)
		parent.generate_animation()

/datum/aquarium_behaviour/fish/on_feeding(datum/reagents/feed_reagents)
	if(feed_reagents.has_reagent(food))
		last_feeding = world.time

/// Checks if our current environment lets us live.
/datum/aquarium_behaviour/fish/proc/proper_environment()
	var/obj/structure/aquarium/aquarium = parent.current_aquarium
	if(!aquarium)
		return FALSE
	if(aquarium.fluid_type != required_fluid_type)
		return FALSE
	if(aquarium.fluid_temp < required_temperature_min || aquarium.fluid_temp > required_temperature_max)
		return FALSE
	return TRUE

/datum/aquarium_behaviour/fish/process(delta_time)
	set waitfor = FALSE

	var/health_change_per_second = 0
	if(!proper_environment())
		health_change_per_second -= 3 //Dying here
	if(world.time - last_feeding >= feeding_frequency)
		health_change_per_second -= 0.5 //Starving
	else
		health_change_per_second += 0.5 //Slowly healing
	health = clamp(health + health_change_per_second * delta_time, 0, initial(health))
	if(health <= 0)
		death()
	else if(ready_to_reproduce())
		try_to_reproduce()

/datum/aquarium_behaviour/fish/proc/death()
	STOP_PROCESSING(SSobj, src)
	status = FISH_DEAD
	var/message = "<span class='notice'>\The [name] dies.</span>"
	if(parent.current_aquarium)
		parent.current_aquarium.visible_message(message)
		parent.current_aquarium.alive_fish -= 1
		parent.current_aquarium.dead_fish += 1
	else
		var/atom/movable/AM = parent.parent
		AM.visible_message(message)
	parent.stop_flopping()
	update_animation()

/datum/aquarium_behaviour/fish/proc/ready_to_reproduce()
	return parent.current_aquarium && parent.current_aquarium.allow_breeding && health == initial(health) && stable_population > 1 && world.time - last_breeding >= breeding_timeout

/datum/aquarium_behaviour/fish/proc/try_to_reproduce()
	if(!parent.current_aquarium)
		return
	if(parent.current_aquarium.alive_fish + parent.current_aquarium.dead_fish >= AQUARIUM_MAX_BREEDING_POPULATION) //so aquariums full of fish don't need to do these expensive checks
		return
	var/list/other_fish_of_same_type = list()
	for(var/atom/movable/fish_or_prop in parent.current_aquarium)
		if(fish_or_prop == parent.parent)
			continue
		var/datum/component/aquarium_content/other_content = fish_or_prop.GetComponent(/datum/component/aquarium_content)
		if(other_content && other_content.properties.type == type)
			other_fish_of_same_type += other_content.properties
	if(length(other_fish_of_same_type) >= stable_population)
		return
	var/datum/aquarium_behaviour/fish/second_fish
	for(var/datum/aquarium_behaviour/fish/other_fish in other_fish_of_same_type)
		if(other_fish.ready_to_reproduce())
			second_fish = other_fish
			break
	if(second_fish)
		generate_fish(parent.current_aquarium,type)
		last_breeding = world.time
		second_fish.last_breeding = world.time

/// This path exists mostly for admin abuse.
/datum/aquarium_behaviour/fish/auto
	name = "automatic fish"
	desc = "generates fish appearance automatically from component parent appearance"
	availible_in_random_cases = FALSE
	sprite_width = 8
	sprite_height = 8
	show_in_catalog = FALSE

/datum/aquarium_behaviour/fish/auto/apply_appearance(obj/effect/holder)
	holder.appearance = parent.parent
	holder.transform = base_transform()
	holder.dir = WEST
