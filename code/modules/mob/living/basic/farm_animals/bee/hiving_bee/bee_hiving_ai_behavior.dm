///Changes for hive bees
/datum/idle_behavior/idle_random_walk/hiving_walk
	walk_chance = 45

/datum/ai_behavior/find_and_set/homepoint // The place where bees should hang out the most.
	action_cooldown = 10 SECONDS

/datum/ai_behavior/find_and_set/homepoint/perform(seconds_per_tick, datum/ai_controller/controller, set_key, locate_path, search_range)
	if(controller.blackboard_key_exists(set_key))
		finish_action(controller, TRUE)
		return
	var/find_this_thing = search_tactic(controller, locate_path, search_range)
	if(find_this_thing)
		var/mob/living/basic/bee/hiving/hiving_bee = controller.pawn
		hiving_bee.sethomepoint(find_this_thing, set_key) // Use bee homepoint setting
		finish_action(controller, TRUE)
	else
		finish_action(controller, FALSE)


/datum/ai_behavior/find_and_set/homepoint/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	var/list/valid_homepoints = list()
	var/mob/living/basic/bee/bee_pawn = controller.pawn

	if(!istype(bee_pawn, /mob/living/basic/bee/hiving)) // Ensure only hiving bees use this subtree
		return

	if(bee_pawn.is_queen)
		for(var/obj/structure/hiving/beebox/potential_home in oview(search_range, bee_pawn))
			if(!potential_home.habitable(bee_pawn))
				continue
			valid_homepoints += potential_home

	if(valid_homepoints.len)
		return pick(valid_homepoints)
//		if(istype(bee_pawn.loc, /obj/structure/beebox))
//			return bee_pawn.loc //for premade homes only queens set their homes in boxes.

