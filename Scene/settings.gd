extends Node2D

@onready var music_slider: HSlider = $VBoxContainer/VolumeRow/MusicSlider
@onready var percent_label: Label = $VBoxContainer/VolumeRow/PercentLabel
@onready var mute_button: CheckButton = $VBoxContainer/MuteButton
@onready var button_blip: AudioStreamPlayer = $ButtonBlip

func _ready() -> void:
	var bus_index = Global.get_music_bus_index()
	var db = AudioServer.get_bus_volume_db(bus_index)
	var linear_vol = 0.0 if db <= -79.0 else db_to_linear(db)
	
	music_slider.value = linear_vol
	percent_label.text = str(roundi(linear_vol * 100)) + "%"
	mute_button.button_pressed = AudioServer.is_bus_mute(bus_index)

func _on_music_slider_value_changed(value: float) -> void:
	var bus_index = Global.get_music_bus_index()
	var db = linear_to_db(value) if value > 0.0001 else -80.0
	AudioServer.set_bus_volume_db(bus_index, db)
	percent_label.text = str(roundi(value * 100)) + "%"
	Global.save_settings()

func _on_mute_toggled(toggled_on: bool) -> void:
	button_blip.play()
	var bus_index = Global.get_music_bus_index()
	AudioServer.set_bus_mute(bus_index, toggled_on)
	Global.save_settings()

func _on_back_pressed() -> void:
	button_blip.play()
	Global.save_settings()
	await get_tree().create_timer(0.08).timeout
	get_tree().change_scene_to_file("res://Scene/title_screen.tscn")
