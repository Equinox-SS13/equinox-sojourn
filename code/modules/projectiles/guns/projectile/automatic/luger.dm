/obj/item/gun/projectile/automatic/luger
	name = "\"Lemun\" SMG"
	desc = "A cheap submachine gun born from a commercial parts kit for an equally cheap pistol. Chambered in 9mm."
	icon = 'icons/obj/guns/projectile/luger.dmi'
	icon_state = "luger"
	item_state = "luger"
	w_class = ITEM_SIZE_NORMAL
	caliber = CAL_PISTOL
	mag_well = MAG_WELL_PISTOL|MAG_WELL_SMG|MAG_WELL_H_PISTOL|MAG_WELL_DRUM
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_WOOD = 6, MATERIAL_STEEL = 10)
	price_tag = 600
	gun_tags = list(GUN_PROJECTILE, GUN_CALIBRE_9MM)
	damage_multiplier = 1
	init_recoil = SMG_RECOIL(0.9)
	load_method = SINGLE_CASING|MAGAZINE
	init_firemodes = list(
		FULL_AUTO_600_NOLOSS,
		SEMI_AUTO_NODELAY,
		)
	serial_type = ""

	wield_delay = 0.5 SECOND
	wield_delay_factor = 0.1 // 10 vig
	gun_parts = list(/obj/item/part/gun/frame/luger = 1, /obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/smg = 1, /obj/item/part/gun/barrel/pistol = 1)

/obj/item/gun/projectile/automatic/luger/update_icon()
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

/obj/item/part/gun/frame/luger
	name = "Lemun frame"
	desc = "A frame for the Lemun SMG."
	icon_state = "frame_luger"
	result = /obj/item/gun/projectile/automatic/luger
	gripvars = list(/obj/item/part/gun/grip/wood)
	resultvars = list(/obj/item/gun/projectile/automatic/luger)
	mechanismvar = /obj/item/part/gun/mechanism/smg
	barrelvars = list(/obj/item/part/gun/barrel/pistol)

