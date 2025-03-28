// Houses the master railgun file to standardize it for all guns & not have issues with overheating.
/obj/item/gun/energy/laser/railgun
	name = "old railgun"
	desc = "An outdated experimental design for a railgun. "
	icon = 'icons/obj/guns/energy/railpistol.dmi'
	icon_state = "railpistol"
	item_state = "railpistol"
	suitable_cell = /obj/item/cell/large
	item_charge_meter = TRUE
	fire_sound = 'sound/weapons/railgun.ogg'
	item_charge_meter = TRUE
	w_class = ITEM_SIZE_BULKY
	extra_bulk = 2
	force = WEAPON_FORCE_PAINFUL
	twohanded = TRUE
	flags = CONDUCT
	slot_flags = SLOT_BACK
	charge_cost = 500
	var/consume_cell = FALSE
	fire_delay = 14 //Slow, on par with a shotgun pump then fire
	init_recoil = RIFLE_RECOIL(1)
	wrench_intraction = TRUE

/obj/item/gun/energy/laser/railgun/pistol
	name = "\"Myrmidon\" rail pistol"
	desc = "An in-colony hybridized rail pistol that feeds from medium power cells."
	icon = 'icons/obj/guns/energy/railpistol.dmi'
	icon_state = "railpistol"
	item_state = "railpistol"
	suitable_cell = /obj/item/cell/medium
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	w_class = ITEM_SIZE_NORMAL
	force = WEAPON_FORCE_NORMAL
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 4, TECH_ENGINEERING = 4)
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_STEEL = 4, MATERIAL_SILVER = 5)
	fire_delay = 7
	charge_cost = 100
	fire_sound = 'sound/weapons/rail.ogg'
	gun_tags = list(GUN_PROJECTILE, GUN_ENERGY)
	init_recoil = RIFLE_RECOIL(0.8)
	can_dual = TRUE
	twohanded = FALSE
	serial_type = "AG"
	init_firemodes = list(
		list(mode_name="standard", mode_desc="Fire a hypersonic metal shaving.", projectile_type=/obj/item/projectile/bullet/kurtz_50/railgun, icon="kill"),
		list(mode_name="rubber", mode_desc="Fire a hypersonic rubber ball. We'll tell the police you had good intentions.", projectile_type=/obj/item/projectile/bullet/kurtz_50/rubber/railgun, icon="stun"),
		list(mode_name="rail", mode_desc="Fire a hypersonic metal rail that will explode on impact. This consumes the power cell.", projectile_type=/obj/item/projectile/bullet/grenade/frag, charge_cost=30000, icon="grenade"),
	)
	price_tag = 1250

/obj/item/gun/energy/laser/railgun/mounted
	name = "\"Shrapnel\" mounted \'railgun\'"
	desc = "An energy gun that employs a matter fabricator to mimic a railgun."
	icon_state = "shrapnel"
	self_recharge = 1
	use_external_power = 1
	safety = FALSE
	restrict_safety = TRUE
	consume_cell = FALSE
	cell_type = /obj/item/cell/small/high //Two shots
	twohanded = FALSE
	init_firemodes = list(
		list(mode_name="standard", mode_desc="Fire a cloud of hypersonic metal shavings.", projectile_type=/obj/item/projectile/bullet/pellet/shotgun, charge_cost=100, icon="kill"),
		list(mode_name="rubber", mode_desc="Fire a regular shotgun beanbag pellet.", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag, charge_cost=25, icon="stun"),
		list(mode_name="'rail'", mode_desc="Fire an accelerated slug.", projectile_type=/obj/item/projectile/bullet/shotgun, charge_cost=50, icon="destroy"),
	)
	serial_type = "GP"
	gun_tags = list(GUN_PROJECTILE, GUN_LASER, GUN_ENERGY, GUN_SCOPE)
	allow_greyson_mods = TRUE

//Re-wrote this to be it's own standalone gun to prevent cooling issues.
/obj/item/gun/energy/laser/railgun/railrifle
	name = "\"Reductor\" railgun"
	desc = "An in-colony hybridized rifle-sized railgun that can be overclocked with a wrench."
	icon = 'icons/obj/guns/energy/railgun.dmi'
	icon_state = "railgun"
	item_state = "railgun"
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 6, TECH_ENGINEERING = 6)
	matter = list(MATERIAL_PLASTEEL = 20, MATERIAL_STEEL = 8, MATERIAL_SILVER = 10)
	charge_cost = 500
	gun_tags = list(GUN_PROJECTILE, GUN_ENERGY, GUN_SCOPE)
	suitable_cell = /obj/item/cell/large
	fire_delay = 10 //Slow, on par with a shotgun pump then fire
	init_recoil = RIFLE_RECOIL(1)
	damage_multiplier = 1
	init_firemodes = list(
		list(mode_name="standard", mode_desc="Fire a pointed metal rail.", projectile_type=/obj/item/projectile/bullet/shotgun/railgun, icon="kill"),
		list(mode_name="rubber", mode_desc="Fire a hypersonic rubber ball. We'll tell the police you had good intentions.", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag/railgun, icon="stun"),
		list(mode_name="rail", mode_desc="Fire a hypersonic metal rail that will explode on impact. This destroys the power cell.", projectile_type=/obj/item/projectile/bullet/grenade, charge_cost=30000, icon="grenade")
	)
	consume_cell = FALSE
	price_tag = 2250
	serial_type = "AG"
