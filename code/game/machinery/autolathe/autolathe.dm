#define ERR_OK 0
#define ERR_NOTFOUND "not found"
#define ERR_NOMATERIAL "no material"
#define ERR_NOREAGENT "no reagent"
#define ERR_NOLICENSE "no license"
#define ERR_PAUSED "paused"
#define ERR_NOINSIGHT "no insight"
#define ERR_WRONG_BUILDTYPE "cant read"


/obj/machinery/autolathe
	name = "autolathe"
	desc = "It produces items using metal and glass."
	icon = 'icons/obj/machines/autolathe.dmi'
	icon_state = "autolathe"
	density = 1
	anchored = 1
	layer = BELOW_OBJ_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 2000
	circuit = /obj/item/circuitboard/autolathe

	var/build_type = AUTOLATHE
	var/code_dex = "AUTOLATHE" //Used in place of build_type

	var/obj/item/computer_hardware/hard_drive/portable/disk

	var/list/stored_material = list()
	var/obj/item/reagent_containers/glass/container

	var/unfolded
	var/show_category
	var/list/categories

	var/list/special_actions

	// Used by wires - unused for now
	var/hacked = FALSE
	var/disabled = FALSE
	var/shocked = FALSE

	var/auto_input //Are we automatically inputting?
	var/turf/auto_in_turf

	var/working = FALSE
	var/paused = FALSE
	var/error
	var/progress = 0

	var/datum/computer_file/binary/design/current_file
	var/list/queue = list()
	var/queue_max = 8

	var/storage_capacity = 120
	var/speed = 2
	var/mat_efficiency = 1

	var/default_disk	// The disk that spawns in autolathe by default

	// Various autolathe functions that can be disabled in subtypes
	var/have_disk = TRUE
	var/have_reagents = TRUE
	var/have_materials = TRUE
	var/have_recycling = FALSE //Also dictates auto-input
	var/direct_recycling = FALSE //Dictates direct input
	var/have_design_selector = TRUE

	var/max_efficiency = 0.5

	var/list/selectively_recycled_types = list()	// Allows recycling of specified types if have_recycling = FALSE

	var/list/unsuitable_materials = list(MATERIAL_BIOMATTER)
	var/list/suitable_materials //List that limits autolathes to eating mats only in that list.

	var/global/list/error_messages = list(
		ERR_NOLICENSE = "Not enough license points left.",
		ERR_NOTFOUND = "Design data not found.",
		ERR_NOMATERIAL = "Not enough materials.",
		ERR_NOREAGENT = "Not enough reagents.",
		ERR_PAUSED = "**Construction Paused**",
		ERR_NOINSIGHT = "Not enough insight.",
		ERR_WRONG_BUILDTYPE = "Unable to read design."
	)

	var/tmp/datum/wires/autolathe/wires

	// A vis_contents hack for materials loading animation.
	var/tmp/obj/effect/flicker_overlay/image_load
	var/tmp/obj/effect/flicker_overlay/image_load_material

/obj/machinery/autolathe/Initialize()
	. = ..()
	wires = new(src)

	image_load = new(src)
	image_load_material = new(src)

	if(have_disk && default_disk)
		disk = new default_disk(src)
	auto_in_turf = get_step(get_turf(src), dir)

/obj/machinery/autolathe/Destroy()
	QDEL_NULL(wires)
	QDEL_NULL(image_load)
	QDEL_NULL(image_load_material)
	return ..()

/obj/machinery/autolathe/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Autolathe", name)
		ui.open()

/obj/machinery/autolathe/ui_static_data(mob/user)
	var/list/data = list()

	var/list/L = list()
	for(var/d in design_list())
		var/datum/computer_file/binary/design/design_file = d
		if(!show_category || design_file.design.category == show_category)
			L.Add(list(design_file.nano_ui_data()))
	data["designs"] = L

	return data

