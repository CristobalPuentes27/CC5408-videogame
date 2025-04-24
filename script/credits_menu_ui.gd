extends Control


@onready var scroll_container: ScrollContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer
@onready var back: Button = %Back

func _ready() -> void:
	back.pressed.connect(_on_back_pressed)

func _process(delta: float) -> void:
	scroll_container.scroll_vertical += 100 * delta

func _on_back_pressed() -> void:
	#SoundManager.play_select_sound()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu_ui.tscn")
