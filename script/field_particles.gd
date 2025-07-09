#@tool
extends ColorRect

@export var gravity := Vector2(0, 100)
@export var charge := 1
@export var density := 0.005
var player_charge:= 1

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	update_field()
	var root = get_tree().get_current_scene()
	var player = root.find_child("Player", true, false)
	if player:
		player.charge_changed.connect(_on_player_charge_changed)

func update_field() -> void:
	
	var half_size = size / 2.0  # Tamaño del ColorRect dividido en 2

	# Centrar las partículas en el ColorRect
	gpu_particles_2d.position = half_size

	# Ajustar la visibilidad de las partículas
	var visibility_size := Vector2(500, 500)
	gpu_particles_2d.visibility_rect = Rect2(-visibility_size / 2.0, visibility_size)
	
	# Ajustar densidad de particulas
	var area := size.x * size.y
	gpu_particles_2d.amount = int(area * density)
		
	# Configurar emisión en caja (box)
	gpu_particles_2d.process_material = gpu_particles_2d.process_material.duplicate()
	var particle_material := gpu_particles_2d.process_material
	if particle_material:
		particle_material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
		particle_material.emission_box_extents = Vector3(half_size.x, half_size.y, 0)
		particle_material.gravity = Vector3(gravity.x, gravity.y, 0) * charge * player_charge
		gpu_particles_2d.set_process_material(particle_material)
		gpu_particles_2d.restart()
		
func _on_player_charge_changed(new_charge: int, player: Player) -> void:
	player_charge = new_charge
	update_field()
