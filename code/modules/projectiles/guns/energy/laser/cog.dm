/obj/item/gun/energy/cog
	name = "\"Cog\" laser carbine"
	icon = 'icons/obj/guns/energy/cog.dmi'
	icon_state = "cog"
	item_state = null	//so the human update icon uses the icon_state instead.
	item_charge_meter = TRUE
	desc = "A now outdated laser rifle, widely considered the first succesful commercial man-portable projectile energy weapon."
	fire_sound = 'sound/weapons/energy/Laser.ogg' // Leaving the OG sound as it's not only iconic but also fitting for an old gun
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_BULKY
	matter = list(MATERIAL_STEEL = 10, MATERIAL_PLASTIC = 15, MATERIAL_GLASS = 5)
	projectile_type = /obj/item/projectile/beam
	fire_delay = 10 //old technology
	charge_cost = 50
	price_tag = 800
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	init_firemodes = list(
		WEAPON_NORMAL
	)
	twohanded = TRUE
	serial_type = "GP"
	max_upgrades = 4 //Older platform meaning 1 less

	wield_delay = 0.4 SECOND
	wield_delay_factor = 0.2 // 20 vig
	allow_greyson_mods = TRUE

/obj/item/gun/energy/cog/gear
	name = "\"Gear\" laser carbine"
	desc = "A modified Cog laser rifle with the ability to fire non-lethal shots at the cost of efficiency."
	icon = 'icons/obj/guns/energy/cog_alt.dmi' // Using their proper sprite now
	w_class = ITEM_SIZE_BULKY
	fire_delay = 7 // Old platform improved by Marshals
	projectile_type = /obj/item/projectile/beam/stun
	matter = list(MATERIAL_STEEL = 10, MATERIAL_PLASTIC = 15, MATERIAL_SILVER = 10)
	init_firemodes = list(
		list(mode_name="stun", mode_desc="fires a concentrated stun beam", projectile_type=/obj/item/projectile/beam/stun, charge_cost = 100, icon="stun", fire_sound='sound/weapons/energy/Taser3.ogg'),
		list(mode_name="lethal", mode_desc="fires a concentrated laser blast", projectile_type=/obj/item/projectile/beam, charge_cost = 50, icon="kill", fire_sound='sound/weapons/energy/laser_rifle.ogg')
	)
	serial_type = "NM"
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	allow_greyson_mods = FALSE

/obj/item/gun/energy/cog/sprocket
	name = "\"Sprocket\" laser carbine"
	desc = "An extensive in-colony modification of the Cog laser rifle fitted with a folding stock. Fires special non-lethal shots at the cost of crippling power inefficiency."
	icon = 'icons/obj/guns/energy/sprocket.dmi'
	icon_state = "sprocket"
	damage_multiplier = 0.9 // +0.1 when unfolded = baseline Cog
	penetration_multiplier = 0.8 // +0.2 when unfolded = base Cog
	projectile_type = /obj/item/projectile/beam/hardstun // Snowflake 100% nonlethal projectile with reduced firerate
	w_class = ITEM_SIZE_NORMAL // Starts folded, bulk added when unfolded FAR surpasses BULKY class
	folding_stock = TRUE // Foldable stock for easy carry
	price_tag = 1000
	fire_delay = 5 // Old platform modded to hell and tinkered by two factions
	matter = list(MATERIAL_STEEL = 10, MATERIAL_PLASTIC = 10, MATERIAL_SILVER = 10)
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	init_firemodes = list(
		list(mode_name="stun", mode_desc="fires a highly concentrated stun beam", projectile_type=/obj/item/projectile/beam/hardstun, charge_cost = 200, fire_delay=40, icon="grenade", fire_sound='sound/weapons/energy/sprocket.ogg'), // Three shots on a T1 M-cell should be enough to reduce someone
		list(mode_name="lethal", mode_desc="Fires a concentrated laser blast", projectile_type=/obj/item/projectile/beam, charge_cost = 50, icon="kill", fire_sound='sound/weapons/energy/laser_rifle.ogg')
	)
	max_upgrades = 3 // Already tinkered enough, smaller frame, good stats
	blacklist_upgrades = list(/obj/item/gun_upgrade/mechanism/greyson_master_catalyst = TRUE, // No warcrimes in medbay please
							  /obj/item/tool_upgrade/augment/expansion = TRUE, // No cheating either. You get three upgrades, make the most of them.
							  )
	serial_type = "GP-SI"
	allow_greyson_mods = FALSE

/obj/item/gun/energy/cog/sprocket/update_icon() // Necessary for the folded and unfolded states
	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(charge_meter)
		var/ratio = 0

		if(cell && cell.charge >= charge_cost)
			ratio = cell.charge / cell.maxcharge
			ratio = min(max(round(ratio, 0.25) * 100, 25), 100)

		if(modifystate)
			iconstring = "[modifystate][ratio]"
		else
			iconstring = "[initial(icon_state)][ratio]"

		if(item_charge_meter)
			itemstring += "-[item_modifystate][ratio]"

	if(wielded)
		itemstring += "_double"

	if(!folded)
		iconstring += "_stock"

	icon_state = iconstring
	set_item_state(itemstring)

/obj/item/gun/energy/cog/sprocket/preloaded // Preloaded version for the medic gear

/obj/item/gun/energy/cog/sprocket/preloaded/New()
	cell = new /obj/item/cell/medium/moebius/high(src)
	. = ..()
	update_icon()

/obj/item/gun/energy/cog/sawn
	name = " \"Pinion\" laser pistol"
	icon = 'icons/obj/guns/energy/obrez_retro.dmi'
	desc = "A variant of the Cog laser rifle turned into an otherwise mediocre handgun."
	icon_state = "shorty"
	item_state = "shorty"
	fire_sound = 'sound/weapons/energy/laser_pistol.ogg'
	slot_flags = SLOT_BACK|SLOT_HOLSTER
	matter = list(MATERIAL_STEEL = 5, MATERIAL_PLASTIC = 10, MATERIAL_GLASS = 5)
	damage_multiplier = 0.7
	penetration_multiplier = 0.7
	charge_cost = 50
	price_tag = 400
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	init_firemodes = list(
		WEAPON_NORMAL
	)
	twohanded = FALSE
	init_recoil = HANDGUN_RECOIL(0.2)
	serial_type = "GP-SI"
	allow_greyson_mods = FALSE
