extends ColorRect
@onready var particles: GPUParticles2D = $GPUParticles2D
@export var width =  100
@export var height = 100
@export var gravity = Vector2(0,50)

@export var colorParticles: Color= Color(1,1,1,1)
@export var charge = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particles.gravity =gravity
	particles.width=width
	particles.gravity=gravity
	particles.charge=charge
	particles.update_field()
	var material: ParticleProcessMaterial= particles.process_material
	material.color=colorParticles
	self.set_size(Vector2(width,height))
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
