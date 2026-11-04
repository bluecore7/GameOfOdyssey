# garlic node script
extends Node2D

@onready var self_area: Area2D = $Area2D

signal garlic_collected

func _ready() -> void:
	self_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and self.visible:
		garlic_collected.emit()
		self_area.set_deferred("monitoring", false)
		self.hide()
