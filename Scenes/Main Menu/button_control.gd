extends Control

var tween: Tween
@onready var colors: Control = self.get_child(0).get_child(1)

@export var text_texture : CompressedTexture2D

var orangeSpeed = 0.15
var yellowSpeed = 0.30

func _ready() -> void:
	var text_object  = $TextureRect2/Text
	if(text_object):
		text_object.texture = text_texture
	pass

func hover_on() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

	for c in colors.get_children():
		if (c == colors.get_child(0)):
			tween.parallel().tween_property(c, "scale", Vector2(5.5,2.1), orangeSpeed)
		else:
			tween.parallel().tween_property(c, "scale", Vector2(-11,6.2), yellowSpeed)
	pass

func hover_off() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

	for i in range(colors.get_child_count()-1, -1, -1):
		var c = colors.get_child(i)
		if (c == colors.get_child(0)):
			tween.parallel().tween_property(c, "scale", Vector2(4.1,1.6), orangeSpeed)
		else:
			tween.parallel().tween_property(c, "scale", Vector2(-6,3.5), yellowSpeed)
	pass

func _on_button_mouse_entered() -> void:
	hover_on()

func _on_button_mouse_exited() -> void:
	hover_off() 
	
#func _on_quit_button_toggled(toggled_on: bool) -> void:
#	if toggled_on == true:
#		$Quit_Button/TextureRect2/Pressed_Overlay.show()
#	if toggled_on == false:
#		$Quit_Button/TextureRect2/Pressed_Overlay.hide()
