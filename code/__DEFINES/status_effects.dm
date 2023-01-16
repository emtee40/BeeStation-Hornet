
//! **These are all the different status effects. Use the paths for each effect in the defines.**

/// if it allows multiple instances of the effect
#define STATUS_EFFECT_MULTIPLE 0
/// if it allows only one, preventing new instances
#define STATUS_EFFECT_UNIQUE 1
/// if it allows only one, but new instances replace
#define STATUS_EFFECT_REPLACE 2
/// if it only allows one, and new instances just instead refresh the timer
#define STATUS_EFFECT_REFRESH 3

//-------//
// BUFFS //
//-------//

#define STATUS_EFFECT_SHADOW_MEND /datum/status_effect/shadow_mend //! Quick, powerful heal that deals damage afterwards. Heals 15 brute/burn every second for 3 seconds.
#define STATUS_EFFECT_VOID_PRICE /datum/status_effect/void_price //T! he price of healing yourself with void energy. Deals 3 brute damage every 3 seconds for 30 seconds.

#define STATUS_EFFECT_VANGUARD /datum/status_effect/vanguard_shield //! Grants temporary stun absorption, but will stun the user based on how many stuns they absorbed.
#define STATUS_EFFECT_INATHNEQS_ENDOWMENT /datum/status_effect/inathneqs_endowment //! A 15-second invulnerability and stun absorption, granted by Inath-neq.
#define STATUS_EFFECT_WRAITHSPECS /datum/status_effect/wraith_spectacles

#define STATUS_EFFECT_POWERREGEN /datum/status_effect/cyborg_power_regen //! Regenerates power on a given cyborg over time

#define STATUS_EFFECT_HISGRACE /datum/status_effect/his_grace //! His Grace.

#define STATUS_EFFECT_WISH_GRANTERS_GIFT /datum/status_effect/wish_granters_gift //! If you're currently resurrecting with the Wish Granter

#define STATUS_EFFECT_BLOODDRUNK /datum/status_effect/blooddrunk //! Stun immunity and greatly reduced damage taken

#define STATUS_EFFECT_FLESHMEND /datum/status_effect/fleshmend //! Very fast healing; suppressed by fire, and heals less fire damage

#define STATUS_EFFECT_CHANGELING_CAMO /datum/status_effect/changeling/camoflague //! Makes you slowly invisible over time, taking damage, being bumped, moving or burning removes the effect.

#define STATUS_EFFECT_CHANGELING_MINDSHIELD /datum/status_effect/changeling/mindshield //! Causes you to appear to have a mindshield to security HUDs.

#define STATUS_EFFECT_EXERCISED /datum/status_effect/exercised //! Prevents heart disease

#define STATUS_EFFECT_HIPPOCRATIC_OATH /datum/status_effect/hippocraticOath //! Gives you an aura of healing as well as regrowing the Rod of Asclepius if lost

#define STATUS_EFFECT_GOOD_MUSIC /datum/status_effect/good_music

#define STATUS_EFFECT_REGENERATIVE_CORE /datum/status_effect/regenerative_core

#define STATUS_EFFECT_ANTIMAGIC /datum/status_effect/antimagic //! grants antimagic (and reapplies if lost) for the duration

//---------//
// DEBUFFS //
//---------//

#define STATUS_EFFECT_STUN /datum/status_effect/incapacitating/stun //! the affected is unable to move or use items

#define STATUS_EFFECT_KNOCKDOWN /datum/status_effect/incapacitating/knockdown //! the affected is unable to stand up

#define STATUS_EFFECT_IMMOBILIZED /datum/status_effect/incapacitating/immobilized //! the affected is unable to move

#define STATUS_EFFECT_PARALYZED /datum/status_effect/incapacitating/paralyzed //! the affected is unable to move, use items, or stand up.

#define STATUS_EFFECT_UNCONSCIOUS /datum/status_effect/incapacitating/unconscious //! the affected is unconscious

#define STATUS_EFFECT_SLEEPING /datum/status_effect/incapacitating/sleeping //! the affected is asleep

#define STATUS_EFFECT_PACIFY /datum/status_effect/pacify //! the affected is pacified, preventing direct hostile actions

#define STATUS_EFFECT_INTERDICTION /datum/status_effect/interdiction //! The affected is inside the range of an interdiction lens

#define STATUS_EFFECT_CHOKINGSTRAND /datum/status_effect/strandling //! Choking Strand

#define STATUS_EFFECT_HISWRATH /datum/status_effect/his_wrath //! His Wrath.

#define STATUS_EFFECT_SUMMONEDGHOST /datum/status_effect/cultghost //! is a cult ghost and can't use manifest runes

