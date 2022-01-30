extends Spatial


# Declare member variables here. Examples:
export var a = -2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#$Animationtree["parameters/blend_position"] = 1

func _input(ev):
	if Input.is_key_pressed(KEY_K):
		switch_side()

func switch_side():
	var playback = $AnimationStateMachine.get("parameters/playback")
	if (a == 0):
		playback.travel("Water_chill")
		a = 1
	else:
		playback.travel("Fire_burning")
		a = 0

