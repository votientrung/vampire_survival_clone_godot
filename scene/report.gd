extends Panel

@onready var text = $Panel/Text
@onready var weapons = %Weapons

var game_over : bool = false
var temp = []

func _ready():
	hide()
	
func _process(_delta):
	set_text()
	
func _input(event):

	if event.is_action_pressed("ui_cancel") and not game_over:
		visible = not visible
		get_tree().paused = visible

func _on_continue_pressed():
	visible = false
	get_tree().paused = false
	
func set_icon(path : String):
	return "[img=32x32]%s[/img]" % path
	
func get_available_resource_in(items)-> Array[Item]:
	if items == null:
		return []
	var resources : Array[Item] = []
	for item in items.get_children():
		if item.item != null:
			resources.append(item.item)
	return resources

func set_text():
	text.clear()
	for weapon: Weapon in get_available_resource_in(weapons):
		if weapon not in temp:
			temp.append(weapon)
		text.append_text(set_icon(weapon.icon.resource_path) + "%20.2f" % weapon.damage_dealt + "\n")

	for weapon: Weapon in temp:
		if weapon not in get_available_resource_in(weapons):
			text.append_text(set_icon(weapon.icon.resource_path) + "%20.2f" % weapon.damage_dealt + "\n")
