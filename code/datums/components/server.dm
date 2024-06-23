// Server component
// will generate a heat based on the power usage of the machine
// use only with /obj/machinery



/datum/component/server

	var/efficiency = 1 // 0 to 1 range

	var/temperature = T20C // current temperature
	var/warning_temp = T0C + 50 // 50C
	var/overheated_temp = T0C + 100 // 100C - temperature at which the server stops working
	var/heat_capacity = 2500 // Used for auxmos heat transfer

	var/heat_generation = 0 // heat generated by the machine

	// if it sparks when overheated
	var/sparks = TRUE
	COOLDOWN_DECLARE(spark_cooldown)
	var/sparks_cooldown_time = 10 SECONDS

/datum/component/server/Initialize()
	if(!ismachinery(parent)) // currently only compatible with machinery
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_MACHINERY_POWER_USED, PROC_REF(ParentPowerUsed))
	START_PROCESSING(SSservers, src)

/datum/component/server/proc/ParentPowerUsed(source, amount, chan)
	heat_generation += amount * 1000

// server is overheated and doesn't work
/datum/component/server/proc/overheated(is_overheated)
	if(is_overheated && sparks && COOLDOWN_FINISHED(src, spark_cooldown))
		do_sparks(5, FALSE, parent)
		COOLDOWN_START(src, spark_cooldown, sparks_cooldown_time)

	SEND_SIGNAL(parent, COMSIG_MACHINERY_OVERHEAT_CHANGE, is_overheated)

/datum/component/server/process(delta_time)
	var/obj/machinery/parent_machine = parent
	calculate_temperature()
	if(temperature > overheated_temp)
		if(!(parent_machine.machine_stat & OVERHEATED))
			overheated(TRUE)
			parent_machine.set_machine_stat(parent_machine.machine_stat | OVERHEATED)
			return
		efficiency = 0
	else
		if(parent_machine.machine_stat & OVERHEATED)
			overheated(FALSE)
		parent_machine.set_machine_stat(parent_machine.machine_stat & ~OVERHEATED)
		var/efficiency_change = ((temperature - T20C) / (overheated_temp - T20C))
		efficiency = clamp(1 - efficiency_change, 0, 1)
		temperature += heat_generation / heat_capacity
		heat_generation = 0

/datum/component/server/proc/calculate_temperature()
	var/turf/turf = get_turf(parent)
	if(!turf)
		return FALSE
	var/datum/gas_mixture/environment = turf.return_air()

	temperature = environment.temperature_share(null, OPEN_HEAT_TRANSFER_COEFFICIENT, temperature, heat_capacity)
