extends CanvasLayer

@onready var next_level: Button = %"Next Level"
@onready var title: Button = %Title
@onready var quit: Button = %Quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var filePath:String = get_parent().get_scene_file_path()
	var index = get_level_index(filePath)
	var nextLevel:String=filePath.replace(str(index),str(index+1))
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	next_level.pressed.connect(_on_next_level_pressed)
	title.pressed.connect(_on_title_pressed)
	quit.pressed.connect(_on_quit_pressed)
	
	# Mover el selector entre botones con el teclado
	next_level.focus_mode = Control.FOCUS_ALL
	title.focus_mode = Control.FOCUS_ALL
	quit.focus_mode = Control.FOCUS_ALL

func _on_next_level_pressed() -> void:
	get_tree().paused = false
	var filePath:String = get_parent().get_scene_file_path()
	var index = get_level_index(filePath)
	var nextLevel:String=filePath.replace(str(index),str(index+1))
	if (ResourceLoader.exists(nextLevel)):
		get_tree().change_scene_to_file(nextLevel)
	else:
		get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn")

func _on_title_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func get_level_index(path: String) -> int:
	var regex = RegEx.new()
	regex.compile(r"demo_level_(\d+)\.tscn")
	var result = regex.search(path)
	if result:
		return result.get_string(1).to_int()
	return -1
