extends pickup
class_name PickupMagnet

func activates():
	super.activates()
	player_reference.get_tree().call_group("Pickups", "follow", player_reference, true)
