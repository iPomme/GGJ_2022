extends Node2D

func _enter_tree():
  Events.connect("hud_gameover", self, "gameOver")

func gameOver(winner):
	print_debug("The winner is %s" % winner)
	$GameOver/Label.text = "%s Win !!" % winner
	$GameOver.visible = true

func _ready():
	$GameOver.visible = false
