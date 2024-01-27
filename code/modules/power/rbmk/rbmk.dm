#define COOLANT_INPUT_GATE airs[1]
#define MODERATOR_INPUT_GATE airs[2]
#define COOLANT_OUTPUT_GATE airs[3]

#define RBMK_TEMPERATURE_OPERATING 640 //Celsius
#define RBMK_TEMPERATURE_CRITICAL 800 //At this point the entire ship is alerted to a meltdown. This may need altering
#define RBMK_TEMPERATURE_MELTDOWN 900

#define RBMK_NO_COOLANT_TOLERANCE 5 //How many process()ing ticks the reactor can sustain without coolant before slowly taking damage

#define RBMK_PRESSURE_OPERATING 1000 //PSI
#define RBMK_PRESSURE_WARNING 1200 //PSI
#define RBMK_PRESSURE_CRITICAL 1469.59 //PSI

#define RBMK_MAX_CRITICALITY 3 //No more criticality than N for now.

#define RBMK_POWER_FLAVOURISER 8000 //To turn those KWs into something usable

#define REACTOR_COUNTDOWN_TIME 30 SECONDS

//Reference: Heaters go up to 500K.
//Hot plasmaburn: 14164.95 C.

/**

What is this?

Moderators list (Not gonna keep this accurate forever):
Fuel Type:
Oxygen: Power production multiplier. Allows you to run a low plasma, high oxy mix, and still get a lot of power.
Plasma: Power production gas. More plasma -> more power, but it enriches your fuel and makes the reactor much, much harder to control.
Tritium: Extremely efficient power production gas. Will cause chernobyl if used improperly.

Moderation Type:
N2: Helps you regain control of the reaction by increasing control rod effectiveness, will massively boost the rad production of the reactor.
CO2: Super effective shutdown gas for runaway reactions. MASSIVE RADIATION PENALTY!
Pluoxium: Same as N2, but no cancer-rads!

Permeability Type:
BZ: Increases your reactor's ability to transfer its heat to the coolant, thus letting you cool it down faster (but your output will get hotter)
Water Vapour: More efficient permeability modifier
Hyper Noblium: Extremely efficient permeability increase. (10x as efficient as bz)

Depletion type:
Nitryl: When you need weapons grade plutonium yesterday. Causes your fuel to deplete much, much faster. Not a huge amount of use outside of sabotage.

Sabotage:

Meltdown:
Flood reactor moderator with plasma, they won't be able to mitigate the reaction with control rods.
Shut off coolant entirely. Raise control rods.
Swap all fuel out with spent fuel, as it's way stronger.

Blowout:
Shut off exit valve for quick overpressure.
Cause a pipefire in the coolant line (LETHAL).
Tack heater onto coolant line (can also cause straight meltdown)

Tips:
Be careful to not exhaust your plasma supply. I recommend you DON'T max out the moderator input when youre running plasma + o2, or you're at a tangible risk of running out of those gasses from atmos.
The reactor CHEWS through moderator. It does not do this slowly. Be very careful with that!

*/

//Remember kids. If the reactor itself is not physically powered by an APC, it cannot shove coolant in!

/obj/item/book/manual/wiki/rbmk
	name = "\improper Haynes nuclear reactor owner's manual"
	icon_state ="bookEngineering2"
	author = "CogWerk Engineering Reactor Design Department"
	title = "Haynes nuclear reactor owner's manual"
	page_link = "Guide_to_the_Nuclear_Reactor"