//	var/overheat_damage = 25

	//Blacklisting now works!
	blacklist_upgrades = list(/obj/item/gun_upgrade/mechanism/greyson_master_catalyst = TRUE)

/obj/item/gun/energy/laser/railgun/railrifle/consume_next_projectile(mob/user)
	if(!cell)
		return null
//commented out for now I wont remove the code incase someones willing to fix it. Currently does no damage to the user for overheating. -Benl8561		//wonder how old this is lol
/**
	var/datum/component/heat/H = GetComponent(/datum/component/heat)
	H.tickHeat()
	if(H.currentHeat > H.heatThresholdSpecial )
		to_chat(user, "\The [src] is currently overheating!")
		handleoverheatreductor()
**/
	if(!ispath(projectile_type))
		return null
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

/obj/item/gun/energy/laser/railgun/wrench_intraction(obj/item/I, mob/user)
	if(I.has_quality(QUALITY_BOLT_TURNING))
		if(I.use_tool(user, src, WORKTIME_SLOW, QUALITY_BOLT_TURNING, FAILCHANCE_VERY_HARD, required_stat = STAT_MEC))
			if(consume_cell)
				consume_cell = FALSE
				to_chat(user, SPAN_NOTICE("You secure the safety bolts and tune down the capacitor to safe levels, preventing the weapon from destroying empty cells for use as ammuniton."))
			else
				consume_cell = TRUE
				to_chat(user, SPAN_NOTICE("You loosen the safety bolts and overclock the capacitor to unsafe levels, allowing the weapon to destroy empty cells for use as ammunition."))
/**
/obj/item/gun/energy/laser/railgun/railrifle/Destroy()
	STOP_PROCESSING(SSobj, src)
	..()

/obj/item/gun/energy/laser/railgun/railrifle/Initialize()
	AddComponent(/datum/component/heat, COMSIG_CLICK_CTRL, TRUE, 50, 60, 5, 0.01, 2)
	RegisterSignal(src, COMSIG_HEAT_VENT, PROC_REF(venteventreductor)) //this sould just be a fluff message, proc can be anything
	RegisterSignal(src, COMSIG_HEAT_OVERHEAT, PROC_REF(handleoverheatreductor)) //this can damge the user/melt the gun/whatever. this will never proc as the gun cannot fire above the special heat threshold and the special heat threshold should be smaller than the overheat threshold
	START_PROCESSING(SSobj, src)
	..()

/obj/item/gun/energy/laser/railgun/railrifle/examine(user)
	. = ..()
	to_chat(user, SPAN_NOTICE("Control-Click to manually vent this weapon's heat."))

/obj/item/gun/energy/laser/railgun/railrifle/proc/handleoverheatreductor()
	src.visible_message(SPAN_DANGER("\The [src] overheats, its exterior becoming blisteringly hot, burning skin down to the flesh!!"))
	var/mob/living/L = loc
	if(istype(L))
		if(L.hand == L.l_hand) // Are we using the left arm?
			L.apply_damage(overheat_damage, BURN, def_zone = BP_L_ARM)
		else // If not then it must be the right arm.
			L.apply_damage(overheat_damage, BURN, def_zone = BP_R_ARM)

/obj/item/gun/energy/laser/railgun/railrifle/proc/venteventreductor()
	src.visible_message("\The [src]'s vents open valves atop of the exterior coil mounts, cooling itself down.")
	playsound(usr.loc, 'sound/weapons/guns/interact/gauss_vent.ogg', 50, 1)
*/
//Gauss-rifle type, snowflake launcher mixed with rail rifle and hydrogen gun code. Consumes matter-stack and cell charge to fire. - Rebel0
/obj/item/gun/energy/laser/railgun/gauss
	name = "\"Bat'ko\" gauss rifle"
	desc = "A heavy cell-loaded gauss rifle fitted with a hand-crank to manually chamber the next round and a series of coils lining its front. This strange rifle has valves along the external coil mounts. Firing this gun requires constant venting."
	icon = 'icons/obj/guns/energy/gauss.dmi'
	icon_state = "gauss"
	item_state = "gauss"
	fire_sound = 'sound/weapons/guns/fire/gaussrifle.ogg'
	w_class = ITEM_SIZE_HUGE
	matter = list(MATERIAL_PLASTEEL = 40, MATERIAL_SILVER = 10, MATERIAL_GOLD = 8, MATERIAL_PLATINUM = 4)
	charge_cost = 750
	fire_delay = 20
	init_recoil = HMG_RECOIL(1)
	zoom_factors = list(1.8)
	extra_damage_mult_scoped = 0.4
	damage_multiplier = 1.6
	penetration_multiplier = 1.5
	twohanded = TRUE
	slowdown_hold = 1.5
	init_firemodes = list(
		list(mode_name="powered-rod", mode_desc="fires a metal rod at incredible speeds", projectile_type=/obj/item/projectile/bullet/gauss, icon="kill"),
		list(mode_name="fragmented scrap", mode_desc="fires a brittle, sharp piece of scrap metal", projectile_type=/obj/item/projectile/bullet/grenade/frag, charge_cost=30000, icon="grenade"),
	)
	serial_type = "AG"
	consume_cell = FALSE
	price_tag = 6000

	var/max_stored_matter = 6
	var/stored_matter = 0
	var/matter_type = "refined scrap pieces"

	var/projectile_cost = 1
	var/overheat_damage = 25

	//Upgrades nerfed to avoid kitting the gun out TOO much. -Rebel0
	max_upgrades = 4

