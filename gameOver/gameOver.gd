extends Node2D

func _enter_tree():
  Events.connect("hud_gameover", self, "gameOver")

func gameOver(winner):
	print_debug("The winner is %s" % winner)
	$GameOver/Label.text = "%s Win !!" % winner
	$GameOver.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_tree().change_scene("res://welcome/welcome.tscn")
