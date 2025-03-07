/obj/item/gun/energy/centurio
	name = "\"Century\" plasma pistol"
	desc = "A compact in-colony dual-mode plasma pistol of sturdy construction."
	icon = 'icons/obj/guns/energy/toxgun.dmi'
	icon_state = "toxgun"
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT|SLOT_BACK|SLOT_HOLSTER
	twohanded = FALSE
	can_dual = TRUE
	sel_mode = 1
	origin_tech = list(TECH_COMBAT = 5, TECH_PLASMA = 4)
	matter = list(MATERIAL_STEEL = 20, MATERIAL_PLASMA = 5)
	price_tag = 1250
	damage_multiplier = 1
	init_recoil = HANDGUN_RECOIL(0.2)
	init_firemodes = list(
		list(mode_name="plasma", mode_desc="Hard hitting plasma bolt that melts flesh and armor", projectile_type=/obj/item/projectile/plasma/heavy, fire_sound='sound/weapons/energy/incinerate.ogg', fire_delay = 9, icon="destroy", projectile_color = "#2bd37f"),
		list(mode_name="EMP", mode_desc="An ionized toroid that disables electronics", projectile_type=/obj/item/projectile/ion, fire_sound='sound/effects/supermatter.ogg', fire_delay = 25, icon="stun", projectile_color = "#99ffb2"),
		)
	serial_type = "SI"
	charge_cost = 50

	wield_delay = 0.3 SECOND
	wield_delay_factor = 0.2 // 20 vig

/obj/item/gun/energy/plasma/auretian
	name = "\"Auretian\" energy pistol"
	desc = "An unreliable and complicated in-colony dual-mode energy gun that has both a laser emitter and a plasma chamber, the first of which is substantially faster firing."
	icon = 'icons/obj/guns/energy/brigador.dmi'
	icon_state = "brigador"
	charge_meter = FALSE
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT|SLOT_BACK|SLOT_HOLSTER
	twohanded = FALSE
	origin_tech = list(TECH_COMBAT = 5, TECH_PLASMA = 6)
	can_dual = TRUE
	sel_mode = 1
	suitable_cell = /obj/item/cell/small
	charge_cost = 20
	damage_multiplier = 1
	init_recoil = HANDGUN_RECOIL(0.2)
	matter = list(MATERIAL_PLASTEEL = 10, MATERIAL_PLASTIC = 8, MATERIAL_PLASMA = 2, MATERIAL_SILVER = 3, MATERIAL_URANIUM = 3)
	gun_tags = list(GUN_LASER, GUN_ENERGY)

	init_firemodes = list(
		list(mode_name="plasma", mode_desc="Hard hitting plasma bolt that melts flesh and armor", projectile_type=/obj/item/projectile/plasma/heavy, fire_sound='sound/weapons/energy/melt.ogg', fire_delay=9, icon="destroy", projectile_color = "#32da99"),
		list(mode_name="laser", mode_desc="Standard laser bolt", projectile_type=/obj/item/projectile/beam/midlaser, fire_sound='sound/weapons/energy/laser_pistol.ogg', fire_delay=0.5, icon="kill", projectile_color = "#d11d1d"),
	)
	serial_type = "SI"

/obj/item/gun/energy/plasma/auretian/update_icon()
	cut_overlays()
	..()
	if(cell)
		add_overlay(image(icon, "cell_guild"))