/obj/machinery/atmospherics/components/trinary/nuclear_reactor
	name = "\improper Advanced Gas-Cooled Nuclear Reactor"
	desc = "A tried and tested design which can output stable power at an acceptably low risk. The moderator can be changed to provide different effects."
	icon = 'icons/obj/machines/rbmk.dmi'
	icon_state = "reactor_map"
	pixel_x = -32
	pixel_y = -32
	density = FALSE //It burns you if you're stupid enough to walk over it.
	anchored = TRUE
	processing_flags = START_PROCESSING_MANUALLY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	light_color = LIGHT_COLOR_CYAN
	dir = 8 //Less headache inducing :))
	circuit = /obj/item/circuitboard/machine/rbmk
	var/id = "default_reactor_for_lazy_mappers" //Change me mappers
	//Variables essential to operation
	var/temperature =  0//Lose control of this -> Meltdown
	var/vessel_integrity = 400 //How long can the reactor withstand overpressure / meltdown? This gives you a fair chance to react to even a massive pipe fire
	var/pressure = 0 //Lose control of this -> Blowout
	var/K = 0 //Rate of reaction.
	var/desired_k = 0
	var/control_rod_effectiveness = 0.65 //Starts off with a lot of control over K. If you flood this thing with plasma, you lose your ability to control K as easily.
	var/power = 0 //0-100%. A function of the maximum heat you can achieve within operating temperature
	var/power_modifier = 1 //Upgrade me with parts, science! Flat out increase to physical power output when loaded with plasma.
	var/list/fuel_rods = list()
	//Secondary variables.
	var/next_slowprocess = 0
	var/gas_absorption_effectiveness = 0.5
	var/gas_absorption_constant = 0.5 //We refer to this one as it's set on init, randomized.
	var/minimum_coolant_level = 5
	var/warning = FALSE //Have we begun warning the crew of their impending death?
	var/next_warning = 0 //To avoid spam.
	var/last_power_produced = 0 //For logging purposes
	var/next_flicker = 0 //Light flicker timer
	var/base_power_modifier = RBMK_POWER_FLAVOURISER
	var/slagged = FALSE //Is this reactor even usable any more?
	//Console statistics.
	var/last_coolant_temperature = 0
	var/last_output_temperature = 0
	var/last_heat_delta = 0 //For administrative cheating only. Knowing the delta lets you know EXACTLY what to set K at.
	var/no_coolant_ticks = 0	//How many times in succession did we not have enough coolant? Decays twice as fast as it accumulates.
	//Alarm Stuffs.
	var/datum/looping_sound/rbmk/alarm
	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_eng
	var/engineering_channel = "Engineering"
	var/common_channel = null
	//Miscellaneous
	var/static/reactorcount = 0
	var/lastwarning = 0
	can_unwrench = 1

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/preset
	id = "default_reactor_for_lazy_mappers"
//Use this in your maps if you want everything to be preset.
/obj/machinery/atmospherics/components/trinary/nuclear_reactor/preset/Initialize(mapload)
	. = ..()
	var/obj/machinery/atmospherics/pipe/simple/general/hidden/pipe1 = new /obj/machinery/atmospherics/pipe/simple/general/hidden(locate(x-1,y,z))
	pipe1.dir = 8
	pipe1.layer = 3
	var/obj/machinery/atmospherics/pipe/simple/general/hidden/pipe2 = new /obj/machinery/atmospherics/pipe/simple/general/hidden(locate(x+1,y,z))
	pipe2.dir = 8
	pipe2.layer = 3
	var/obj/machinery/atmospherics/pipe/simple/general/hidden/pipe3 = new /obj/machinery/atmospherics/pipe/simple/general/hidden(locate(x,y+1,z))
	pipe3.dir = 1
	pipe3.layer = 3

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/destroyed
	icon_state = "reactor_slagged"
	slagged = TRUE
	vessel_integrity = 0


