/obj/effect/effect/melee/swing
	name = "swing"
	icon = 'icons/effects/meleeeffects.dmi'
	pixel_x = -32
	pixel_y = -32
	anchored = TRUE
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/effect/melee/alert
	name = "READY TO STRIKE" //Making this REALLY OBVIOUS
	icon = 'icons/effects/alerts.dmi'
	icon_state = "ready"
	pixel_y = 4
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/effect/melee/mob_melee_animation
	icon = 'icons/effects/mob_melee_animation.dmi'
	anchored = TRUE
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/effect/melee/mob_melee_animation/New(fancy_colour)
	..()
	if(fancy_colour)
		color = fancy_colour
