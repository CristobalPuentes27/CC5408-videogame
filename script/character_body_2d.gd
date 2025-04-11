class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var charge: int = 1
var electric_force = Vector2(0, 0)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() + electric_force) * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("invert"):
		charge*=-1
		
	move_and_slide()

func setForce(x: int, y: int, other_charge: int) -> void:
	print("Entro")
	electric_force = -Vector2(x, y) * charge * other_charge
	pass

func resetForce() -> void:
	print("Salio")
	electric_force = Vector2(0, 0)
