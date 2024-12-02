///Modified version of the hydroponics/beekeeping/beebox
///Mostly used for testing purposes of Queen centered organization

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


/obj/structure/hiving/beebox/proc/habitable(mob/living/basic/target)
	if(!istype(target, /mob/living/basic/bee/hiving))
		return FALSE
	var/mob/living/basic/bee/hiving/citizen = target
	if(citizen.reagent_incompatible(queen_bee))
		return FALSE
	return TRUE
