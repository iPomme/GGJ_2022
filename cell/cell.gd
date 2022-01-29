extends Spatial

signal fillOne

var level = 0
var oldLevel = 0
var currentside = -1
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(instance):
	instance.connect("playerChanged", self, "OnPlayerChanged")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite3D/Viewport/Label.text = str(level)
	$Toto/Viewport/Label.text = str(level)
	#pass
func _on_StaticBody_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		print_debug("cell: " + str(self.name))
		level += currentside
		emit_signal("fillOne")
	

func OnPlayerChanged(newSide):
	currentside = newSide
	if(oldLevel != level):
		var delta = oldLevel + level
		oldLevel = level
		print_debug("PlayerChanged: current side %s and delta is %s" % [currentside, delta])
