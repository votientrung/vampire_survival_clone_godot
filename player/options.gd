extends VBoxContainer


@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer
var OptionSlot = preload("res://scene/option_slot.tscn")

func _ready():
	hide()

func close_option():
	hide()
	get_tree().paused=false


func get_available_resouces_in(items)-> Array[Item]:
	var resources : Array[Item] = []
	for item in items.get_children():
		if item.item != null:
			resources.append(item.item)
	return resources

func  add_option(item)->int:
	if item.is_upgradable():
		var option_slot = OptionSlot.instantiate()
		option_slot.item = item
		add_child(option_slot)
		return 1
	return 0


func show_option():
	var weapon_available = get_available_resouces_in(weapons)
	var passive_item_available = get_available_resouces_in(passive_items)
	if weapon_available.size() == 0 and passive_item_available.size() ==0:
		return
	
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	for weapon in weapon_available:
		option_size += add_option(weapon)
		
		if weapon.max_level_reached() and weapon.item_needed in passive_item_available:
			var option_slot = OptionSlot.instantiate()
			option_slot.item = weapon
			add_child(option_slot)
			option_size +=1
	
	for passive_item in passive_item_available:
		option_size += add_option(passive_item)
	
	if option_size == 0:
		return
	
	show()
	get_tree().paused = true
