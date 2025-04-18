/obj/item/gun/energy/lasercannon
	name = "\"Titanica\" laser cannon"
	desc = "An early iteration of man-portable energy weapons, currently outdated and of horrible quality in comparison to its successors."
	icon = 'icons/obj/guns/energy/lascannon.dmi'
	icon_state = "lasercannon"
	item_state = "lasercannon"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/energy/lasercannonfire.ogg'
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_POWER = 3) //Shows that its not as high tech but still rather smartly designed
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BACK //It's a cannon
	projectile_type = /obj/item/projectile/beam/heavylaser
	charge_cost = 100
	fire_delay = 20
	matter = list(MATERIAL_STEEL = 25, MATERIAL_SILVER = 6)
	price_tag = 650
	init_recoil = CARBINE_RECOIL(1)
	twohanded = TRUE
	init_firemodes = list(
		WEAPON_NORMAL
		)
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	serial_type = "H&S"

/obj/item/gun/energy/lasercannon/mounted
	name = "mounted laser cannon"
	self_recharge = TRUE
	use_external_power = TRUE
	damage_multiplier = 0.7 //Mounted cannon deals less do to being a mini-verson
	recharge_time = 10
	safety = FALSE
	restrict_safety = TRUE
	twohanded = FALSE

/obj/item/gun/energy/lasercannon/rnd
	name = "\"Solaris\" laser cannon"
	desc = "A proprietary in-colony modification of an outdated, early iteration of a laser gun."
	icon = 'icons/obj/guns/energy/si_lascannon.dmi'
	matter = list(MATERIAL_STEEL = 25, MATERIAL_SILVER = 4, MATERIAL_URANIUM = 1)
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	price_tag = 1500
	init_firemodes = list(
		WEAPON_NORMAL,
		WEAPON_CHARGE
		)
	serial_type = "SI"
