/obj/item/gun/energy/concillium
	name = "\"Concillium\" laser rifle"
	desc = "A church-made automatic laser rifle with a high rate of fire, but poor accuracy and stopping power. Slots large power cells."
	icon = 'icons/obj/guns/energy/concilium.dmi'
	icon_state = "concilium"
	item_state = null	//so the human update icon uses the icon_state instead.
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/energy/laser_rifle.ogg' // Big unwieldy gun, despite the shit lasers
	slot_flags = null
	w_class = ITEM_SIZE_HUGE
	matter = list(MATERIAL_PLASTEEL = 30, MATERIAL_WOOD = 25, MATERIAL_GLASS = 10, MATERIAL_SILVER = 5, MATERIAL_GOLD = 5)
	projectile_type = /obj/item/projectile/beam/drone
	init_recoil = CARBINE_RECOIL(2)
	fire_delay = 2
	charge_cost = 100 //130 shots on a large spark
	wield_delay = 1.5 SECOND
	wield_delay_factor = 0.5 // 50 vig to instant wield heavy chonker gun
	slowdown_hold = 1 //heavy wood stock. Stupidly chonky
	suitable_cell = /obj/item/cell/large
	damage_multiplier = 1.2 //Kinda bad beam inside but can be upgraded to be a normal laser lmg!
	armor_penetration = 1.1
	init_offset = 3
	price_tag = 2000
	gun_tags = list(GUN_LASER, GUN_ENERGY)
	init_firemodes = list(
		FULL_AUTO_300,
		BURST_5_ROUND,
		BURST_8_ROUND
		)
	blacklist_upgrades = list(/obj/item/gun_upgrade/mechanism/greyson_master_catalyst = TRUE)
	twohanded = TRUE
	serial_type = "Absolute"
