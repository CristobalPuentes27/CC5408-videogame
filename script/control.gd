extends Control

const LEVEL_BTN = preload("res://scenes/interface/button.tscn")

@onready var grid: GridContainer = $"../GridContainer"

@export var level_paths: Array[String] = [
	"res://scenes/levels/demo_level.tscn",
	"res://scenes/levels/demo_level_2.tscn"
]

func _ready() -> void:
	for lvl_path in level_paths:
		var name = lvl_path.get_file().trim_suffix(".tscn").replace("_", " ")
		create_level_btn(lvl_path, name)

func create_level_btn(lvl_path: String, lvl_name: String):
	var btn = LEVEL_BTN.instantiate()
	btn.text = lvl_name.trim_suffix(".tscn").replace("_", " ")
	btn.focus_mode = Control.FOCUS_ALL
	btn.focus_entered.connect(_on_focus_entered)
	grid.add_child(btn)
	btn.pressed.connect(func(): get_tree().change_scene_to_file(lvl_path))

	# Darle el foco inicial al primer botón
	if grid.get_child_count() == 1:
		btn.grab_focus()

func _on_focus_entered() -> void:
	SoundManager.play_select_sound()
