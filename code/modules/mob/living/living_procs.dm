//TODO: Add vimpaired, blurry and druggy
/mob/living/proc/handle_hud_vision()
	if (stat != DEAD)
		if (blind)
			blind.alpha = blinded ? 255 : 0
	else
		reset_hud_vision()

/mob/living/proc/reset_hud_vision()
	if (blind)
		blind.alpha = 0