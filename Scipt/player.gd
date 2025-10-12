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

var speed : float = 150
var health : float =100:
	set(value):
		health = value
		%HeatlhBar.value = value

var nearest_enemy: CharacterBody2D
var nearest_enemy_distance: float = INF



func _physics_process(delta) :
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
	else :
		nearest_enemy_distance = INF
	
	
	velocity = Input.get_vector("left","right","up","down") * speed
	move_and_collide(velocity * delta)

func  take_damage(amount): 
	health -= amount

func _on_selfdamage_body_entered(body: Node2D):
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%hitbox.set_deferred("disable", true)
	%hitbox.set_deferred("disable", false)

func gain_xp(amount):
	xp += amount
	total_xp += amount
	if xp >= %XP.max_value :
		xp-=%XP.max_value
		level+=1


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)
