class_name Player
extends CharacterBody2D
@onready var raycast_force: RayCast2D = $RayCastForce
@onready var raycast_down: RayCast2D = $RayCastDown
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var charge_label: Label = $"CanvasLayer/Charge Label"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = 400.0
@export var health = 100
@export var charge: int = 1
const default_electric_force = Vector2(0, 1000)
var electric_force = default_electric_force
var is_dead: bool = false
var enable_rotation: bool = false
var invert_move: int = 1
var move_direction: Vector2 = global_transform.x
var jump_direction: Vector2 = -global_transform.y
var new_velocity: Vector2 = Vector2(0, 0)

signal charge_changed(new_charge: int, player: Player)

func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	#raycast_force.enabled = false

func _physics_process(delta: float) -> void:
	
	# Gravity.
	if !is_on_floor():
		new_velocity += (electric_force) * delta
	else:
		new_velocity = Vector2(0, 0)
	
	#if raycast_force.is_colliding():
		#enable_rotation = true
		#raycast_force.enabled = false
	
	# Rotate Player to the opposit of the force 
	if enable_rotation:
		var force: Vector2 = electric_force.normalized().rotated(-PI/2)
		var angle: float = force.angle()
		global_rotation = rotate_toward(global_rotation, angle, 0.4)
		move_direction = global_transform.x
		jump_direction = -global_transform.y
		up_direction = jump_direction
		if global_rotation == angle:
			enable_rotation = false
			if angle > 3*PI/4 and angle < 5*PI/4:
				invert_move = -1
			else:
				invert_move = 1
	
	# Jump.
	if Input.is_action_just_pressed("jump") and raycast_down.is_colliding():
		new_velocity = JUMP_VELOCITY * jump_direction
	
	# Direction.
	var direction := Input.get_axis("move_left", "move_right") * invert_move
	
	# Right/Left Movement
	if !enable_rotation:
		velocity = new_velocity.move_toward(new_velocity + move_direction * direction * SPEED, SPEED)
	else:
		velocity = new_velocity
	
	# Sprite Direction.
	if direction < 0:
		animated_sprite.scale.x = -1
	elif direction > 0:
		animated_sprite.scale.x = 1
	
	# Animations.
	var anim_suffix: String = "-inverse" if charge == -1 else ""
	var anim_to_play: String = ""
	
	if raycast_down.is_colliding():
		if direction:
			anim_to_play = "run" + anim_suffix
		else:
			anim_to_play = "idle" + anim_suffix
	else:
		anim_to_play = "jump" + anim_suffix
	
	# Solo cambia si es diferente para evitar reiniciar innecesariamente la animación
	if animated_sprite.animation != anim_to_play:
		animated_sprite.play(anim_to_play)
	
	# Invert charge
	if Input.is_action_just_pressed("invert"):
		charge *= -1
		emit_signal("charge_changed", charge, self)
		if charge == -1:
			charge_label.text = "Charge (-)"
		else:
			charge_label.text = "Charge (+)"
		var current_anim = animated_sprite.animation
		if charge == -1 and not current_anim.ends_with("-inverse"):
			animated_sprite.animation = current_anim + "-inverse"
		elif charge == 1 and current_anim.ends_with("-inverse"):
			animated_sprite.animation = current_anim.replace("-inverse", "")
	
	# Death
	if health <= 0 and not is_dead:
		is_dead = true
		#SoundManager.play_player_death_sound()
		set_physics_process(false)  # Detener el movimiento
		collision_shape_2d.disabled = true  # Evita colisiones
		animated_sprite.play("death")
	
	move_and_slide()

func bounce() -> void:
	new_velocity = JUMP_VELOCITY * jump_direction / 1.5

# Death
func take_damage():
	health = 0

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "death":
		get_tree().reload_current_scene()

# Set Electromagnetic Force
func setForce(force:Vector2 , other_charge: int) -> void:
	electric_force = force * charge * other_charge
	#prepare_rotation(electric_force)
	enable_rotation = true

func resetForce() -> void:
	electric_force = default_electric_force
	#prepare_rotation(default_electric_force)
	enable_rotation = true

#func prepare_rotation(force: Vector2) -> void:
	#raycast_force.global_rotation = electric_force.normalized().angle()
	#print(electric_force.normalized().angle())
	#raycast_force.enabled = true
