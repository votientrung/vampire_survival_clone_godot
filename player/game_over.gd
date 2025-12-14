extends Control

@export var main_menu_scene: PackedScene

func _ready():
	hide()

func _on_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)
