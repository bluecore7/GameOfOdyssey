extends TextureButton
@onready var parent =$"."

func _on_pressed() -> void:
	hide()
	parent.button_pressed+=1
