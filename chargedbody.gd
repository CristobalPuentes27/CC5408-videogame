extends Area2D
@export var vector=Vector2(0,1100)
@export var charge=1


func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		var player: Player = body
		
		player.setForce(vector,charge) # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.resetForce() # Replace with function body.