/obj/machinery/atmospherics/components/trinary/nuclear_reactor/Destroy()
	QDEL_NULL(alarm)
	QDEL_NULL(radio)
	qdel(src)
	. = ..()

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/examine(mob/user)
	. = ..()
	if(Adjacent(src, user))
		if(do_after(user, 1 SECONDS, target=src))
			var/percent = vessel_integrity / initial(vessel_integrity) * 100
			var/msg = "<span class='warning'>The reactor looks operational.</span>"
			switch(percent)
				if(0 to 10)
					msg = "<span class='boldwarning'>[src]'s seals are dangerously warped and you can see cracks all over the reactor vessel! </span>"
				if(10 to 40)
					msg = "<span class='boldwarning'>[src]'s seals are heavily warped and cracked! </span>"
				if(40 to 60)
					msg = "<span class='warning'>[src]'s seals are holding, but barely. You can see some micro-fractures forming in the reactor vessel.</span>"
				if(60 to 80)
					msg = "<span class='warning'>[src]'s seals are in-tact, but slightly worn. There are no visible cracks in the reactor vessel.</span>"
				if(80 to 90)
					msg = "<span class='notice'>[src]'s seals are in good shape, and there are no visible cracks in the reactor vessel.</span>"
				if(95 to 100)
					msg = "<span class='notice'>[src]'s seals look factory new, and the reactor's in excellent shape.</span>"
			. += msg

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/fuel_rod))
		if(power >= 20)
			to_chat(user, "<span class='notice'>You cannot insert fuel into [src] when it has been raised above 20% power.</span>")
			return FALSE
		if(fuel_rods.len >= 5)
			to_chat(user, "<span class='warning'>[src] is already at maximum fuel load.</span>")
			return FALSE
		to_chat(user, "<span class='notice'>You start to insert [W] into [src]...</span>")
		radiation_pulse(src, temperature)
		if(do_after(user, 5 SECONDS, target=src))
			if(!length(fuel_rods))
				start_up() //That was the first fuel rod. Let's heat it up.
			fuel_rods += W
			W.forceMove(src)
			radiation_pulse(src, temperature) //Wear protective equipment when even breathing near a reactor!
		return TRUE
	if(!slagged && istype(W, /obj/item/sealant))
		if(power >= 20)
			to_chat(user, "<span class='notice'>You cannot repair [src] while it is running at above 20% power.</span>")
			return FALSE
		if(vessel_integrity >= 0.875*initial(vessel_integrity))
			to_chat(user, "<span class='notice'>[src]'s seals are already in-tact, repairing them further would require a new set of seals.</span>")
			return FALSE
		if(vessel_integrity <= 0.5 * initial(vessel_integrity)) //Heavily damaged.
			to_chat(user, "<span class='notice'>[src]'s reactor vessel is cracked and worn, you need to repair the cracks with a welder before you can repair the seals.</span>")
			return FALSE
		if(do_after(user, 5 SECONDS, target=src))
			if(vessel_integrity >= 0.875*initial(vessel_integrity))	//They might've stacked doafters
				to_chat(user, "<span class='notice'>[src]'s seals are already in-tact, repairing them further would require a new set of seals.</span>")
				return FALSE
			playsound(src, 'sound/effects/spray2.ogg', 50, 1, -6)
			user.visible_message("<span class='warning'>[user] applies sealant to some of [src]'s worn out seals.</span>", "<span class='notice'>You apply sealant to some of [src]'s worn out seals.</span>")
			vessel_integrity += 10
			vessel_integrity = clamp(vessel_integrity, 0, initial(vessel_integrity))
		return TRUE
	return ..()

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/welder_act(mob/living/user, obj/item/I)
	if(slagged)
		to_chat(user, "<span class='notice'>You can't repair [src], it's completely slagged!</span>")
		return FALSE
	if(power >= 20)
		to_chat(user, "<span class='notice'>You can't repair [src] while it is running at above 20% power.</span>")
		return FALSE
	if(vessel_integrity > 0.5 * initial(vessel_integrity))
		to_chat(user, "<span class='notice'>[src] is free from cracks. Further repairs must be carried out with flexi-seal sealant.</span>")
		return FALSE
	if(I.use_tool(src, user, 0, volume=40))
		if(vessel_integrity > 0.5 * initial(vessel_integrity))
			to_chat(user, "<span class='notice'>[src] is free from cracks. Further repairs must be carried out with flexi-seal sealant.</span>")
			return FALSE
		vessel_integrity += 20
		to_chat(user, "<span class='notice'>You weld together some of [src]'s cracks. This'll do for now.</span>")
	return TRUE

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/wrench_act(mob/user, obj/item/tool)
	if(anchored)
		if(power >= 5)
			balloon_alert(user, "You can't unwrench the reactor when it has been raised above 5% power!")
			return
		if(tool.use_tool(src, user, 40, volume=100))
			anchored = FALSE
	else
		if(tool.use_tool(src, user, 40, volume=100))
			anchored = TRUE

