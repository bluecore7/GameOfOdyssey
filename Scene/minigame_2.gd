extends Node2D
@onready var themed_timer: Node2D = $Themed_timer

var buttons_pressed = 0
var timer_end = false
var game_over = false

func _ready() -> void:
	await themed_timer.Timer(7.0)
	timer_end = true

func _process(_delta: float) -> void:
	if game_over:
		return
	if buttons_pressed >= 4:
		game_over = true
		if Global.minigames_done >= 3:
			get_tree().change_scene_to_file("res://Scene/End.tscn")
		else:
			get_tree().change_scene_to_file("res://Scene/level_screen.tscn")
	elif timer_end:
		game_over = true
		Global.lives -= 1
		Global.minigames_done -= 1
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://Scene/game_over.tscn")
		else:
			get_tree().change_scene_to_file("res://Scene/level_screen.tscn")