/obj/machinery/autolathe/ui_data(mob/user)
	var/list/data = list()

	data["have_disk"] = have_disk
	data["have_reagents"] = have_reagents
	data["have_materials"] = have_materials
	data["have_design_selector"] = have_design_selector

	data["error"] = error
	data["paused"] = paused

	data["unfolded"] = unfolded

	data["speed"] = speed

	if(disk)
		data["disk"] = list(
			"name" = disk.get_disk_name(),
			"license" = disk.license,
			"read_only" = disk.read_only
		)
	else
		data["disk"] = null

	if(categories)
		data["categories"] = categories
		data["show_category"] = show_category
	else
		data["categories"] = null
		data["show_category"] = null

	data["special_actions"] = special_actions

	data |= materials_data()


	if(current_file)
		data["current"] = current_file.nano_ui_data()
		data["progress"] = progress
	else
		data["current"] = null
		data["progress"] = null

	var/list/Q = list()
	var/licenses_used = 0
	var/list/qmats = stored_material.Copy()

	for(var/i = 1; i <= queue.len; i++)
		var/datum/computer_file/binary/design/design_file = queue[i]
		var/list/QR = design_file.nano_ui_data()

		QR["ind"] = i

		QR["error"] = 0

		if(design_file.copy_protected)
			licenses_used++

			if(!disk || (licenses_used > disk.license && disk.license >= 0))
				QR["error"] = 1

		for(var/rmat in design_file.design.materials)
			if(!(rmat in qmats))
				qmats[rmat] = 0

			qmats[rmat] -= design_file.design.materials[rmat]
			if(qmats[rmat] < 0)
				QR["error"] = 1

		if(can_print(design_file) != ERR_OK)
			QR["error"] = 2

		Q.Add(list(QR))

	data["queue"] = Q
	data["queue_max"] = queue_max

	return data

/obj/machinery/autolathe/ui_assets(mob/user)
	if(user?.client?.get_preference_value(/datum/client_preference/tgui_toaster) == GLOB.PREF_YES)
		return list()
	return list(
		get_asset_datum(/datum/asset/spritesheet_batched/design_icons)
	)

// Also used by R&D console UI.
/obj/machinery/autolathe/proc/materials_data()
	var/list/data = list()

	data["mat_efficiency"] = mat_efficiency
	data["mat_capacity"] = storage_capacity

	data["container"] = !!container
	if(container && container.reagents)
		var/list/L = list()
		for(var/datum/reagent/R in container.reagents.reagent_list)
			var/list/LE = list("name" = R.name, "amount" = R.volume)
			L.Add(list(LE))

		data["reagents"] = L
	else
		data["reagents"] = null

	var/list/M = list()
	for(var/mtype in stored_material)
		if(stored_material[mtype] <= 0)
			continue

		var/material/MAT = get_material_by_name(mtype)
		var/list/ME = list("name" = MAT.display_name, "id" = mtype, "amount" = stored_material[mtype], "ejectable" = !!MAT.stack_type)

		M.Add(list(ME))

	data["materials"] = M

	return data

/obj/machinery/autolathe/attackby(obj/item/I, mob/user)

	if(istype(I, /obj/item/stack/material/cyborg))
		return //Prevents borgs throwing their stuff into it

	if(default_deconstruction(I, user))
		wires?.Interact(user)
		return

	if(default_part_replacement(I, user))
		return

	if(istype(I, /obj/item/computer_hardware/hard_drive/portable))
		insert_disk(user, I)

	// Override allowing direct input of items without need for 'load from hand'
	if(direct_recycling)
		eat(user, I)
		return
	// Some item types are consumed by default
	else if(istype(I, /obj/item/stack) || istype(I, /obj/item/trash) || istype(I, /obj/item/material/shard))
		eat(user, I)
		return

	if(istype(I, /obj/item/reagent_containers/glass))
		insert_beaker(user, I)
		return

	user.set_machine(src)
	ui_interact(user)


/obj/machinery/autolathe/attack_hand(mob/user)
	if(..())
		return TRUE

	user.set_machine(src)
	ui_interact(user)
	wires.Interact(user)

