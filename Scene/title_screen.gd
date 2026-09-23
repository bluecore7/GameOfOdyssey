extends Node2D

@onready var subtitle: RichTextLabel = $Subtitle
@onready var type_key: AudioStreamPlayer = $TypeKey
@onready var button_blip: AudioStreamPlayer = $ButtonBlip

func _process(_delta: float) -> void:
	pass

func _ready() -> void:
	type_out(subtitle, 0.08)

func type_out(label: RichTextLabel, delay: float) -> void:
	label.visible_characters = 0
	var total = label.get_total_character_count()
	for i in range(total + 1):
		label.visible_characters = i
		if i > 0:
			type_key.play()
		await get_tree().create_timer(delay).timeout

func _on_start_pressed() -> void:
	button_blip.play()
	Global.lives = 3
	Global.minigames_done = 0
	get_tree().change_scene_to_file("res://Scene/level_screen.tscn")

func _on_settings_pressed() -> void:
	button_blip.play()
	await get_tree().create_timer(0.08).timeout
	get_tree().change_scene_to_file("res://Scene/settings.tscn")

func _on_quit_pressed() -> void:
	button_blip.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
