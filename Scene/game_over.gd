extends Node2D

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		_restart()
	elif event is InputEventMouseButton and event.is_pressed():
		_restart()

func _restart() -> void:
	Global.lives = 3
	Global.minigames_done = 0
	get_tree().change_scene_to_file("res://Scene/title_screen.tscn")