/obj/machinery/autolathe/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("abort_print")
			abort()
			. = TRUE

		if("pause")
			paused = !paused
			. = TRUE

		if("eject_disk")
			eject_disk(usr)
			. = TRUE

		if("eject_beaker")
			eject_beaker(usr)
			. = TRUE

		if("clear_queue")
			queue.Cut()
			. = TRUE

		if("insert_material")
			eat(usr)
			. = TRUE

		if("eject_material")
			if(!current_file || paused || error)
				var/material = params["id"]
				var/material/M = get_material_by_name(material)

				if(!M.stack_type)
					return FALSE

				var/num = input("Enter sheets number to eject. 0-[stored_material[material]]","Eject",0) as num
				if(!CanUseTopic(usr))
					return FALSE

				num = min(max(num,0), stored_material[material])

				eject(material, num)
				. = TRUE

		if("add_to_queue")
			var/recipe_filename = params["filename"]
			var/datum/computer_file/binary/design/design_file

			for(var/f in design_list())
				var/datum/computer_file/temp_file = f
				if(temp_file.filename == recipe_filename)
					design_file = temp_file
					break

			if(design_file)
				var/amount = 1

				if(params["several"])
					amount = input("How many \"[design_file.design.name]\" you want to print ?", "Print several") as null|num
					if(!CanUseTopic(usr) || !(design_file in design_list()) || amount == null)
						return FALSE

				queue_design(design_file, amount)

			. = TRUE

		if("remove_from_queue")
			var/ind = text2num(params["index"])
			if(ind >= 1 && ind <= queue.len)
				queue.Cut(ind, ind + 1)
			. = TRUE

		if("move_up_queue")
			var/ind = text2num(params["index"])
			if(ind >= 2 && ind <= queue.len)
				queue.Swap(ind, ind - 1)
			. = TRUE

		if("move_down_queue")
			var/ind = text2num(params["index"])
			if(ind >= 1 && ind <= queue.len-1)
				queue.Swap(ind, ind + 1)
			. = TRUE

		if("switch_category")
			show_category = params["category"]
			update_static_data(usr, ui)
			. = TRUE

/obj/machinery/autolathe/proc/insert_disk(mob/living/user, obj/item/computer_hardware/hard_drive/portable/inserted_disk)
	if(!inserted_disk && istype(user))
		inserted_disk = user.get_active_hand()

	if(!istype(inserted_disk))
		return

	if(!Adjacent(user) && !Adjacent(inserted_disk))
		return

	if(!have_disk)
		to_chat(user, SPAN_WARNING("[src] has no slot for a data disk."))
		return

	if(disk)
		to_chat(user, SPAN_NOTICE("There's already \a [disk] inside [src]."))
		return

	if(istype(user) && (inserted_disk in user))
		user.unEquip(inserted_disk, src)

	inserted_disk.forceMove(src)
	disk = inserted_disk
	to_chat(user, SPAN_NOTICE("You insert \the [inserted_disk] into [src]."))
	update_static_data_for_all_viewers()


/obj/machinery/autolathe/proc/insert_beaker(mob/living/user, obj/item/reagent_containers/glass/beaker)
	if(!beaker && istype(user))
		beaker = user.get_active_hand()

	if(!istype(beaker))
		return

	if(!Adjacent(user) && !Adjacent(beaker))
		return

	if(!have_reagents)
		to_chat(user, SPAN_WARNING("[src] has no slot for a beaker."))
		return

	if(container)
		to_chat(user, SPAN_WARNING("There's already \a [container] inside [src]."))
		return

	if(istype(user) && (beaker in user))
		user.unEquip(beaker, src)

	beaker.forceMove(src)
	container = beaker
	to_chat(user, SPAN_NOTICE("You put \the [beaker] into [src]."))
	SSnano.update_uis(src)


/obj/machinery/autolathe/proc/eject_beaker(mob/living/user)
	if(!container)
		return

	if(current_file && !paused && !error)
		return

	container.forceMove(drop_location())
	to_chat(usr, SPAN_NOTICE("You remove \the [container] from \the [src]."))

	if(istype(user) && Adjacent(user))
		user.put_in_active_hand(container)

	container = null


