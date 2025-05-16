extends CharacterBody2D

@export var speed = 180.0
@export var gravity = 1100.0
@export var acceleration = 1300.0
@export var jump_velocity = 500.0
@export var friction = 3500.0
@export var health = 100
var direction = -1
var is_dead = false

@onready var pivot: Node2D = $Pivot
@onready var hurt_box_collision: CollisionShape2D = $HurtBox/CollisionShape2D
@onready var death_zone_collision: CollisionShape2D = $Deathzone/CollisionShape2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var animated_sprite_2d: AnimatedSprite2D = $Pivot/AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if health <= 0 and not is_dead:
		is_dead = true
		#SoundManager.play_enemy_death_sound()
		set_physics_process(false)
		collision_shape_2d.disabled = true
		death_zone_collision.disabled = true
		animated_sprite_2d.play("death")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Raycast Collision
	if ray_cast_left.is_colliding() or (is_on_floor() and not ray_cast_down.is_colliding()):
		turn_around()
	
	# Right/Left Movement
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, speed * direction, friction * delta)
	
	move_and_slide()
	
func turn_around():
	direction *= -1
	pivot.scale.x *= -1
	collision_shape_2d.position.x *= -1
	hurt_box_collision.position.x *= -1
	death_zone_collision.position.x *= -1
	ray_cast_left.scale.x *= -1
	ray_cast_down.scale.x *= -1
	

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		health = 0
		player.bounce()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		queue_free()
