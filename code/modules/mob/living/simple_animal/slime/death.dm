/mob/living/simple_animal/slime/death(gibbed)
	if(stat == DEAD)
		return
	remove_form_spawner_menu()
	if(!gibbed)
		if(is_adult)
			var/mob/living/simple_animal/slime/M = new(loc, colour)
			M.rabid = TRUE
			M.regenerate_icons()

			is_adult = FALSE
			maxHealth = 150
			for(var/datum/action/innate/slime/reproduce/R in actions)
				qdel(R)
			var/datum/action/innate/slime/evolve/E = new
			E.Grant(src)
			revive(full_heal = 1)
			regenerate_icons()
			update_name()
			return

	if(buckled)
		Feedstop(silent = TRUE) //releases ourselves from the mob we fed on.

	GLOB.total_slimes--
	stat = DEAD
	cut_overlays()

	if(SSticker.mode)
		SSticker.mode.check_win()

	return ..(gibbed)

/mob/living/simple_animal/slime/gib()
	death(TRUE)
	qdel(src)


/mob/living/simple_animal/slime/Destroy()
	for(var/obj/machinery/computer/camera_advanced/xenobio/X in GLOB.machines)
		if(src in X.stored_slimes)
			X.stored_slimes -= src
	if(stat != DEAD)
		GLOB.total_slimes--
	remove_form_spawner_menu()
	master = null
	return ..()
