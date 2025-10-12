extends TextureButton

@export var weapon : Weapon :
	set(value):
		weapon = value
		
		texture_normal = value.texture
		$Label.text = "lvl " + str(weapon.level + 1)
		$description.text = value.upgrades[value.level-1].description



func _on_gui_input(event: InputEvent) :
	if event.is_action("click") and weapon:
		print(weapon.title)
		weapon.updrage_item()
		get_parent().close_option()
		
