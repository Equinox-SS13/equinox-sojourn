/obj/item/gun/projectile/automatic/greasegun
	name = "\"Greaser\" SMG"
	desc = "A slow-firing integrally suppressed submachine gun made out of mostly sheet metal. Chambered in 9mm."
	icon = 'icons/obj/guns/projectile/greasegun.dmi'
	icon_state = "greasegun"
	item_state = "greasegun"
	w_class = ITEM_SIZE_NORMAL
	force = WEAPON_FORCE_NORMAL
	caliber = CAL_PISTOL
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	slot_flags = SLOT_BELT
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_SMG
	matter = list(MATERIAL_PLASTEEL = 28, MATERIAL_PLASTIC = 10)
	price_tag = 800
	penetration_multiplier = 1.2
	init_recoil = SMG_RECOIL(0.8)
	fire_sound = 'sound/weapons/guns/fire/grease_fire.ogg'
	gun_tags = list(GUN_PROJECTILE, GUN_CALIBRE_9MM, GUN_MAGWELL)
	init_firemodes = list(
		FULL_AUTO_600_NOLOSS,
		SEMI_AUTO_NODELAY
		)
	serial_type = "Sol Fed"

	wield_delay = 0.5 SECOND
	wield_delay_factor = 0.1 // 10 vig
	gun_parts = list(/obj/item/part/gun/frame/grease = 1, /obj/item/part/gun/grip/black = 1, /obj/item/part/gun/mechanism/smg = 1, /obj/item/part/gun/barrel/pistol = 1)

/obj/item/gun/projectile/automatic/greasegun/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	icon_state = iconstring
	item_state = itemstring

/obj/item/part/gun/frame/grease
	name = "Greaser frame"
	desc = "A cheap frame for a Greaser SMG."
	icon_state = "frame_grease"
	result = /obj/item/gun/projectile/automatic/greasegun
	gripvars = list(/obj/item/part/gun/grip/black)
	resultvars = list(/obj/item/gun/projectile/automatic/greasegun)
	mechanismvar = /obj/item/part/gun/mechanism/smg
	barrelvars = list(/obj/item/part/gun/barrel/pistol)
