extends GPUParticles2D
@export var width =  100
@export var height = 100
@export var gravity = Vector2(0,50)
@onready var polygon_2d: Polygon2D = $".."
var charge = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_field()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_field() -> void:
	visibility_rect = Rect2(width,height,2*width,2*height)
	var particle_material : ParticleProcessMaterial = process_material
	particle_material.emission_box_extents = Vector3(width, height, 0)
	particle_material.gravity = Vector3(gravity.x, gravity.y, 0) * charge
