extends CanvasLayer

@onready var next_level: Button = %"Next Level"
@onready var title: Button = %Title
@onready var quit: Button = %Quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	title.pressed.connect(_on_title_pressed)
	quit.pressed.connect(_on_quit_pressed)

func _on_title_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
