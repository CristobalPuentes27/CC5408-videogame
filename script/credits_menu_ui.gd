extends Control


@onready var scroll_container: ScrollContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer
@onready var back: Button = %Back

func _ready() -> void:
	back.pressed.connect(_on_back_pressed)
	
	# Mover el selector entre botones con el teclado
	back.focus_mode = Control.FOCUS_ALL
	back.grab_focus()

func _process(delta: float) -> void:
	scroll_container.scroll_vertical += 100 * delta

func _on_back_pressed() -> void:
	#SoundManager.play_select_sound()
	get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn")
