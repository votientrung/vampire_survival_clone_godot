extends Area2D

var direction : Vector2 = Vector2.RIGHT
var damage : float = 1.0
var duration : float = 0.2
var knockback : float = 90
var source
var weapon : Weapon

func _ready():
	var timer = get_tree().create_timer(duration)
	timer.timeout.connect(queue_free)

func _on_body_entered(body):
	if body.has_method("take_damage") and (body != source):
		if "might" in source:
			body.take_damage(damage * source.might)
			if weapon : 
				weapon.damage_dealt += damage * source.might
		else:
			body.take_damage(damage)
			if weapon :
				weapon.damage_dealt += damage
				
		body.knockback += direction * knockback
