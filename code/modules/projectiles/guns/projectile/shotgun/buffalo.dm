/obj/item/gun/projectile/automatic/buff_autoshotgun
	name = "\"Buffalo\" tactical shotgun" //With correct mods this can be better then the pug
	desc = "A lightweight and versatile semi-automatic breaching shotgun. Chambered in 20mm, fitted with a holographic sight."
	icon = 'icons/obj/guns/projectile/buffalo.dmi'
	icon_state = "buffalo"
	item_state = "buffalo"
	max_shells = 8
	w_class = ITEM_SIZE_HUGE
	force = WEAPON_FORCE_PAINFUL
	flags = CONDUCT
	slot_flags = SLOT_BACK
	caliber = CAL_SHOTGUN
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	load_method = SINGLE_CASING
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	handle_casings = EJECT_CASINGS
	fire_sound = 'sound/weapons/guns/fire/buffalo.ogg'
	bulletinsert_sound 	= 'sound/weapons/guns/interact/shotgun_insert.ogg'
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_PLASTIC = 10)
	price_tag = 800
	penetration_multiplier = 1.8
	pierce_multiplier = 2
	damage_multiplier = 0.8
	init_recoil = RIFLE_RECOIL(1.4)
	gun_tags = list(GUN_PROJECTILE, GUN_INTERNAL_MAG, GUN_SCOPE)
	saw_off = FALSE
	init_firemodes = list(
		list(mode_name="semiauto", mode_desc="Shoot once per pull after chambering", burst=1, fire_delay=5, move_delay=null, icon="semi")
		)
	serial_type = "NM"
