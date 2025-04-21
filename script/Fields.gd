extends Area2D
class_name Fields

	
@export var  charge=1
@export var vector= Vector2(0,1000)
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		
		
		player.setForce(vector,charge)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.resetForce()
