extends Node


signal hud_gameover(winner)
func emit_hud_gameover(winner: String) -> void:
  emit_signal("hud_gameover", winner)
