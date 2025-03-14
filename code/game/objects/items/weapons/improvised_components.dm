erial/butterflyconstruction
	name = "unfinished concealed knife"
	desc = "An unfinished concealed knife, it looks like the screws need to be tightened."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterflystep1"
	force_divisor = 0.1
	thrown_force_divisor = 0.1

erial/butterflyconstruction/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/tool/screwdriver))
		to_chat(user, "You finish the concealed blade weapon.")
		new erial/butterfly(user.loc, material.name)
		qdel(src)
		return

erial/butterflyblade
	name = "knife blade"
	desc = "A knife blade. Unusable as a weapon without a grip."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly2"
	force_divisor = 0.1
	thrown_force_divisor = 0.1

erial/butterflyhandle
	name = "concealed knife grip"
	desc = "A plasteel grip with screw fittings for a blade."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly1"
	force_divisor = 0.1
	thrown_force_divisor = 0.1

erial/butterflyhandle/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,erial/butterflyblade))
		varerial/butterflyblade/B = W
		to_chat(user, "You attach the two concealed blade parts.")
		new erial/butterflyconstruction(user.loc, B.material.name)
		qdel(W)
		qdel(src)
		return

erial/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "rods"
	flags = CONDUCT
	force = WEAPON_FORCE_PAINFUL
	throwforce = WEAPON_FORCE_NORMAL
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("hit", "bludgeoned", "whacked", "bonked")
	force_divisor = 0.1
	thrown_force_divisor = 0.1

erial/wirerod/attackby(var/obj/item/I, mob/user as mob)
	..()
	var/obj/item/finished
	if(istype(I, erial/shard))
		finished = new /obj/item/tool/spear(get_turf(user))
		to_chat(user, SPAN_NOTICE("You fasten \the [I] to the top of the rod with the cable."))
	else if((QUALITY_CUTTING in I.tool_qualities) || (QUALITY_WIRE_CUTTING in I.tool_qualities))
		finished = new /obj/item/tool/baton/cattleprod(get_turf(user))
		to_chat(user, SPAN_NOTICE("You fasten the wire cutters to the top of the rod with the cable, prongs outward."))
	if(finished)
		user.drop_from_inventory(src)
		user.drop_from_inventory(I)
		qdel(I)
		qdel(src)
		user.put_in_hands(finished)
	update_icon(user)