//This proc ejects the autolathe disk, but it also does some DRM fuckery to prevent exploits
/obj/machinery/autolathe/proc/eject_disk(mob/living/user)
	if(!disk)
		return

	var/list/design_list = design_list()

	// Go through the queue and remove any recipes we find which came from this disk
	for(var/design in queue)
		if(design in design_list)
			queue -= design

	//Check the current too
	if(current_file in design_list)
		//And abort it if it came from this disk
		abort()


	//Digital Rights have been successfully managed. The corporations win again.
	//Now they will graciously allow you to eject the disk
	disk.forceMove(drop_location())
	to_chat(usr, SPAN_NOTICE("You remove \the [disk] from \the [src]."))
	update_static_data_for_all_viewers()

	if(istype(user) && Adjacent(user))
		user.put_in_active_hand(disk)

	disk = null

/obj/machinery/autolathe/AltClick(mob/living/user)
	if(user.incapacitated())
		to_chat(user, SPAN_WARNING("You can't do that right now!"))
		return
	if(!in_range(src, user))
		return
	eject_disk(user)


/obj/machinery/autolathe/CtrlClick(mob/living/user)
	..() //comsig
	if(!have_recycling)
		to_chat(user, SPAN_NOTICE("[src] does not support automatic sheet loading!"))
		return
	auto_input = !auto_input
	to_chat(user, SPAN_NOTICE("[src] is now [auto_input ? "" : "no longer"] automatically loading."))

/obj/machinery/autolathe/CtrlShiftClick(mob/living/user)
	..()
	if(user.incapacitated())
		to_chat(user, SPAN_WARNING("You can't do that right now!"))
		return
	src.set_dir(turn(src.dir, 90))
	to_chat(user, SPAN_NOTICE("You rotate the [src]! Now it faces [dir2text(dir)]."))
	auto_in_turf = get_step(get_turf(src), dir)

/obj/machinery/autolathe/proc/eat(mob/living/user, obj/item/eating)
	if(!eating && istype(user))
		eating = user.get_active_hand()

	if(!istype(eating) || QDELETED(eating))
		return FALSE

	if(stat)
		return FALSE

	if(!Adjacent(user) && !Adjacent(eating))
		return FALSE

	if(is_robot_module(eating))
		return FALSE

	if(!have_recycling && !(istype(eating, /obj/item/stack) || can_recycle(eating)))
		to_chat(user, SPAN_WARNING("[src] does not support material recycling."))
		return FALSE

	if(!length(eating.get_matter()))
		to_chat(user, SPAN_WARNING("\The [eating] does not contain significant amounts of useful materials and cannot be accepted."))
		return FALSE

	if(istype(eating, /obj/item/stack/ore))
		to_chat(user, SPAN_WARNING("\The [eating] can not be accepted due to being unprocessed."))
		return FALSE

	if(istype(eating, /obj/item/computer_hardware/hard_drive/portable))
		var/obj/item/computer_hardware/hard_drive/portable/disk = eating
		if(disk.license)
			to_chat(user, SPAN_WARNING("\The [src] refuses to accept \the [eating] as it has non-null license."))
			return FALSE

	var/filltype = 0       // Used to determine message.
	var/reagents_filltype = 0
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.

	var/list/total_material_gained = list()

	for(var/obj/O in eating.GetAllContents(includeSelf = TRUE))
		var/list/_matter = O.get_matter()
		if(_matter)
			for(var/material in _matter)
				if(material in unsuitable_materials)
					continue

				if(suitable_materials)
					if(!(material in suitable_materials))
						continue

				if(!(material in stored_material))
					stored_material[material] = 0

				if(!(material in total_material_gained))
					total_material_gained[material] = 0

				if(stored_material[material] + total_material_gained[material] >= storage_capacity)
					continue

				var/total_material = _matter[material]

				//If it's a stack, we eat multiple sheets.
				if(istype(O, /obj/item/stack))
					var/obj/item/stack/material/stack = O
					total_material *= stack.get_amount()

				if(stored_material[material] + total_material > storage_capacity)
					total_material = storage_capacity - stored_material[material]
					filltype = 1
				else
					filltype = 2

				total_material_gained[material] += total_material
				total_used += total_material
				mass_per_sheet += O.matter[material]

		if(O.matter_reagents)
			if(container)
				var/datum/reagents/RG = new(0)
				for(var/r in O.matter_reagents)
					RG.maximum_volume += O.matter_reagents[r]
					RG.add_reagent(r ,O.matter_reagents[r])
				reagents_filltype = 1
				RG.trans_to(container, RG.total_volume)

			else
				reagents_filltype = 2

		if(O.reagents && container)
			O.reagents.trans_to(container, O.reagents.total_volume)

	if(!filltype && !reagents_filltype)
		to_chat(user, SPAN_NOTICE("\The [src] is full or this thing isn't suitable for this autolathe type. Try remove material from [src] in order to insert more."))
		return

	// Determine what was the main material
	var/main_material
	var/main_material_amt = 0
	for(var/material in total_material_gained)
		stored_material[material] += total_material_gained[material]
		if(total_material_gained[material] > main_material_amt)
			main_material_amt = total_material_gained[material]
			main_material = material

	if(istype(eating, /obj/item/stack))
		res_load(get_material_by_name(main_material)) // Play insertion animation.
		var/obj/item/stack/stack = eating
		var/used_sheets = min(stack.get_amount(), round(total_used/mass_per_sheet))

		to_chat(user, SPAN_NOTICE("You add [used_sheets] [main_material] [stack.singular_name]\s to \the [src]."))

		if(!stack.use(used_sheets))
			qdel(stack)	// Protects against weirdness
	else
		res_load() // Play insertion animation.
		to_chat(user, SPAN_NOTICE("You recycle \the [eating] in \the [src]."))
		qdel(eating)

	if(reagents_filltype == 1)
		to_chat(user, SPAN_NOTICE("Some liquid flowed to \the [container]."))
	else if(reagents_filltype == 2)
		to_chat(user, SPAN_NOTICE("Some liquid flowed to the floor from \the [src]."))