//Admin procs to mess with the reaction environment.

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/lazy_startup()
	slagged = FALSE
	for(var/I=0;I<5;I++)
		fuel_rods += new /obj/item/fuel_rod(src)
	start_up()

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/deplete()
	for(var/obj/item/fuel_rod/FR in fuel_rods)
		FR.depletion = 100

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/Initialize(mapload)
	. = ..()
	icon_state = "reactor_off"
	reactorcount++
	src.name = name + " ([reactorcount])"
	gas_absorption_effectiveness = rand(5, 6)/10 //All reactors are slightly different. This will result in you having to figure out what the balance is for K.
	gas_absorption_constant = gas_absorption_effectiveness //And set this up for the rest of the round.
	alarm = new(src, FALSE)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	AddElement(/datum/element/point_of_interest)
	radio = new(src)
	radio.keyslot = new radio_key
	radio.listening = 0
	radio.recalculateChannels()
	piping_layer = PIPING_LAYER_DEFAULT

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/on_construction()
	var/obj/item/circuitboard/machine/rbmk/board = circuit
	if(board)
		piping_layer = board.pipe_layer
	return ..(dir, piping_layer)

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/on_entered(datum/source, atom/movable/AM, oldloc)
	SIGNAL_HANDLER

	if(isliving(AM) && temperature > 0)
		var/mob/living/L = AM
		L.adjust_bodytemperature(clamp(temperature, BODYTEMP_COOLING_MAX, BODYTEMP_HEATING_MAX)) //If you're on fire, you heat up!

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/process()
	update_parents() //Update the pipenet to register new gas mixes
	if(next_slowprocess < world.time)
		slowprocess()
		next_slowprocess = world.time + 1 SECONDS //Set to wait for another second before processing again, we don't need to process more than once a second

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/has_fuel()
	return length(fuel_rods)

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/slowprocess()
	if(slagged)
		STOP_PROCESSING(SSmachines, src)
		return


	//Let's get our gasses sorted out.
	var/datum/gas_mixture/coolant_input = COOLANT_INPUT_GATE
	var/datum/gas_mixture/moderator_input = MODERATOR_INPUT_GATE
	var/datum/gas_mixture/coolant_output = COOLANT_OUTPUT_GATE

	//Firstly, heat up the reactor based off of K.
	var/input_moles = coolant_input.total_moles() //Firstly. Do we have enough moles of coolant?
	if(input_moles >= minimum_coolant_level)
		last_coolant_temperature = coolant_input.return_temperature()-273.15
		//Important thing to remember, once you slot in the fuel rods, this thing will not stop making heat, at least, not unless you can live to be thousands of years old which is when the spent fuel finally depletes fully.
		var/heat_delta = ((coolant_input.return_temperature()-273.15) / 100) * gas_absorption_effectiveness //Take in the gas as a cooled input, cool the reactor a bit. The optimum, 100% balanced reaction sits at K=1, coolant input temp of 200K / -73 celsius.
		last_heat_delta = heat_delta
		temperature += heat_delta
		coolant_output.merge(coolant_input) //And now, shove the input into the output.
		coolant_input.clear() //Clear out anything left in the input gate.
		color = null
		no_coolant_ticks = max(0, no_coolant_ticks-2)	//Needs half as much time to recover the ticks than to acquire them
	else
		if(has_fuel())
			no_coolant_ticks++
			if(no_coolant_ticks > RBMK_NO_COOLANT_TOLERANCE)
				temperature += temperature / 500 //This isn't really harmful early game, but when your reactor is up to full power, this can get out of hand quite quickly.
				vessel_integrity -= temperature / 200 //Think fast loser.
				take_damage(10) //Just for the sound effect, to let you know you've fucked up.

	//Now, heat up the output and set our pressure.
	coolant_output.set_temperature(temperature+273.15) //Heat the coolant output gas that we just had pass through us.
	last_output_temperature = coolant_output.return_temperature()-273.15
	pressure = coolant_output.return_pressure()/6.895
	power = (temperature / RBMK_TEMPERATURE_CRITICAL) * 100
	var/radioactivity_spice_multiplier = 1 //Some gasses make the reactor a bit spicy.
	var/depletion_modifier = 0.035 //How rapidly do your rods decay
	gas_absorption_effectiveness = gas_absorption_constant
	//Next up, handle moderators!
	if(moderator_input.total_moles() >= minimum_coolant_level)
		var/total_fuel_moles = moderator_input.get_moles(GAS_PLASMA) + (moderator_input.get_moles(GAS_NITROUS)*2)+ (moderator_input.get_moles(GAS_TRITIUM)*10) //n2o is 50% more efficient as fuel than plasma, but is harder to produce
		var/power_modifier = max((moderator_input.get_moles(GAS_O2) / moderator_input.total_moles() * 10), 1) //You can never have negative IPM. For now.
		if(total_fuel_moles >= minimum_coolant_level) //You at least need SOME fuel.
			var/power_produced = max((total_fuel_moles / moderator_input.total_moles() * 10), 1)
			last_power_produced = max(0,((power_produced*power_modifier)*moderator_input.total_moles()))
			last_power_produced *= (max(0,power)/100) //Aaaand here comes the cap. Hotter reactor => more power.
			last_power_produced *= base_power_modifier //Finally, we turn it into actual usable numbers.
			radioactivity_spice_multiplier += moderator_input.get_moles(GAS_TRITIUM) / 5 //Chernobyl 2.
			if(power >= 20)
				coolant_output.adjust_moles(GAS_TRITIUM, total_fuel_moles/20) //Shove out tritium into the air when it's fuelled. You need to filter this off, or you're gonna have a bad time.
			var/turf/T = get_turf(src)
			var/obj/structure/cable/C = T.get_cable_node()
			if (!C)
				return
			C.get_connections()
			C.add_avail(last_power_produced)

		var/total_control_moles = moderator_input.get_moles(GAS_N2) + (moderator_input.get_moles(GAS_CO2)*2) + (moderator_input.get_moles(GAS_PLUOXIUM)*3) //N2 helps you control the reaction at the cost of making it absolutely blast you with rads. Pluoxium has the same effect but without the rads!
		if(total_control_moles >= minimum_coolant_level)
			var/control_bonus = total_control_moles / 250 //1 mol of n2 -> 0.002 bonus control rod effectiveness, if you want a super controlled reaction, you'll have to sacrifice some power.
			control_rod_effectiveness = initial(control_rod_effectiveness) + control_bonus
			radioactivity_spice_multiplier += moderator_input.get_moles(GAS_N2) / 25 //An example setup of 50 moles of n2 (for dealing with spent fuel) leaves us with a radioactivity spice multiplier of 3.
			radioactivity_spice_multiplier += moderator_input.get_moles(GAS_CO2) / 12.5
		var/total_permeability_moles = moderator_input.get_moles(GAS_BZ) + (moderator_input.get_moles(GAS_H2O)*2) + (moderator_input.get_moles(GAS_HYPERNOB)*10)
		if(total_permeability_moles >= minimum_coolant_level)
			var/permeability_bonus = total_permeability_moles / 500
			gas_absorption_effectiveness = gas_absorption_constant + permeability_bonus
		var/total_degradation_moles = moderator_input.get_moles(GAS_NITRYL) //Because it's quite hard to get.
		if(total_degradation_moles >= minimum_coolant_level*0.5) //I'll be nice.
			depletion_modifier += total_degradation_moles / 15 //Oops! All depletion. This causes your fuel rods to get SPICY.
			playsound(src, pick('sound/machines/sm/accent/normal/1.ogg','sound/machines/sm/accent/normal/2.ogg','sound/machines/sm/accent/normal/3.ogg','sound/machines/sm/accent/normal/4.ogg','sound/machines/sm/accent/normal/5.ogg'), 100, TRUE)
		//From this point onwards, we clear out the remaining gasses.
		moderator_input.clear() //Woosh. And the soul is gone.
		K += total_fuel_moles / 1000
	var/fuel_power = 0 //So that you can't magically generate K with your control rods.
	if(!has_fuel())  //Reactor must be fuelled and ready to go before we can heat it up boys.
		K = 0
	else
		for(var/obj/item/fuel_rod/FR in fuel_rods)
			K += FR.fuel_power
			fuel_power += FR.fuel_power
			FR.deplete(depletion_modifier)
	//Firstly, find the difference between the two numbers.
	var/difference = abs(K - desired_k)
	//Then, hit as much of that goal with our cooling per tick as we possibly can.
	difference = clamp(difference, 0, control_rod_effectiveness) //And we can't instantly zap the K to what we want, so let's zap as much of it as we can manage....
	if(difference > fuel_power && desired_k > K)
		difference = fuel_power //Again, to stop you being able to run off of 1 fuel rod.
	if(K != desired_k)
		if(desired_k > K)
			K += difference
		else if(desired_k < K)
			K -= difference

	K = clamp(K, 0, RBMK_MAX_CRITICALITY)
	if(has_fuel())
		temperature += K
	else
		temperature -= 10 //Nothing to heat us up, so.
	handle_alerts() //Let's check if they're about to die, and let them know.
	update_icon()
	radiation_pulse(src, temperature*radioactivity_spice_multiplier)
	if(power >= 90 && world.time >= next_flicker) //You're overloading the reactor. Give a more subtle warning that power is getting out of control.
		next_flicker = world.time + 1 MINUTES
		for(var/obj/machinery/light/L in GLOB.machines)
			if(prob(75)) //If youre running the reactor cold though, no need to flicker the lights.
				L.flicker()
	for(var/atom/movable/I in get_turf(src))
		if(isliving(I))
			var/mob/living/L = I
			if(temperature > 0)
				L.adjust_bodytemperature(clamp(temperature, BODYTEMP_COOLING_MAX, BODYTEMP_HEATING_MAX)) //If you're on fire, you heat up!
		if(istype(I, /obj/item/reagent_containers/food) && !istype(I, /obj/item/reagent_containers/food/drinks))
			playsound(src, pick('sound/machines/fryer/deep_fryer_1.ogg', 'sound/machines/fryer/deep_fryer_2.ogg'), 100, TRUE)
			var/obj/item/reagent_containers/food/grilled_item = I
			if(prob(80))
				return //To give the illusion that it's actually cooking omegalul.
			switch(power)
				if(20 to 39)
					grilled_item.name = "grilled [initial(grilled_item.name)]"
					grilled_item.desc = "[initial(I.desc)] It's been grilled over a nuclear reactor."
					if(!(grilled_item.foodtype & FRIED))
						grilled_item.foodtype |= FRIED
				if(40 to 70)
					grilled_item.name = "heavily grilled [initial(grilled_item.name)]"
					grilled_item.desc = "[initial(I.desc)] It's been heavily grilled through the magic of nuclear fission."
					if(!(grilled_item.foodtype & FRIED))
						grilled_item.foodtype |= FRIED
				if(70 to 95)
					grilled_item.name = "Three-Mile Nuclear-Grilled [initial(grilled_item.name)]"
					grilled_item.desc = "A [initial(grilled_item.name)]. It's been put on top of a nuclear reactor running at extreme power by some badass engineer."
					if(!(grilled_item.foodtype & FRIED))
						grilled_item.foodtype |= FRIED
				if(95 to INFINITY)
					grilled_item.name = "Ultimate Meltdown Grilled [initial(grilled_item.name)]"
					grilled_item.desc = "A [initial(grilled_item.name)]. A grill this perfect is a rare technique only known by a few engineers who know how to perform a 'controlled' meltdown whilst also having the time to throw food on a reactor. I'll bet it tastes amazing."
					if(!(grilled_item.foodtype & FRIED))
						grilled_item.foodtype |= FRIED

