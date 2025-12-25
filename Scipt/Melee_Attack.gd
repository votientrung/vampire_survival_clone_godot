extends Weapon
class_name Melee_attack

@export var scale :float

func slash(source, target, scene_tree):
	var projectile = slash_node.instantiate()
	
	projectile.damage = damage
	projectile.source = source
	projectile.direction = source.mouse
	projectile.weapon = self
	projectile.scale = Vector2(scale, scale)
	projectile.position = source.position + projectile.direction * 30
	projectile.rotation = projectile.direction.angle()
	
	scene_tree.current_scene.add_child(projectile)

func activate(source, target, scene_tree):
	slash(source, target, scene_tree)

func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
	
	var upgrade = upgrades[level -1]
	damage += upgrade.damage
	cooldown -= upgrade.cooldown
	scale += upgrade.scale
	
	level +=1
