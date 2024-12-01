/datum/ai_controller/basic_controller/hiving_bee
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/bee,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_BASIC_MOB_RETALIATE_LIST = list() //For aggro lists.
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/hiving_walk

	planning_subtrees = list(
		//datum/ai_planning_subtree/capricious_retaliate/hiving_retaliate,
		//datum/ai_planning_subtree/target_retaliate,
		//datum/ai_planning_subtree/basic_melee_attack_subtree,
		//datum/ai_planning_subtree/find_valid_home,
		//datum/ai_planning_subtree/enter_exit_home,
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
		//datum/ai_planning_subtree/find_valid_home,
		//datum/ai_planning_subtree/enter_exit_home/queen
	)

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