//Method to handle sound effects, reactor warnings, all that jazz.
/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/handle_alerts()
	var/alert = FALSE //If we have an alert condition, we'd best let people know.
	var/turf/T = get_turf(src)
	var/rbmkzlevel = T.get_virtual_z_level()
	var/offset = prob(50) ? -2 : 2
	if(K <= 0 && temperature <= 0)
		shut_down()
	//First alert condition: Overheat
	if(temperature >= RBMK_TEMPERATURE_CRITICAL)
		alert = TRUE
		alertEngineers()
		if(temperature >= RBMK_TEMPERATURE_MELTDOWN)
			var/temp_damage = min(temperature/100, initial(vessel_integrity)/40)	//40 seconds to meltdown from full integrity, worst-case. Bit less than blowout since it's harder to spike heat that much.
			vessel_integrity -= temp_damage
			if(vessel_integrity <= temp_damage) //It wouldn't be able to tank another hit.
				meltdown() //Oops! All meltdown
				return
	else
		alert = FALSE
	if(temperature < -200) //That's as cold as I'm letting you get it, engineering.
		color = COLOR_CYAN
		temperature = -200
	else
		color = null
	//Second alert condition: Overpressurized (the more lethal one)
	if(pressure >= RBMK_PRESSURE_CRITICAL)
		alert = TRUE
		animate(src, pixel_x = pixel_x + offset, time = 0.2, loop = 200) //start shaking
		alertEngineers()
		playsound(loc, 'sound/machines/clockcult/steam_whoosh.ogg', 100, TRUE)
		T.atmos_spawn_air("water_vapor=[pressure/100];TEMP=[temperature+273.15]")
		// Warning: Pressure reaching critical thresholds!
		var/pressure_damage = min(pressure/100, initial(vessel_integrity)/45)	//You get 45 seconds (if you had full integrity), worst-case. But hey, at least it can't be instantly nuked with a pipe-fire.. though it's still very difficult to save.
		vessel_integrity -= pressure_damage
		if(vessel_integrity <= pressure_damage) //It wouldn't be able to tank another hit.
			blowout()
			return

	if(!rbmkzlevel) //Can't be bothered to do this any other way ;)
		return

	// Warning alarm variable is used to make sure the alarm is not overlapping.  var/warning
	// To turn the alarm on or off = var/alert

	if (alert)
		if (warning)
			return
		else
			alarm.start()
			set_light(0)
			light_color = LIGHT_COLOR_RED
			set_light(10)
			warning = TRUE
	else
		alarm.stop()
		set_light(0)
		light_color = LIGHT_COLOR_BLUE
		set_light(10)
		warning = FALSE

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/alertEngineers()
	if((REALTIMEOFDAY - lastwarning) / 10 >= WARNING_DELAY)
		if(temperature >= RBMK_TEMPERATURE_CRITICAL)
			radio.talk_into(src, "Warning: Reactor overpressurized. Blowout imminent.", engineering_channel, language = get_selected_language())
			SEND_SIGNAL(src, COMSIG_SUPERMATTER_DELAM_ALARM)
			lastwarning = REALTIMEOFDAY - (WARNING_DELAY * 5)
		if(pressure >= RBMK_PRESSURE_CRITICAL)
			radio.talk_into(src, "Warning: Reactor overheating. Nuclear meltdown imminent.", engineering_channel, language = get_selected_language())
			SEND_SIGNAL(src, COMSIG_SUPERMATTER_DELAM_ALARM)
			lastwarning = REALTIMEOFDAY - (WARNING_DELAY * 5)



