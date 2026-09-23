extends Area2D

@export var min_speed : float =250.0
@export var max_speed: float=450.0

var fall_speed :float =0.0
var spin_speed :float=0.0
signal player_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fall_speed=randf_range(min_speed,max_speed)
	spin_speed=randf_range(-2.0,2.0)
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y+=fall_speed *delta
	if position.y>700:
		queue_free()
		
func _on_body_entered(body: Node2D)->void :
	if body is CharacterBody2D:
		player_hit.emit()
		queue_free()
		
