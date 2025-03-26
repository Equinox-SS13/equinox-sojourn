/obj/item/gun/projectile/automatic/vector
	name = "\"Trajectory\" SMG"
	desc = "An expensive submachine gun that utilizes a proprietary recoil mitigation system. Chambered in 10mm."
	icon = 'icons/obj/guns/projectile/vector.dmi' //A sprited Toriate sprite, Credit to Toriate(Sprite base and flow)
	icon_state = "vector"
	item_state = "vector"
	fire_sound = 'sound/weapons/guns/fire/vector_fire.ogg'
	auto_eject_sound = 'sound/weapons/vector_empty_alarm.ogg'
	unload_sound 	= 'sound/weapons/vector_empty_alarm.ogg'
	cocked_sound 	= 'sound/weapons/guns/interact/vector_cock.ogg'
	w_class = ITEM_SIZE_NORMAL
	caliber = CAL_MAGNUM
	can_dual = TRUE
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 3)
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	load_method = SINGLE_CASING|MAGAZINE
	mag_well = MAG_WELL_SMG|MAG_WELL_PISTOL
	matter = list(MATERIAL_PLASTEEL = 12, MATERIAL_PLASTIC = 12, MATERIAL_GLASS = 5, MATERIAL_SILVER = 3, MATERIAL_PLASMA = 2, MATERIAL_GOLD = 1) //Some rare ones so they dont just mass make this shift start without some good rng
	price_tag = 1000
	damage_multiplier = 0.7 //Not the best gun in the world
	init_recoil = SMG_RECOIL(1)
	gun_tags = list(GUN_PROJECTILE, GUN_MAGWELL, GUN_SILENCABLE, GUN_SCOPE)
	folding_stock = TRUE //we can fold are stocks

	auto_eject = TRUE //Eather a blessing or a curse, always can be fixed with a gunmod tho

	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		BURST_3_ROUND_NOLOSS,
		FULL_AUTO_600_NOLOSS
		)
	serial_type = "SA"

	wield_delay = 0.4 SECOND
	wield_delay_factor = 0.3 // Heavy smg , 30 vig to insta wield
	gun_parts = list(/obj/item/part/gun = 2, /obj/item/part/gun/grip/black = 1, /obj/item/part/gun/mechanism/smg = 1, /obj/item/part/gun/barrel/magnum = 1)

/obj/item/gun/projectile/automatic/vector/update_icon()
	..()
	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(!folded)
		iconstring += "_stock"

	if (ammo_magazine)
		if(ammo_magazine.max_ammo==30)
			iconstring += "_longmag"
		else
			iconstring += "_mag"

	if (!ammo_magazine || !length(ammo_magazine.stored_ammo))
		iconstring += "_slide"

	if(wielded)
		itemstring += "_doble"

	if (silenced)
		iconstring += "_s"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/projectile/automatic/vector/Initialize()
	. = ..()
	update_icon()