//Failure condition 1: Meltdown. Achieved by having heat go over tolerances. This is less devastating because it's easier to achieve.
//Results: Engineering becomes unusable and your engine irreparable
/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/meltdown()
	set waitfor = FALSE
	SSair.atmos_machinery -= src //Annd we're now just a useless brick.
	slagged = TRUE
	update_icon()
	STOP_PROCESSING(SSmachines, src)
	icon_state = "reactor_slagged"
	AddComponent(/datum/component/radioactive, 15000 , src)
	var/obj/modules/power/rbmk/nuclear_sludge_spawner/NSW = new /obj/modules/power/rbmk/nuclear_sludge_spawner/strong(get_turf(src))
	var/turf/T = get_turf(src)
	var/rbmkzlevel = T.get_virtual_z_level()
	for(var/mob/M in GLOB.player_list)
		if(M.get_virtual_z_level() == rbmkzlevel)
			SEND_SOUND(M, 'sound/effects/rbmk/meltdown.ogg')
			to_chat(M, "<span class='userdanger'>You hear a horrible metallic hissing.</span>")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "delam", /datum/mood_event/delam) //Might as well use the same moodlet since its essentialy the same thing happening

	NSW.fire() //This will take out engineering for a decent amount of time as they have to clean up the sludge.
	for(var/obj/machinery/power/apc/A in GLOB.apcs_list)
		if(src.get_virtual_z_level() == A.get_virtual_z_level() && prob(70))
			A.overload_lighting()
	var/datum/gas_mixture/coolant_input = COOLANT_INPUT_GATE
	var/datum/gas_mixture/moderator_input = MODERATOR_INPUT_GATE
	var/datum/gas_mixture/coolant_output = COOLANT_OUTPUT_GATE
	coolant_input.set_temperature((temperature+273.15)*2)
	moderator_input.set_temperature((temperature+273.15)*2)
	coolant_output.set_temperature((temperature+273.15)*2)
	T.assume_air(coolant_input)
	T.assume_air(moderator_input)
	T.assume_air(coolant_output)
	Destroy()
	alarm.stop()
	explosion(get_turf(src), 0, 5, 10, 20, TRUE, TRUE)
	empulse(get_turf(src), 20, 30)
	SSblackbox.record_feedback("tally", "engine_stats", 1, "failed")
	SSblackbox.record_feedback("tally", "engine_stats", 1, "agcnr")

