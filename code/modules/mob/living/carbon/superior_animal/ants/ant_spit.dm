/obj/item/projectile/ant_spit
	name = "Formic Acid Spit"
	icon = 'icons/obj/hivemind.dmi'
	icon_state = "goo_proj"
	damage_types = list()
	irradiate = 20
	check_armour = ARMOR_BIO
	step_delay = 2
	/obj/item/projectile/roach_spit/on_hit(atom/target)
	. = ..()
	if(isliving(target))
		if (!testing)
			var/mob/living/L = target
			var/damage = rand(3, 7)
			L.damage_through_armor(damage, TOX, attack_flag = ARMOR_BIO)

/obj/item/projectile/ant_spit/attack_mob(mob/living/target_mob, distance, miss_modifier=0)
	if (istype(target_mob, /mob/living/carbon/superior_animal/ant))
		return FALSE // so these pass through friendlies
	..()

/obj/item/projectile/ant_spit/large
	name = "Formic Acid Blob"
	icon = 'icons/obj/hivemind.dmi'
	icon_state = "goo_proj"
	damage_types = list()
	irradiate = 20
	check_armour = ARMOR_BIO
	step_delay = 2

/obj/item/projectile/ant_spit/large/on_hit(atom/target)
	. = ..()
	if(!(locate(/obj/effect/decal/cleanable/greenglow/bile) in target.loc))		//Equinox edit: Prevents excessive stacking of hundreds of puddles that process and irradiate
		new /obj/effect/decal/cleanable/greenglow/bile(target.loc)		//Equinox edit: Makes the puddles drop right on the intended target instead of harmlessly splatering on distant walls
	if(isliving(target))
		if (!testing)
			var/mob/living/L = target
			var/damage = rand(12, 20)
			L.damage_through_armor(damage, BURN, attack_flag = ARMOR_BIO)

/obj/item/projectile/ant_spit/large/attack_mob(mob/living/target_mob, distance, miss_modifier=0)
	if (istype(target_mob, /mob/living/carbon/superior_animal/ant))
		return FALSE // so these pass through friendlies
	..()
