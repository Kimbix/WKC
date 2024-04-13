extends Node2D

enum State {
	START,
	SEEING_ENDING
}
var current_state : State = State.START

@onready var endings_buttons : GridContainer = $"../ButtonsLayer/EndingsContainer"

const text_box : PackedScene = preload("res://Text Box/TXT_TextBox.tscn")
var tbi

func _ready():
	load_game()
	endings_buttons.visible = false
	tbi = text_box.instantiate()
	add_child(tbi)
	
	tbi.queue_dialogue("A quien acusar...?", "Humber")

func _input(event):
	if tbi.disable_input: return
	if (not Input.is_action_just_released("ui_accept")): return
	if (not tbi.current_state == tbi.State.READY): return
	
	match(current_state):
		State.START:
			show_buttons()
			endings_buttons.visible = true
		State.SEEING_ENDING:
			get_tree().change_scene_to_file("res://Scenes/Main Menu/SCN_main_menu.tscn")

func show_buttons():
	for ending in ScrPersistentData.possible_endings:
		match(ending):
			ScrPersistentData.Endings.CRIS:
				$"../ButtonsLayer/EndingsContainer/Cris".visible = true
			ScrPersistentData.Endings.UKESITO:
				$"../ButtonsLayer/EndingsContainer/Ukesito".visible = true
			ScrPersistentData.Endings.YEETUS:
				$"../ButtonsLayer/EndingsContainer/Yeetus".visible = true
			ScrPersistentData.Endings.CYRU:
				$"../ButtonsLayer/EndingsContainer/Cyrus".visible = true
			ScrPersistentData.Endings.KIMBIX:
				$"../ButtonsLayer/EndingsContainer/Kimbix".visible = true
			ScrPersistentData.Endings.CONO:
				$"../ButtonsLayer/EndingsContainer/Cono".visible = true
			ScrPersistentData.Endings.KIRI:
				$"../ButtonsLayer/EndingsContainer/Kiri".visible = true
			ScrPersistentData.Endings.MAGNITUDE:
				$"../ButtonsLayer/EndingsContainer/Magnitude".visible = true
			ScrPersistentData.Endings.JOACO:
				$"../ButtonsLayer/EndingsContainer/Joaco".visible = true
			ScrPersistentData.Endings.BICI:
				$"../ButtonsLayer/EndingsContainer/Bici".visible = true

func _on_cris_pressed():
	if (save_dict["cris"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.CRIS)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("CRIS ENDING", "The Evil Cris")

func _on_ukesito_pressed():
	if (save_dict["ukesito"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.UKESITO)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("REQUENA ENDING", "The Evil Cris")

func _on_yeetus_pressed():
	if (save_dict["yeetus"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.YEETUS)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("YEETUS ENDING", "The Evil Cris")

func _on_cyrus_pressed():
	if (save_dict["cyrus"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.CYRU)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("CYRUS ENDING", "The Evil Cris")

func _on_kimbix_pressed():
	if (save_dict["kimbix"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.KIMBIX)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("KIMBIX ENDING", "The Evil Cris")

func _on_cono_pressed():
	if (save_dict["cono"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.CONO)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("CONO ENDING", "The Evil Cris")

func _on_kiri_pressed():
	if (save_dict["kiri"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.KIRI)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("KIRI ENDING", "The Evil Cris")

func _on_magnitude_pressed():
	if (save_dict["magnitude"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.MAGNITUDE)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("MAGNITUDE ENDING", "The Evil Cris")

func _on_joaco_pressed():
	if (save_dict["joaco"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.JOACO)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("JOACO ENDING", "The Evil Cris")

func _on_bici_pressed():
	if (save_dict["bici"]):
		tbi.queue_dialogue("You feel deja vu", "The Evil Cris")
	save_endings(ScrPersistentData.Endings.BICI)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.queue_dialogue("BICI ENDING", "The Evil Cris")

var save_dict = {}
func load_game():
	if not FileAccess.file_exists("user://endings.json"):
		save_dict = {
			"cris": false,
			"ukesito": false,
			"yeetus": false,
			"cyrus": false,
			"kimbix": false,
			"cono": false,
			"kiri": false,
			"magnitude": false,
			"joaco": false,
			"bici": false
		}
		return
	
	var load_file = FileAccess.open("user://endings.json", FileAccess.READ)
	var json_object = JSON.new()
	
	var json_string = load_file.get_line()
	if (not json_object.parse(json_string) == OK):
		print("JSON PARSE ERROR")
	var data = json_object.get_data()
	save_dict = data
	load_file.close()

func save_endings(ending : ScrPersistentData.Endings):
	load_game()
	var save_game = FileAccess.open("user://endings.json", FileAccess.WRITE)
	match(ending):
		ScrPersistentData.Endings.CRIS:
			save_dict["cris"] = true
		ScrPersistentData.Endings.UKESITO:
			save_dict["ukesito"] = true
		ScrPersistentData.Endings.YEETUS:
			save_dict["yeetus"] = true
		ScrPersistentData.Endings.CYRU:
			save_dict["cyrus"] = true
		ScrPersistentData.Endings.KIMBIX:
			save_dict["kimbix"] = true
		ScrPersistentData.Endings.CONO:
			save_dict["cono"] = true
		ScrPersistentData.Endings.KIRI:
			save_dict["kiri"] = true
		ScrPersistentData.Endings.MAGNITUDE:
			save_dict["magnitude"] = true
		ScrPersistentData.Endings.JOACO:
			save_dict["joaco"] = true
		ScrPersistentData.Endings.BICI:
			save_dict["bici"] = true
	
	var json = JSON.new()
	var json_string = JSON.stringify(save_dict)
	save_game.store_line(json_string)
	save_game.close()
