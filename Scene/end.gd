extends Node2D

@onready var button_blip: AudioStreamPlayer = $ButtonBlip

func _ready() -> void:
	pass

func _on_main_menu_pressed() -> void:
	button_blip.play()
	Global.lives = 3
	Global.minigames_done = 0
	await get_tree().create_timer(0.08).timeout
	get_tree().change_scene_to_file("res://Scene/title_screen.tscn")

func _on_quit_pressed() -> void:
	button_blip.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
