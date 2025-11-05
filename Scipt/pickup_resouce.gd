extends Resource
class_name  pickup

@export var title :String
@export var icon : Texture2D
@export_multiline var descripton : String

@export var weight : float

var player_reference : CharacterBody2D

func activates():
	print(title + "picked up")
