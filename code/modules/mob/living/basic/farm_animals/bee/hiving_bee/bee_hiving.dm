///Hiving Bees
/mob/living/basic/bee/hiving
	name = "Hiving Bee"
	desc = "Crafted by Nanotrasen's botanical team, these bees are at home in alien habitats, tirelessly making honey."
	ai_controller = /datum/ai_controller/basic_controller/hiving_bee
	icon_base = "bee"

/mob/living/basic/bee/hiving/Initialize(mapload)
	. = ..()
//	AddComponent(/datum/component/ai_retaliate_advanced, CALLBACK(src, PROC_REF(on_attacked_response)))


//mob/living/basic/bee/hiving/proc/respond_to_threat(mob/attacker, Drop_All = FALSE)
//	if (!attacker || !ai_controller)
//		return
//	if(Drop_All)
//		ai_controller.CancelActions() //Drop what we are doing.
//		ai_controller.insert_blackboard_key_lazylist(BB_BASIC_MOB_RETALIATE_LIST, attacker) // continue to focus after the first attack
//	ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, attacker) //Who to get angry at.
//	look_angry() // time to look the part.
//	ai_controller.queue_behavior(	// prepare to attack.
//		/datum/ai_behavior/basic_melee_attack,
//		BB_BASIC_MOB_CURRENT_TARGET,
//		BB_TARGETING_STRATEGY,
//		BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION
//	)

//mob/living/basic/bee/hiving/proc/on_attacked_response(mob/living/attacker)
//	respond_to_threat(attacker, Drop_All = TRUE)

///mob/living/basic/bee/hiving/proc/look_angry()
//	icon_base = "angry_bee" // Switch to a aggressive icon
//	generate_bee_visuals()

//mob/living/basic/bee/hiving/proc/smile_again()
//	icon_base = "bee" // Switch to a non-aggressive icon
//	generate_bee_visuals()

/mob/living/basic/bee/queen/hiving
	name = "Hiving Queen Bee"
	desc = "The crown jewel of Nanotrasen's botanical team, this queen commands her swarm with precision, even in the harshest environments."
	ai_controller = /datum/ai_controller/basic_controller/queen_bee/hiving_bee

/mob/living/basic/bee/queen/hiving/Initialize(mapload)
	. = ..()
	//AddComponent(/datum/component/ai_retaliate_advanced, CALLBACK(src, PROC_REF(on_attacked_response)))
