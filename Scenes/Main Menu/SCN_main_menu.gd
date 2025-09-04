extends CanvasLayer

var save_dict = {}
var book_info = []

var current_page : int = 0
var max_pages : int = 0

func _ready():
	save_game()
	for key in save_dict.keys(): 
		match(key):
			"chris": 
				if (save_dict.keys().filter(func(x : String): return (x != "chris" and x != "cono")).any(func(x): return not save_dict[x])): continue
				if (not save_dict["chris"]): book_info.append("Something is not as it seems")
				else: book_info.append(
				"True Ending: Chris
				
				The Dungeon + Bedroom
				
				Thanks for playing the game :) This was made in a month for my 20th birthday. It was later polished and debugged
				Fun fact: there's a secret ending you can only get if you dont have 8+ endings ")
			"cono":
				if (save_dict.keys().filter(func(x : String): return (x != "chris" and x != "cono")).any(func(x): return not save_dict[x])): continue
				if (not save_dict["cono"]): book_info.append("The true murderer is still out there")
				else: book_info.append(
					"Evil Ending: Cone
					
					The Dungeon + Garden
					
					Deltarune Chapter 2 inspired the fight against Cone.
					You might have noticed Cone's name being written as either Cono or Cone. This was not intentional
					")
			"ukesito": 
				if (not save_dict["ukesito"]): book_info.append("This ending remains a mystery")
				else: book_info.append(
					"Admin Ending: Ukesito
					
					Garden + Bedroom
					
					Apart from Chris, Uke is the only character that knows how to speak horse. 
					")
			"yeetus": 
				if (not save_dict["yeetus"]): book_info.append("This ending remains a horsey mystery")
				else: book_info.append(
				"Freedom Ending: Yeetus
				
				Bedroom + Kitchen
				
				The original ending had yeetus being forced to be the shadow admin of walter via a contract. It ended up being changed as a funny way to show what happens when you don't do your part in a group proyect.
				")
			"cyrus": 
				if (not save_dict["cyrus"]): book_info.append("This ending remains a mystery...")
				else: book_info.append(
				"Jealousy Ending: Cyrus
				
				Bedroom + Kitchen
				
				Cyrus killing Chris with a plate is a reference to Cyrus hitting Chris with a plate IRL. No hate to Cyrus, I deserved it that day :P
				")
			"kimbix": 
				if (not save_dict["kimbix"]): book_info.append("This ending is not one of us")
				else: book_info.append(
				"Imposter Ending: Kimbix
				
				The Dungeon + Garage
				
				While it's never outright said, Kimbix's motivation was due to Chris gambling away all of their money on tf2 crates. Now how are we going to feed baby Jededaiah?
				")
			"kiri": 
				if (not save_dict["kiri"]): book_info.append("This ending remains a 腥 mystery")
				else: book_info.append(
				"小红书 Ending: Kiri
				
				The Dungeon + Kitchen
				
				Kiri becomes obssessed with killing Chris when instead of using her pronouns, he jokingly says 鱼/钓鱼. She took up the opportunity to learn Chinese. To this day, she still doesn't know what that means...
				")
			"magnitude": 
				if (not save_dict["magnitude"]): book_info.append("This ending remains a real mystery")
				else: book_info.append(
				"Purgatory Ending: Magnitude
				
				Garage + Kitchen
				
				We actually have no idea who Magnitude really is. In his original ending, he's sent to a purgatory where he is constantly summoned and sent back. This ended up getting cut to make the ending flow better.
				")
			"joaco": 
				if (not save_dict["joaco"]): book_info.append("This ending remains an audio mystery")
				else: book_info.append(
				"Audio Place Ending: Joaco
				
				Garage + Garden
				
				Audio place is real and will hurt you no matter what
				")
			"bici": 
				if (not save_dict["bici"]): book_info.append("Use 7 coins or watch an ad to unlock the ending")
				else: book_info.append(
				"Eggnoid Ending: Bici
				
				Garden + Kitchen
				
				Bici has made me read so many webcomics it's crazy. They are incredible tho, except when I catch up and now have to wait weekly for new episodes. RAAAAAAGGGHHHHHH
				")
	max_pages = book_info.size()

func load_game():
	if not FileAccess.file_exists("user://endings.json"):
		save_dict = {
			"chris": false,
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
	update_tablet()

@onready var title: Label = $Book/Panel/TextureRect/MarginContainer/Panel/VSplitContainer/VSplitContainer/Title
@onready var information: Label = $Book/Panel/TextureRect/MarginContainer/Panel/VSplitContainer/VSplitContainer/Information

func update_tablet():
	information.text = book_info[current_page]

func _on_right_page_pressed():
	current_page = clamp(current_page + 1, 0, max_pages - 1)
	update_tablet()

func _on_left_page_pressed():
	current_page = clamp(current_page - 1, 0, max_pages - 1)
	update_tablet()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Letter Opening/SCN_intro_scene.tscn")

func _on_endings_button_pressed() -> void:
	book.visible = not book.visible
	update_tablet()

func _on_credits_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
