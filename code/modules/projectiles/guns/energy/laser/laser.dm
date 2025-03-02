/obj/item/gun/energy/laser
	name = "\"Lightfall\" laser rifle"
	desc = "A reliable run of the mill church-made laser rifle."
	icon = 'icons/obj/guns/energy/laser.dmi' // No longer scoped, stop the lies!
	icon_state = "laser"
	item_state = "laser"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/energy/laser_rifle.ogg'
	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_BULKY
	force = WEAPON_FORCE_NORMAL
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_WOOD = 8, MATERIAL_SILVER = 6)
	price_tag = 900
	projectile_type = /obj/item/projectile/beam/midlaser
	fire_delay = 5
	charge_cost = 50
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	init_firemodes = list(
		WEAPON_NORMAL,
		WEAPON_CHARGE
	)
	twohanded = TRUE
	serial_type = "Absolute"

	wield_delay = 0.4 SECOND
	wield_delay_factor = 0.2 // 20 vig

/obj/item/gun/energy/laser/mounted
	self_recharge = TRUE
	use_external_power = TRUE
	safety = FALSE
	restrict_safety = TRUE
	damage_multiplier = 0.7
	twohanded = FALSE
	serial_type = "SI"

/obj/item/gun/energy/laser/mounted/blitz
	name = "\"Ray\" mounted laser gun"		//What's up with you people and using random German words for gun names. Changed to English.
	desc = "A laser pistol re-tooled for use by a cyborg."
	icon_state = "laser_turret"
	damage_multiplier = 0.9
	charge_meter = FALSE
	twohanded = FALSE
	serial_type = "GP"
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	allow_greyson_mods = TRUE

/obj/item/gun/energy/laser/mounted/cyborg
	name = "integrated \"Cog\" laser carbine"
	desc = "A Cog laser rifle re-tooled for use by a cyborg."
	icon = 'icons/obj/guns/energy/cog.dmi'
	icon_state = "cog"
	recharge_time = 4 //Time it takes for shots to recharge (in ticks)
	damage_multiplier = 0.8
	projectile_type = /obj/item/projectile/beam/heavylaser
	cell_type = /obj/item/cell/medium/moebius/high
	charge_cost = 50

/obj/item/gun/energy/laser/practice
	name = "\"Lightfall\" practice laser rifle"
	desc = "A modified versiion of the Lightfall laser rifle firing weaker shots, intended for target practice."
	matter = list(MATERIAL_STEEL = 10, MATERIAL_WOOD = 2)
	price_tag = 150
	projectile_type = /obj/item/projectile/beam/practice

/obj/item/gun/energy/captain
	name = "\"Destiny\" vintage laser pistol"
	icon = 'icons/obj/guns/energy/capgun.dmi'
	icon_state = "caplaser"
	item_state = "caplaser"
	item_charge_meter = TRUE
	desc = "An hand-made ornamental version of a an already rare self-recharging laser pistol."
	force = WEAPON_FORCE_PAINFUL
	fire_sound = 'sound/weapons/energy/laser_pistol.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK|SLOT_HOLSTER
	w_class = ITEM_SIZE_NORMAL
	can_dual = TRUE
	projectile_type = /obj/item/projectile/beam
	origin_tech = null
	self_recharge = TRUE
	price_tag = 2250
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	init_firemodes = list(
		WEAPON_NORMAL,
		WEAPON_CHARGE
	)
	twohanded = FALSE
	allow_greyson_mods = TRUE
	serial_type = "GP"

	wield_delay = 0.3 SECOND
	wield_delay_factor = 0.2 // 20 vig

/obj/item/gun/energy/zwang
	name = "\"Enforcer\" energy revolver"	//German name again but this time it's a cop gun dude BLOW UP!!!!		Changed name.
	desc = "A dual-mode laser pistol styled after a traditional revolver for the sake of theatrics and cool factor."
	icon = 'icons/obj/guns/energy/zwang.dmi'
	icon_state = "zwang"
	item_state = "zwang"
	item_charge_meter = TRUE
	can_dual = TRUE
	charge_cost = 160
	matter = list(MATERIAL_PLASTEEL = 13, MATERIAL_PLASTIC = 6, MATERIAL_SILVER = 6)
	price_tag = 1400

	init_firemodes = list(
		list(mode_name="stunshot", projectile_type=/obj/item/projectile/energy/electrode/stunshot, fire_sound = 'sound/weapons/energy/Taser.ogg', fire_delay=35, icon="stun"),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam/midlaser, fire_sound='sound/weapons/energy/laser_pistol.ogg', fire_delay=10, icon="kill"),
	)
	serial_type = "NM"

	wield_delay = 0.3 SECOND
	wield_delay_factor = 0.2 // 20 vig

/obj/item/gun/energy/zwang/update_icon()
	..()
	cut_overlays()
	var/datum/firemode/current_mode = firemodes[sel_mode]
	if(current_mode.name == "stunshot")
		add_overlay("tazer_zwang")
	else
		add_overlay("laser_zwang")
