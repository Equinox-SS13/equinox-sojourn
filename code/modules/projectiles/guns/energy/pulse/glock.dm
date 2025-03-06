/obj/item/gun/energy/glock		//You can have ONE Fallout reference. ONE.
	name = "\"Galaxy\" plasma pistol"
	desc = "A rare triple-mode plasma pistol rumoured to have been designed by an AI personality."
	icon = 'icons/obj/guns/energy/plasglock.dmi'
	icon_state = "plaslock"
	item_state = "plaslock"
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/energy/pulse.ogg'
	can_dual = TRUE
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	projectile_type = /obj/item/projectile/plasma
	suitable_cell = /obj/item/cell/medium
	charge_cost = 120
	fire_delay = 8
	zoom_factors = list(0.4)
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_STEEL = 10, MATERIAL_SILVER = 4, MATERIAL_PLASMA = 8)
	price_tag = 5000
	damage_multiplier = 1.2
	penetration_multiplier = 1.2
	init_recoil = CARBINE_RECOIL(0.7)
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SIGHT)
	init_firemodes = list(
		list(mode_name="plasma bolt", mode_desc="Fire a bolt of plasma.", projectile_type=/obj/item/projectile/plasma, fire_sound='sound/weapons/energy/pulse.ogg', charge_cost=120, fire_delay=8, icon="destroy", projectile_color = "#00AAFF"),
		list(mode_name="laser", mode_desc="Fire a standard laser.", projectile_type=/obj/item/projectile/beam, fire_sound='sound/weapons/energy/laser_pistol.ogg', charge_cost=80, fire_delay=0.5, icon="kill", projectile_color = "#00AAFF"),
		list(mode_name="ion shot", mode_desc="Fire an ionized toroid to disable electronics.", projectile_type=/obj/item/projectile/ion, fire_sound='sound/effects/supermatter.ogg', fire_delay=12, charge_cost=300, icon="charge", projectile_color = "#ff7f24"),
	)
	serial_type = "NM"

	wield_delay = 0.3 SECOND
	wield_delay_factor = 0.2 // 20 vig

/obj/item/gun/energy/glock/update_icon()
	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(charge_meter)
		var/ratio = 0

		//make sure that rounding down will not give us the empty state even if we have charge for a shot left.
		if(cell && cell.charge >= charge_cost)
			ratio = cell.charge / cell.maxcharge
			ratio = min(max(round(ratio, 0.25) * 100, 25), 100)

		if(modifystate)
			iconstring = "[modifystate][ratio]"
		else
			iconstring = "[initial(icon_state)][ratio]"

		if(item_charge_meter)
			itemstring += "-[item_modifystate][ratio]"

	if (!cell)
		iconstring += "_slide"

	icon_state = iconstring
