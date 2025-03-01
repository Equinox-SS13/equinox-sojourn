/obj/item/gun/projectile/automatic/bren
	name = "\"Bren\" light machine gun"
	desc = "A select-fire top-loaded light machine gun chambered in 6.5mm. At a closer inspection, it seems to be the gruesome result of mental illness and an AK-pattern rifle."
	icon = 'icons/obj/guns/projectile/bren.dmi'
	icon_state = "bren"
	item_state = "bren"
	w_class = ITEM_SIZE_BULKY
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_LRIFLE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ILLEGAL = 4)
	slot_flags = SLOT_BACK
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_RIFLE
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 10, MATERIAL_PLASTIC = 3, MATERIAL_WOOD = 12)
	price_tag = 900
	damage_multiplier = 0.9
	fire_sound = 'sound/weapons/guns/fire/ltrifle_fire.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/ltrifle_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/ltrifle_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/ltrifle_cock.ogg'
	init_recoil = LMG_RECOIL(1)
	twohanded = TRUE
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL)
	gun_parts = null

	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		FULL_AUTO_600,
		BURST_5_ROUND,
		BURST_8_ROUND,
		list(mode_name="suppressing fire", mode_desc = "Long, uncontrolled bursts",  burst=16, burst_delay=1.2, move_delay=11,  icon="burst")
		)
	serial_type = "INDEX"
	serial_shown = FALSE

/obj/item/gun/projectile/automatic/bren/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "mag[ammo_magazine.max_ammo]": ""]"
		itemstring += "_full"

	if(wielded)
		itemstring += "_doble"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/bren/Initialize()
	. = ..()
	update_icon()
