extends Node2D

class_name Zona

	
@export var  charge=1
@export var vector= Vector2(0,1000)
func setCharge(vec:Vector2,charg:int):
	charge=charg
	vector=vec
func getCharge()->int:
	return charge
func getVector()->Vector2:
	return vector
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
