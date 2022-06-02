/*				MEDICAL OBJECTIVES				*/
// Clean body medbay -------------------------------------------------------
/datum/objective/crew/morgue //Ported from old Hippie
	explanation_text = "Ensure the Medbay has been cleaned of any corpses when the shift ends."
	jobs = "chiefmedicalofficer,medicaldoctor"

/datum/objective/crew/morgue/check_completion()
	var/list/medical_areas = typecacheof(list(/area/medical/cryo, /area/medical/genetics/cloning, /area/medical/exam_room,
		/area/medical/medbay/aft, /area/medical/medbay/central, /area/medical/medbay/lobby, /area/medical/patients_rooms,
		/area/medical/sleeper, /area/medical/storage))
	for(var/mob/living/carbon/human/H in GLOB.mob_living_list)
		var/area/A = get_area(H)
		if(H.stat == DEAD && is_station_level(H.z) && is_type_in_typecache(A, medical_areas)) // If person is dead and corpse is in one of these areas
			return ..()
	return TRUE

// Clean body station (paramedic) -------------------------------------------------------
/datum/objective/crew/emtmorgue
	explanation_text = "Ensure that no corpses remain outside of Medbay when the shift ends."
	jobs = "paramedic"

/datum/objective/crew/emtmorgue/check_completion()
	var/list/medical_areas_morgue = typecacheof(list(/area/medical/cryo, /area/medical/genetics/cloning, /area/medical/exam_room,
		/area/medical/medbay/aft, /area/medical/medbay/central, /area/medical/medbay/lobby, /area/medical/patients_rooms,
		/area/medical/sleeper, /area/medical/storage, /area/medical/morgue))
	for(var/mob/living/carbon/human/H in GLOB.mob_living_list)
		var/area/A = get_area(H)
		if(H.stat == DEAD && is_station_level(H.z) && !is_type_in_typecache(A, medical_areas_morgue)) // If person is dead and corpse is NOT in one of these areas
			return ..()
	return TRUE

// chemist Chem eat -------------------------------------------------------
/datum/objective/crew/chems //Ported from old Hippie
	var/targetchem = "none"
	var/datum/reagent/chempath
	explanation_text = "Have (yell about this on GitHub, something broke) in your bloodstream when the shift ends."
	jobs = "chiefmedicalofficer,chemist"

/datum/objective/crew/chems/New()
	. = ..()
	chempath = get_random_reagent_id(CHEMICAL_GOAL_CHEMIST_BLOODSTREAM)
	targetchem = chempath
	update_explanation_text()

/datum/objective/crew/chems/update_explanation_text()
	. = ..()
	explanation_text = "Have [initial(chempath.name)] in your bloodstream when the shift ends."

/datum/objective/crew/chems/check_completion()
	if(owner.current)
		if(!owner.current.stat == DEAD && owner.current.reagents)
			if(owner.current.reagents.has_reagent(targetchem))
				return TRUE
	return ..()

// chemist drug maker -------------------------------------------------------
/datum/objective/crew/druglordchem //ported from old Hippie with adjustments
	var/targetchem = "none"
	var/datum/reagent/chempath
	var/chemamount = 0
	explanation_text = "Have at least (something broke here) pills containing at least (like really broke) units of (yell on GitHub) when the shift ends."
	jobs = "chemist"

/datum/objective/crew/druglordchem/New()
	. = ..()
	target_amount = rand(5,50)
	chemamount = rand(1,20)
	chempath = get_random_reagent_id(CHEMICAL_GOAL_CHEMIST_DRUG)
	targetchem = chempath
	update_explanation_text()

/datum/objective/crew/druglordchem/update_explanation_text()
	. = ..()
	explanation_text = "Have at least [target_amount] pills containing at least [chemamount] units of [initial(chempath.name)] when the shift ends."

/datum/objective/crew/druglordchem/check_completion()
	var/pillcount = target_amount
	if(owner.current)
		if(owner.current.contents)
			for(var/obj/item/reagent_containers/pill/P in owner.current.get_contents())
				if(P.reagents.has_reagent(targetchem, chemamount))
					pillcount--
	if(pillcount <= 0)
		return TRUE
	else
		return ..()

// geneticist mutation give -------------------------------------------------------
/datum/objective/crew/crewmutant
	explanation_text = "Let more than one third crew members have a mutation at least at the end of the shift."
	jobs = "chiefmedicalofficer,geneticist"

/datum/objective/crew/crewmutant/check_completion()
	var/realperson = 0
	var/hadmutation = 0
	for(var/mob/living/carbon/human/H in GLOB.mob_list)
		if(H.mind && H.mind.assigned_role)
			realperson++
		if(length(H.dna.mutations))
			hadmutation++
	if(realperson/3 <= hadmutation) //don't have to `round(realperson/2)`
		return TRUE
	return ..()

// geneticist self enhancement
/datum/objective/crew/selfmutant
	explanation_text = "Have yourself enhanced by spending more than 50 genetic stability when the shift ends."
	jobs = "geneticist"

/datum/objective/crew/selfmutant/check_completion()
	if(owner.current)
		if(ishuman(owner.current)) // in case that your body is fucked (i.e. corgified)
			var/mob/living/carbon/human/you = owner.current
			var/datum/dna/yourdna = you.dna
			if(yourdna.stability <= 50)
				return TRUE
	return ..()

// virologist Vaccine -------------------------------------------------------
/datum/objective/crew/vaccine
	explanation_text = "Let more than half crew members have a vaccine of any diesease at the end of the shift."
	jobs = "chiefmedicalofficer,virologist"

/datum/objective/crew/vaccine/check_completion()
	var/realperson = 0
	var/hadvaccine = 0
	for(var/mob/living/carbon/human/H in GLOB.mob_list)
		if(H.mind && H.mind.assigned_role)
			realperson++
		if(length(H.disease_resistances))
			hadvaccine++
	if(realperson/2 <= hadvaccine) //don't have to `round(realperson/2)`
		return TRUE
	return ..()
