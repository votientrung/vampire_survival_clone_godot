extends CharacterBody2D

@export var player_reference : CharacterBody2D
var damage_popup_node = preload("res://scene/damage.tscn")
var direction : Vector2 
var knockback : Vector2
var separation: float
var damage: float 
var health: float
var speed : float

var drop = preload("res://scene/pickup.tscn")

func _ready():
	add_to_group("Enemy")

var elite : bool = false:
	set (value):
		elite = value
		if value:
			$Sprite2D.material = load("res://Shader/rainbow.tres")
			scale = Vector2(1.5,1.5)
			health = health*1.5
			damage = damage*2

var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
		speed  = value.speed
		health = value.health

func _physics_process(delta: float):
	check_separation(delta)
	knockback_update(delta)	

func check_separation(_detal):
	separation = (player_reference.position - position).length()
	if separation >=1500 and not elite:
		queue_free()
	
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self

func knockback_update(delta):
	velocity = (player_reference.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity +=  knockback
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50

func damage_popup(amount, modifier = 1.0):
	var popup = damage_popup_node.instantiate()
	popup.text = str(amount * modifier)
	popup.position = position + Vector2(-50,-25)
	if modifier > 1.0:
		popup.set("theme_override_color/font_color", Color.RED)
	get_tree().current_scene.add_child(popup)

func take_damage(amount):
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(3, 0.25, 0.25), 0.2)
	tween.chain().tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.2)
	tween.bind_node(self)
	
	var chance = randf()
	var modifier : float = 2.0 if (chance < (1.0 -(1.0/player_reference.luck))) else 1.0
	
	damage_popup(amount, modifier)
	health-= amount * modifier
	if health <= 0:
		drop_item()
		queue_free()

func drop_item():
	if type.drop.size() == 0: 
		return
	
	var item = type.drop.pick_random()
	
	if elite:
		item = load("res://resouce/pickup/chest.tres")
	
	var item_to_drop = drop.instantiate()
	
	item_to_drop.type = item
	item_to_drop.position = position
	item_to_drop.player_reference = player_reference
	
	get_tree().current_scene.call_deferred("add_child", item_to_drop)
	queue_free()
