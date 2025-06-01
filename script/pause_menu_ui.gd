extends CanvasLayer

@onready var victory_menu: CanvasLayer = $"../Victory_Menu"

@onready var resume: Button = %Resume
@onready var retry: Button = %Retry
@onready var title: Button = %Title
@onready var quit: Button = %Quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	title.pressed.connect(_on_title_pressed)
	quit.pressed.connect(_on_quit_pressed)
	
		# Mover el selector entre botones con el teclado
	resume.focus_mode = Control.FOCUS_ALL
	retry.focus_mode = Control.FOCUS_ALL
	title.focus_mode = Control.FOCUS_ALL
	quit.focus_mode = Control.FOCUS_ALL
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not victory_menu.visible:
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		if visible:
			resume.grab_focus()
func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_title_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
