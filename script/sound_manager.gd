extends Node

func play_enemy_death_sound():
	var player = AudioStreamPlayer.new()
	player.stream = preload("res://music/sfx/Boss hit 1.wav")
	get_tree().root.add_child(player)  # Lo agregamos al árbol de la escena
	player.play()
	player.connect("finished", player.queue_free) # Se borra al terminar

func play_player_death_sound():
	var player = AudioStreamPlayer.new()
	player.stream = preload("res://music/sfx/Hit damage 1.wav")
	get_tree().root.add_child(player)  # Lo agregamos al árbol de la escena
	player.play()
	player.connect("finished", player.queue_free) # Se borra al terminar

func play_jump_sound():
	var player = AudioStreamPlayer.new()
	player.volume_db = -6.0
	player.stream = preload("res://music/sfx/Jump 1.wav")
	get_tree().root.add_child(player)  # Lo agregamos al árbol de la escena
	player.play()
	player.connect("finished", player.queue_free) # Se borra al terminar

func play_select_sound():
	var player = AudioStreamPlayer.new()
	player.volume_db = -6.0
	player.stream = preload("res://music/sfx/Select 1.wav")
	get_tree().root.add_child(player)  # Lo agregamos al árbol de la escena
	player.play()
	player.connect("finished", player.queue_free) # Se borra al terminar
