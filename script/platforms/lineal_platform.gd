extends AnimatableBody2D

var pos1: Vector2
var pos2: Vector2
@export var distancia:Vector2 
var from: Vector2
var to: Vector2
var time: float = 0
@export var speed: float = 100.0
func _ready() -> void:
	pos1 = self.position
	pos2 = pos1 + distancia

func _physics_process(delta: float) -> void:
	
	if self.position == pos1:
		_changeDirection(pos1, pos2)
	if self.position == pos2:
		_changeDirection(pos2, pos1)
	
	var total_dist := distancia.length()
	if total_dist > 0.0:
		time = min(time + delta * speed / total_dist, 1.0)
	else:
		time = 1.0 
	
	self.position = time * to + (1 - time) * from
	#print(self.position)

func _changeDirection(last: Vector2, new: Vector2) -> void:
	from = last
	to = new
	time = 0
