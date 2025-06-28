extends CanvasLayer

@onready var next_level: Button = %"Next Level"
@onready var title: Button = %Title
@onready var quit: Button = %Quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index:String=get_parent().get_name()
	var realIndex:int= index.to_int()
	var filePath:String = get_parent().get_scene_file_path()
	var nextLevel:String=filePath.replace(str(realIndex),str(realIndex+1))
	print(nextLevel)
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
	var index:String=get_parent().get_name()
	var realIndex:int= index.to_int()
	var filePath:String = get_parent().get_scene_file_path()
	var nextLevel:String=filePath.replace(str(realIndex),str(realIndex+1))
	if (ResourceLoader.exists(nextLevel)):
		print("test")
		get_tree().change_scene_to_file(nextLevel)
	else:
		get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn")
		

func _on_title_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
