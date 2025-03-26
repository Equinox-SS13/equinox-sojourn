/obj/item/gun/energy/plasma/excubitor
	name = "\"Excubitor\" gunspear"
	icon = 'icons/obj/guns/energy/excubitor.dmi'
	icon_state = "excubitor"
	item_state = null	//so the human update icon uses the icon_state instead.
	item_charge_meter = TRUE
	desc = "A large church-made polearm with an inbuilt experimental plasma caster. Uses proprietary church cells."
	fire_sound = 'sound/weapons/energy/Laser.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_BULKY
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_WOOD = 15, MATERIAL_GLASS = 5, MATERIAL_GOLD = 2, MATERIAL_BIOMATTER = 80, MATERIAL_STEEL = 15)
	suitable_cell = /obj/item/cell/medium/neotheology
	projectile_type = /obj/item/projectile/plasma/light
	force = WEAPON_FORCE_BRUTAL
	armor_penetration = ARMOR_PEN_MASSIVE
	fire_delay = 10
	charge_cost = 60 // 10 shots out of a 600M
	init_recoil = HANDGUN_RECOIL(1)
	price_tag = 1500
	gun_tags = list(GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	init_firemodes = list(
		list(mode_name="plasma", mode_desc="Fire light plasma bolts", projectile_type=/obj/item/projectile/plasma/light, fire_sound='sound/weapons/energy/vaporize.ogg', fire_delay=8, icon="stun", projectile_color = "#00FFFF"),
		list(mode_name="grenade", mode_desc="Fashion a frag grenade out of the gun's power cell", projectile_type=/obj/item/projectile/bullet/grenade/frag/nt, charge_cost=30000, icon="grenade"),
	)
	twohanded = TRUE
	var/consume_cell = TRUE
	price_tag = 2250
	serial_type = "Absolute"

/obj/item/gun/energy/plasma/excubitor/consume_next_projectile()
	if(!cell) return null
	if(!ispath(projectile_type)) return null
	if(consume_cell && !cell.checked_use(charge_cost))
		visible_message(SPAN_WARNING("\The [cell] of \the [src] burns out!"))
		qdel(cell)
		cell = null
		playsound(loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		return new projectile_type(src)
	else if(!consume_cell && !cell.checked_use(charge_cost))
		return null
	else
		return new projectile_type(src)