#define STATUS_EFFECT_CRUSHERMARK /datum/status_effect/crusher_mark //! if struck with a proto-kinetic crusher, takes a ton of damage

#define STATUS_EFFECT_SAWBLEED /datum/status_effect/saw_bleed //! if the bleed builds up enough, takes a ton of damage

#define STATUS_EFFECT_NECKSLICE /datum/status_effect/neck_slice //Creates the flavor messages for the neck-slice

#define STATUS_EFFECT_CONVULSING /datum/status_effect/convulsing

#define STATUS_EFFECT_NECROPOLIS_CURSE /datum/status_effect/necropolis_curse
#define CURSE_BLINDING	1 //! makes the edges of the target's screen obscured
#define CURSE_SPAWNING	2 //! spawns creatures that attack the target only
#define CURSE_WASTING	4 //! causes gradual damage
#define CURSE_GRASPING	8 //! hands reach out from the sides of the screen, doing damage and stunning if they hit the target

#define STATUS_EFFECT_KINDLE /datum/status_effect/kindle //! A knockdown reduced by 1 second for every 3 points of damage the target takes.

#define STATUS_EFFECT_ICHORIAL_STAIN /datum/status_effect/ichorial_stain //! Prevents a servant from being revived by vitality matrices for one minute.

#define STATUS_EFFECT_GONBOLAPACIFY /datum/status_effect/gonbolaPacify //! Gives the user gondola traits while the gonbola is attached to them.

#define STATUS_EFFECT_SPASMS /datum/status_effect/spasms //! causes random muscle spasms

#define STATUS_EFFECT_DNA_MELT /datum/status_effect/dna_melt //! usually does something horrible to you when you hit 100 genetic instability

#define STATUS_EFFECT_GO_AWAY /datum/status_effect/go_away //! makes you launch through walls in a single direction for a while

#define STATUS_EFFECT_STASIS /datum/status_effect/incapacitating/stasis //! Halts biological functions like bleeding, chemical processing, blood regeneration, walking, etc

#define STATUS_EFFECT_SYRINGE /datum/status_effect/syringe //used to handle being injected with a syringe

#define STATUS_EFFECT_SPANISH /datum/status_effect/spanish //Robotic Tongue EMP

#define STATUS_EFFECT_IPC_EMP /datum/status_effect/ipc/emp //EMP'd IPC

#define STATUS_EFFECT_SLIMEGRUB /datum/status_effect/slimegrub //infected slime

#define STATUS_EFFECT_AMOK /datum/status_effect/amok //Makes the target automatically strike out at adjecent non-heretics.

#define STATUS_EFFECT_CLOUDSTRUCK /datum/status_effect/cloudstruck //blinds and applies an overlay.

///Raises click cooldowns for everything you do.
#define STATUS_EFFECT_WOOZY /datum/status_effect/woozy

///Makes you bleed harder
#define STATUS_EFFECT_HIGHBLOODPRESSURE /datum/status_effect/high_blood_pressure

/// makes you seize up. reminds me of this video https://www.youtube.com/watch?v=wvkHIZg_954
#define STATUS_EFFECT_SEIZURE /datum/status_effect/seizure


//---------//
// NEUTRAL //
//---------//

#define STATUS_EFFECT_SIGILMARK /datum/status_effect/sigil_mark

#define STATUS_EFFECT_CRUSHERDAMAGETRACKING /datum/status_effect/crusher_damage //! tracks total kinetic crusher damage on a target

#define STATUS_EFFECT_SYPHONMARK /datum/status_effect/syphon_mark //! tracks kills for the KA death syphon module

#define STATUS_EFFECT_INLOVE /datum/status_effect/in_love //! Displays you as being in love with someone else, and makes hearts appear around them.

#define STATUS_EFFECT_BUGGED /datum/status_effect/bugged //! Lets other mobs listen in on what it hears

#define STATUS_EFFECT_BOUNTY /datum/status_effect/bounty //! rewards the person who added this to the target with refreshed spells and a fair heal

//---------//
//  SLIME  //
//---------//

#define STATUS_EFFECT_RAINBOWPROTECTION /datum/status_effect/rainbow_protection //! Invulnerable and pacifistic
#define STATUS_EFFECT_SLIMESKIN /datum/status_effect/slimeskin //! Increased armor

// Stasis helpers

#define STASIS_ASCENSION_EFFECT "heretic_ascension"

#define IS_IN_STASIS(mob) (mob.has_status_effect(STATUS_EFFECT_STASIS))

#define STATUS_EFFECT_OFFERING /datum/status_effect/offering // you are offering up an item to people
