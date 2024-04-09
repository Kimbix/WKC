extends Node2D

@onready var locations_container = $"../ButtonsLayer/LocationsContainer"

enum State {
	CHOOSING,
	PLACE_DIALOGUE,
	ENDING,
}
var current_state : State = State.CHOOSING

enum Location {
	NO_PREVIOUS,
	DUNGEON,
	KITCHEN,
	BEDROOM,
	GARAGE,
	GARDEN
}
var previous_location : Location = Location.NO_PREVIOUS

const text_box : PackedScene = preload("res://Text Box/TXT_TextBox.tscn")
var tbi

func _ready():
	locations_container.visible = false
	tbi = text_box.instantiate()
	add_child(tbi)
	
	tbi.queue_dialogue("A donde ir...?", "Humber")

func _input(_event):
	if tbi.disable_input: return
	
	if (not Input.is_action_just_released("ui_accept")): return
	if (not tbi.current_state == tbi.State.READY): return
	
	match(current_state):
		State.CHOOSING:
			locations_container.visible = true
		var state when state == State.PLACE_DIALOGUE and locations_container.get_child_count() == 2:
			tbi.queue_dialogue("It's nearing midnight, I should go back with the rest", "Humber")
			current_state = State.ENDING
		var state when state == State.PLACE_DIALOGUE and locations_container.get_child_count() > 2:
			locations_container.visible = true
		State.ENDING:
			get_tree().change_scene_to_file("res://Scenes/Ending/SCN_endings.tscn")

func _on_the_dungeon_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/The Dungeon".queue_free()
	tbi.fade_black_back_in(dungeon_scene, "You went to the dungeon")

var dungeon_scene = func():
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("But nobody came... RANDOM 1", "The evil cris")
	else:
		tbi.queue_dialogue("But nobody came... RANDOM 2", "The evil cris")
	match (previous_location):
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIRI)
			tbi.queue_dialogue("You previously went to the Kitchen", "The evil cris")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CRIS)
			tbi.queue_dialogue("You previously went to the Bedroom", "The evil cris")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIMBIX)
			tbi.queue_dialogue("You previously went to the Garage", "The evil cris")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CONO)
			tbi.queue_dialogue("You previously went to the Garden", "The evil cris")
		_:
			tbi.queue_dialogue("Nothing else happened", "The evil cris")
	previous_location = Location.DUNGEON

func _on_kitchen_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Kitchen".queue_free()
	tbi.fade_black_back_in(kitchen_scene, "You went to the kitchen")

var kitchen_scene = func():
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("But nobody came... RANDOM 1", "The evil cris")
	else:
		tbi.queue_dialogue("But nobody came... RANDOM 2", "The evil cris")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIRI)
			tbi.queue_dialogue("You previously went to the Dungeon", "The evil cris")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CYRU)
			tbi.queue_dialogue("You previously went to the Bedroom", "The evil cris")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.MAGNITUDE)
			tbi.queue_dialogue("You previously went to the Garage", "The evil cris")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.BICI)
			tbi.queue_dialogue("You previously went to the Garden", "The evil cris")
		_:
			tbi.queue_dialogue("Nothing else happened", "The evil cris")
	previous_location = Location.KITCHEN

func _on_bedroom_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Bedroom".queue_free()
	tbi.fade_black_back_in(bedroom_scene, "You went to the bedroom")

var bedroom_scene = func():
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("But nobody came... RANDOM 1", "The evil cris")
	else:
		tbi.queue_dialogue("But nobody came... RANDOM 2", "The evil cris")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CRIS)
			tbi.queue_dialogue("You previously went to the Dungeon", "The evil cris")
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CYRU)
			tbi.queue_dialogue("You previously went to the Kitchen", "The evil cris")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.YEETUS)
			tbi.queue_dialogue("You previously went to the Garage", "The evil cris")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.UKESITO)
			tbi.queue_dialogue("You previously went to the Garden", "The evil cris")
		_:
			tbi.queue_dialogue("Nothing else happened", "The evil cris")
	previous_location = Location.BEDROOM

func _on_garage_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Garage".queue_free()
	tbi.fade_black_back_in(garage_scene, "You went to the garage")

var garage_scene = func():
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("But nobody came... RANDOM 1", "The evil cris")
	else:
		tbi.queue_dialogue("But nobody came... RANDOM 2", "The evil cris")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIMBIX)
			tbi.queue_dialogue("You previously went to the Dungeon", "The evil cris")
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.MAGNITUDE)
			tbi.queue_dialogue("You previously went to the Kitchen", "The evil cris")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.YEETUS)
			tbi.queue_dialogue("You previously went to the Bedroom", "The evil cris")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.JOACO)
			tbi.queue_dialogue("You previously went to the Garden", "The evil cris")
		_:
			tbi.queue_dialogue("Nothing else happened", "The evil cris")
	previous_location = Location.GARAGE

func _on_garden_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Garden".queue_free()
	tbi.fade_black_back_in(garden_scene, "You went to the garage")

var garden_scene = func():
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("But nobody came... RANDOM 1", "The evil cris")
	else:
		tbi.queue_dialogue("But nobody came... RANDOM 2", "The evil cris")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CONO)
			tbi.queue_dialogue("You previously went to the Dungeon", "The evil cris")
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.BICI)
			tbi.queue_dialogue("You previously went to the Kitchen", "The evil cris")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.UKESITO)
			tbi.queue_dialogue("You previously went to the Bedroom", "The evil cris")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.JOACO)
			tbi.queue_dialogue("You previously went to the Garage", "The evil cris")
		_:
			tbi.queue_dialogue("Nothing else happened", "The evil cris")
	previous_location = Location.GARDEN
