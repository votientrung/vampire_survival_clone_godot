extends pickup
class_name Chest

func activates():
	super.activates()
	player_reference.open_chest()
