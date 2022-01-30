extends Spatial

signal playerChanged(newPlayer)

var currentPlayer = -1
var yingYang = .5

var posCell = 0
var negCell = 0
var hasPosCell = false
var hasNegCell = false

var notGameOver = true

var cells = []
var initialStock = 10
var availlableStock = initialStock
var animationSpeed = 1
var nbCells = Universe.rowSize
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
	playAnimation()
	switchAmbiance()
	currentPlayer = -currentPlayer
	availlableStock = initialStock
	posCell = 0
	negCell = 0
	if(currentPlayer < 0):
		updateYingYing()
	
func emit_playerChanged():
	emit_signal("playerChanged", currentPlayer)
	
func updateNbCells():
	posCell = 0
	negCell = 0
	hasPosCell = false
	hasNegCell = false
	for c in cells:
		if(c.level > 0):
			posCell += 1
			hasPosCell = true
		elif(c.level < 0):
			negCell += 1
			hasNegCell = true

func updatePlayerHud():
	updateNbCells()
	var totalCell = negCell + posCell
	$hudPlayer1/LabelNbCell.text = str(negCell)
	$hudPlayer1/LabelTotalCels.text = str(totalCell)
	$hudPlayer2/LabelNbCell.text = str(posCell)
	$hudPlayer2/LabelTotalCels.text = str(totalCell)
	
func updateYingYing():
	updateNbCells()
	var totalCell = posCell + negCell
	if(negCell != 0):
		yingYang = float(negCell) / totalCell
	elif(posCell != 0):
		yingYang = 1 - float(posCell) / totalCell
	updatePlayerHud()
	print_debug("posCell=%s, negCell=%s, totalCell=%s, yingyang=%s" % [posCell, negCell, totalCell, yingYang])
	var cellsNbToWin = cells.size() / 2
	if(currentPlayer < 0):
		if(posCell > cellsNbToWin):
			onGameOver("Player 2")
		elif(negCell > cellsNbToWin):
			onGameOver("Player 1")

func switchAmbiance():
	$Environment.switch_side()
	pass
	
func playAnimation():
	$AnimationPlayer.set_speed_scale(animationSpeed)
	if(currentPlayer==-1):
		$AnimationPlayer.play("boardFlip")
	else:
		$AnimationPlayer.play_backwards("boardFlip")

func OnCellFilled():
	availlableStock -= 1
	updateNbCells()
	if(currentPlayer < 0):
		hasNegCell = true
	else:
		hasPosCell = true
	# print_debug("Current Stock: %s" % availlableStock)
	if availlableStock==0:
		swithSide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var stockIndicator = $hud_Stock/ProgressBar
	stockIndicator.value = availlableStock
	var gameIndicator = $hudTop/Progress
	gameIndicator.value = yingYang
	if(currentPlayer > 0):
		if(notGameOver):		
			$hudPlayer1.visible = false
			$hudPlayer2.visible = true
		$ambianceWater.stop()
		if(!$ambianceFeux.playing):
			if(hasPosCell):
				$ambianceFeux.play()
			else:
				$ambianceFeux.stop()
	else:
		if(notGameOver):
			$hudPlayer1.visible = true
			$hudPlayer2.visible = false
		$ambianceFeux.stop()
		if(!$ambianceWater.playing):
			if(hasNegCell):
				$ambianceWater.play()
			else:
				$ambianceWater.stop()

func _on_ButtonQuit_pressed():
	get_tree().change_scene("res://welcome/welcome.tscn")


func onGameOver(win) -> void:
	$hudPlayer1.visible = true
	$hudPlayer2.visible = true
	notGameOver = false
	Events.emit_hud_gameover(win)
