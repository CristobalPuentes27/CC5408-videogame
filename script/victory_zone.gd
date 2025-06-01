extends Area2D

@onready var victory_menu: CanvasLayer = $"../Victory_Menu"

func _ready() -> void:
	victory_menu.visible = false  # Ocultar al inicio
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		victory_menu.visible = true

func hide_victory() -> void:
	victory_menu.visible = false
	
