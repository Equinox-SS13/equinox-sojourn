/obj/item/gun/projectile/automatic/bastard
	name = "\"Bastard\" light machine gun"
	desc = "A compact and unreliable machine gun carefully pieced together with a solyanka of scrap and leftover parts. Chambered in 6.5mm."
	icon = 'icons/obj/guns/projectile/bastard.dmi'
	icon_state = "bastard"
	item_state = "bastard"
	w_class = ITEM_SIZE_NORMAL
	force = WEAPON_FORCE_NORMAL
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_LINKED_BOX
	caliber = CAL_LRIFLE
	tac_reloads = FALSE
	penetration_multiplier = 0.8
	damage_multiplier = 0.9
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 4, MATERIAL_STEEL = 15)
	price_tag = 1000
	fire_sound = 'sound/weapons/guns/fire/sfrifle_fire.ogg'
	init_recoil = LMG_RECOIL(0.7)

	init_firemodes = list(
		BURST_5_ROUND,
		FULL_AUTO_600
		)
	serial_type = "NM"

	wield_delay = 0.6 SECOND
	wield_delay_factor = 0.2 // 20 vig
	gun_parts = list(/obj/item/part/gun/frame/bastard = 1, /obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/smg = 1, /obj/item/part/gun/barrel/srifle = 1)

/obj/item/gun/projectile/automatic/bastard/update_icon()
	var/iconstring = initial(icon_state)
	var/itemstring = ""
	if (ammo_magazine)
		var/percent = (ammo_magazine.stored_ammo.len / ammo_magazine.max_ammo) * 100
		var/number = round(percent, 25)
		iconstring += "[number]"
	else
		iconstring += "-empty"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/part/gun/frame/bastard
	name = "Bastard frame"
	desc = "A Bastard LMG frame."
	icon_state = "frame_bastard"
	result = /obj/item/gun/projectile/automatic/bastard
	resultvars = list(/obj/item/gun/projectile/automatic/bastard)
	gripvars =  list(/obj/item/part/gun/grip/wood)
	mechanismvar = /obj/item/part/gun/mechanism/smg
	barrelvars =  list(/obj/item/part/gun/barrel/srifle)
