class_name Player
extends CharacterBody2D

@onready var up: RayCast2D = $RayCast2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_charge=1
var charge: int = 1
var electric_force = Vector2(0, 1000)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += (electric_force) * delta * charge

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY *jump_charge

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if up.is_colliding():
		var normal = up.get_collision_normal()
		up_direction = normal
		var angle = Vector2.UP.angle_to(normal)
		rotation = angle
	if Input.is_action_just_pressed("invert"):
		charge*=-1
		jump_charge*=-1
		
	move_and_slide()

func setForce(vector:Vector2 , other_charge: int) -> void:
	print("Entro")
	jump_charge*=other_charge
	#charge*=other_charge
	electric_force = vector  * charge * other_charge
	pass

func resetForce() -> void:
	print("Salio")
	electric_force =  Vector2(0, 1000)
