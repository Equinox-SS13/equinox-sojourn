/obj/item/gun/projectile/boltgun/sa
	name = "\"Militia\" bolt-action rifle"
	desc = "A simple bolt-action rifle made to meet modern combat standards. Chambered in 7.62mm."
	icon = 'icons/obj/guns/projectile/boltgun_wood.dmi'
	icon_state = "boltgun"
	item_state = "boltgun"
	max_shells = 5
	price_tag = 450
	matter = list(MATERIAL_STEEL = 20, MATERIAL_WOOD = 10)
	saw_off = TRUE
	sawn = /obj/item/gun/projectile/boltgun/sawn/sa
	serial_type = "Hunt Inc."
	gun_parts = list(/obj/item/part/gun/frame/boltgun = 1, /obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/boltgun = 1, /obj/item/part/gun/barrel/lrifle/steel = 1)

/obj/item/gun/projectile/boltgun/sawn/sa
	name = "\"Obrez\" bolt-action pistol"
	desc = "A Militia bolt-action rifle with most of it's barrel and furniture removed. Chambered in 7.62mm."
	icon = 'icons/obj/guns/projectile/sawnoff/boltgun_wood.dmi'
	icon_state = "obrez"
	item_state = "obrez"
	max_shells = 5
	init_recoil = HMG_RECOIL(0.8)
	matter = list(MATERIAL_STEEL = 10, MATERIAL_WOOD = 4)
	saw_off = FALSE
	serial_type = "Hunt Inc."
	gun_parts = list(/obj/item/part/gun/grip/wood = 1, /obj/item/part/gun/mechanism/boltgun = 1, /obj/item/stack/material/steel = 2)

