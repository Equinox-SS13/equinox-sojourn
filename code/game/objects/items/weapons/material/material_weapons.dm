// SEE code/modules/materials/materials.dm FOR DETAILS ON INHERITED DATUM.
// This class of weapons takes force and appearance data from a material datum.
// They are also fragile based on material data and many can break/smash apart.
/obj/item/tool/material

	health = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	gender = NEUTER
	throw_speed = 3
	throw_range = 7
	w_class = ITEM_SIZE_NORMAL
	sharp = 0
	edge = 0
	icon = 'icons/obj/weapons.dmi'
	var/list/weight_tool_qualities //heavier weight = better. gives tool quality based on weight
	//example: weight_tool_qualities = list(QUALITY_HAMMERING = 0.5) would give 2x of material's weight as hammering quality. for example, steel's weight is 22
	var/list/hardness_tool_qualities
	var/applies_material_colour = 1
	var/force_divisor = 1
	var/thrown_force_divisor = 0.5
	var/default_material = MATERIAL_STEEL
	var/material/material
	var/furniture_icon  //icon states for non-material colorable overlay, i.e. handles

/obj/item/tool/material/New(var/newloc, var/material_key)
	..(newloc)
	if(!material_key)
		material_key = default_material
	set_material_by_name(material_key)
	if(!material)
		qdel(src)
		return

	matter = material.get_matter()
	if(matter.len)
		for(var/material_type in matter)
			if(!isnull(matter[material_type]))
				matter[material_type] = round(max(1, matter[material_type] * force_divisor)) // current system uses rounded values, so no less than 1.

/obj/item/tool/material/get_material()
	return material

/obj/item/tool/material/proc/update_force()
	if(edge || sharp)
		force = material.get_hardness()
	else
		force = material.get_weight()
	force = round(force*force_divisor)
	throwforce = round(material.get_weight()*thrown_force_divisor)
	//spawn(1)
	//	world << "[src] has force [force] and throwforce [throwforce] when made from default material [material.name]"

/obj/item/tool/material/proc/set_stats_from_material()
	name = "[material.display_name] [initial(name)]"
	max_health = material.integrity * 3 //this gives 450 health for most tools, 50 better than default. wood, plastic etc. are less
	health = max_health
	if(material.is_brittle())
		degradation = round(material.integrity / 2) //we break in 2-3 hits if we're brittle
	if(applies_material_colour)
		color = material.icon_colour
	if(material.products_need_process())
		START_PROCESSING(SSobj, src)

	if(!islist(tool_qualities)) //if we don't exist...
		tool_qualities = list()
	for(var/quality in weight_tool_qualities)
		tool_qualities |= quality
		tool_qualities[quality] = max(round(weight_tool_qualities[quality] * material.get_weight()), 0)
	for(var/quality in hardness_tool_qualities)
		tool_qualities |= quality
		tool_qualities[quality] += round(hardness_tool_qualities[quality] * material.get_hardness())

	workspeed += max(round(material.get_hardness() / 60), 0) //harder tools work faster. or something
	update_force()

/obj/item/tool/material/proc/set_material_by_name(var/new_material)
	material = get_material_by_name(new_material)
	if(!material)
		qdel(src)
	else
		set_stats_from_material()



/obj/item/tool/material/proc/set_material_by_type(var/material/new_material)
	material = new_material
	if(!material)
		qdel(src)
	else
		set_stats_from_material()


//This is a complete override of parent, because we need to move where appval is called. Yay.
/obj/item/tool/material/refresh_upgrades()
//First of all, lets reset any var that could possibly be altered by an upgrade
	degradation = initial(degradation)
	workspeed = initial(workspeed)
	precision = initial(precision)
	suitable_cell = initial(suitable_cell)
	max_fuel = initial(max_fuel)
	health_threshold = initial(health_threshold)

	use_fuel_cost = initial(use_fuel_cost)
	use_power_cost = initial(use_power_cost)
	force = initial(force)
	armor_penetration = initial(armor_penetration)
	damtype = initial(damtype)
	force_upgrade_mults = initial(force_upgrade_mults)
	force_upgrade_mods = initial(force_upgrade_mods)

	hitcost = initial(hitcost)
	stunforce = initial(stunforce)
	agonyforce = initial(agonyforce)


	extra_bulk = initial(extra_bulk)
	item_flags = initial(item_flags)
	name = initial(name)
	max_upgrades = initial(max_upgrades)
	allow_greyson_mods = initial(allow_greyson_mods)
	color = initial(color)
	sharp = initial(sharp)
	extended_reach = initial(extended_reach)
	no_swing = initial(no_swing)
	LAZYNULL(name_prefixes)

	if(alt_mode_active)
		alt_mode_activeate_two()

	if(isliving(loc) && extended_reach)
		var/mob/living/location_of_item = loc
		if(location_of_item.stats.getPerk(PERK_NATURAL_STYLE))
			extended_reach += 1

	if(switched_on)
		if(switched_on_forcemult)
			force *= switched_on_forcemult
		if(switched_on_penmult)
			armor_penetration *= switched_on_penmult

	SStgui.update_uis(src)


	set_material_by_type(material)
	update_force()

		//Now lets have each upgrade reapply its modifications
	LEGACY_SEND_SIGNAL(src, COMSIG_APPVAL, src)

	for(var/prefix in name_prefixes)
		name = "[prefix] [name]"

	health_threshold = max(0, health_threshold)

	//Set the fuel volume, incase any mods altered our max fuel
	if(reagents)
		reagents.maximum_volume = max_fuel

	if(wielded)
		if(force_wielded_multiplier)
			force = force * force_wielded_multiplier
		else //This will give items wielded 30% more damage. This is balanced by the fact you cannot use your other hand.
			force = (force * 1.3) //Items that do 0 damage will still do 0 damage though.
		name = "[name] (Wielded)"

/obj/item/tool/material/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()
/*
Commenting this out pending rebalancing of radiation based on small objects.
/obj/item/tool/material/Process()
	if(!material.radioactivity)
		return
	for(var/mob/living/L in range(1,src))
		L.apply_effect(round(material.radioactivity/30),IRRADIATE,0)
*/

/*
// Commenting this out while fires are so spectacularly lethal, as I can't seem to get this balanced appropriately.
/obj/item/tool/material/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	TemperatureAct(exposed_temperature)

// This might need adjustment. Will work that out later.
/obj/item/tool/material/proc/TemperatureAct(temperature)
	health -= material.combustion_effect(get_turf(src), temperature, 0.1)
	check_health(1)

/obj/item/tool/material/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/tool/weldingtool))
		var/obj/item/tool/weldingtool/WT = W
		if(material.ignition_point && WT.remove_fuel(0, user))
			TemperatureAct(150)
	else
		return ..()
*/
