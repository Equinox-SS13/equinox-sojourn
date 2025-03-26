/obj/item/gun/projectile/boltgun/scout
	name = "\"Magnum\" sniper rifle"
	desc = "An extremely accurate bolt-action sniper rifle used by Colonial hostage rescue marksmen when the situation has absolutely no margin for error. Chambered in 8.6mm."
	icon = 'icons/obj/guns/projectile/heavyboltgun.dmi'
	icon_state = "boltgun"
	item_state = "boltgun"
	force = WEAPON_FORCE_PAINFUL
	damage_multiplier = 1.5
	penetration_multiplier  = 1.5
	extra_damage_mult_scoped = 0.2
	init_recoil = HMG_RECOIL(0.8)
	max_shells = 5
	zoom_factors = list(2.0)
	price_tag = 1500
	sharp = 0
	caliber = CAL_HRIFLE
	load_method = SINGLE_CASING|SPEEDLOADER
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 10, MATERIAL_GLASS = 10)
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	gun_tags = list(GUN_PROJECTILE, GUN_INTERNAL_MAG, GUN_SILENCABLE)
	fire_sound = 'sound/weapons/guns/fire/sniper_fire.ogg'
	saw_off = TRUE
	sawn = /obj/item/gun/projectile/boltgun/sawn/scout
	slowdown_hold = 1
	serial_type = "H&S"

	wield_delay = 0.4 SECOND
	wield_delay_factor = 0.3 // 30 vig, little heavier than normal
	gun_parts = list(/obj/item/part/gun/frame/scout = 1, /obj/item/part/gun/grip/rubber = 1, /obj/item/part/gun/mechanism/boltgun = 1, /obj/item/part/gun/barrel/hrifle = 1)

/obj/item/part/gun/frame/scout
	name = "Magnum rifle frame"
	desc = "A \"Magnum\" bolt-action sniper rifle frame."
	icon_state = "frame_scout"
	resultvars = list(/obj/item/gun/projectile/boltgun/scout)
	gripvars = list(/obj/item/part/gun/grip/rubber)
	mechanismvar = /obj/item/part/gun/mechanism/boltgun
	barrelvars = list(/obj/item/part/gun/barrel/hrifle)

/obj/item/gun/projectile/boltgun/sawn/scout
	name = "\"Hand of God\" sawn-off sniper rifle"
	desc = "A pocketable sawn-off bolt-action sniper rifle with an apt nickname, it's in the shooter's interest not to miss. Chambered in 8.6mm."
	icon = 'icons/obj/guns/projectile/sawnoff/heavyboltgun.dmi'
	icon_state = "obrez"
	item_state = "obrez"
	caliber = CAL_HRIFLE
	load_method = SINGLE_CASING|SPEEDLOADER
	fire_delay = 18
	max_shells = 5
	init_recoil = HMG_RECOIL(1.2)
	saw_off = FALSE
	slowdown_hold = FALSE
	serial_type = "H&S"
	gun_parts = list(/obj/item/part/gun/grip/rubber = 1, /obj/item/part/gun/mechanism/boltgun = 1, /obj/item/stack/material/plasteel = 2)

