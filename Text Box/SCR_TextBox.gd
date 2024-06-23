extends CanvasLayer

# Blud this textbox was like blatantly stolen from here doug
# but i needed something working ASAP so i hope i dont have
# to revisit it :)

# source: https://www.youtube.com/watch?v=QEHOiORnXIk

const READ_RATE : float = 0.05
var END_READING_FUNCTION = func():
	end_symbol.text = "V"
	change_state(State.FINISHED)

var queue = [{}]
var highlight_queue = []
var character_queue = []
var text_queue = []

@onready var textbox_container : MarginContainer = $MarginContainer/TextboxContainer
@onready var speaker_container : MarginContainer = $MarginContainer/MarginContainer

@onready var start_symbol : Label = $MarginContainer/TextboxContainer/MarginContainer/HBoxContainer/StartSymbol
@onready var end_symbol : Label  = $MarginContainer/TextboxContainer/MarginContainer/HBoxContainer/EndSymbol
@onready var label : Label = $MarginContainer/TextboxContainer/MarginContainer/HBoxContainer/Text
@onready var speaker_label : Label = $MarginContainer/MarginContainer/Panel/Label


@onready var tween : Tween

enum State {
	READY,
	READING,
	FINISHED
}

var current_state : State = State.READY

func _ready():
	print("Starting state State.READY")
	hide_textbox()

func _process(_delta):
	match (current_state):
		State.READY:
			if not queue.is_empty():
				next_all()
		State.READING:
			if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_Z):
				tween.stop()
				label.visible_ratio = 1
				END_READING_FUNCTION.call()
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_Z):
				change_state(State.READY)
				hide_textbox()

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	speaker_label.text = ""
	textbox_container.hide()
	speaker_container.hide()

func show_textbox():
	start_symbol.text = ">"
	textbox_container.show()
	speaker_container.show()

func queue_text(next_text):
	text_queue.append(next_text)

func change_state(next_state):
	current_state = next_state
	match (current_state):
		State.READY:
			print("Changing to State.READY")
		State.READING:
			print("Changing to State.READING")
		State.FINISHED:
			print("Changing to State.FINISHED")

@onready var left_container = $CharacterContainerLeft/LeftContainer
@onready var right_container = $CharacterContainerRight/RightContainer
var chars_on_left = {}
var chars_on_right = {}

func add_character_left(char_name : String, character : PackedScene):
	assert(!chars_on_left.has(char_name), (char_name + " already is in chars_on_left"))
	var char_instance = character.instantiate()
	left_container.add_child(char_instance)
	chars_on_left[char_name] = char_instance

func remove_character_left(char_name : String):
	assert(chars_on_left.has(char_name), (char_name + " not found in chars_on_left"))
	chars_on_left[char_name].queue_free()
	chars_on_left.erase(char_name)

func highlight_character_left(char_name : String):
	assert(chars_on_left.has(char_name), (char_name + " not found in chars_on_left"))
	for character in chars_on_left.values():
		character.modulate = Color(0.2, 0.2, 0.2)
	chars_on_left[char_name].modulate = Color(1, 1, 1)

func add_character_right(char_name : String, character : PackedScene):
	var char_instance = character.instantiate()
	right_container.add_child(char_instance)
	chars_on_right[char_name] = char_instance

func remove_character_right(char_name : String):
	assert(chars_on_right.has(char_name), (char_name + " not found in chars_on_left"))
	chars_on_right[char_name].queue_free()
	chars_on_right.erase(char_name)

func highlight_character_right(char_name : String):
	assert(chars_on_right.has(char_name), (char_name + " not found in chars_on_right"))
	for character in chars_on_right.values():
		character.modulate = Color(0.2, 0.2, 0.2)
	chars_on_right[char_name].modulate = Color(1, 1, 1)

func sprite_change(char_name, sprite, left):
	queue_all(null, null, char_name, sprite, null, false, left)

func queue_dialogue(text, speaker):
	queue_all(text, speaker, null, null, null, false, false)

func queue_all(text, speaker, char_name, sprite, background, highlight, left):
	queue.append({})
	queue[-1]["text"] = text
	queue[-1]["speaker"] = speaker
	queue[-1]["char_name"] = char_name
	queue[-1]["sprite"] = sprite
	queue[-1]["background"] = background
	queue[-1]["highlight"] = highlight
	queue[-1]["left"] = left

