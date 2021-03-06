/client/proc/atmosscan()
	set category = "Mapping"
	set name = "Check Plumbing"
	if(!src.holder)
		src << "Only administrators may use this command."
		return


	//all plumbing - yes, some things might get stated twice, doesn't matter.
	for (var/obj/machinery/atmospherics/plumbing in world)
		if (plumbing.nodealert)
			usr << "Unconnected [plumbing.name] located at [plumbing.x],[plumbing.y],[plumbing.z] ([get_area(plumbing.loc)])"

	//Manifolds
	for (var/obj/machinery/atmospherics/pipe/manifold/pipe in world)
		if (!pipe.node1 || !pipe.node2 || !pipe.node3)
			usr << "Unconnected [pipe.name] located at [pipe.x],[pipe.y],[pipe.z] ([get_area(pipe.loc)])"

	//Pipes
	for (var/obj/machinery/atmospherics/pipe/simple/pipe in world)
		if (!pipe.node1 || !pipe.node2)
			usr << "Unconnected [pipe.name] located at [pipe.x],[pipe.y],[pipe.z] ([get_area(pipe.loc)])"

/client/proc/powerdebug()
	set category = "Mapping"
	set name = "Check Power"
	if(!src.holder)
		src << "Only administrators may use this command."
		return


	for (var/datum/powernet/PN in SSpower.powernets)
		if (!PN.nodes || !PN.nodes.len)
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				usr << "Powernet with no nodes! \ref[PN] - example cable at [C.x], [C.y], [C.z] in area [get_area(C.loc)]"

		if (!PN.cables || (PN.cables.len < 10))
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				usr << "Powernet with fewer than 10 cables! \ref[PN] - example cable at [C.x], [C.y], [C.z] in area [get_area(C.loc)]"