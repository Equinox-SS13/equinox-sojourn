/obj/item/gun/projectile/automatic/luty
	name = "\"Ghost\" printed SMG"
	desc = "\"Live free or die. These are not empty words.\"\
	An extremely simple submachine gun that can be produced with no engineering experience and minimal technical knowledge. Chambered in 9mm."
	icon = 'icons/obj/guns/projectile/luty.dmi'
	icon_state = "luty"
	item_state = "luty"
	w_class = ITEM_SIZE_NORMAL
	can_dual = TRUE
	caliber = CAL_PISTOL
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	ammo_type = /obj/item/ammo_casing/pistol_35
	load_method = MAGAZINE
	mag_well = MAG_WELL_PISTOL|MAG_WELL_H_PISTOL|MAG_WELL_SMG
	matter = list(MATERIAL_STEEL = 10, MATERIAL_PLASTIC = 5, MATERIAL_WOOD = 12)
	init_firemodes = list(
		FULL_AUTO_300,
		SEMI_AUTO_NODELAY,
		)
	can_dual = 1
	damage_multiplier = 0.8
	penetration_multiplier = 0.6
	init_recoil = SMG_RECOIL(0.6)
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	serial_type = "INDEX"
	serial_shown = FALSE
	gun_tags = list(GUN_PROJECTILE, GUN_SILENCABLE, GUN_CALIBRE_9MM, GUN_MAGWELL)
	gun_parts = list(/obj/item/part/gun/frame/luty = 1, /obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/smg/steel = 1, /obj/item/part/gun/barrel/pistol/steel = 1)

	wield_delay = 0 // No delay for this , its litteraly a junk gun

/obj/item/part/gun/frame/luty
	name = "Ghost gun frame"
	desc = "The frame for a 3D printed gun."
	icon_state = "frame_luty"
	matter = list(MATERIAL_STEEL = 5)
	resultvars = list(/obj/item/gun/projectile/automatic/luty)
	gripvars = list(/obj/item/part/gun/grip/rubber)
	mechanismvar = /obj/item/part/gun/mechanism/smg/steel
	barrelvars = list(/obj/item/part/gun/barrel/pistol/steel, /obj/item/part/gun/barrel/magnum/steel)	//9mm or 10mm.
	nra = FALSE		//This controls if the weapon checks for barrels or not. If you want a gun to have MULTIPLE calibers that it can be chambered in, put FALSE.

/obj/item/gun/projectile/automatic/luty/update_icon()
	..()
	cut_overlays()

	var/iconstring = initial(icon_state)

	iconstring = "[initial(icon_state)][safety ? "_safe" : ""]"

	if (ammo_magazine)
		iconstring += "-full"

	if (silenced)
		iconstring += "_s"

	icon_state = iconstring

/obj/item/gun/projectile/automatic/luty/Initialize()
	. = ..()
	update_icon()

/obj/item/gun/projectile/automatic/luty/toggle_safety()
	. = ..()
	update_icon()
