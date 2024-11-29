/datum/preference/choiced/braintype
	savefile_key = "braintype"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_DEFAULT //done after species

/datum/preference/choiced/braintype/init_possible_values()
	return assoc_to_keys(GLOB.body_heights)

//datum/preference/choiced/body_height/create_default_value()
//	return "Normal"

//datum/preference/choiced/body_height/apply_to_human(mob/living/carbon/human/target, value)
//__detect_rust_g	target.dna.body_height = value
