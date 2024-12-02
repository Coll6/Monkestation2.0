///Hiving Bees
/mob/living/basic/bee/hiving
	name = "Hiving Bee"
	desc = "Crafted by Nanotrasen's botanical team, these bees are at home in alien habitats, tirelessly making honey."
	ai_controller = /datum/ai_controller/basic_controller/hiving_bee
	icon_base = "bee"

	var/bee_homepoint = null

/mob/living/basic/bee/hiving/Initialize(mapload)
	. = ..()

/mob/living/basic/bee/hiving/examine(mob/user)
	. = ..()
	if(bee_homepoint)
		. -= span_warning("This bee is homeless!")

/mob/living/basic/bee/hiving/proc/sethomepoint(atom/new_home, set_key)
	bee_homepoint = new_home

	if(ai_controller && set_key)
		ai_controller.set_blackboard_key(set_key, new_home)

	if(is_queen)
		var/obj/structure/hiving/beebox/hive = new_home
		if(hive)
			hive.queen_bee = src // Hives new queen
		else if(src.bee_homepoint && istype(src.bee_homepoint, /obj/structure/hiving/beebox))
			hive = src.bee_homepoint
			hive.queen_bee = null // Either moved out or something weird happened.



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

/mob/living/basic/bee/hiving/queen
	name = "Hiving Queen Bee"
	desc = "The crown jewel of Nanotrasen's botanical team, this queen commands her swarm with precision, even in the harshest environments."
	icon_base = "queen"
	dead_icon_base = "dead_queen_bee"
	is_queen = TRUE
	ai_controller = /datum/ai_controller/basic_controller/queen_bee/hiving_bee

	var/list/worker_bees = list() //List of queens workers for her to command.

	//AddComponent(/datum/component/ai_retaliate_advanced, CALLBACK(src, PROC_REF(on_attacked_response)))
