
/client/verb/who()
	set name = "Who"
	set category = "OOC"

	var/msg = "<b>Current Players:</b>\n"

	var/list/Lines = list()

	if(!holder)//Standard players see
		for(var/client/C in clients)
			if(C.holder && C.holder.fakekey)
				Lines += C.holder.fakekey
			else
				Lines += C.key

	else//What admins see
		for(var/client/C in clients)
			var/entry = "\t[C.key]"
			if(C.holder && C.holder.fakekey)
				entry += " <i>(as [C.holder.fakekey])</i>"
			entry += " - Playing as [C.mob.real_name]"
			switch(C.mob.stat)
				if(UNCONSCIOUS)
					entry += " - <font color='darkgray'><b>Unconscious</b></font>"
				if(DEAD)
					if(isobserver(C.mob))
						var/mob/dead/observer/O = C.mob
						if(O.started_as_observer)
							entry = "\t[C.key]"
							if(C.holder && C.holder.fakekey)
								entry += " <i>(as [C.holder.fakekey])</i>"
							entry += " - Observing as [C.mob.real_name]"
							entry += " - <font color='gray'>Observing</font>"
						else
							entry += " - <font color='black'><b>DEAD</b></font>"
					else
						entry += " - <font color='black'><b>DEAD</b></font>"
			if(is_special_character(C.mob))
				entry += " - <b><font color='red'>Antagonist</font></b>"
			entry += " (<A HREF='?_src_=holder;adminmoreinfo=\ref[C.mob]'>?</A>)"
			Lines += entry


	for(var/line in sortList(Lines))
		msg += "[line]\n"

	msg += "<b>Total Players: [length(Lines)]</b>"
	src << msg
	return

var/global/endevent = 0

/client/verb/adminwho()
	set category = "Admin"
	set name = "Adminwho"

	var/msg = "<b>Current Admins:</b>\n"
	if(!holder)//Players see this
		for(var/client/C in admins)
			if(!endevent)
				if(!C.holder.fakekey)
					msg += "\t[C] is a [C.holder.rank]\n"
	else//Admins see this
		for(var/client/C in admins)
			msg += "\t[C] is a [C.holder.rank]"

			if(C.holder.fakekey)
				msg += " <i>(as [C.holder.fakekey])</i>"

			if(isobserver(C.mob))
				msg += " - Observing"
			else if(istype(C.mob,/mob/new_player))
				msg += " - Lobby"
			else
				msg += " - Playing"

			if(C.is_afk())
				msg += " (AFK)"
			msg += "\n"


	src << msg
	return