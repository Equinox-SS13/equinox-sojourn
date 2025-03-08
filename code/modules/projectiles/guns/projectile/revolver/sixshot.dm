/obj/item/gun/projectile/revolver/sixshot
	name = "\"Six-Shot\" revolver shotgun"
	desc = "A rare rifle-sized revolver fitted with a handguard and a stock. Chambered in 20mm."
	icon = 'icons/obj/guns/projectile/sixshot.dmi'
	icon_state = "sixshot"
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	slot_flags = SLOT_BACK
	caliber = CAL_SHOTGUN
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	max_shells = 6
	fire_sound = 'sound/weapons/guns/fire/shotgun.ogg'
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 15, MATERIAL_STEEL = 5)
	price_tag = 500
	damage_multiplier = 0.8
	init_recoil = RIFLE_RECOIL(2)
	saw_off = TRUE
	sawn = /obj/item/gun/projectile/revolver/sixshot/sawn
	gun_tags = list(GUN_PROJECTILE, GUN_INTERNAL_MAG, GUN_REVOLVER)
	serial_type = "SA"

	wield_delay = 1 SECOND
	wield_delay_factor = 0.4 // 40 vig
	gun_parts = list(/obj/item/part/gun/frame/sixshot = 1, /obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/revolver = 1, /obj/item/part/gun/barrel/shotgun = 1)

/obj/item/part/gun/frame/sixshot
	name = "Six-Shot frame"
	desc = "A Six-Shot revolving shotgun frame. Classy."
	icon_state = "frame_revolver"
	result = /obj/item/gun/projectile/revolver/sixshot
	resultvars = list(/obj/item/gun/projectile/revolver/sixshot)
	gripvars = list(/obj/item/part/gun/grip/wood)
	mechanismvar = /obj/item/part/gun/mechanism/revolver
	barrelvars = list(/obj/item/part/gun/barrel/shotgun)

/obj/item/gun/projectile/revolver/sixshot/conversion
	name = "\"Ten-Shot\" revolver shotgun"
	desc = "An unorthodox belt-fed revolver fitted with a stock and handguard. Chambered in 20mm."
	icon = 'icons/obj/guns/projectile/sixshotconversion.dmi'
	icon_state = "sixshot_belt"
	max_shells = 10
	matter = list(MATERIAL_PLASTEEL = 24, MATERIAL_WOOD = 15, MATERIAL_STEEL = 5)
	price_tag = 600
	init_recoil = RIFLE_RECOIL(3)
	saw_off = FALSE
	serial_type = "AG"

/obj/item/gun/projectile/revolver/sixshot/update_icon()
	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(wielded)
		itemstring += "_doble"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/revolver/sixshot/sawn
	name = "sawn-off \"Six-Shot\" revolving shotgun"
	desc = "A revolver rifle turned regular revolver again. Chambered in 20mm."
	icon = 'icons/obj/guns/projectile/sawnoff/sixshot.dmi'
	w_class = ITEM_SIZE_NORMAL
	force = WEAPON_FORCE_PAINFUL
	slot_flags = SLOT_BACK|SLOT_BELT|SLOT_HOLSTER
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_WOOD = 5, MATERIAL_STEEL= 5)
	price_tag = 250
	damage_multiplier = 0.7
	penetration_multiplier = 0.8
	init_recoil = RIFLE_RECOIL(2.3)

	wield_delay = 0.8 SECOND
	wield_delay_factor = 0.6 // 60 vig
	gun_parts = list( /obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/revolver = 1, /obj/item/stack/material/plasteel = 2)