func clean_up():
	for key in chars_on_left.keys():
		sprite_change(key, null, true)
	for key in chars_on_right.keys():
		sprite_change(key, null, false)

func display_text(next_text, speaker):
	label.text = next_text
	speaker_label.text = speaker
	show_textbox()
	label.visible_ratio = 0.0
	tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * READ_RATE)
	change_state(State.READING)
	tween.tween_callback(END_READING_FUNCTION)

@onready var background_container : TextureRect = $Background/TextureRect

var current_step : int = 1
func next_all():
	if (queue.size() == current_step): return
	var dict = queue[current_step]
	if (dict["background"] != null):
		background_container.texture = dict["background"]
	if (dict["text"] != null):
		display_text(dict["text"], dict["speaker"])
	if (dict["char_name"] == null): 
		current_step += 1
		return
	var char_name = dict["char_name"]
	assert(dict["left"] != null, "If char_name is selected, must select left or right")
	var sprite_changed = dict["sprite"] != null
	var highlight_changed = dict["highlight"]
	if (dict["left"]):
		print("Changing chars on left")
		if (sprite_changed):
			if (chars_on_left.has(char_name)):
				chars_on_left[char_name].texture = dict["sprite"]
			else:
				var sprite = TextureRect.new()
				sprite.texture = dict["sprite"]
				sprite.expand_mode = TextureRect.EXPAND_FIT_WIDTH
				sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
				sprite.size_flags_horizontal = TextureRect.SIZE_EXPAND_FILL
				sprite.size_flags_vertical = TextureRect.SIZE_EXPAND_FILL
				sprite.flip_h = true
				chars_on_left[char_name] = sprite
				left_container.add_child(sprite)
		elif (not sprite_changed and chars_on_left.has(char_name)):
			chars_on_left[char_name].queue_free()
			chars_on_left.erase(char_name)
		if (highlight_changed):
			assert(chars_on_left.has(char_name), char_name + " is not in chars_on_left")
			for character in chars_on_right.values():
				character.modulate = Color(0.2, 0.2, 0.2)
			for character in chars_on_left.values():
				character.modulate = Color(0.2, 0.2, 0.2)
			chars_on_left[char_name].modulate = Color(1, 1, 1)
	else:
		if (sprite_changed):
			if (chars_on_right.has(char_name)):
				chars_on_right[char_name].texture = dict["sprite"]
			else:
				var sprite = TextureRect.new()
				sprite.texture = dict["sprite"]
				sprite.expand_mode = TextureRect.EXPAND_FIT_WIDTH
				sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
				sprite.size_flags_horizontal = TextureRect.SIZE_EXPAND_FILL
				sprite.size_flags_vertical = TextureRect.SIZE_EXPAND_FILL
				chars_on_right[char_name] = sprite
				right_container.add_child(sprite)
		elif (not sprite_changed and chars_on_right.has(char_name)):
			chars_on_right[char_name].queue_free()
			chars_on_right.erase(char_name)
		if (highlight_changed):
			assert(chars_on_right.has(char_name), char_name + " is not in chars_on_right")
			for character in chars_on_right.values():
				character.modulate = Color(0.2, 0.2, 0.2)
			for character in chars_on_left.values():
				character.modulate = Color(0.2, 0.2, 0.2)
			chars_on_right[char_name].modulate = Color(1, 1, 1)
	current_step += 1
	if (dict["text"] == null): next_all()

var disable_input = false
@onready var fade_black = $FadeBlack
func fade_black_back_in(callback : Callable, midfunction : Callable):
	disable_input = true
	var ending = func():
		callback.call()
		disable_input = false
	
	var backOff = func():
		var tweenOff = get_tree().create_tween()
		if (current_state == State.FINISHED):
			change_state(State.READY)
			hide_textbox()
		tweenOff.tween_property(fade_black, "modulate", Color(0, 0, 0, 0), 1)
		tweenOff.tween_callback(ending)
	
	var cback = func():
		await midfunction.call()
		backOff.call()
	
	var tweenOn = get_tree().create_tween()
	tweenOn.tween_property(fade_black, "modulate", Color(0, 0, 0, 1), 1)
	tweenOn.tween_callback(cback)
