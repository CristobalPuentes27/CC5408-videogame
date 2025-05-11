extends Area2D
@export var vector=Vector2(0,1100)
@export var charge=1


func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		var player: Player = body
		player.setForce(vector,charge)
		player.charge_changed.connect(_on_player_charge_changed)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.resetForce()
		player.charge_changed.disconnect(_on_player_charge_changed)

func _on_player_charge_changed(new_charge: int, player: Player) -> void:
	player.setForce(vector, charge)
