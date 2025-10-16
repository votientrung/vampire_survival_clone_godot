extends CharacterBody2D

var xp : int = 0:
	set(value):
		xp = value
		%XP.value = value
var total_xp : int =0 
var level : int =1 :
	set(value):
		level = value
		%level.text = "LV " + str(value)
		%Options.show_option()
		
		if (level % 5) == 0:
			%XP.max_value += 20

var move_speed : float = 150
var health : float =100:
	set(value):
		health = max(value,0)
		%HeatlhBar.value = value
var max_health : float = 100:
	set(value):
		max_health = value
		%HeatlhBar.max_value = value

var recovery : float = 0
var armor : float =0
var might : float =1.5
var area : float = 100
var magnet : float = 0 :
	set(value):
		magnet = value
		%magnet.shape.radius = 60 + value
var growth : float =1


var nearest_enemy: CharacterBody2D
var nearest_enemy_distance: float = 150 + area
var mouse



func _physics_process(delta) :
	mouse = (get_global_mouse_position() - position).normalized()
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
	else :
		nearest_enemy_distance = INF
		nearest_enemy = null
	
	
	velocity = Input.get_vector("left","right","up","down") * move_speed
	move_and_collide(velocity * delta)
	
	health += recovery * delta

func  take_damage(amount): 
	health -= max(amount - armor, 0)

func _on_selfdamage_body_entered(body: Node2D):
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%hitbox.set_deferred("disable", true)
	%hitbox.set_deferred("disable", false)

func gain_xp(amount):
	xp += amount * growth
	total_xp += amount *growth
	if xp >= %XP.max_value :
		xp-=%XP.max_value
		level+=1


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)
