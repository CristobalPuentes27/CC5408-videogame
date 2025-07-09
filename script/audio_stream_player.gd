extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	stream = preload("res://music/chibi-robot-b.ogg")
	stream.loop = true
	volume_db = -20.0
	play()
