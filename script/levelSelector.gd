extends Control
@onready var back: Button = $PanelContainer/MarginContainer/VBoxContainer/Back


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.pressed.connect(_on_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	pass
	get_tree().change_scene_to_file("res://scenes/interface/main_menu_ui.tscn") # Replace with function body.
