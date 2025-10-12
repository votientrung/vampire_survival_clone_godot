extends pickup
class_name gem

@export var xp : float

func activates():
	super.activates()
	print("+" + str(xp) + "XP")
	player_reference.gain_xp(xp)
