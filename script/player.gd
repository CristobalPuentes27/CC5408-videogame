class_name Player
extends CharacterBody2D

@onready var raycast_up: RayCast2D = $RayCast2D
@onready var raycast_down: RayCast2D = $RayCast2D2
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var charge_label: Label = $"CanvasLayer/Charge Label"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_dir = 1
@export var charge: int = 1
var electric_force = Vector2(0, 1000)
@export var health = 100
var is_dead = false

signal charge_changed(new_charge: int, player: Player)

func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)


func _physics_process(delta: float) -> void:
	# Gravity.
	velocity += (electric_force) * delta

	# Jump.
	if Input.is_action_just_pressed("jump") and raycast_down.is_colliding():
		velocity.y = JUMP_VELOCITY * jump_dir

	# Direction.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Sprite Direction.
	if direction < 0:
		animated_sprite.scale.x = -1
	elif direction > 0:
		animated_sprite.scale.x = 1

	# Animations.
	var anim_suffix = "-inverse" if charge == -1 else ""
	var anim_to_play = ""

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

	# Right/Left Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if raycast_up.is_colliding():
		self.scale.y *= -1
		jump_dir *= -1
		
	# Invert charge
	if Input.is_action_just_pressed("invert"):
		charge*=-1
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
		collision_shape_2d.disabled = true  # Para evitar más colisiones
		animated_sprite.play("death")

	move_and_slide()

# Death
func take_damage():
	health = 0
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "death":
		get_tree().reload_current_scene()

# Set Electromagnetic Force
func setForce(vector:Vector2 , other_charge: int) -> void:
	print("Entro")
	electric_force = vector  * charge * other_charge

func resetForce() -> void:
	print("Salio")
	electric_force =  Vector2(0, 1000)
