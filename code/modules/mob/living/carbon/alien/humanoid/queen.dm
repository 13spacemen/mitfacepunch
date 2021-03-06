/mob/living/carbon/alien/humanoid/queen
	name = "alien queen"
	caste = "q"
	maxHealth = 250
	health = 250
	icon_state = "alienq_s"
	status_flags = CANPARALYSE
	plasma_rate = 20


	New()
		//there should only be one queen
		for(var/mob/living/carbon/alien/humanoid/queen/Q in living_mob_list)
			if(Q == src)		continue
			if(Q.stat == DEAD)	continue
			if(Q.client)
				name = "alien princess ([rand(1, 999)])"	//if this is too cutesy feel free to change it/remove it.
				break

		real_name = src.name
		verbs.Add(/mob/living/carbon/alien/humanoid/proc/corrosive_acid,/mob/living/carbon/alien/humanoid/proc/neurotoxin,/mob/living/carbon/alien/humanoid/proc/resin)
		verbs -= /mob/living/carbon/alien/verb/ventcrawl
		..()


	handle_regular_hud_updates()
		..()
		if(src.healths)
			if(src.stat == 2)
				src.healths.icon_state = "health6"
			else
				switch(health)
					if(250 to INFINITY)
						src.healths.icon_state = "health0"
					if(175 to 250)
						src.healths.icon_state = "health1"
					if(100 to 175)
						src.healths.icon_state = "health2"
					if(50 to 100)
						src.healths.icon_state = "health3"
					if(0 to 50)
						src.healths.icon_state = "health4"
					else
						src.healths.icon_state = "health5"

	movement_delay()
		return (5 + move_delay_add + config.alien_delay)


//Queen verbs
	verb/lay_egg()
		set name = "Lay Egg (75)"
		set desc = "Lay an egg to produce huggers to impregnate prey with."
		set category = "Alien"

		if(locate(/obj/effect/alien/egg) in get_turf(src))
			src << "There's already an egg here."
			return

		if(powerc(75,1))//Can't plant eggs on spess tiles. That's silly.
			adjustPlasma(-75)
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\green <B>[src] has laid an egg!</B>"), 1)
			new /obj/effect/alien/egg(loc)
		return





/mob/living/carbon/alien/humanoid/queen/large
	icon = 'icons/mob/alienqueen.dmi'
	icon_state = "queen_s"
	pixel_x = -16

/mob/living/carbon/alien/humanoid/queen/large/update_icons()
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again
	update_hud()		//TODO: remove the need for this to be here
	overlays.Cut()
	if(lying)
		if(resting)					icon_state = "queen_sleep"
		else						icon_state = "queen_l"
		for(var/image/I in overlays_lying)
			overlays += I
	else
		icon_state = "queen_s"
		for(var/image/I in overlays_standing)
			overlays += I