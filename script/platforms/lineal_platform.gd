extends TileMapLayer

var pos1: Vector2
var pos2: Vector2
var from: Vector2
var to: Vector2
var time: float = 0

func _ready() -> void:
	pos1 = self.position
	pos2 = pos1 + Vector2(100, -50)

func _process(delta: float) -> void:
	
	if self.position == pos1:
		_changeDirection(pos1, pos2)
	if self.position == pos2:
		_changeDirection(pos2, pos1)
	
	time = min(time+delta, 1)
	
	self.position = time * to + (1 - time) * from
	#print(self.position)

func _changeDirection(last: Vector2, new: Vector2) -> void:
	from = last
	to = new
	time = 0
