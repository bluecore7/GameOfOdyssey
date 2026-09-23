extends Node2D

# Preload your falling object scene
const HAZARD_SCENE = preload("res://Scene/gaint_falling.tscn")

@onready var spawn_timer: Timer = $SpawnTimer
@onready var hazard_container: Node2D = get_node_or_null("HazardContainer")
@onready var themed_timer: Node2D = $Themed_timer

var game_over: bool = false

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	# Start survival countdown (survive 1 minute to escape)
	await themed_timer.Timer(60.0)
	
	# If player survived without game over:
	if not game_over:
		_on_player_escaped()

func _on_spawn_timer_timeout() -> void:
	if game_over:
		return
		
	# 1. Instance a new falling picture
	var hazard = HAZARD_SCENE.instantiate()
	
	# 2. Pick a random X position across screen width
	var random_x = randf_range(60.0, 1090.0)
	var spawn_y = -50.0 # Just above the visible screen
	hazard.position = Vector2(random_x, spawn_y)
	
	# 3. Listen if this specific hazard hits the player
	hazard.player_hit.connect(_on_player_hit)
	
	# 4. Add it to the scene (use container if available, otherwise root)
	if hazard_container:
		hazard_container.add_child(hazard)
	else:
		add_child(hazard)
	
	# Optional: randomize next spawn delay for varying wave rhythms
	spawn_timer.wait_time = randf_range(0.4, 0.9)

func _on_player_hit() -> void:
	if game_over:
		return
	game_over = true
	spawn_timer.stop()
	
	# Player failed to dodge: lose a life
	Global.lives -= 1
	Global.minigames_done -= 1

	# Transition back to level screen or game over screen if out of lives
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://Scene/game_over.tscn")
	else:
		get_tree().change_scene_to_file("res://Scene/level_screen.tscn")

func _on_player_escaped() -> void:
	if game_over:
		return
	game_over = true
	spawn_timer.stop()
	
	# Player successfully escaped without touching!
	if Global.minigames_done >= 3:
		get_tree().change_scene_to_file("res://Scene/End.tscn")
	else:
		get_tree().change_scene_to_file("res://Scene/level_screen.tscn")
