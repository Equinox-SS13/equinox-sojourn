/datum/preferences
	var/mob/living/carbon/human/dummy/mannequin/mannequin = null

/datum/preferences/proc/update_preview_icon(var/naked = FALSE)
	mannequin = get_mannequin(client_ckey)
	mannequin.delete_inventory(TRUE)

//Equinox edit - makes it so that you can preview your character edits when the server is still initing
	dress_preview_mob(mannequin, naked)

	update_character_previews(new /mutable_appearance(mannequin))

	return mannequin.icon
