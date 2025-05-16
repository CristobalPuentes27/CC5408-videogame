extends Area2D
class_name Deathzone

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.take_damage()
