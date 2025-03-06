/obj/item/gun/projectile/automatic/thompson
	name = "\"Tommy\" SMG"
	desc = "A reproduction Thompson SMG from the days of old, originally intended for use in combat recreations and rare in physical museums."
	icon = 'icons/obj/guns/projectile/thompson.dmi'
	icon_state = "thompson"
	item_state = "thompson"
	w_class = ITEM_SIZE_BULKY
	extra_bulk = -2
	twohanded = TRUE
	force = WEAPON_FORCE_NORMAL
	caliber = CAL_MAGNUM
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	slot_flags = SLOT_BACK
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_SMG|MAG_WELL_PISTOL
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 14, MATERIAL_WOOD = 12)
	price_tag = 850
	penetration_multiplier = 0.8
	init_recoil = SMG_RECOIL(0.8)
	fire_sound = 'sound/weapons/guns/fire/grease_fire.ogg'
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL, GUN_SILENCABLE, GUN_SCOPE)
	init_firemodes = list(
		FULL_AUTO_600_NOLOSS,
		BURST_3_ROUND_NOLOSS,
		BURST_5_ROUND_NOLOSS
		)
	serial_type = "Sol Fed"

	wield_delay = 0.4 SECOND
	wield_delay_factor = 0.3 // Heavy smg , 30 vig to insta wield
	gun_parts = list(/obj/item/part/gun/frame/thompson = 1, /obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/smg = 1, /obj/item/part/gun/barrel/magnum = 1)

/obj/item/gun/projectile/automatic/thompson/update_icon()
	..()
	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		if(ammo_magazine.max_ammo==30)
			iconstring += "_longmag"
		else
			iconstring += "_mag"

	if(wielded)
		itemstring += "_doble"

	if (silenced)
		iconstring += "_s"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/thompson/Initialize()
	. = ..()
	update_icon()

/obj/item/part/gun/frame/thompson
	name = "Thompson frame"
	desc = "A Thompson SMG frame. Just like in the gangster movies!"
	icon_state = "frame_thompson"
	matter = list(MATERIAL_PLASTEEL = 4, MATERIAL_STEEL = 4)
	result = /obj/item/gun/projectile/automatic/thompson
	resultvars = list(/obj/item/gun/projectile/automatic/thompson)
	gripvars = list(/obj/item/part/gun/grip/wood)
	mechanismvar = /obj/item/part/gun/mechanism/smg
	barrelvars = list(/obj/item/part/gun/barrel/magnum)
