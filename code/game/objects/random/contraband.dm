/obj/random/contraband
	name = "random illegal item"
	icon_state = "box-red"

/obj/random/contraband/item_to_spawn()
	return pickweight(list(
				/obj/random/pack/rare = 1,
				/obj/item/storage/pill_bottle/tramadol = 3,
				/obj/item/haircomb = 4,
				/obj/item/storage/pill_bottle/happy = 2,
				/obj/item/storage/pill_bottle/zoom = 2,
				/obj/item/contraband/poster = 5,
				erial/butterfly = 2,
				erial/butterflyblade = 3,
				erial/butterflyhandle = 3,
				erial/wirerod = 3,
				erial/butterfly/switchblade = 1,
				/obj/item/clothing/mask/chameleon = 1,
				/obj/item/clothing/glasses/chameleon = 1,
				/obj/item/clothing/gloves/chameleon = 1,
				/obj/item/storage/backpack/chameleon = 1,
				/obj/item/device/radio/headset/chameleon = 1,
				/obj/item/clothing/shoes/chameleon = 1,
				/obj/item/clothing/head/chameleon = 1,
				/obj/item/clothing/under/chameleon = 1,
				/obj/item/gun/energy/chameleon = 2,
				/obj/item/reagent_containers/syringe/drugs = 1,
				/obj/item/reagent_containers/syringe/drugs_recreational = 1,
				erial/butterfly/frenchman = 1))

/obj/random/contraband/low_chance
	name = "low chance random illegal item"
	icon_state = "box-red-low"
	spawn_nothing_percentage = 60
