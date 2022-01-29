extends Spatial


# Declare member variables here. Examples:
export var a = -1
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
		var playback = $AnimationTree2.get("parameters/playback")
		playback.travel("Water_chill")
		print("KKKK")
	if Input.is_key_pressed(KEY_L):
		var playback = $AnimationTree2.get("parameters/playback")
		playback.travel("Fire_burning")
		$AnimationTree2.set("")
		print("LLLL")

func switch_side():
	print("switched sides in ENVIRONEMNT")
	a -= a
	$AnimationTree["parameters/blend_position"] = -$AnimationTree["parameters/blend_position"]
