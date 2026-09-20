# garlic node script
extends Node2D

@onready var self_area: Area2D = $Area2D

signal garlic_collected

func _ready() -> void:
	self_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and self.visible:
		emit_signal("garlic_collected")
		self.hide()
