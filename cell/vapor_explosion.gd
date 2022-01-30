extends Spatial


# Declare member variables here. Examples:
# var a = 2



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#		makeVaporExplosion()
##	if Input.is_action_pressed("ui_right"):
		
func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_S and not ev.echo:
		makeVaporExplosion()
	if ev is InputEventKey and ev.scancode == KEY_M and not ev.echo:
		makeVaporExplosion(50)
	if ev is InputEventKey and ev.scancode == KEY_L and not ev.echo:
		makeVaporExplosion(250)
		
func makeVaporExplosion(sizeOfExplosion = 10):
	$Particles.emitting = true
	$Particles.amount = sizeOfExplosion
	$Particles.lifetime = .6
	
