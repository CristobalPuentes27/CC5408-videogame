extends Area2D
@onready var victory_menu: CanvasLayer = $"../Victory_Menu"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	victory_menu.visible = false  # Ocultar al inicio
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animated_sprite_2d.play("open")
		victory_menu.visible = true
		victory_menu.next_level.grab_focus()
	timer.start(1.0)
	await timer.timeout
	get_tree().paused = true
	

func hide_victory() -> void:
	victory_menu.visible = false
	
