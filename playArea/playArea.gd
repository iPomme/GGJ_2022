extends Spatial

signal playerChanged(newPlayer)

var currentPlayer = -1
var yingYang = .5

var cells = []
var initialStock = 10
var availlableStock = initialStock
var animationSpeed = 1
var nbCells = 8
var cellCoef = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	var cellResource = preload("res://cell/cell.tscn")
	var movingNode = $moving
	var scaling = 1/float(nbCells)*cellCoef
	for x in range(-nbCells/2, nbCells/2):
		for y in range(-nbCells/2, nbCells/2):
			var cellTmp = cellResource.instance()
			cellTmp.init(self)
			cellTmp.scale.x = scaling
			cellTmp.scale.z = scaling
			cellTmp.transform.origin = Vector3((x+0.5)*scaling, 0, (y+0.5)*scaling)
			movingNode.add_child(cellTmp)
			cellTmp.connect("fillOne", self, "OnCellFilled")
			cells.push_back(cellTmp)

func _input(ev):
	if Input.is_key_pressed(KEY_F):
		swithSide()
		print_debug("current player is " + currentPlayer as String)	


func swithSide():
	emit_signal("playerChanged", -currentPlayer)
	playAnimation()
	switchAmbiance()
	currentPlayer = -currentPlayer
	availlableStock = initialStock
	updateYingYing()
	
	
func updateYingYing():
	var posCell = 0
	var negCell = 0
	for c in cells:
		if(c.level > 0):
			posCell += 1
		elif(c.level < 0):
			negCell += 1
	var totalCell = posCell + negCell
	if(negCell != 0):
		yingYang = float(negCell) / totalCell
	elif(posCell != 0):
		yingYang = 1 - float(posCell) / totalCell
	print_debug("posCell=%s, negCell=%s, totalCell=%s, yingyang=%s" % [posCell, negCell, totalCell, yingYang])
	var cellsNbToWin = cells.size() / 2
	if(posCell > cellsNbToWin):
		print_debug("Player 2 WINNER!!!!!!!!!")
	elif(negCell > cellsNbToWin):
		print_debug("Player 1 WINNER!!!!!!!!!")
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
		swithSide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var stockIndicator = $hud_Stock/ProgressBar
	stockIndicator.value = availlableStock
	var gameIndicator = $hudTop/Progress
	gameIndicator.value = yingYang
