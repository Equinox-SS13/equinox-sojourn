/obj/item/gun/projectile/automatic/duty
	name = "\"Duty\" carbine"
	desc = "A versatile mag-fed infantry rifle proprietary to the colony. Chambered in 6.5mm, fitted with a stripper clip guide."
	icon = 'icons/obj/guns/projectile/duty.dmi'
	icon_state = "duty"
	item_state = "duty"
	w_class = ITEM_SIZE_BULKY
	caliber = CAL_LRIFLE
	mag_well = MAG_WELL_RIFLE
	load_method = SINGLE_CASING|SPEEDLOADER|MAGAZINE
	matter = list(MATERIAL_PLASTEEL = 25, MATERIAL_PLASTIC = 25)
	price_tag = 900
	penetration_multiplier = 1.2
	damage_multiplier = 1.2
	init_recoil = CARBINE_RECOIL(1.0)
	fire_sound = 'sound/weapons/guns/fire/carbine.ogg'
	force = WEAPON_FORCE_ROBUST
	gun_tags = list(GUN_PROJECTILE, GUN_BAYONET, GUN_SCOPE)
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_2_ROUND,
		FULL_AUTO_200
		)
	serial_type = "NM"
	gun_parts = list(/obj/item/part/gun/frame/discountnordwind = 1, /obj/item/part/gun/grip/black = 1, /obj/item/part/gun/mechanism/autorifle = 1, /obj/item/part/gun/barrel/srifle = 1)

/obj/item/gun/projectile/automatic/duty/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"
		itemstring += "_full"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	icon_state = iconstring
	set_item_state(itemstring)

//SNOWFLAKE CODE
//TODO make all projectile guns work like this with a flag

/obj/item/part/gun/frame/discountnordwind
	name = "Blackshield rifle frame"
	desc = "A lightweight rifle frame, matches the receiver profile of both the Duty and Watchtower rifles."
	icon_state = "frame_serbrifle"
	result = /obj/item/gun/projectile/automatic/duty
	gripvars = list(/obj/item/part/gun/grip/black, /obj/item/part/gun/grip/serb)
	mechanismvar = /obj/item/part/gun/mechanism/autorifle
	barrelvars = list(/obj/item/part/gun/barrel/srifle, /obj/item/part/gun/barrel/lrifle)
	resultvars = list(/obj/item/gun/projectile/automatic/duty, /obj/item/gun/projectile/automatic/nordwind/watchtower)
