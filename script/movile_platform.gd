extends TileMapLayer


var pos1: Vector2
var pos2: Vector2
var from: Vector2
var to: Vector2
var tiempo: float = 0

func _ready() -> void:
	pos1 = self.position
	pos2 = pos1 + Vector2(100, 0)

func _process(delta: float) -> void:
	
	if self.position == pos1:
		from = pos1
		to = pos2
		tiempo = 0
	elif self.position == pos2:
		from = pos2
		to = pos1
		tiempo = 0
	
	tiempo = min(tiempo+delta, 1)
	
	self.position = tiempo * to + (1 - tiempo) * from
	#print(self.position)
