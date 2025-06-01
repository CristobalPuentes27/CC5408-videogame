extends Control

const LEVEL_BTN = preload("res://scenes/interface/button.tscn")

@export_dir var dir_path
@onready var grid: GridContainer = $"../GridContainer"

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tscn"):
				var full_path = dir.get_current_dir().path_join(file_name)
				create_level_btn(full_path, file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")

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
