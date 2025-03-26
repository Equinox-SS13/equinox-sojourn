/obj/item/gun/projectile/boltgun/lever/shotgun
	name = "\"Mare's Leg\" repeating shotgun"
	desc = "A sawn-off Armstrong lever-action rifle. Re-chambered to 20mm."
	icon = 'icons/obj/guns/projectile/mares.dmi'
	icon_state = "mares"
	item_state = "mares"
	w_class = ITEM_SIZE_BULKY
	caliber = CAL_SHOTGUN
	fire_sound = 'sound/weapons/guns/fire/shotgun.ogg'
	max_shells = 6
	price_tag = 650
	init_recoil = HMG_RECOIL(1.0)
	damage_multiplier = 0.8
	penetration_multiplier = 0.9
	zoom_factors = list()
	extra_damage_mult_scoped = 0.2
	matter = list(MATERIAL_STEEL = 20, MATERIAL_WOOD = 6, MATERIAL_PLASTEEL = 7)
	serial_type = "INDEX"
	extra_bulk = -2
	gun_tags = list(GUN_PROJECTILE, GUN_INTERNAL_MAG, GUN_SCOPE)

/obj/item/gun/projectile/boltgun/lever/shotgun/bounty
	name = "\"Bounty\" bolt-action shotgun"
	desc = "A training shotgun meant for in-colony familiarisation with bolt-action rifles. Chambered in 20mm."
	icon = 'icons/obj/guns/projectile/bounty.dmi'
	damage_multiplier = 1.1
	penetration_multiplier = 0.7
	icon_state = "bounty"
	item_state = "bounty"
	price_tag = 950
	matter = list(MATERIAL_STEEL = 20, MATERIAL_PLASTIC = 6, MATERIAL_PLASTEEL = 7)
	serial_type = "NM"
