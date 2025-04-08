/obj/item/reagent_containers/glass/beaker/hypocartridge
	name = "broken apollo cartridge"
	desc = "A specialized cartridge compatible with the MID 'Apollo'."
	icon = 'modular_sojourn/hypospray_mk2/icons/chemical.dmi'
	icon_state = "hypovial"
	w_class = ITEM_SIZE_SMALL
	volume = 10
	filling_states = "-10;10;25;50;75;80;100"
	possible_transfer_amounts = list(5,10,15)

/obj/item/reagent_containers/glass/beaker/hypocartridge/Initialize()
	. = ..()
	update_icon()
	update_name_label()

/obj/item/reagent_containers/glass/beaker/hypocartridge/update_icon()
	cut_overlays()

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('modular_sojourn/hypospray_mk2/icons/reagentfillings.dmi', "hypovial[get_filling_state()]")
		filling.color = reagents.get_color()
		add_overlay(filling)

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/Initialize()
	. = ..()
	update_icon()
	update_name_label()

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/update_icon()
	cut_overlays()

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('modular_sojourn/hypospray_mk2/icons/reagentfillings.dmi', "hypoviallarge[get_filling_state()]")
		filling.color = reagents.get_color()
		add_overlay(filling)

/obj/item/reagent_containers/glass/beaker/hypocartridge/tiny
	name = "small mid apollo cartridge"
	//Shouldn't be possible to get this without adminbuse

/obj/item/reagent_containers/glass/beaker/hypocartridge/small
	name = "mid apollo cartridge"
	volume = 45
	possible_transfer_amounts = list(5,10,15)

/*
/obj/item/reagent_containers/glass/beaker/hypocartridge/bluespace
	name = "bluespace hypovial"
	icon_state = "hypovialbs"
	rarity_value = 100
	volume = 90
	possible_transfer_amounts = list(5,10,15)
*/

/obj/item/reagent_containers/glass/beaker/hypocartridge/large
	name = "mid 'hecate' cartridge"
	desc = "A large MID Cartridge, for the MID 'Hecate'."
	icon_state = "hypoviallarge"
	volume = 90
	possible_transfer_amounts = list(5,10,15)

/*	unique_reskin = list("large hypovial" = "hypoviallarge",		//Saving for icon reference purely.
						"large red hypovial" = "hypoviallarge-b",
						"large blue hypovial" = "hypoviallarge-d",
						"large green hypovial" = "hypoviallarge-a",
						"large orange hypovial" = "hypoviallarge-k",
						"large purple hypovial" = "hypoviallarge-p",
						"large black hypovial" = "hypoviallarge-t"
						)
	cached_icon = "hypoviallarge"
*/
/*
/obj/item/reagent_containers/glass/beaker/hypocartridge/large/bluespace
	possible_transfer_amounts = list(5,10,15)
	name = "bluespace large hypovial"
	volume = 240
	rarity_value = 150
	icon_state = "hypoviallargebs"
*/

/obj/item/reagent_containers/glass/beaker/hypocartridge/small/polystem
	name = "red mid cartridge"
	icon_state = "hypovial-b"
	preloaded_reagents = list("polystem" = 45)
	label_text = "polystem"

/obj/item/reagent_containers/glass/beaker/hypocartridge/small/paracetamol
	name = "grey mid cartridge"
	icon_state = "hypovial-t"
	preloaded_reagents = list("paracetamol" = 45)
	label_text = "paracetamol"

/obj/item/reagent_containers/glass/beaker/hypocartridge/small/antitoxin
	name = "green mid cartridge"
	icon_state = "hypovial-a"
	preloaded_reagents = list("anti_toxin" = 45)
	label_text = "anti-tox"

/obj/item/reagent_containers/glass/beaker/hypocartridge/small/kelotane
	name = "orange mid cartridge"
	icon_state = "hypovial-k"
	preloaded_reagents = list("kelotane" = 45)
	label_text = "kelotane"

/obj/item/reagent_containers/glass/beaker/hypocartridge/small/dexalin
	name = "blue mid cartridge"
	icon_state = "hypovial-d"
	preloaded_reagents = list("dexalin" = 45)
	label_text = "dexalin"

/obj/item/reagent_containers/glass/beaker/hypocartridge/small/tricord
	name = "mid cartridge"
	icon_state = "hypovial"
	preloaded_reagents = list("tricordrazine" = 45)
	label_text = "tricord"

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/CMO
	name = "mid 'hecate' cartridge"
	icon_state = "hypoviallarge"
	preloaded_reagents = list("meralyne" = 45)
	label_text = "meralyne"

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/polystem
	name = "mid 'hecate' cartridge"
	icon_state = "hypoviallarge"
	preloaded_reagents = list("polystem" = 45)
	label_text = "polystem"

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/antitoxin
	name = "mid 'hecate' cartridge"
	icon_state = "hypoviallarge"
	preloaded_reagents = list("anti_toxin" = 45)
	label_text = "anti-tox"

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/kelotane
	name = "mid 'hecate' cartridge"
	icon_state = "hypoviallarge"
	preloaded_reagents = list("kelotane" = 45)
	label_text = "kelotane"

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/dexalin
	name = "mid 'hecate' cartridge"
	icon_state = "hypoviallarge"
	preloaded_reagents = list("dexalin" = 45)
	label_text = "dexalin"

/obj/item/reagent_containers/glass/beaker/hypocartridge/large/tricord
	name = "mid 'hecate' cartridge"
	icon_state = "hypoviallarge"
	preloaded_reagents = list("tricordrazine" = 45)
	label_text = "tricord"

/obj/item/reagent_containers/glass/beaker/hypocartridge/small/combat
	name = "combat mid 'ares' cartridge"
	icon_state = "hypovial-t"
	preloaded_reagents = list("synaptizine" = 5, "hyperzine" = 10, "paracetamol" = 10, "trauma_control_system" = 10, "nanosymbiotes" = 10)
