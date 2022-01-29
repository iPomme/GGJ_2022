extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentPlayer = -1
var animationSpeed = 10
var nbCells = 16
var cellCoef = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var cellResource = preload("res://cell/cell.tscn")
	var movingNode = $moving
	var scaling = 1/float(nbCells)*cellCoef
	for x in range(-nbCells/2, nbCells/2):
		for y in range(-nbCells/2, nbCells/2):
			var cellTmp = cellResource.instance()
			
			print_debug("sclaing: %s" % scaling)
			cellTmp.scale.x = scaling
			cellTmp.scale.z = scaling
			cellTmp.transform.origin = Vector3((x+.5)*scaling,0,(y+.5)*scaling)
			movingNode.add_child(cellTmp)

func _input(ev):
	if Input.is_key_pressed(KEY_F):
		$AnimationPlayer.set_speed_scale(animationSpeed)
		if(currentPlayer==-1):
			 $AnimationPlayer.play("boardFlip")
		else:
			 $AnimationPlayer.play_backwards("boardFlip")
		currentPlayer = -currentPlayer
		print_debug("current player is " + currentPlayer as String)	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
