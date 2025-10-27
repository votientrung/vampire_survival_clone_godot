extends pickup
class_name Death

func activates():
	super.activates()
	player_reference.get_tree().call_group("Enemy", "drop_item")
