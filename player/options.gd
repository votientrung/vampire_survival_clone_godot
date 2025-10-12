extends VBoxContainer


@export var weapon : HBoxContainer
var OptionSlot = preload("res://scene/option_slot.tscn")

func _ready():
	hide()

func close_option():
	hide()
	get_tree().paused=false

func get_available_weapon():
	var weapon_resouce = []
	for weapon in weapon.get_children():
		if weapon.weapon != null:
			weapon_resouce.append(weapon.weapon)
	return weapon_resouce

func show_option():
	var weapon_available = get_available_weapon()
	if weapon_available.size() == 0:
		return
	
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	for weapon in weapon_available:
		if weapon.is_upgradable():
			var option_slot = OptionSlot.instantiate()
			option_slot.weapon = weapon
			add_child(option_slot)
			option_size +=1
	
	if option_size == 0:
		return
	
	show()
	get_tree().paused = true
