extends Spatial

signal fillOne
# Declare member variables here. Examples:
var level = 0
var currentside = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = self.get_parent().get_parent()
	parent.connect("playerChanged", self, "OnPlayerChanged")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite3D/Viewport/Label.text = str(level)
	$Toto/Viewport/Label.text = str(level)
	#pass
func _on_StaticBody_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		# print_debug("cell: " + str(self.name))
		level += currentside
		emit_signal("fillOne")
	

func OnPlayerChanged(newSide):
	currentside = newSide
	# print_debug("PlayerChanged: current side %s", currentside)
