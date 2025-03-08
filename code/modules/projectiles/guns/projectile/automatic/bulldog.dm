/obj/item/gun/projectile/automatic/bulldog
	name = "\"Bulldog\" carbine"
	desc = "An economy-class carbine manufactured by S.D. GmbH and used as a common rifle for security and police forces across the universe. Chambered in 6.5mm Carbine."
	icon = 'icons/obj/guns/projectile/bulldog.dmi'
	icon_state = "bulldog"
	item_state = "bulldog"
	w_class = ITEM_SIZE_BULKY
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_RIFLE
	caliber = CAL_LRIFLE
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	slot_flags = SLOT_BELT
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 12)
	price_tag = 1100
	gun_parts = list(/obj/item/part/gun/frame/bulldog = 1, /obj/item/part/gun/grip/black = 1, /obj/item/part/gun/mechanism/autorifle = 1, /obj/item/part/gun/barrel/srifle = 1)
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	init_recoil = CARBINE_RECOIL(1)
	gun_tags = list(GUN_PROJECTILE, GUN_SCOPE, GUN_MAGWELL)

	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_3_ROUND
		)
	serial_type = "SD GmbH"

/obj/item/gun/projectile/automatic/bulldog/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if (ammo_magazine)
		iconstring += "[ammo_magazine? "_mag[ammo_magazine.max_ammo]": ""]"
		itemstring += "_full"

	if(wielded)
		itemstring += "_doble"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/bulldog/Initialize()
	. = ..()
	update_icon()

/obj/item/part/gun/frame/bulldog
	name = "K9-series frame"
	desc = "A K9-series frame. Predecesor to the Wind-series, remains largely popular with low budget security firms. Can be assembled into a Bulldog or a Pitbull."
	icon_state = "frame_bull"
	result = /obj/item/gun/projectile/automatic/bulldog
	resultvars = list(/obj/item/gun/projectile/automatic/bulldog, /obj/item/gun/projectile/automatic/pitbull)
	gripvars = list(/obj/item/part/gun/grip/black, /obj/item/part/gun/grip/serb)
	mechanismvar = /obj/item/part/gun/mechanism/autorifle
	barrelvars = list(/obj/item/part/gun/barrel/srifle)

/obj/item/gun/projectile/automatic/bulldog/rds
	name = "\"Bulldog Tactical\" carbine"
	desc = "An economy-class carbine manufactured by S.D. GmbH, fitted with an aftermarket holographic sight for improved target acquisition. Chambered in 6.5mm Carbine."
	icon = 'icons/obj/guns/projectile/bulldog_rds.dmi'
	icon_state = "bulldog_rds"
	item_state = "bulldog_rds"
	price_tag = 1225
	zoom_factors = list(0.3)
