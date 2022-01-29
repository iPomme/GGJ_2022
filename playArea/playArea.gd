extends Spatial

signal playerChanged(newPlayer)

var currentPlayer = -1
var initialStock = 10
var availlableStock = initialStock
var animationSpeed = 10
var nbCells = 8
var cellCoef = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	#self.connect("fillOne", self, "OnCellFilled")
	var cellResource = preload("res://cell/cell.tscn")
	var movingNode = $moving
	var scaling = 1/float(nbCells)*cellCoef
	for x in range(-nbCells/2, nbCells/2):
		for y in range(-nbCells/2, nbCells/2):
			var cellTmp = cellResource.instance()
			cellTmp.scale.x = scaling
			cellTmp.scale.z = scaling
			cellTmp.transform.origin = Vector3(x*scaling + .2,0,y*scaling+ .2)
			movingNode.add_child(cellTmp)
			cellTmp.connect("fillOne", self, "OnCellFilled")

func _input(ev):
	if Input.is_key_pressed(KEY_F):
		swithSide()
		print_debug("current player is " + currentPlayer as String)	


func swithSide():
	emit_signal("playerChanged", -currentPlayer)
	playAnimation()
	switchAmbiance()
	currentPlayer = -currentPlayer
	
	
func switchAmbiance():
	pass
	
func playAnimation():
	$AnimationPlayer.set_speed_scale(animationSpeed)
	if(currentPlayer==-1):
		$AnimationPlayer.play("boardFlip")
	else:
		$AnimationPlayer.play_backwards("boardFlip")

func OnCellFilled():
	availlableStock -= 1
	print_debug("Current Stock: %s" % availlableStock)
	if availlableStock==0:
		availlableStock = initialStock
		swithSide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
