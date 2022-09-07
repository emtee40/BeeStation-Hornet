/datum/component/anti_artifact
	///Amount of chances to block artifacts
	var/charges = INFINITY
	///Wether you can / cant target yourself
	var/blocks_self = TRUE
	///Allowed item slots
	var/allowed_slots = ~ITEM_SLOT_BACKPACK
	///Chance to block
	var/chance = 100

	var/datum/callback/reaction
	var/datum/callback/expire

/datum/component/anti_artifact/Initialize(_charges, _blocks_self = TRUE, _chance = 100, datum/callback/_reaction, datum/callback/_expire, _allowed_slots)
	if(isitem(parent))
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/on_equip)
		RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/on_drop)
	else if(ismob(parent))
		RegisterSignal(parent, COMSIG_MOB_RECEIVE_ARTIFACT, .proc/protect)
	else
		return COMPONENT_INCOMPATIBLE

	charges = (_charges || charges)
	allowed_slots = (_allowed_slots || allowed_slots)
	chance = _chance
	blocks_self = _blocks_self
	reaction = _reaction
	expire = _expire

/datum/component/anti_artifact/proc/on_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(allowed_slots & slot)) //Check that the slot is valid for antimagic
		UnregisterSignal(equipper, COMSIG_MOB_RECEIVE_ARTIFACT)
		return
	RegisterSignal(equipper, COMSIG_MOB_RECEIVE_ARTIFACT, .proc/protect, TRUE)

/datum/component/anti_artifact/proc/on_drop(datum/source, mob/user)
	SIGNAL_HANDLER

	UnregisterSignal(user, COMSIG_MOB_RECEIVE_ARTIFACT)

/datum/component/anti_artifact/proc/protect(datum/source, mob/user, self, list/protection_sources)
	SIGNAL_HANDLER

	if(!self || blocks_self && prob(chance))
		protection_sources += parent
		reaction?.Invoke(user)
		charges--
		if(charges <= 0)
			expire?.Invoke(user)
		return COMPONENT_BLOCK_ARTIFACT
