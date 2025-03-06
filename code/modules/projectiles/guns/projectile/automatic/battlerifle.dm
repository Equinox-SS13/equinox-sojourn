/obj/item/gun/projectile/automatic/omnirifle
	name = "\"OMNI\" battle rifle"
	desc = "The \"M13A\" is versatile, reliable battle rifle chambered in 8.6x70mm - most commonly seen in the hands of SolFed infantrymen. It's especially hard to control without servos or a static mount."
	icon = 'icons/obj/guns/projectile/Omnirifle.dmi'
	icon_state = "omnirifle"
	item_state = "omnirifle"
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_HRIFLE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1)
	slot_flags = SLOT_BACK
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_HRIFLE|MAG_WELL_DRUM
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 10, MATERIAL_GLASS = 5, MATERIAL_DIAMOND = 3)
	price_tag = 1500
	penetration_multiplier = 1.1
	damage_multiplier = 1.2
	zoom_factors = list(0.4)
	init_recoil = RIFLE_RECOIL(1.0)
	fire_sound = 'sound/weapons/guns/fire/lmg_fire.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/sfrifle_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/sfrifle_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/rifle_boltforward.ogg'
	gun_tags = list(GUN_PROJECTILE, GUN_SCOPE, GUN_MAGWELL)
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/guns/interact/sfrifle_cock.ogg'

	init_firemodes = list(
	FULL_AUTO_300,
	SEMI_AUTO_NODELAY
	)
	serial_type = "Sol Fed"
	wield_delay = 1.6 SECOND
	wield_delay_factor = 0.5 // 50 vig to insta wield , heavy class battle rifle

	gun_parts = list(/obj/item/part/gun/frame/omni = 1, /obj/item/part/gun/grip/black = 1, /obj/item/part/gun/mechanism/autorifle = 1, /obj/item/part/gun/barrel/hrifle = 1)

/obj/item/gun/projectile/automatic/omnirifle/update_icon()
	..()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(ammo_magazine)
		add_overlay("_mag[ammo_magazine.max_ammo]")
	else
		cut_overlays()
		return

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/omnirifle/Initialize()
	. = ..()
	update_icon()

/obj/item/gun/projectile/automatic/omnirifle/scoped
	name = "\"Longarm\" marksman rifle"
	desc = "A standard-issue M13A2 SPR fashioned out of an Omnirifle, tailored for higher accuracy and penetration as well as better target acquisition capabilities. Chambered in 8.6x70mm."
	icon = 'icons/obj/guns/projectile/DMR.dmi'
	icon_state = "DMR"
	item_state = "DMR"
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 15, MATERIAL_GLASS = 10, MATERIAL_DIAMOND = 3)
	mag_well = MAG_WELL_HRIFLE
	gun_parts = null
	price_tag = 2000
	damage_multiplier = 1.2
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/guns/interact/sfrifle_cock.ogg'
	fire_sound = 'sound/weapons/guns/fire/sniper_fire.ogg'
	zoom_factors = list(1)
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL)
	init_recoil = RIFLE_RECOIL(0.7)
	penetration_multiplier = 1.35
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_2_ROUND,
		BURST_3_ROUND
		)
	serial_type = "H&S"
	gun_parts = null //To prevent meme decon of uniques

/obj/item/gun/projectile/automatic/omnirifle/scoped/fancy
	name = "\"Osprey\" sniper rifle"
	desc = "A purpose-made variant of the M13 rifle adopted by police marksmen and counter-terror units. Chambered in 8.6x70mm."
	icon = 'icons/obj/guns/projectile/Osprey.dmi'
	icon_state = "osprey"
	item_state = "osprey"
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 15, MATERIAL_GLASS = 10, MATERIAL_DIAMOND = 3)
	mag_well = MAG_WELL_HRIFLE
	price_tag = 2000
	init_recoil = RIFLE_RECOIL(0.7)
	init_firemodes = list(
		SEMI_AUTO_NODELAY
		)
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL)
	fire_sound = 'sound/weapons/guns/fire/sniper_fire.ogg'
	serial_type = "SD GmbH"


/obj/item/gun/projectile/automatic/omnirifle/rds
	name = "\"Warthog\" battle rifle"
	desc = "A modified M13 battle rifle outfitted with a proprietary holographic sight, commonly issued to Blackshield NCOs. Chambered in 8.6x70mm."
	icon = 'icons/obj/guns/projectile/Warthog.dmi'
	icon_state = "warthog"
	item_state = "warthog"
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 10, MATERIAL_GLASS = 5, MATERIAL_DIAMOND = 3)
	mag_well = MAG_WELL_HRIFLE|MAG_WELL_DRUM
	price_tag = 1750
	penetration_multiplier = 1.2
	damage_multiplier = 1.1
	init_recoil = RIFLE_RECOIL(0.8)
	zoom_factors = list(0.4)
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_3_ROUND
		)
	serial_type = "H&S"

	gun_parts = list(/obj/item/part/gun/frame/omni = 1, /obj/item/part/gun/grip/rubber = 1, /obj/item/part/gun/mechanism/autorifle = 1, /obj/item/part/gun/barrel/hrifle = 1)

/obj/item/part/gun/frame/omni
	name = "OMNI rifle frame"
	desc = "The receiver group of an M13A battle rifle."
	icon_state = "frame_omni"
	matter = list(MATERIAL_PLASTEEL = 8, MATERIAL_DIAMOND = 3)
	result = /obj/item/gun/projectile/automatic/omnirifle
	gripvars = list(/obj/item/part/gun/grip/black, /obj/item/part/gun/grip/rubber)
	resultvars = list(/obj/item/gun/projectile/automatic/omnirifle, /obj/item/gun/projectile/automatic/omnirifle/rds)
	mechanismvar = /obj/item/part/gun/mechanism/autorifle
	barrelvars = list(/obj/item/part/gun/barrel/hrifle)

/obj/item/gun/projectile/automatic/omnirifle/hustler
	name = "\"Hustler\" shotgun"
	desc = "A substantially heavier locally-made reproduction of the M13A OMNI rifle re-tooled and accessorized to fire shotgun rounds. Chambered in 20mm shells."
	icon = 'icons/obj/guns/projectile/Hustler.dmi'
	icon_state = "hustler"
	item_state = "hustler"
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_SHOTGUN
	slot_flags = SLOT_BACK
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_RIFLE
	matter = list(MATERIAL_PLASTEEL = 30, MATERIAL_PLASTIC = 15, MATERIAL_DIAMOND = 10)
	gun_parts = null
	price_tag = 2000
	penetration_multiplier = 1.1
	damage_multiplier = 1.3 //better than the saigini but no full auto
	zoom_factors = list(0.4)
	fire_delay = 12
	init_recoil = RIFLE_RECOIL(1.0) //less recoil than others, because we're so slow to fire/move
	fire_sound = 'sound/weapons/guns/fire/sbaw.ogg'
	unload_sound 	= 'sound/weapons/guns/interact/sfrifle_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/sfrifle_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/batrifle_cock.ogg'
	max_upgrades = 3//Starts good but less modifiable
	blacklist_upgrades = list(
							/obj/item/tool_upgrade/augment/expansion = TRUE,
							  )
	init_firemodes = list(
		SEMI_AUTO_NODELAY
		)

	gun_tags = list(GUN_PROJECTILE, GUN_SCOPE, GUN_MAGWELL, GUN_SIGHT)
