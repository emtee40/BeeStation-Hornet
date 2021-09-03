/**
 * # Compact Remote
 *
 * A handheld device with several buttons.
 * In game, this translates to having different signals for normal usage, alt-clicking, and ctrl-clicking when in your hand.
 */
/obj/item/controller
	name = "controller"
	icon = 'icons/obj/wiremod.dmi'
	icon_state = "setup_small_calc"
	item_state = "electronic"
	//worn_icon_state = "electronic"	//remember to change it
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	light_range = FALSE

/obj/item/controller/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shell, list(
		new /obj/item/circuit_component/controller()
	), SHELL_CAPACITY_MEDIUM)

/obj/item/circuit_component/controller
	display_name = "Controller"
	desc = "Used to receive inputs from the controller shell. Use the shell in hand to trigger the output signal. Alt-click for the alternate signal. Right click for the extra signal."

	/// The three separate buttons that are called in attack_hand on the shell.
	var/datum/port/output/signal
	var/datum/port/output/alt
	var/datum/port/output/right

	/// The entity output
	var/datum/port/output/entity

/obj/item/circuit_component/controller/populate_ports()
	entity = add_output_port("User", PORT_TYPE_ATOM)
	signal = add_output_port("Signal", PORT_TYPE_SIGNAL)
	alt = add_output_port("Alternate Signal", PORT_TYPE_SIGNAL)
	right = add_output_port("Extra Signal", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/controller/register_shell(atom/movable/shell)
	RegisterSignal(shell, COMSIG_ITEM_ATTACK_SELF, .proc/send_trigger)
	RegisterSignal(shell, COMSIG_CLICK_ALT, .proc/send_alternate_signal)

/obj/item/circuit_component/controller/unregister_shell(atom/movable/shell)
	UnregisterSignal(shell, list(
		COMSIG_ITEM_ATTACK_SELF,
		COMSIG_CLICK_ALT,
	))

/**
 * Called when the shell item is used in hand
 */
/obj/item/circuit_component/controller/proc/send_trigger(atom/source, mob/user)
	SIGNAL_HANDLER
	if(!user.Adjacent(source))
		return
	source.balloon_alert(user, "Clicked the primary button.")
	playsound(source, get_sfx("terminal_type"), 25, FALSE)
	entity.set_output(user)
	signal.set_output(COMPONENT_SIGNAL)

/**
 * Called when the shell item is alt-clicked
 */
/obj/item/circuit_component/controller/proc/send_alternate_signal(atom/source, mob/user)
	SIGNAL_HANDLER
	if(!user.Adjacent(source))
		return
	source.balloon_alert(user, "Clicked the alternate button.")
	playsound(source, get_sfx("terminal_type"), 25, FALSE)
	entity.set_output(user)
	alt.set_output(COMPONENT_SIGNAL)
	return COMPONENT_INTERCEPT_ALT

/**
 * Called when the shell item is right-clicked in active hand
 */
/obj/item/circuit_component/controller/proc/send_right_signal(atom/source, mob/user)
	SIGNAL_HANDLER
	if(!user.Adjacent(source))
		return
	source.balloon_alert(user, "Clicked the extra button.")
	playsound(source, get_sfx("terminal_type"), 25, FALSE)
	entity.set_output(user)
	right.set_output(COMPONENT_SIGNAL)
