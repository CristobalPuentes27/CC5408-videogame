extends Control

@onready var play: Button = %Play
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play.pressed.connect(_on_start_pressed)
	credits.pressed.connect(_on_credit_pressed)
	quit.pressed.connect(_on_quit_pressed)
	
	# Mover el selector entre botones con el teclado
	for button in [play, credits, quit]:
		button.focus_mode = Control.FOCUS_ALL
		button.focus_entered.connect(_on_focus_entered)
	play.grab_focus()

func _on_focus_entered() -> void:
	SoundManager.play_select_sound()
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/interface/level_selector_ui.tscn")
	
func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/interface/credits_menu_ui.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
