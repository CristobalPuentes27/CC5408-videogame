extends Area2D

var parent= get_parent() 
var vector2=Vector2(0,1100)
var charge2=1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent= get_parent()
	if parent is Zona:
		vector2=parent.vector
		charge2=parent.charge
		print("ok")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player and parent is Zona:
		var player: Player = body
		vector2=parent.getVector()
		print(charge2+10)
		charge2=parent.getCharge()
		print(charge2+10)
		player.setForce(vector2,parent.charge)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.resetForce()