//Failure condition 2: Blowout. Achieved by reactor going over-pressured. This is a round-ender because it requires more fuckery to achieve.
/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/blowout()
	explosion(get_turf(src), GLOB.MAX_EX_DEVESTATION_RANGE, GLOB.MAX_EX_HEAVY_RANGE, GLOB.MAX_EX_LIGHT_RANGE, GLOB.MAX_EX_FLASH_RANGE)
	meltdown() //Double kill.
	var/turf/T = get_turf(src)
	var/rbmkzlevel = T.get_virtual_z_level()
	for(var/mob/M in GLOB.player_list)
		if(M.get_virtual_z_level() == rbmkzlevel)
			SEND_SOUND(M, 'sound/effects/rbmk/explode.ogg')
			to_chat(M, "<span class='userdanger'>You hear a horrible metallic explosion.</span>")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "delam", /datum/mood_event/delam) //Might as well use the same moodlet since its essentialy the same thing happening
	for(var/X in GLOB.landmarks_list)
		if(istype(X, /obj/modules/power/rbmk/nuclear_sludge_spawner))
			var/obj/modules/power/rbmk/nuclear_sludge_spawner/WS = X
			if(src.get_virtual_z_level() == WS.get_virtual_z_level()) //Begin the SLUDGING
				WS.fire()

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/update_icon()
	icon_state = "reactor_off"
	switch(temperature)
		if(0 to 200)
			icon_state = "reactor_on"
		if(200 to RBMK_TEMPERATURE_OPERATING)
			icon_state = "reactor_hot"
		if(RBMK_TEMPERATURE_OPERATING to 750)
			icon_state = "reactor_veryhot"
		if(750 to RBMK_TEMPERATURE_CRITICAL) //Point of no return.
			icon_state = "reactor_overheat"
		if(RBMK_TEMPERATURE_CRITICAL to INFINITY)
			icon_state = "reactor_meltdown"
	if(!has_fuel())
		icon_state = "reactor_off"
	if(slagged)
		icon_state = "reactor_slagged"


//Startup, shutdown

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/start_up()
	if(slagged)
		return // No :)
	START_PROCESSING(SSmachines, src)
	desired_k = 1
	can_unwrench = 0
	set_light(10)
	var/startup_sound = pick('sound/effects/rbmk/startup.ogg', 'sound/effects/rbmk/startup2.ogg')
	playsound(loc, startup_sound, 50)
	SSblackbox.record_feedback("tally", "engine_stats", 1, "agcnr")
	SSblackbox.record_feedback("tally", "engine_stats", 1, "started")