/obj/machinery/autolathe/proc/can_recycle(obj/O)
	if(!selectively_recycled_types)
		return FALSE
	if(!selectively_recycled_types.len)
		return FALSE

	for(var/type in selectively_recycled_types)
		if(istype(O, type))
			return TRUE

	return FALSE


/obj/machinery/autolathe/proc/eat_stack_only(obj/item/stack/material/eating)
	var/filltype = 0       // Used to determine message.
	var/reagents_filltype = 0
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.

	var/list/total_material_gained = list()

	for(var/obj/O in eating.GetAllContents(includeSelf = TRUE))
		var/obj/item/stack/material/stack = O
		var/list/_matter = O.get_matter()
		if(_matter)
			for(var/material in _matter)
				if(material in unsuitable_materials)
					continue

				if(suitable_materials)
					if(!(material in suitable_materials))
						continue

				if(!(material in stored_material))
					stored_material[material] = 0

				if(!(material in total_material_gained))
					total_material_gained[material] = 0

				if(stored_material[material] + total_material_gained[material] >= storage_capacity)
					continue

				var/total_material = _matter[material]

				total_material *= stack.get_amount()

				if(stored_material[material] + total_material > storage_capacity)
					total_material = storage_capacity - stored_material[material]
					filltype = 1
				else
					filltype = 2

				total_material_gained[material] += total_material
				total_used += total_material
				mass_per_sheet += O.matter[material]

		if(O.matter_reagents)
			if(container)
				var/datum/reagents/RG = new(0)
				for(var/r in O.matter_reagents)
					RG.maximum_volume += O.matter_reagents[r]
					RG.add_reagent(r ,O.matter_reagents[r])
				reagents_filltype = 1
				RG.trans_to(container, RG.total_volume)

			else
				reagents_filltype = 2

		if(O.reagents && container)
			O.reagents.trans_to(container, O.reagents.total_volume)

	if(!filltype && !reagents_filltype)
		return

	// Determine what was the main material
	var/main_material
	var/main_material_amt = 0
	for(var/material in total_material_gained)
		stored_material[material] += total_material_gained[material]
		if(total_material_gained[material] > main_material_amt)
			main_material_amt = total_material_gained[material]
			main_material = material


	res_load(get_material_by_name(main_material)) // Play insertion animation.
	var/obj/item/stack/eatstack = eating
	var/used_sheets = min(eatstack.get_amount(), round(total_used/mass_per_sheet))


	if(!eatstack.use(used_sheets))
		qdel(eatstack)	// Protects against weirdness




