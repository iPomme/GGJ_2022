extends Control


onready var playArea = preload("res://playArea/playArea.tscn")

func _ready():
  Universe.playBackroundMusic()
  get_tree().paused = false

func _on_Next_Scene():
  Universe.stopBackroundMusic()
  get_tree().change_scene_to(playArea)

func _on_quit_game():
		get_tree().quit()

func _on_ButtonCredits_pressed():
	get_tree().change_scene("res://credits/credits.tscn")
