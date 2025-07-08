extends Area2D
class_name CircularArea

@onready var charged_area: ChargedArea = $Area2D
@onready var debug: RayCast2D = $RayCast2D

var following: Player = null

signal new_direction(player: Player)

func _ready() -> void:
	charged_area.inCircularArea(self)

func _physics_process(delta: float) -> void:
	if following:
		var angle := (following.global_position - charged_area.global_position).angle()-charged_area.vector.angle()
		charged_area.vector = charged_area.vector.rotated(angle)
		debug.rotate(angle)
		emit_signal("new_direction", following)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		following = body

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		following = null
