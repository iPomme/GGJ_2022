extends Spatial

signal fillOne

export var level = 0
var oldLevel = 0
var currentside = -1
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	updateParticule(false)
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
		addParticule()
		emit_signal("fillOne")
	
func updateParticule(withExplosion):
	if(currentside < 0):
		$ParticlesFire.emitting = false
		if(level<0):
			$ParticlesWater.emitting = true
			$ParticlesWater.amount = abs(level) * 20
		else:
			$ParticlesWater.emitting = false
			if(oldLevel > 0):
				if(withExplosion):
					$Vapor_ExplosionWater.makeVaporExplosion(100)
					$Zisch.play()
	elif(currentside > 0):
		if(level>0):
			$ParticlesFire.emitting = true
			$ParticlesFire.amount = level * 20
		else:
			$ParticlesFire.emitting = false
			if(oldLevel < 0):
				if(withExplosion):
					$Vapor_ExplosionFire.makeVaporExplosion(100)
					$CuissonShort.play()
		$ParticlesWater.emitting = false

func addParticule():
	if(currentside < 0):
		$ParticlesFire.emitting = false
		$ParticlesWater.emitting = true
	elif(currentside > 0):
		$ParticlesFire.emitting = true
		$ParticlesWater.emitting = false

func OnPlayerChanged(newSide):
	currentside = newSide
	if(oldLevel != level):
		var delta = oldLevel + level
		oldLevel = level
		print_debug("PlayerChanged: current side %s and delta is %s" % [currentside, delta])
	updateParticule(true)