/obj/machinery/autolathe/proc/queue_design(datum/computer_file/binary/design/design_file, amount=1)
	if(!design_file || !amount)
		return

	// Copy the designs that are not copy protected so they can be printed even if the disk is ejected.
	if(!design_file.copy_protected)
		design_file = design_file.clone()

	while(amount && queue.len < queue_max)
		queue.Add(design_file)
		amount--

	if(!current_file)
		next_file()

/obj/machinery/autolathe/proc/clear_queue()
	queue.Cut()

/obj/machinery/autolathe/proc/check_craftable_amount_by_material(datum/design/design, material)
	return stored_material[material] / max(1, SANITIZE_LATHE_COST(design.materials[material])) // loaded material / required material

/obj/machinery/autolathe/proc/check_craftable_amount_by_chemical(datum/design/design, reagent)
	if(!container || !container.reagents)
		return 0

	return container.reagents.get_reagent_amount(reagent) / max(1, design.chemicals[reagent])


//////////////////////////////////////////
//Helper procs for derive possibility
//////////////////////////////////////////
/obj/machinery/autolathe/proc/design_list()
	if(!disk)
		return list()

	return disk.find_files_by_type(/datum/computer_file/binary/design)

/obj/machinery/autolathe/update_icon()
	cut_overlays()

	icon_state = initial(icon_state)

	if(panel_open)
		add_overlay(image(icon, "[icon_state]_panel"))

	if(stat & NOPOWER)
		icon_state = "[initial(icon_state)]_off"

	if(working) // if paused, work animation looks awkward.
		if(paused || error)
			icon_state = "[icon_state]_pause"
		else
			icon_state = "[icon_state]_work"

	if(direct_recycling)
		add_overlay(image(icon, "[initial(icon_state)]_recycle"))

//Procs for handling print animation
/obj/machinery/autolathe/proc/print_pre()
	flick("[initial(icon_state)]_start", src)

/obj/machinery/autolathe/proc/print_post()
	flick("[initial(icon_state)]_finish", src)
	if(!current_file && !queue.len)
		playsound(src.loc, 'sound/machines/ping.ogg', 50, 1 -3)
		visible_message("\The [src] pings, indicating that queue is complete.")


/obj/machinery/autolathe/proc/res_load(material/material)
	flick("[initial(icon_state)]_load", image_load)
	if(material)
		image_load_material.color = material.icon_colour
		image_load_material.alpha = max(255 * material.opacity, 200) // The icons are too transparent otherwise
		flick("[initial(icon_state)]_load_m", image_load_material)


/obj/machinery/autolathe/proc/can_print(datum/computer_file/binary/design/design_file)
	if(progress <= 0)
		if(!design_file || !design_file.design)
			return ERR_NOTFOUND

		if(!design_file.check_license())
			return ERR_NOLICENSE


		if(design_file.design.required_printer_code)
			if(design_file.design.code_dex != code_dex)
				return ERR_WRONG_BUILDTYPE

		var/datum/design/design = design_file.design

		for(var/rmat in design.materials)
			if(!(rmat in stored_material))
				return ERR_NOMATERIAL

			if(stored_material[rmat] < SANITIZE_LATHE_COST(design.materials[rmat]))
				return ERR_NOMATERIAL

		if(design.chemicals.len)
			if(!container || !container.is_drawable())
				return ERR_NOREAGENT

			for(var/rgn in design.chemicals)
				if(!container.reagents.has_reagent(rgn, design.chemicals[rgn]))
					return ERR_NOREAGENT


	if(paused)
		return ERR_PAUSED

	return ERR_OK


/obj/machinery/autolathe/power_change()
	..()
	if(stat & NOPOWER)
		working = FALSE
	update_icon()
	SSnano.update_uis(src)

