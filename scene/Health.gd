extends pickup
class_name Health

@export var amount : int = 50

func activates():
	super.activates()
	player_reference.health += amount
	
