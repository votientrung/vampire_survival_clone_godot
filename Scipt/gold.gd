extends pickup
class_name Gold

var player_referencce : CharacterBody2D
@export var gold :int = 5

func activates():
	player_reference.gain_gold(gold)
