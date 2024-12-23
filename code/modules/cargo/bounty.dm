/// How many jobs have bounties, minus the random civ bounties. PLEASE INCREASE THIS NUMBER AS MORE DEPTS ARE ADDED TO BOUNTIES.
#define MAXIMUM_BOUNTY_JOBS 13
/// Global bounty list for departmental bounties. Generated once per shift.
GLOBAL_LIST_EMPTY(bounties_list)
#define MAXIMUM_GLOBAL_BOUNTIES 25

/datum/bounty
	var/name
	var/description
	var/reward = 1000 // In credits.
	var/claimed = FALSE
	var/high_priority = FALSE

/datum/bounty/proc/can_claim()
	return !claimed

/// Called when the claim button is clicked. Override to provide fancy rewards.
/datum/bounty/proc/claim()
	if(can_claim())
		var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
		if(D)
			D.adjust_money(reward * SSeconomy.bounty_modifier)
		claimed = TRUE

/// If an item sent in the cargo shuttle can satisfy the bounty.
/datum/bounty/proc/applies_to(obj/O)
	return FALSE

/// Called when an object is shipped on the cargo shuttle.
/datum/bounty/proc/ship(obj/O)
	return

/** Returns a new bounty of random type, but does not add it to GLOB.bounties_list.
 *
 * *Guided determines what specific catagory of bounty should be chosen.
 */
/proc/random_bounty(guided = 0)
	var/bounty_num
	var/chosen_type
	var/bounty_succeeded = FALSE
	var/datum/bounty/item/bounty_ref
	while(!bounty_succeeded)
		if(guided && (guided != CIV_JOB_RANDOM))
			bounty_num = guided
		else
			bounty_num = rand(1, MAXIMUM_BOUNTY_JOBS)
		switch(bounty_num)
			if(CIV_JOB_BASIC)
				chosen_type = pick(subtypesof(/datum/bounty/item/assistant))
			if(CIV_JOB_ROBO) //monkestation edit: bot bounties
				if(prob(50))
					chosen_type = pick(subtypesof(/datum/bounty/item/mech))
				else
					chosen_type = pick(subtypesof(/datum/bounty/item/bot))
			if(CIV_JOB_CHEF)
				chosen_type = pick(subtypesof(/datum/bounty/item/chef) + subtypesof(/datum/bounty/reagent/chef))
			if(CIV_JOB_SEC)
				chosen_type = pick(subtypesof(/datum/bounty/item/security))
			if(CIV_JOB_DRINK)
				if(prob(50))
					chosen_type = /datum/bounty/reagent/simple_drink
				else
					chosen_type = /datum/bounty/reagent/complex_drink
			if(CIV_JOB_CHEM)
				if(prob(50))
					chosen_type = /datum/bounty/reagent/chemical_simple
				else
					chosen_type = /datum/bounty/reagent/chemical_complex
			if(CIV_JOB_VIRO)
				chosen_type = /datum/bounty/item/virus // Monkestation Edit: Pathology Bounties
			if(CIV_JOB_SCI)
				if(prob(50))
					chosen_type = pick(subtypesof(/datum/bounty/item/science))
				else
					chosen_type = pick(subtypesof(/datum/bounty/item/slime))
			if(CIV_JOB_SCI_HEAD) //monkestation addition : RD bounties. 50% for science bounty, 50% for robo bounty.
				if(prob(50))
					if(prob(50))
						chosen_type = pick(subtypesof(/datum/bounty/item/science))
					else
						chosen_type = pick(subtypesof(/datum/bounty/item/slime))
				else
					if(prob(50))
						chosen_type = pick(subtypesof(/datum/bounty/item/mech))
					else
						chosen_type = pick(subtypesof(/datum/bounty/item/bot))
			if(CIV_JOB_ENG)
				chosen_type = pick(subtypesof(/datum/bounty/item/engineering))
			if(CIV_JOB_MINE)
				chosen_type = pick(subtypesof(/datum/bounty/item/mining))
			if(CIV_JOB_MED)
				chosen_type = pick(subtypesof(/datum/bounty/item/medical))
			if(CIV_JOB_GROW)
				chosen_type = pick(subtypesof(/datum/bounty/item/botany))
			if(CIV_JOB_ATMOS)
				chosen_type = pick(subtypesof(/datum/bounty/item/atmospherics))
		bounty_ref = new chosen_type
		if(bounty_ref.can_get())
			bounty_succeeded = TRUE
		else
			qdel(bounty_ref)
	return bounty_ref
/** Returns new bounties of random types, organizes them by department and adds it to GLOB.bounties_list.
 *
 * *MAXIMUM_GLOBAL_BOUNTIES* Will be the maximum amount of global bounties generated per shift.
 */
/proc/random_bounty_for_departments()
// Define how departments map to job types change if adding new jobs or new bounty types.
	var/list/departments = list(
	"sec" = list(CIV_JOB_SEC),  // Security department
	"eng" = list(CIV_JOB_ENG, CIV_JOB_ATMOS),  // Engineering
	"med" = list(CIV_JOB_MED, CIV_JOB_CHEM, CIV_JOB_VIRO), // Medical department
	"car" = list(CIV_JOB_MINE),  // Cargo and Mining department
	"srv" = list(CIV_JOB_CHEF, CIV_JOB_DRINK, CIV_JOB_GROW),
	"sci" = list(CIV_JOB_SCI, CIV_JOB_ROBO),
	"civ" = list(CIV_JOB_BASIC),
	// Add more departments and jobs bounties as needed...
	)
	var/list/listing_bounties = list()
	for(var/i =1; i <= MAXIMUM_GLOBAL_BOUNTIES; i++)
		var/department_key = pick(departments)  // Random department key. Make sure they have a bounty or remove their key.
		var/job_type = pick(departments[department_key])  // Random job type from the.
		var/bounty_ref = random_bounty(guided = job_type)  // Generate bounty based on the selected job

		if(!bounty_ref)
			continue
		if(isnull(listing_bounties[department_key]))
			listing_bounties[department_key] += list()
		listing_bounties[department_key] += bounty_ref

	//return listing_bounties
	return list()
#undef MAXIMUM_BOUNTY_JOBS
