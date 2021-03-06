/obj/item/weapon/gun/gib
	icon_state = "biggun"
	name = "gibbing gun"
	desc = "A gun that gibs people."
	fire_sound = 'sound/weapons/gibgun.ogg'
	locked = -1


	afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
		if(flag) return//backpacks, ect
		playsound(user, fire_sound, 100, 1)
		user.visible_message("<span class='warning'>[user] fires [src]!</span>", "<span class='warning'>You fire [src]!</span>", "You hear a splat!")
		spawn(5)
			user.drop_item()
			user.gib()
		return
