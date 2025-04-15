extends Player


const GRAVITY: float = 450
const JUMP: float = -400
var air_time = 0
var is_jumping = false
var raw_velocity: Vector2
 
@onready var floor_detector: RayCast2D = $floor as RayCast2D
@onready var up_detector: RayCast2D = $top as RayCast2D



func _physics_process(delta: float) -> void:
	raw_velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED
	if Input.is_action_just_pressed("jump"):
		is_jumping = true
	
	if is_on_floor() and !is_jumping:
		raw_velocity.y = 0.0
	elif is_jumping:
		air_time += delta
		up_direction = Vector2(0,-1)
		if air_time > 0.2:
			is_jumping = false
			air_time =0
		raw_velocity.y = JUMP
	else:
		raw_velocity.y = GRAVITY
 	
	if floor_detector.is_colliding():
		var normal = floor_detector.get_collision_normal()
		up_direction = normal
 
		var angle = Vector2.UP.angle_to(normal)
		rotation = angle
 
		velocity = raw_velocity.rotated(angle)
	elif up_detector.is_colliding():
		var normal = up_detector.get_collision_normal()
		up_direction = normal
		var angle = Vector2.UP.angle_to(normal)
		rotation = angle
	else:
		velocity = raw_velocity
 	
	
	move_and_slide()
