extends TextureButton



func _on_pressed() -> void:
	hide()
	get_parent().buttons_pressed += 1
