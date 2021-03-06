/datum/disease/gbs
	name = "GBS"
	max_stages = 5
	spread = "On contact"
	spread_type = CONTACT_GENERAL
	cure = "Synaptizine & Sulfur"
	cure_id = list("synaptizine","sulfur")
	agent = "Gravitokinetic Bipotential SADS+"
	affected_species = list("Human", "Monkey")
	curable = 0

/datum/disease/gbs/stage_act()
	..()
	switch(stage)
		if(2)
			if(prob(45))
				affected_mob.deal_damage(2, TOX)
			if(prob(1))
				affected_mob.emote("sneeze")
		if(3)
			if(prob(5))
				affected_mob.emote("cough")
			else if(prob(5))
				affected_mob.emote("gasp")
			if(prob(10))
				affected_mob << "\red You're starting to feel very weak..."
		if(4)
			if(prob(10))
				affected_mob.emote("cough")
			affected_mob.deal_damage(2, TOX)
		if(5)
			affected_mob << "\red Your body feels as if it's trying to rip itself open..."
			if(prob(50))
				affected_mob.gib()
	return