/turf/simulated
	name = "station"
	var/wet = 0
	var/image/wet_overlay = null

	var/thermite = 0
	oxygen = MOLES_O2STANDARD
	nitrogen = MOLES_N2STANDARD
	var/to_be_destroyed = 0 //Used for fire, if a melting temperature was reached, it will be destroyed
	var/max_fire_temperature_sustained = 0 //The max temperature of the fire which it was subjected to

/turf/simulated/New()
	..()
	levelupdate()

/turf/simulated/Entered(atom/A, atom/OL)
	if (istype(A,/mob/living/carbon))
		var/mob/living/carbon/M = A
		if(M.lying)	return
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(istype(H.shoes, /obj/item/clothing/shoes/clown_shoes))
				var/obj/item/clothing/shoes/clown_shoes/O = H.shoes
				if(H.m_intent == "run")
					if(O.footstep >= 2)
						O.footstep = 0
						playsound(src, "clownstep", 50, 1) // this will get annoying very fast.
					else
						O.footstep++
				else
					playsound(src, "clownstep", 20, 1)

		switch(src.wet)
			if(1)
				if(M.m_intent == "run")
					if(istype(M, /mob/living/carbon/human)) // Added check since monkeys don't have shoes
						if(!(istype(M:shoes, /obj/item/clothing/shoes) && M:shoes.flags&NOSLIP))
							M.stop_pulling()
							step(M, M.dir)
							M << "\blue You slipped on the wet floor!"
							playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
							M.deal_damage(8, WEAKEN, IMPACT, "chest")
					else
						M.stop_pulling()
						step(M, M.dir)
						M << "\blue You slipped on the wet floor!"
						playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
						M.deal_damage(8, WEAKEN, IMPACT, "chest")

			if(2) //lube		//can cause infinite loops - needs work
				M.stop_pulling()
				step(M, M.dir)
				spawn(1) step(M, M.dir)
				spawn(2) step(M, M.dir)
				spawn(3) step(M, M.dir)
				spawn(4) step(M, M.dir)
				M << "\blue You slipped on the floor!"
				playsound(src.loc, 'sound/misc/slip.ogg', 50, 1, -3)
				M.deal_damage(10, WEAKEN, IMPACT, "chest")
	..()