extends Node2D

@export var Player : CharacterBody2D
@export var Enemies : PackedScene

var distance : float = 600
var can_spawn : bool =true

@export var enemy_types : Array[Enemy]

var Minute :int :
	set(value):
		Minute = value
		%Minute.text = str(value)

var Second :int :
	set(value):
		Second = value
		if Second >= 10:
			Second -= 10
			Minute += 1
		%Second.text = str(Second).lpad(2,'0')

func _physics_process(_delta):
	if get_tree().get_node_count_in_group("Enemy") < 400:
		can_spawn = true
	else :
		can_spawn = false

func spawn(pos : Vector2, elite : bool =false):
	if  can_spawn or  elite:
		var enemy_instance = Enemies.instantiate()
		
		enemy_instance.type = enemy_types[min(Minute, enemy_types.size()-1)]
		enemy_instance.position = pos
		enemy_instance.player_reference = Player
		enemy_instance.elite = elite
		enemy_instance.damage = enemy_instance.damage * (1+Player.level/5)
		
		get_tree().current_scene.add_child(enemy_instance)
	else:
		return

func get_random_position() -> Vector2:
	return Player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2*PI))

func amount(number : int =1 ) : 
	for i in range(number) :
		spawn(get_random_position())

func _on_timer_timeout() -> void:
	Second +=1
	amount(Second % 20)


func _on_pattern_timeout():
	for i in range(50):
		spawn(get_random_position())


func _on_elite_timeout() -> void:
	spawn(get_random_position(),true
	)