//Shuts off the fuel rods, ambience, etc. Keep in mind that your temperature may still go up!
/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/shut_down()
	STOP_PROCESSING(SSmachines, src)
	set_light(0)
	K = 0
	can_unwrench = 1
	desired_k = 0
	temperature = 0
	update_icon()

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/proc/get_status()
	var/turf/T = get_turf(src)
	if(!T)
		return NUCLEAR_REACTOR_ERROR
	if(warning)
		return SUPERMATTER_DELAMINATING
	return NUCLEAR_REACTOR_INACTIVE

/obj/item/fuel_rod/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddComponent(/datum/component/radioactive, 350 , src)
/turf/open/indestructible/sound/pool/spentfuel
	name = "Spent fuel pool"
	desc = "A dumping ground for spent nuclear fuel, can you touch the bottom?"
	icon = 'icons/obj/pool.dmi'
	icon_state = "spentfuelpool"

/turf/open/indestructible/sound/pool/spentfuel/wall
	icon_state = "spentfuelpoolwall"

//Plutonium sludge

#define PLUTONIUM_SLUDGE_RANGE 500
#define PLUTONIUM_SLUDGE_RANGE_STRONG 1000
#define PLUTONIUM_SLUDGE_RANGE_WEAK 300

#define PLUTONIUM_SLUDGE_CHANCE 15


/obj/modules/power/rbmk/nuclear_sludge_spawner //Clean way of spawning nuclear gunk after a reactor core meltdown.
	name = "nuclear waste spawner"
	var/range = PLUTONIUM_SLUDGE_RANGE //tile radius to spawn goop
	var/center_sludge = TRUE // Whether or not the center turf should spawn sludge or not.
	var/static/list/avoid_objs = typecacheof(list( // List of objs that the waste does not spawn on
		/obj/structure/stairs, // Sludge is hidden below stairs
		/obj/structure/ladder, // Going down the ladder directly on sludge bad
		/obj/effect/decal/cleanable/nuclear_waste, // No stacked sludge
		/obj/structure/girder,
		/obj/structure/grille,
		/obj/structure/window/fulltile,
		/obj/structure/window/plasma/fulltile,
		/obj/structure/window/plasma/reinforced/fulltile,
		/obj/structure/window/plastitanium,
		/obj/structure/window/reinforced/fulltile,
		/obj/structure/window/reinforced/clockwork/fulltile,
		/obj/structure/window/reinforced/tinted/fulltile,
		/obj/structure/window,
		/obj/structure/window/shuttle,
		/obj/machinery/gateway,
		/obj/machinery/gravity_generator,
		))
/// Tries to place plutonium sludge on 'floor'. Returns TRUE if the turf has been successfully processed, FALSE otherwise.
/obj/modules/power/rbmk/nuclear_sludge_spawner/proc/place_sludge(turf/open/floor, epicenter = FALSE)
	if(!floor)
		return FALSE

	if(epicenter)
		for(var/obj/effect/decal/cleanable/nuclear_waste/waste in floor) //Replace nuclear waste with the stronger version
			qdel(waste)
		new /obj/effect/decal/cleanable/nuclear_waste/epicenter (floor)
		return TRUE

	if(!prob(PLUTONIUM_SLUDGE_CHANCE)) //Scatter the sludge, don't smear it everywhere
		return TRUE

	for(var/obj/O in floor)
		if(avoid_objs[O.type])
			return TRUE

	new /obj/effect/decal/cleanable/nuclear_waste (floor)
	return TRUE

/obj/modules/power/rbmk/nuclear_sludge_spawner/strong
	range = PLUTONIUM_SLUDGE_RANGE_STRONG

/obj/modules/power/rbmk/nuclear_sludge_spawner/weak
	range = PLUTONIUM_SLUDGE_RANGE_WEAK
	center_sludge = FALSE

/obj/modules/power/rbmk/nuclear_sludge_spawner/proc/fire()
	playsound(src, 'sound/effects/gib_step.ogg', 100)

	if(center_sludge)
		place_sludge(get_turf(src), TRUE)

	for(var/turf/open/floor in orange(range, get_turf(src)))
		place_sludge(floor, FALSE)

	qdel(src)

#undef PLUTONIUM_SLUDGE_RANGE
#undef PLUTONIUM_SLUDGE_RANGE_STRONG
#undef PLUTONIUM_SLUDGE_RANGE_WEAK
#undef PLUTONIUM_SLUDGE_CHANCE
