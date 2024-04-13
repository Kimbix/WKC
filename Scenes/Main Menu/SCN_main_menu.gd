extends CanvasLayer

var save_dict = {}

var book_info = []

func _ready():
	save_game()
	for key in save_dict.keys(): 
		match(key):
			"cris": 
				if (save_dict.keys().filter(func(x : String): return (x != "cris" and x != "cono")).any(func(x): return not save_dict[x])): continue
				if (not save_dict["cris"]): book_info.append("Something is not as it seems")
				else: book_info.append("The cris ending: lorem")
			"cono":
				if (save_dict.keys().filter(func(x : String): return (x != "cris" and x != "cono")).any(func(x): return not save_dict[x])): continue
				if (not save_dict["cono"]): book_info.append("The true murderer is still out there")
				else: book_info.append("The cono ending: lorem")
			"ukesito": 
				if (not save_dict["ukesito"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The ukesito ending: lorem")
			"yeetus": 
				if (not save_dict["yeetus"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The yeetus ending: lorem")
			"cyrus": 
				if (not save_dict["cyrus"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The cyrus ending: lorem")
			"kimbix": 
				if (not save_dict["kimbix"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The kimbix ending: lorem")
			"kiri": 
				if (not save_dict["kiri"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The kiri ending: lorem")
			"magnitude": 
				if (not save_dict["magnitude"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The magnitude ending: lorem")
			"joaco": 
				if (not save_dict["joaco"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The joaco ending: lorem")
			"bici": 
				if (not save_dict["bici"]): book_info.append("This ending remains a mystery")
				else: book_info.append("The bici ending: lorem")
	max_pages = book_info.size() / 2
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Letter Opening/SCN_intro_scene.tscn")

func _on_quit_pressed():
	get_tree().quit()

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

func save_game():
	load_game()
	var save_game = FileAccess.open("user://endings.json", FileAccess.WRITE)
	var json = JSON.new()
	var json_string = JSON.stringify(save_dict)
	save_game.store_line(json_string)
	save_game.close()

@onready var book = $Book
func _on_book_pressed():
	book.visible = not book.visible
	update_book()


var current_page : int = 0
var max_pages : int = 0
@onready var left_page : Label = $Book/Panel/MarginContainer/HSplitContainer/Panel/VSplitContainer/LeftLabel
@onready var right_page : Label = $Book/Panel/MarginContainer/HSplitContainer/Panel2/VSplitContainer/RightLabel

func update_book():
	left_page.text = book_info[current_page * 2]
	right_page.text = book_info[(current_page * 2) + 1]

func _on_right_page_pressed():
	current_page = clamp(current_page + 1, 0, max_pages - 1)
	update_book()

func _on_left_page_pressed():
	current_page = clamp(current_page - 1, 0, max_pages - 1)
	update_book()
