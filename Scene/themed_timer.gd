# scenes/themed_timer.gd
extends Node2D

@onready var timer: RichTextLabel = $timer
var time: float

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	timer.text = "%0.1f" % max(time, 0.0)

func Timer(start_time: float):
	time = start_time
	while time > 0.0:
		await wait(0.10)
		time -= 0.10
	return

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
