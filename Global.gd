extends Node

var minigames_done = 0 # track how many minigames done
var lives = 3 # track how many lives left, also effecting garlic appearing

const Game_Name = {
	1: "Blue Lotus",
	2: "The Sirens ",
	3: "The Cyclopes"
}

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

const SETTINGS_FILE_PATH = "user://settings.cfg"

func _ready() -> void:
	add_child(music_player)
	var bgm = preload("res://assets/audio/cynicbattleloop.ogg")
	if bgm is AudioStreamOggVorbis:
		bgm.loop = true
	music_player.stream = bgm
	music_player.bus = "Music"
	
	load_settings()
	music_player.play()

func get_music_bus_index() -> int:
	var bus_index = AudioServer.get_bus_index("Music")
	if bus_index == -1:
		AudioServer.add_bus()
		bus_index = AudioServer.bus_count - 1
		AudioServer.set_bus_name(bus_index, "Music")
		AudioServer.set_bus_send(bus_index, "Master")
	return bus_index

func save_settings() -> void:
	var config = ConfigFile.new()
	var bus_index = get_music_bus_index()
	config.set_value("audio", "music_volume", AudioServer.get_bus_volume_db(bus_index))
	config.set_value("audio", "music_muted", AudioServer.is_bus_mute(bus_index))
	config.save(SETTINGS_FILE_PATH)

func load_settings() -> void:
	var bus_index = get_music_bus_index()
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE_PATH)
	if err == OK:
		var vol = config.get_value("audio", "music_volume", linear_to_db(0.8))
		var muted = config.get_value("audio", "music_muted", false)
		AudioServer.set_bus_volume_db(bus_index, vol)
		AudioServer.set_bus_mute(bus_index, muted)
	else:
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(0.8))
		AudioServer.set_bus_mute(bus_index, false)
