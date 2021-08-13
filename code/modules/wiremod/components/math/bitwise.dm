/**
 * # Bitwise Component
 *
 * A component that preforms bitwise and, or and xor operations, as well as left shifts and right shifts
 * All input and output values are floored
 */
/obj/item/circuit_component/arbitrary_input_amount/bitwise
	display_name = "Bitwise"
	display_desc = "A component that operates on the bits of integers. Any decimal values are ignored."

	//The type of port to use
	port_type = PORT_TYPE_NUMBER

	/// The amount of input ports to have
	input_port_amount =  2

/obj/item/circuit_component/arbitrary_input_amount/bitwise/populate_options()
	var/static/component_options = list(
		COMP_BITWISE_AND,
		COMP_BITWISE_OR,
		COMP_BITWISE_XOR,
		COMP_BITWISE_LEFTSHIFT,
		COMP_BITWISE_RIGHTSHIFT,
	)
	options = component_options

/obj/item/circuit_component/arbitrary_input_amount/bitwise/calculate_output(datum/port/input/port, datum/port/input/first_port, list/ports)

	var/result = round(first_port.input_value)

	for(var/datum/port/input/input_port as anything in ports)
		var/value = input_port.input_value
		if(isnull(value))
			continue

		value = round(value)

		switch(current_option)
			if(COMP_BITWISE_AND)
				result &= value
			if(COMP_BITWISE_OR)
				result |= value
			if(COMP_BITWISE_XOR)
				result ^= value
			if(COMP_BITWISE_LEFTSHIFT)
				result = round(result * 2**value) //Bitshifts are done with powers of two instead of the >> and << operators to allow negative shifts
			if(COMP_BITWISE_RIGHTSHIFT)
				result = round(result * 2**(-value))

	return result
