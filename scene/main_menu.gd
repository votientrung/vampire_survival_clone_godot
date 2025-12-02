extends Control

func _ready():
	menu()

func _on_upgrades_pressed():
	skill_tree()


func _on_beastiary_pressed():
	beastiary()

func menu():
	$Menu.show()
	$SkillTree.hide()
	$Beastiary.hide()
	$Gold.hide()
	$Back.hide()
	tween_pop($Menu)
	
func skill_tree():
	$SkillTree.show()
	$Gold.show()
	$Menu.hide()
	$Back.show()
	tween_pop($SkillTree)

func beastiary():
	$Beastiary.show()
	$Gold.hide()
	$Menu.hide()
	$Back.show()
	tween_pop($Beastiary)


func _on_back_pressed():
	menu()
	
func tween_pop(panel):
	panel.scale = Vector2(0.85,0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel, "scale", Vector2(1,1), 0.5)
