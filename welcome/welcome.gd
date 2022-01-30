extends Control


func _ready():
  Universe.playBackroundMusic()
  get_tree().paused = false

func _on_Next_Scene():
  Universe.stopBackroundMusic()
  get_tree().change_scene("res://Root.tscn")

func _show_credits():
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_quit_game():
		get_tree().quit()

func _on_ButtonCredits_pressed():
	get_tree().change_scene("res://credits/credits.tscn")
