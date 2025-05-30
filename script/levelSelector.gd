extends Control
@onready var button: Button = $PanelContainer/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	pass
	get_tree().change_scene_to_file("res://scenes/main_menu_ui.tscn") # Replace with function body.