/obj/machinery/autolathe/Process()
	if(stat & NOPOWER)
		return

	if(current_file)
		var/err = can_print(current_file)

		if(err == ERR_OK)
			error = null

			working = TRUE
			progress += speed

		else if(err in error_messages)
			error = error_messages[err]
		else
			error = "Unknown error."

		if(current_file.design && progress >= current_file.design.time)
			finish_construction()

	else
		error = null
		working = FALSE
		next_file()

	use_power = working ? ACTIVE_POWER_USE : IDLE_POWER_USE

	special_process()
	update_icon()
	SSnano.update_uis(src)
	if(auto_input)
		for(var/O in auto_in_turf)
			if(!istype(O, /obj/item/stack/material))
				continue
			var/obj/item/stack/material/M = O
			eat_stack_only(M)
			visible_message(SPAN_NOTICE("[src]'s automatic feeder attempts to load [M]!"))


/obj/machinery/autolathe/proc/consume_materials(datum/design/design)
	for(var/material in design.materials)
		var/material_cost = design.adjust_materials ? SANITIZE_LATHE_COST(design.materials[material]) : design.materials[material]
		stored_material[material] = max(0, stored_material[material] - material_cost)

	for(var/reagent in design.chemicals)
		container.reagents.remove_reagent(reagent, design.chemicals[reagent])

	return TRUE


/obj/machinery/autolathe/proc/next_file()
	current_file = null
	progress = 0
	if(queue.len)
		current_file = queue[1]
		print_pre()
		working = TRUE
		queue.Cut(1, 2) // Cut queue[1]
	else
		working = FALSE
	update_icon()

/obj/machinery/autolathe/proc/special_process()
	return

//Autolathes can eject decimal quantities of material as a shard
/obj/machinery/autolathe/proc/eject(material, amount)
	if(!(material in stored_material))
		return

	if(!amount)
		return

	var/material/M = get_material_by_name(material)

	if(!M.stack_type)
		return
	amount = min(amount, stored_material[material])

	var/whole_amount = round(amount)
	var/remainder = amount - whole_amount


	if(whole_amount)
		var/obj/item/stack/material/S = new M.stack_type(drop_location())

		//Accounting for the possibility of too much to fit in one stack
		if(whole_amount <= S.max_amount)
			S.amount = whole_amount
			S.update_strings()
			S.update_icon()
		else
			//There's too much, how many stacks do we need
			var/fullstacks = round(whole_amount / S.max_amount)
			//And how many sheets leftover for this stack
			S.amount = whole_amount % S.max_amount

			if(!S.amount)
				qdel(S)

			for(var/i = 0; i < fullstacks; i++)
				var/obj/item/stack/material/MS = new M.stack_type(drop_location())
				MS.amount = MS.max_amount
				MS.update_strings()
				MS.update_icon()


	//And if there's any remainder, we eject that as a shard
	if(remainder)
		new /obj/item/material/shard(drop_location(), material, _amount = remainder)

	//The stored material gets the amount (whole+remainder) subtracted
	stored_material[material] -= amount


/obj/machinery/autolathe/on_deconstruction()
	for(var/mat in stored_material)
		eject(mat, stored_material[mat])

	eject_disk()
	..()

//Updates lathe material storage size, production speed and material efficiency.
/obj/machinery/autolathe/RefreshParts()
	..()
	var/mb_rating = 0
	var/mb_amount = 0
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		mb_rating += MB.rating
		mb_amount++

	storage_capacity = round(initial(storage_capacity)*(mb_rating/mb_amount))

	var/man_rating = 0
	var/man_amount = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating
		man_amount++
	man_rating -= man_amount

	var/las_rating = 0
	var/las_amount = 0
	for(var/obj/item/stock_parts/micro_laser/M in component_parts)
		las_rating += M.rating
		las_amount++
	las_rating -= las_amount

	queue_max = initial(queue_max) + mb_rating + (hacked ? 8 : 0) //So the more matter bin levels the more we can queue!

	speed = initial(speed) + man_rating + las_rating
	mat_efficiency = max(max_efficiency, 1.0 - (man_rating * 0.1))




//Cancels the current construction
/obj/machinery/autolathe/proc/abort()
	if(working)
		print_post()
	current_file = null
	paused = TRUE
	working = FALSE
	update_icon()

