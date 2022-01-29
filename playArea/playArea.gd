extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentPlayer = -1
var animationSpeed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(ev):
	if Input.is_key_pressed(KEY_F):
		$board/AnimationPlayer.set_speed_scale(animationSpeed)
		if(currentPlayer==-1):
			 $board/AnimationPlayer.play("Board_flip")
		else:
			 $board/AnimationPlayer.play_backwards("Board_flip")
		currentPlayer = -currentPlayer
		print_debug("current player is " + currentPlayer as String)	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
