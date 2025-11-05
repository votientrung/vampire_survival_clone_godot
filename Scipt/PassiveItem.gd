extends Item
class_name PassiveItem

@export var upgrades : Array[Stats]
var player_reference

func is_upgradable() -> bool:
	if level <= upgrades.size():
		return true
	return false

func upgrade_item():
	if  not is_upgradable():
		print("can not upgrade")
		return
	
	if player_reference == null:
		print("player not found")
		return
	
	var upgrade = upgrades[level-1]
	player_reference.max_health += upgrade.max_health
	player_reference.recovery += upgrade.recovery
	player_reference.armor += upgrade.armor
	player_reference.move_speed += upgrade.move_speed
	player_reference.might += upgrade.might
	player_reference.magnet += upgrade.magnet
	player_reference.growth += upgrade.growth
	player_reference.luck += upgrade.luck
	
	level +=1