//Finishing current construction
/obj/machinery/autolathe/proc/finish_construction()
	if(current_file.use_license()) //In the case of an an unprotected design, this will always be true
		fabricate_design(current_file.design)
	else
		//If we get here, then the user attempted to print something but the disk had run out of its limited licenses
		//Those dirty cheaters will not get their item. It is aborted before it finishes
		abort()


/obj/machinery/autolathe/proc/fabricate_design(datum/design/design)
	consume_materials(design)
	design.Fabricate(drop_location(), mat_efficiency, src)

	working = FALSE
	current_file = null
	print_post()
	next_file()



//Second level autolathe

/obj/machinery/autolathe/industrial
	name = "industrial autolathe"
	desc = "It produces items using metal and glass."
	idle_power_usage = 100
	active_power_usage = 8000
	circuit = /obj/item/circuitboard/autolathe_industrial
	speed = 4
	storage_capacity = 240
	max_efficiency = 0.3
	have_recycling = TRUE

/obj/machinery/autolathe/greyson
	name = "greyson autolathe"
	desc = "It produces items using metal and glass."
	icon_state = "greyson"
	idle_power_usage = 200
	active_power_usage = 10000
	circuit = /obj/item/circuitboard/autolathe_greyson
	speed = 4
	storage_capacity = 240
	have_recycling = TRUE

/obj/machinery/autolathe/greyson/RefreshParts()
	..()
	var/mb_rating = 0
	var/mb_amount = 0
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		mb_rating += MB.rating
		mb_amount++

	storage_capacity = round(initial(storage_capacity)*(mb_rating/mb_amount))

	var/man_rating = 0
	var/man_amount = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating
		man_amount++
	man_rating -= man_amount

	var/las_rating = 0
	var/las_amount = 0
	for(var/obj/item/stock_parts/micro_laser/M in component_parts)
		las_rating += M.rating
		las_amount++
	las_rating -= las_amount

	queue_max = initial(queue_max) + mb_rating //So the more matter bin levels the more we can queue!

	speed = initial(speed) + man_rating + las_rating
	mat_efficiency = max(0.05, 1.0 - (man_rating * 0.1))

#undef ERR_OK
#undef ERR_NOTFOUND
#undef ERR_NOMATERIAL
#undef ERR_NOREAGENT
#undef ERR_NOLICENSE
#undef ERR_PAUSED
#undef ERR_NOINSIGHT
#undef ERR_WRONG_BUILDTYPE


// A version with some materials already loaded, to be used on map spawn
/obj/machinery/autolathe/loaded
	stored_material = list(
		MATERIAL_STEEL = 15,
		MATERIAL_PLASTIC = 15,
		MATERIAL_GLASS = 15,
		)

/obj/machinery/autolathe/loaded/Initialize()
	. = ..()
	container = new /obj/item/reagent_containers/glass/beaker(src)


// You (still) can't flicker over-lays in BYOND, and this is a vis_contents hack to provide the same functionality.
// Used for materials loading animation.
/obj/effect/flicker_overlay
	name = ""
	icon_state = ""
	// Acts like a part of the object it's created for when in vis_contents
	// Inherits everything but the icon_state
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_DIR | VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID

/obj/effect/flicker_overlay/New(atom/movable/loc)
	..()
	// Just VIS_INHERIT_ICON isn't enough: flicker() needs an actual icon to be set
	icon = loc.icon
	loc.vis_contents += src

/obj/effect/flicker_overlay/Destroy()
	if(istype(loc, /atom/movable))
		var/atom/movable/A = loc
		A.vis_contents -= src
	return ..()

/obj/machinery/autolathe/verb/toggle_direct_recycling() // Verb designed to toggle Direct Recycling
	set name = "Direct Recycling"
	set category = "Object"
	set src in view(1)

	if(!direct_recycling)
		direct_recycling = TRUE
		to_chat(usr, SPAN_NOTICE("Direct Recycling has been enabled."))
		update_icon()
		return
	else
		direct_recycling = FALSE
		to_chat(usr, SPAN_NOTICE("Direct recycling has been disabled."))
		update_icon()
		return
