//Adding in robot energy powered variants of guns, to avoid the hassle of needing to reload, etc. Centralising them all here for ease of use.

/obj/item/gun/energy/riot_autoshotgun
	name = "intergrated \"State\" riot shotgun"
	desc = "An unorthodox semi-automatic riot shotgun custom fitted for use by a cyborg. Chambered in 20mm."
	icon = 'icons/obj/robot_items.dmi'
	icon_state = "riot_shotgun"
	item_state = "riot_shotgun"
	cell_type = /obj/item/cell/medium/greyson
	modifystate = null
	force = WEAPON_FORCE_PAINFUL
	charge_cost = 100 //16 shots
	self_recharge = 1
	init_firemodes = list(
		list(mode_name="beanbag", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag, fire_sound = 'sound/weapons/guns/fire/shotgun_combat.ogg', fire_delay=25, icon="stun"),
		list(mode_name="slug", projectile_type=/obj/item/projectile/bullet/shotgun, fire_sound='sound/weapons/guns/fire/shotgun_combat.ogg', fire_delay=10, icon="kill"),
		list(mode_name="buckshot", projectile_type=/obj/item/projectile/bullet/pellet/shotgun, fire_sound='sound/weapons/guns/fire/shotgun_combat.ogg', fire_delay=10, icon="kill"),
		list(mode_name="pepperball", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag/pepperball, fire_sound='sound/weapons/guns/fire/shotgun_combat.ogg', fire_delay=10, icon="stun")
	)
	serial_type = "SD GmbH"
	charge_meter = FALSE

/obj/item/gun/energy/bsrifle
	name = "integrated \"STS\" Burst rifle"
	desc = "A modified variant of the STS rifle that has been modified to serve as the primary weapon for a combat robot, connected to a synthesizer."
	icon = 'icons/obj/robot_items.dmi'
	icon_state = "security_rifle"
	item_state = "security_rifle"
	damage_multiplier = 1.2 //all firemodes are -0.2 so this should go down to 1.0
	cell_type = /obj/item/cell/medium/greyson
	modifystate = null
	force = WEAPON_FORCE_PAINFUL
	charge_cost = 32 //about 50 rounds per full charge
	self_recharge = 1
	charge_meter = TRUE
	serial_type = "NM"
	init_firemodes = list(
		list(mode_name="Rubbers Burst", projectile_type=/obj/item/projectile/bullet/rifle_75/rubber, fire_sound = 'sound/weapons/guns/fire/NM_PARA.ogg', burst = 2 ,fire_delay = 10, icon="burst", damage_mult_add = -0.2),
		list(mode_name="Standard Burst", projectile_type=/obj/item/projectile/bullet/rifle_75, fire_sound = 'sound/weapons/guns/fire/NM_PARA.ogg', burst = 2 ,fire_delay = 10, icon="burst", damage_mult_add = -0.2),
		list(mode_name="Hollowpoint Burst", projectile_type=/obj/item/projectile/bullet/rifle_75/lethal, fire_sound = 'sound/weapons/guns/fire/NM_PARA.ogg', burst = 2 , fire_delay = 10,  icon="burst", damage_mult_add = -0.2),
		list(mode_name="Incendiary Burst", projectile_type=/obj/item/projectile/bullet/rifle_75/incend, fire_sound = 'sound/weapons/guns/fire/NM_PARA.ogg', burst = 2, fire_delay = 20, icon="burst", damage_mult_add = -0.2),
		)

/obj/item/gun/energy/dazzlation //the last gun you'll ever need.
	name = "integrated \"Dazlation\" light pistol"
	icon = 'icons/obj/guns/projectile/flaregun.dmi'
	icon_state = "flaregun"
	item_state = "pistol"
	fire_sound = 'sound/weapons/guns/interact/hpistol_cock.ogg'
	cell_type = /obj/item/cell/small/greyson
	charge_cost = 200 //2 shots per 'charge'
	proj_step_multiplier = 0.5
	self_recharge = 1
	charge_meter = FALSE

	init_firemodes = list(
		list(mode_name="Red Flare", projectile_type=/obj/item/projectile/bullet/flare, fire_sound = 'sound/weapons/guns/interact/hpistol_cock.ogg', fire_delay = 20 , icon="grenade"),
		list(mode_name="Green Flare", projectile_type=/obj/item/projectile/bullet/flare/green, fire_sound = 'sound/weapons/guns/interact/hpistol_cock.ogg', fire_delay = 20 , icon="grenade"),
		list(mode_name="Blue Flare", projectile_type=/obj/item/projectile/bullet/flare/blue, fire_sound = 'sound/weapons/guns/interact/hpistol_cock.ogg', fire_delay = 20  , icon="grenade"),
		list(mode_name="Random Flare", projectile_type=/obj/item/projectile/bullet/flare/chaos, fire_sound = 'sound/weapons/guns/interact/hpistol_cock.ogg', fire_delay = 20  , icon="grenade")
		)

/obj/item/gun/energy/borg/pistol
	name = "\"Disabler\" pistol"
	desc = "A standardised ammunition-synthesising pistol superficially resembling an ancient pistol."
	icon = 'icons/obj/guns/projectile/glock.dmi'
	icon_state = "glock"
	item_state = "glock"
	cell_type = /obj/item/cell/medium/greyson
	modifystate = null
	charge_cost = 50 //32 shots
	self_recharge = 1
	init_firemodes = list(
		list(mode_name="rubber bullet", projectile_type=/obj/item/projectile/bullet/pistol_35/rubber, fire_sound = 'sound/weapons/guns/fire/9mm_pistol.ogg', fire_delay=10
		, icon="stun"),
		list(mode_name="Hollowpoint round", projectile_type=/obj/item/projectile/bullet/pistol_35/lethal, fire_sound='sound/weapons/guns/fire/9mm_pistol.ogg', fire_delay=5, icon="kill"),
		)
	charge_meter = FALSE

/obj/item/gun/energy/smg
	icon = 'icons/obj/guns/projectile/armsmg.dmi'
	icon_state = "armsmg"
	item_state = null
	name = "embedded energy SMG"
	desc = "An energy-based SMG deployed from your arm. A favoured hidden weapon."
	cell_type = /obj/item/cell/medium/greyson
	charge_cost = 20 //80 shots
	self_recharge = 1
	fire_sound = 'sound/weapons/energy/laser_pistol.ogg'
	projectile_type = /obj/item/projectile/bullet/pistol_35/lethal //self defense gun, great for bugs less good for a "real fight" against anyone with anything resembling armor
	damage_multiplier = 0.7
	penetration_multiplier = 0.7
	init_recoil = HANDGUN_RECOIL(0.4) //Hard to control accurately in most cases.
	charge_meter = FALSE
	gun_tags = list(GUN_PROJECTILE, GUN_CALIBRE_9MM)
	init_firemodes = list(
		FULL_AUTO_300_NOLOSS,
		BURST_3_ROUND_NOLOSS,
		SEMI_AUTO_NODELAY
		)

/obj/item/gun/energy/smg/blackshield
	init_recoil = HANDGUN_RECOIL(0.2) //Unless you've got built-in targetting software.
	cell_type = /obj/item/cell/medium/hyper //we're not Soteria produced, so we don't get a Soteria cell.
