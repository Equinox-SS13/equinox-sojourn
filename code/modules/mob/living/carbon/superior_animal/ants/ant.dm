//These are VERY similar to roaches but lack the certain kinds of annoying ones like the EMP, Bluespace, or other ones.
//They're also included in the roach chems.
/mob/living/carbon/superior_animal/ant
	name = "Ant Worker"
	desc = "A massive insectoid creature resembling A. gracilipes, the yellow crazy ant. This one is the most common variety."
	icon = 'icons/mob/mobs-roach.dmi'
	icon_state = "roach"

	mob_size = MOB_SMALL

	density = 0 //Swarming! They also more robust that way.

	attack_sound = 'sound/voice/insect_battle_bite.ogg'
	emote_see = list("chitters quietly.", "cleans its antannae with forelegs.")
	turns_per_move = 4
	turns_since_move = 0

	get_stat_modifier = FALSE//NNNNNOPE, having hoard enemies get these has caused massive issues for balance. These should be limited to actual serious mobs from here on out.

	armor = list(melee = 5, bullet = 0, energy = 0, bomb = 5, bio = 20, rad = 100, agony = 0)

	meat_type = /obj/item/reagent_containers/food/snacks/meat/roachmeat/ant
	meat_amount = 2
	leather_amount = 0
	bones_amount = 0

	maxHealth = 15 * ROACH_HEALTH_MOD
	health = 15 * ROACH_HEALTH_MOD

	var/blattedin_revives_left = 3 // how many times blattedin can get us back to life (as num for adminbus fun).
	//The common ant, gets to live 4 times, same as a roachling. They have so much to live for.
	melee_damage_lower = 3
	melee_damage_upper = 4
	var/knockdown_odds = 1 //1% KO odds

	min_breath_required_type = 3
	min_air_pressure = 15 //below this, brute damage is dealt

	faction = "roach"
	pass_flags = PASSTABLE
	acceptableTargetDistance = 3 //consider all targets within this range equally
	randpixel = 12
	overkill_gib = 16

	sanity_damage = 0.5

	fleshcolor = "#e0dc5c"
	bloodcolor = "#e0dc5c"

	var/taming_window = 30 //How long you have to tame this roach, once it's pacified.
	eating_time = 2 MINUTES // how long it will take to eat/lay egg
	var/busy_start_time // when it started eating/laying egg

	var/atom/eat_target // target that the roach wants to eat
	var/fed = 0 // roach gets fed after eating a corpse
	var/probability_egg_laying = 75 // probability to lay an egg

	var/snacker = FALSE

	do_friendly_fire_chance = 100

	colony_friend = FALSE
	friendly_to_colony = FALSE

	known_languages = list(LANGUAGE_CHTMANT)

	inherent_mutations = list(MUTATION_ROACH_BLOOD, MUTATION_DEAF, MUTATION_TOURETTES, MUTATION_EPILEPSY)