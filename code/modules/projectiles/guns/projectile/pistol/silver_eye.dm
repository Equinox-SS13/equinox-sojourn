/obj/item/gun/projectile/silvereye
	name = "\"Silver-Eye\" heavy pistol"
	desc = "An in-colony customized Basilisk pistol made for the Foreman. Chambered in 12mm."
	icon = 'icons/obj/guns/projectile/silvereye.dmi'
	icon_state = "silvereye"
	item_state = "silvereye"
	w_class = ITEM_SIZE_NORMAL
	caliber = CAL_50
	can_dual = TRUE
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	matter = list(MATERIAL_PLASTEEL = 18, MATERIAL_SILVER = 6, MATERIAL_WOOD = 6, MATERIAL_STEEL = 6)
	price_tag = 1250
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_PISTOL
	damage_multiplier = 1.2
	init_recoil = HANDGUN_RECOIL(1.1)
	penetration_multiplier = 1
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL, GUN_CALIBRE_12MM)

	init_firemodes = list(
		list(mode_name = "semiauto",  mode_desc = "Fire as fast as you can pull the trigger", burst=1, fire_delay=0.2, fire_stacks=0, move_delay=null, icon="semi"),
		list(mode_name="fire blast", mode_desc="Consumes one round to fire a burst of flame.", burst=1, fire_delay=0.2, fire_stacks=3, penetration_multiplier = 0.5, damage_multiplier = 0.8, icon="kill") //Worse than Kurtz incendiary.
		)

	reload_sound 	= 'sound/weapons/guns/interact/reload_silver.ogg'
	fire_sound = 'sound/weapons/guns/fire/fire_silver.ogg'
	serial_type = "NM"

	wield_delay = 0.6 SECOND
	wield_delay_factor = 0.6 // 60 vig

/obj/item/gun/projectile/silvereye/update_icon()
	..()

	var/iconstring = initial(icon_state)

	if (ammo_magazine)
		iconstring += "_mag"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	icon_state = iconstring

/obj/item/gun/projectile/silvereye/Initialize()
	. = ..()
	update_icon()
