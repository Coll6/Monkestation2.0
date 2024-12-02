/datum/ai_controller/basic_controller/hiving_bee
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/bee,
		//BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends, probably added for apid
		BB_BASIC_MOB_RETALIATE_LIST = list() //For aggro lists.
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/hiving_walk

	planning_subtrees = list(
		//datum/ai_planning_subtree/capricious_retaliate/hiving_retaliate,
		//datum/ai_planning_subtree/target_retaliate,
		//datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/hiving_find_valid_home,
		/datum/ai_planning_subtree/hiving/enter_exit_home,
		//datum/ai_planning_subtree/find_and_hunt_target/hivingpollinate
	)

/datum/ai_controller/basic_controller/queen_bee/hiving_bee
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/bee,
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/hiving_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/hiving_find_valid_home,
		/datum/ai_planning_subtree/hiving/enter_exit_home/queen
	)

/datum/ai_planning_subtree/hiving/enter_exit_home// Used for the bee to return to the queen inside a beebox or not.
	///chance we go back home
	var/flyback_chance = 15
	///chance we exit the home
	var/exit_chance = 35

/datum/ai_planning_subtree/hiving/enter_exit_home/queen // The queen spends more time in the hive.
	flyback_chance = 85
	exit_chance = 5

/datum/ai_planning_subtree/hiving/enter_exit_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)

	var/atom/current_home = controller.blackboard[BB_CURRENT_HOME]

	if(QDELETED(current_home))
		return
	//add aggro blocking here
	var/mob/living/basic/bee/hiving/bee_pawn = controller.pawn
	var/action_prob = 0
	var/target = null
	// For non-queen bees
	if(!bee_pawn.is_queen)
		if(istype(current_home, /mob/living/basic/bee/hiving/queen))
			var/mob/living/basic/bee/hiving/queen/queen = current_home
			if(istype(queen.bee_homepoint, /obj/structure/hiving/beebox))
				var/obj/structure/hiving/beebox/beehome = queen.bee_homepoint
				action_prob = (beehome.contains(bee_pawn)) ? exit_chance : flyback_chance
				target = beehome // Target the beebox
			else
				action_prob = flyback_chance //Not in a suitable container so just fly back to location chance.
				target = current_home
	else //Queens should only have a beebox to enter and leave. For now.
		var/obj/structure/hiving/beebox/beehome = bee_pawn.bee_homepoint
		action_prob = (beehome.contains(bee_pawn)) ? exit_chance : flyback_chance
		target = current_home
	if(!SPT_PROB(action_prob, seconds_per_tick))
		return

	controller.queue_behavior(/datum/ai_behavior/return_to_home, target)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_behavior/return_to_home
    behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/return_to_home/setup(datum/ai_controller/controller, atom/target)
	. = ..()
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/return_to_home/perform(seconds_per_tick, datum/ai_controller/controller, target)
	. = ..()
	var/mob/living/bee_pawn = controller.pawn

	var/datum/callback/callback = CALLBACK(bee_pawn, TYPE_PROC_REF(/mob/living/basic/bee/hiving, handle_return_home), target)
	callback.Invoke()
	finish_action(controller, TRUE)

/datum/ai_planning_subtree/hiving_find_valid_home

/datum/ai_planning_subtree/hiving_find_valid_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/basic/bee/hiving/beepawn = controller.pawn
	var/atom/current_home = controller.blackboard[BB_CURRENT_HOME] // Home point could be a queen a beebox or a mob(In the future).

	if(QDELETED(current_home))
		if(beepawn.bee_homepoint && controller) // Controller AI so make sure blackboard is updated incase it was deleted somehow
			controller.set_blackboard_key(BB_CURRENT_HOME, beepawn.bee_homepoint)
			return
		controller.queue_behavior(/datum/ai_behavior/find_and_set/homepoint, BB_CURRENT_HOME, null)
		return

		//if(istype(work_bee, /mob/living/basic/bee/hiving) && (controller.blackboard[BB_BASIC_MOB_RETALIATE_LIST] || controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]))
		//return // Shouldn't be looking for a home we must fight.

///Hiving bees
//datum/ai_planning_subtree/find_and_hunt_target/hivingpollinate
//	target_key = BB_TARGET_HYDRO
//	hunting_behavior = /datum/ai_behavior/hunt_target/pollinate
//	finding_behavior = /datum/ai_behavior/find_hunt_target/pollinate
//	hunt_targets = list(/obj/machinery/growing, /mob/living/basic/pet/potty)
//	hunt_range = 10
//	hunt_chance = 85

//datum/ai_planning_subtree/find_and_hunt_target/hivingpollinate/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
//	if(controller.blackboard[BB_BASIC_MOB_RETALIATE_LIST] || controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
//		return // Engaged in combat, skip pollination.
//	. = ..() // Run the pollination routine otherwise.

///datum/ai_planning_subtree/capricious_retaliate/hiving_retaliate
	/// Whether we should skip checking faction for our decision
//	ignore_faction = FALSE
