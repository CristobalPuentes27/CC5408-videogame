class_name Player
extends CharacterBody2D

@onready var raycast_up: RayCast2D = $RayCast2D
@onready var raycast_down: RayCast2D = $RayCast2D2
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var charge_label: Label = $"CanvasLayer/Charge Label"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_dir = 1
var charge: int = 1
var electric_force = Vector2(0, 1000)

signal charge_changed(new_charge: int, player: Player)

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
	if raycast_down.is_colliding():
		if direction:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("jump")

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

	move_and_slide()

func setForce(vector:Vector2 , other_charge: int) -> void:
	print("Entro")
	electric_force = vector  * charge * other_charge

func resetForce() -> void:
	print("Salio")
	electric_force =  Vector2(0, 1000)
