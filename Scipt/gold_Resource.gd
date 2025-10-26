extends pickup
class_name Gold_resouce


@export var amount : int

func activates():
	super.activates()
	player_reference.gain_gold(amount)
