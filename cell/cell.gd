extends Spatial


# Declare member variables here. Examples:
var level = 0
var currentside = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite3D/Viewport/Label.text = str(level)

func _on_StaticBody_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		print_debug("cell: " + str(self.name))
		level += currentside
	
