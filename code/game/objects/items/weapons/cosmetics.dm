/obj/item/weapon/lipstick
	name = "red lipstick"
	desc = "A generic brand of lipstick."
	icon = 'icons/obj/items.dmi'
	icon_state = "lipstick"
	flags = FPRINT | TABLEPASS
	w_class = 1.0
	var/colour = "red"
	var/open = 0


/obj/item/weapon/lipstick/purple
	name = "purple lipstick"
	colour = "purple"

/obj/item/weapon/lipstick/jade
	name = "jade lipstick"
	colour = "jade"

/obj/item/weapon/lipstick/black
	name = "black lipstick"
	colour = "black"


/obj/item/weapon/lipstick/random
	name = "lipstick"

/obj/item/weapon/lipstick/random/New()
	colour = pick("red","purple","jade","black")
	name = "[colour] lipstick"


/obj/item/weapon/lipstick/attack_self(mob/user as mob)
	user << "<span class='notice'>You twist \the [src] [open ? "closed" : "open"].</span>"
	open = !open
	if(open)
		icon_state = "[initial(icon_state)]_[colour]"
	else
		icon_state = initial(icon_state)

/obj/item/weapon/lipstick/attack(mob/M as mob, mob/user as mob)
	if(!open)	return

	if(!istype(M, /mob))	return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.lip_style)	//if they already have lipstick on
			user << "<span class='notice'>You need to wipe off the old lipstick first!</span>"
			return
		if(H == user)
			user.visible_message("<span class='notice'>[user] does their lips with \the [src].</span>", \
								 "<span class='notice'>You take a moment to apply \the [src]. Perfect!</span>")
			H.unlock_achievement("Opposites Attract")
			H.lip_style = colour
			H.update_body()
		else
			user.visible_message("<span class='warning'>[user] begins to do [H]'s lips with \the [src].</span>", \
								 "<span class='notice'>You begin to apply \the [src].</span>")
			if(do_after(user, 20) && do_after(H, 20, 5, 0))	//user needs to keep their active hand, H does not.
				user.visible_message("<span class='notice'>[user] does [H]'s lips with \the [src].</span>", \
									 "<span class='notice'>You apply \the [src].</span>")
				H.lip_style = colour
				H.update_body()
	else
		user << "<span class='notice'>Where are the lips on that?</span>"

//you can wipe off lipstick with paper!
/obj/item/weapon/paper/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(user.zone_sel.selecting == "mouth")
		if(!istype(M, /mob))	return

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H == user)
				user << "<span class='notice'>You wipe off the lipstick with [src].</span>"
				H.lip_style = null
				H.update_body()
			else
				user.visible_message("<span class='warning'>[user] begins to wipe [H]'s lipstick off with \the [src].</span>", \
								 	 "<span class='notice'>You begin to wipe off [H]'s lipstick.</span>")
				if(do_after(user, 10) && do_after(H, 10, 5, 0))	//user needs to keep their active hand, H does not.
					user.visible_message("<span class='notice'>[user] wipes [H]'s lipstick off with \the [src].</span>", \
										 "<span class='notice'>You wipe off [H]'s lipstick.</span>")
					H.lip_style = null
					H.update_body()
	else
		..()





/*

/obj/item/device/puller
	name = "Grenade Casing"
	icon_state = "chemg"
	item_state = "flashbang"
	icon = 'icons/obj/grenade.dmi'

/obj/item/device/puller/proc/controller()
	while(src)

		if(!isturf(loc))
			del(src)
			return

		//DESTROYING STUFF AT THE EPICENTER
		for(var/mob/living/M in orange(1,src))
			del(M)
		for(var/obj/O in orange(1,src))
			del(O)
		for(var/turf/simulated/ST in orange(1,src))
			ST.ChangeTurf(/turf/space)

		sleep(6)
		grav(10, 4, 10, 0 )
		sleep(6)
		grav( 8, 4, 10, 0 )
		sleep(6)
		grav( 9, 4, 10, 0 )
		sleep(6)
		grav( 7, 3, 40, 1 )
		sleep(6)
		grav( 5, 3, 40, 1 )
		sleep(6)
		grav( 6, 3, 40, 1 )
		sleep(6)
		grav( 4, 2, 50, 6 )
		sleep(6)
		grav( 3, 2, 50, 6 )
		sleep(6)
		grav( 2, 2, 75,25 )
		sleep(6)



		//MOVEMENT
		if( prob(50) )
			src.anchored = 0
			step(src,pick(alldirs))
			src.anchored = 1
*/