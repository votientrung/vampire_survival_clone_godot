extends Item
class_name Gold

var player_referencce : CharacterBody2D
@export var gold :int = 5

func upgrade_item():
		if is_instance_valid(player_referencce):
			player_referencce.gain_gold(gold)
