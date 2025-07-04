class_name Player
extends CharacterBody2D
@onready var raycast_force: RayCast2D = $RayCastForce
@onready var raycast_down: RayCast2D = $RayCastDown
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var charge_label: Label = $"CanvasLayer/Charge Label"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = 400.0
const MAX_VELOCITY: float = 550.0
@export var health = 100
@export var charge: int = 1
@export var GlobalDash:bool=true     # Enable this to be able to Dash!!
const default_electric_force = Vector2(0, 1000)
var electric_force = default_electric_force
var is_dead: bool = false
var enable_rotation: bool = false
var invert_move: int = 1
var move_direction: Vector2 = global_transform.x
var jump_direction: Vector2 = -global_transform.y
var new_velocity: Vector2 = Vector2(0, 0)
var coyote_time: float = 0
const dash_velocity: float = 800
const MAX_DASH_TIME: float = 0.2
var dash_time: float = MAX_DASH_TIME
var is_dashing: bool = false
var can_dash: bool = false
var dash_direction: int
var bouncing: bool = false

signal charge_changed(new_charge: int, player: Player)

func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	#Engine.time_scale = 0.3

func _physics_process(delta: float) -> void:
	# Gravity.
	if !is_on_floor():
		coyote_time = max(coyote_time-delta, 0)
		new_velocity += (electric_force) * delta
		new_velocity = new_velocity.limit_length(MAX_VELOCITY)  # Limitar velocidad máxima
	else:
		can_dash = true
		coyote_time = .12
		new_velocity = Vector2(0, 0)
	
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
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_time):
		SoundManager.play_jump_sound()
		new_velocity = JUMP_VELOCITY * jump_direction
		coyote_time = 0
	
	if bouncing:
		new_velocity = JUMP_VELOCITY * jump_direction / 2
		bouncing = false
	
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
	
	if is_dashing:
		anim_to_play = "dash" + anim_suffix

	elif is_on_floor():
		if direction:
			anim_to_play = "run" + anim_suffix
		else:
			anim_to_play = "idle" + anim_suffix
	else:
		anim_to_play = "jump" + anim_suffix
	
	# Solo cambia si es diferente para evitar reiniciar innecesariamente la animación
	if animated_sprite.animation != anim_to_play:
		animated_sprite.play(anim_to_play)
	
	# Dash
	if (GlobalDash and (Input.is_action_just_pressed("dash") and can_dash and direction) or is_dashing):
		if !is_dashing:
			dash_direction = direction
			is_dashing = true
			can_dash = false
		velocity = move_direction * dash_direction * dash_velocity
		dash_time -= delta
		if dash_time < 0:
			dash_time = MAX_DASH_TIME
			is_dashing = false
	
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
		SoundManager.play_player_death_sound()
		set_physics_process(false)  # Detener el movimiento
		collision_shape_2d.disabled = true  # Evita colisiones
		animated_sprite.play("death")
	
	move_and_slide()

func bounce() -> void:
	bouncing = true

# Death
func take_damage():
	health = 0

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "death":
		get_tree().reload_current_scene()

# Set Electromagnetic Force
func setForce(force:Vector2 , other_charge: int) -> void:
	electric_force = force * charge * other_charge
	enable_rotation = true

func resetForce() -> void:
	electric_force = default_electric_force
	enable_rotation = true
