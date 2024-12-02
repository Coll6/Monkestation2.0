///Modified version of the hydroponics/beekeeping/beebox
///Mostly used for testing purposes of Queen centered organization
#define BEEBOX_MAX_FRAMES 3 //Max frames per box
#define BEES_RATIO 0.5 //Multiplied by the max number of honeycombs to find the max number of bees
#define BEE_PROB_NEW_BEE 20 //The chance for spare bee_resources to be turned into new bees
#define BEE_RESOURCE_HONEYCOMB_COST 100 //The amount of bee_resources for a new honeycomb to be produced, percentage cost 1-100
#define BEE_RESOURCE_NEW_BEE_COST 50 //The amount of bee_resources for a new bee to be produced, percentage cost 1-100

/obj/structure/hiving/beebox
	name = "Hiving Apiary"
	desc = "Only a temporary stand in."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "beebox"
	anchored = TRUE
	density = TRUE
	var/mob/living/basic/bee/hiving/queen/queen_bee = null
	var/list/honeycombs = list()
	var/list/honey_frames = list()
	var/bee_resources = 0

/obj/structure/hiving/beebox/proc/get_max_honeycomb()
	. = 0
	for(var/obj/item/honey_frame/HF in honey_frames)
		. += HF.honeycomb_capacity

/obj/structure/hiving/beebox/proc/get_max_bees()
    return get_max_honeycomb() * BEES_RATIO

/obj/structure/hiving/beebox/proc/habitable(mob/living/basic/target)
	if(!istype(target, /mob/living/basic/bee/hiving))
		return FALSE
	var/mob/living/basic/bee/hiving/citizen = target
	if(citizen.reagent_incompatible(queen_bee))
		return FALSE
	if(!citizen.is_queen)
		if(!queen_bee)
			return FALSE
		if(queen_bee.worker_bees.len >= get_max_bees())
			return FALSE
	if(citizen.is_queen && queen_bee)
		return FALSE
	return TRUE

#undef BEE_PROB_NEW_BEE
#undef BEE_RESOURCE_HONEYCOMB_COST
#undef BEE_RESOURCE_NEW_BEE_COST
#undef BEEBOX_MAX_FRAMES
#undef BEES_RATIO
