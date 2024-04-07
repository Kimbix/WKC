extends Control

const scene_to_change : String = "res://Scenes/Intro Cutscene/SCN_intro_cutscene.tscn"

@onready var note = $MarginContainer2
@onready var note_dos = $MarginContainer3
@onready var opened_note = $MarginContainer/Note3

var note_triggered : bool = false
var note_opened : bool = false

func _ready():
	opened_note.visible = false
	opened_note.modulate.a = 0
	note_dos.visible = false
	pass

func _input(_event):
	var ms_pos = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if (not note_triggered):
			note_triggered = true
			note_dos.position = note.position
			note_dos.visible  = true
			note.queue_free()
		elif (note_triggered and not note_opened):
			note_opened = true
			opened_note.visible = true
			note_dos.visible = false
			var tween : Tween = get_tree().create_tween()
			tween.tween_property(opened_note, "modulate", Color(1, 1, 1, 1), 1.5)
			tween.tween_callback(tween.kill)
		elif (opened_note.modulate.a == 1):
			var tween : Tween = get_tree().create_tween()
			tween.tween_property(opened_note, "modulate", Color(1, 1, 1, 0), 1.5)
			var callback = func(): get_tree().change_scene_to_file(scene_to_change)
			tween.tween_callback(callback)
