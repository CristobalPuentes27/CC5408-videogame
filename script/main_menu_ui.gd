extends Control

@onready var play: Button = %Play
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.pressed.connect(_on_start_pressed)
	credits.pressed.connect(_on_credit_pressed)
	quit.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	pass
	#SoundManager.play_select_sound()
	#get_tree().change_scene_to_file("res://scenes/Level001.tscn")
	
func _on_credit_pressed() -> void:
	pass
	#SoundManager.play_select_sound()
	#get_tree().change_scene_to_file("res://scenes/credits_menu_ui.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
