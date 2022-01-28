extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(ev):
	if Input.is_key_pressed(KEY_K):
		$AnimationPlayer.play("Board_flip")
		print_debug("KKKKKK")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
