/obj/item/gun/projectile/deaglebolt
	name = "\"Triple Primary\" heavy pistol"
	desc = "An anomalous weapon that takes after the appearance of the Basilisk, with the ability to swap it's chamber on demand. Chambered in 9mm, 10mm, and 12mm."
	icon = 'icons/obj/guns/projectile/deaglebolt.dmi'
	icon_state = "deagle"
	item_state = "deagle"
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_50
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_PISTOL|MAG_WELL_H_PISTOL
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 8)
	price_tag = 1750
	can_dual = TRUE
	damage_multiplier = 1.4
	penetration_multiplier = 1.3
	init_recoil = HANDGUN_RECOIL(1.3)
	fire_sound 		= 'sound/weapons/guns/fire/deagle_fire.ogg' // Sound taken from JSRS SOUND MOD https://www.moddb.com/mods/stalker-anomaly/addons/solarint-gunshot-overhaul
	unload_sound 	= 'sound/weapons/guns/interact/hpistol_magout.ogg'
	reload_sound 	= 'sound/weapons/guns/interact/hpistol_magin.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/hpistol_cock.ogg'
	auto_eject = 1
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL, GUN_CALIBRE_12MM, GUN_CALIBRE_9MM)
	serial_type = "BlueCross"

	wield_delay = 0.6 SECOND
	wield_delay_factor = 0.6 // 60 vig

/obj/item/gun/projectile/deaglebolt/verb/change_caliber()
	set name = "Change Caliber"
	set desc = "Adapt the chamber of your weapon for a new caliber on the fly."
	set category = "Object"

	playsound(src.loc, 'sound/weapons/guns/interact/chaingun_cock.ogg', 100, 1)
	if(caliber == CAL_50)
		caliber = CAL_PISTOL
		fire_sound = 'sound/weapons/guns/fire/pistol_fire.ogg'
		visible_message(SPAN_NOTICE("\The [usr] flicks a switch to the third position on \the [src], a beep and a metallic whirr are heard before the screen says '9MM'"), \
		SPAN_NOTICE("You hear something metallic whirr and beep."))
	else if(caliber == CAL_PISTOL)
		caliber = CAL_MAGNUM
		fire_sound = 'sound/weapons/guns/fire/1911_fire.ogg'
		visible_message(SPAN_NOTICE("\The [usr] flicks a switch to the second position on \the [src], a beep and a metallic whirr are heard before the screen says '10MM'!"), \
		SPAN_NOTICE("You hear something metallic whirr and beep."))
	else if (caliber == CAL_MAGNUM)
		caliber = CAL_50
		fire_sound = initial(fire_sound)
		visible_message(SPAN_NOTICE("\The [usr] flicks a switch to the first position on \the [src], a beep and a metallic whirr are heard before the screen says '12MM'!"), \
		SPAN_NOTICE("You hear something metallic whirr and beep."))
	refresh_upgrades()
