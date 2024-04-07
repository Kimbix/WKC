extends Node2D

const text_box : PackedScene = preload("res://Text Box/TXT_TextBox.tscn")
const test_cris = preload("res://Characters/CHR_Cris.tscn")

var text_box_instance

# Here's all of the arguments because i keep forgetting
# queue_all(text, speaker, char_name, sprite, background, highlight, left):
func _ready():
	text_box_instance = text_box.instantiate()
	add_child(text_box_instance)
	text_box_instance.queue_all("Long ago, two races ruled over Earth: HUMANS and MONSTERS", "Cris", "Cris", test_cris, null, true, true)
	text_box_instance.queue_all("One day, war broke out between the two races", "Cris", "Cris", test_cris, null, true, true)
	text_box_instance.queue_all("After a long battle, the humans were victorious", "Cris", "Cris", test_cris, null, true, true)
	text_box_instance.queue_all("They sealed the monsters underground with a magic spell", "Cris", "Cris", test_cris, null, true, true)
