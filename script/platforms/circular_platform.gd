extends TileMapLayer

var center: Vector2
var radius: int = 20
var time: float = 0
var velocity: int = 5
var direction: int = -1 #1 es horario, -1 antihorario

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = self.position
	print(center)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	self.position.x = radius*cos(time * velocity * direction) + center.x
	self.position.y = radius*sin(time * velocity * direction) + center.y
	
	time += delta
