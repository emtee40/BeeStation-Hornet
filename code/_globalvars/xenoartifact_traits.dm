///traits types, referenced for generation
GLOBAL_LIST(xenoa_activators)
GLOBAL_LIST(xenoa_minors)
GLOBAL_LIST(xenoa_majors)
GLOBAL_LIST(xenoa_malfs)
GLOBAL_LIST(xenoa_all_traits)

///Blacklist for traits
GLOBAL_LIST(xenoa_bluespace_blacklist)
GLOBAL_LIST(xenoa_plasma_blacklist)
GLOBAL_LIST(xenoa_uranium_blacklist)

//We're not allowed to just use this in a GLOBAL_LIST_INIT
/proc/generate_xenoa_statics()
    if(GLOB.xenoa_all_traits)
        return

    GLOB.xenoa_activators = compile_artifact_weights(/datum/xenoartifact_trait/activator)
    GLOB.xenoa_minors = compile_artifact_weights(/datum/xenoartifact_trait/minor)
    GLOB.xenoa_majors = compile_artifact_weights(/datum/xenoartifact_trait/major)
    GLOB.xenoa_malfs = compile_artifact_weights(/datum/xenoartifact_trait/malfunction)
    GLOB.xenoa_all_traits = compile_artifact_weights(/datum/xenoartifact_trait)

    GLOB.xenoa_bluespace_blacklist = compile_artifact_blacklist(BLUESPACE_TRAIT)
    GLOB.xenoa_plasma_blacklist = compile_artifact_blacklist(PLASMA_TRAIT)
    GLOB.xenoa_uranium_blacklist = compile_artifact_blacklist(URANIUM_TRAIT)
