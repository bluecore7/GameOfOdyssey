# scenes/minigame_1.gd
extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
var garlic_collected = 0
var timer_end = false
var game_over = false

func _ready() -> void:
	await themed_timer.Timer(10.0)
	timer_end = true

func _process(_delta: float) -> void:
	if game_over:
		return
	if garlic_collected >= 3:
		game_over = true
		if Global.minigames_done >= 3:
			get_tree().change_scene_to_file("res://Scene/End.tscn")
		else:
			get_tree().change_scene_to_file("res://Scene/level_screen.tscn")
	elif timer_end:
		game_over = true
		Global.minigames_done -= 1
		Global.lives -= 1
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://Scene/game_over.tscn")
		else:
			get_tree().change_scene_to_file("res://Scene/level_screen.tscn")

func garlic_collect() -> void:
	garlic_collected += 1