/obj/item/gun/energy/laser/railgun/gauss/Initialize()
	..()
	AddComponent(/datum/component/heat, COMSIG_CLICK_CTRL, TRUE,  50,  60,  20, 0.01, 2)
	RegisterSignal(src, COMSIG_HEAT_VENT, PROC_REF(ventEvent)) //this sould just be a fluff message, proc can be anything
	RegisterSignal(src, COMSIG_HEAT_OVERHEAT, PROC_REF(handleoverheat)) //this can damge the user/melt the gun/whatever. this will never proc as the gun cannot fire above the special heat threshold and the special heat threshold should be smaller than the overheat threshold
	update_icon()
	START_PROCESSING(SSobj, src)

/obj/item/gun/energy/laser/railgun/gauss/Destroy()
	STOP_PROCESSING(SSobj, src)
	..()
/obj/item/gun/energy/laser/railgun/gauss/attackby(obj/item/I, mob/user)

	if(!istype(I,/obj/item/stack))
		..()
	var/obj/item/stack/M = I
	if(istype(M) && M.name == matter_type)
		var/amount = min(M.get_amount(), round(max_stored_matter - stored_matter))
		if(M.use(amount))
			stored_matter += amount
			to_chat(usr, "You load [amount] [matter_type] into \the [src].")
	else
		return ..()

/obj/item/gun/energy/laser/railgun/gauss/consume_next_projectile(mob/user)
	if(stored_matter < projectile_cost) return null
	if(!cell) return null
	if(!ispath(projectile_type)) return null
	if(!cell.checked_use(charge_cost)) return null

	var/datum/component/heat/H = GetComponent(/datum/component/heat)
	if((H.currentHeat > H.heatThresholdSpecial ||stored_matter < projectile_cost || !..()))
		to_chat(user, "\The [src] is currently overheating!")
		handleoverheat()
		return null

	stored_matter -= projectile_cost
	return new projectile_type(src)

/obj/item/gun/energy/laser/railgun/gauss/examine(user)
	. = ..()
	to_chat(user, "It holds [stored_matter]/[max_stored_matter] [matter_type].")
	to_chat(user, SPAN_NOTICE("Control-Click to manually vent this weapon's heat."))

/obj/item/gun/energy/laser/railgun/gauss/update_icon()
	cut_overlays()

	var/iconstring = initial(icon_state)
	var/itemstring = ""

	if(wielded)
		itemstring += "_doble"

	icon_state = iconstring
	set_item_state(itemstring)

//Hydrogen gun snowflake variables for the Gauss
/obj/item/gun/energy/laser/railgun/gauss/proc/ventEvent()
	src.visible_message("\The [src]'s vents open valves atop of the exterior coil mounts, cooling itself down.")
	playsound(usr.loc, 'sound/weapons/guns/interact/gauss_vent.ogg', 50, 1)

/obj/item/gun/energy/laser/railgun/gauss/proc/handleoverheat()
	src.visible_message(SPAN_DANGER("\The [src] overheats, its exterior becoming blisteringly hot, burning skin down to the flesh!!"))
	var/mob/living/L = loc
	if(istype(L))
		if(L.hand == L.l_hand) // Are we using the left arm?
			L.apply_damage(overheat_damage, BURN, def_zone = BP_L_ARM)
		else // If not then it must be the right arm.
			L.apply_damage(overheat_damage, BURN, def_zone = BP_R_ARM)
