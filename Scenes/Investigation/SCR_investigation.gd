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

const mansion_background = preload("res://Scenes/Intro Cutscene/Main.jpg")

func _ready():
	locations_container.visible = false
	tbi = text_box.instantiate()
	add_child(tbi)
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	tbi.queue_dialogue("Where to go...?", "Humber")

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
			var back_mansion = func():
				locations_container.visible = true
			var change_bg = func():
				tbi.queue_all(null, null, null, null, mansion_background, false, false)
			tbi.fade_black_back_in(back_mansion, change_bg)
		State.ENDING:
			get_tree().change_scene_to_file("res://Scenes/Ending/SCN_endings.tscn")

func _on_the_dungeon_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/The Dungeon".queue_free()
	var dungeon_trans = func():
		tbi.queue_all(null, null, null, null, dungeon_background, false, false)
		tbi.queue_dialogue("You went to the dungeon", "")
		await get_tree().create_timer(3.0).timeout
		tbi.change_state(tbi.State.READY)
		tbi.hide_textbox()
	tbi.fade_black_back_in(dungeon_scene, dungeon_trans)

const padding_texture = preload("res://Other Assets/Padding.png")

const kimbix_serious_speak = preload("res://Characters/Humber/Humber_serious2.png")
const kimbix_serious_no_speak = preload("res://Characters/Humber/Humber_serious1.png")
const kimbix_happy_speak = preload("res://Characters/Humber/Humber_happy2.png")
const kimbix_happy_no_speak = preload("res://Characters/Humber/Humber_happy1.png")

const kiri_happy_speak = preload("res://Characters/Kiri/Kiri_happy2.png")
const kiri_happy_no_speak = preload("res://Characters/Kiri/Kiri_happy1.png")
const kiri_serious_speak = preload("res://Characters/Kiri/Kiri_serious2.png")
const kiri_serious_no_speak = preload("res://Characters/Kiri/Kiri_serious1.png")

const cyrus_happy_speak = preload("res://Characters/Cyrus/Cyrus_happy2.png")
const cyrus_happy_no_speak = preload("res://Characters/Cyrus/Cyrus_happy1.png")
const cyrus_serious_speak = preload("res://Characters/Cyrus/Cyrus_serious2.png")
const cyrus_serious_no_speak = preload("res://Characters/Cyrus/Cyrus_serious1.png")

const dungeon_background = preload("res://Scenes/Investigation/Dungeon/Dungeon.jpg")
var dungeon_scene = func():
	tbi.queue_dialogue(" * I walk towards the dungeon * ", "Humber")
	tbi.queue_dialogue(" * Cris would always joke and say to others he had a dungeon in their house, only to laugh at people when they actually saw what it was * ", "Humber")
	tbi.queue_dialogue(" * I enter the dimly lit room, showered with blue light coming from the 3 monitors set up and humming coming from the multiple server racks * ", "Humber")
	tbi.queue_dialogue(" * After that one time cris hosted the minecraft server, it turned into cris hosting just about anything server related * ", "Humber")
	tbi.queue_dialogue(" * I scan the room and I spot... * ", "Humber")
	if (randi_range(0, 1) == 1):
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Looks like I'm all alone", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(". . .", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hello?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("...", "Humber")
		tbi.queue_dialogue("...", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("gartic?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("...", "Humber")
		tbi.queue_dialogue("...", "Humber")
		tbi.queue_dialogue("...", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("just making sure", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * Walking towards the desk I spot the printer and find cris’ gun on the table * ", "Humber")
		tbi.queue_dialogue(" * He said he had it in case the printer started rebelling against him * ", "Humber")
		tbi.queue_dialogue(" * I take a glance at the room to make sure the room really is empty and take the gun, hiding it in the inside of my jacket * ", "Humber")
		tbi.queue_dialogue(" * It’s best if no one else takes the gun * ", "Humber")
		tbi.queue_dialogue(" * I should go to the garage to make sure nothing is missing from there * ", "Humber")
		
		tbi.queue_dialogue("...", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Have I already checked in the garage?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("...", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hmmm...", "Humber")
		tbi.queue_dialogue("I don’t remember if I did. I’ll probably remember if I go back to the main hall", "Humber")
		tbi.queue_dialogue("I’m leaving before anyone else notices the gun is gone", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * I take a final look at the room * ", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Still, no one is there", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * I leave the room without anyone noticing * ", "Humber")
		tbi.queue_dialogue(" * Everyone must be in the other rooms of the mansion * ", "Humber")
		tbi.queue_dialogue("Where to now?", "Humber")
		tbi.sprite_change("Humber",null,true)
	else:
		tbi.queue_dialogue("Kiri and Cyrus", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Kiri",kiri_serious_no_speak,false)
		tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hey", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Kiri",kiri_serious_speak,false)
		tbi.queue_dialogue("Hi", "Kiri")
		tbi.sprite_change("Kiri",kiri_serious_no_speak,false)
		
		tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
		tbi.queue_dialogue("ola", "Cyrus")
		tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Have you guys found anything?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
		tbi.queue_dialogue("I saw cris’ gun is missing, didn’t he keep it next to that printer?", "Cyrus")
		tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("He did, let me check", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * Walking towards the desk I spot the printer and no gun to be seen * ", "Humber")
		tbi.queue_dialogue(" * I inspect the desk and spot Cris had some open tabs before * ", "Humber")
		tbi.queue_dialogue(" * I sit on his chair and go to the link * ", "Humber")
		tbi.queue_dialogue(" * “Custom hyper realistic pinata” it reads. There seems to be a completed order for 9999 pinatas * ", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("huh", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Kiri",kiri_serious_speak,false)
		tbi.queue_dialogue("Why would Cris have a gun?", "Kiri")
		tbi.sprite_change("Kiri",kiri_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("In case the printer rebelled", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Kiri",kiri_serious_speak,false)
		tbi.queue_dialogue("... engineers i swear ...", "Kiri")
		tbi.sprite_change("Kiri",kiri_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Any suspicious people so far?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
		tbi.queue_dialogue("No has been acting kinda strange, he doesn’t speak when spoken to not really", "Cyrus")
		tbi.queue_dialogue("What’s suspicious to me is the way cris died; something doesn’t feel right", "Cyrus")
		tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
		
		tbi.sprite_change("Kiri",kiri_serious_speak,false)
		tbi.queue_dialogue("To be fair he has been under a lot of stress being homeless and all, I dont think it’s him", "Kiri")
		tbi.sprite_change("Kiri",kiri_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Do you guys know where I could find more evidence on them?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
		tbi.queue_dialogue("I think you can find someone who knows in the garden, I saw Cone went there after what happened.", "Cyrus")
		tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
		
		tbi.sprite_change("Kiri",kiri_serious_speak,false)
		tbi.queue_dialogue("I still don’t think it’s cone but you could still go to ask them how they are", "Kiri")
		tbi.sprite_change("Kiri",kiri_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Thanks", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("I leave the room, hoping to find out what Cris did with those piñatas", "Kiri")
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("Kiri",null,false)
		tbi.sprite_change("Cyrus",null,false)
	match (previous_location):
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIRI)
			tbi.queue_dialogue("You previously went to the Kitchen", "")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CRIS)
			tbi.queue_dialogue("You previously went to the Bedroom", "")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIMBIX)
			tbi.queue_dialogue("You previously went to the Garage", "")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CONO)
			tbi.queue_dialogue("You previously went to the Garden", "")
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.DUNGEON

const clara_happy_speak = preload("res://Characters/Clara/Clara_happy2.png")
const clara_happy_no_speak = preload("res://Characters/Clara/Clara_happy1.png")
const clara_serious_speak = preload("res://Characters/Clara/Clara_serious2.png")
const clara_serious_no_speak = preload("res://Characters/Clara/Clara_serious1.png")

const cesar_happy_speak = preload("res://Characters/Cesar/Cesar_happy2.png")
const cesar_happy_no_speak = preload("res://Characters/Cesar/Cesar_happy1.png")
const cesar_serious_speak = preload("res://Characters/Cesar/Cesar_serious2.png")
const cesar_serious_no_speak = preload("res://Characters/Cesar/Cesar_serious1.png")

const felix_serious_speak = preload("res://Characters/Felix/Felix_serious2.png")
const felix_serious_no_speak = preload("res://Characters/Felix/Felix_serious1.png")

const jem_serious_speak = preload("res://Characters/Jem/Jem_serious2.png")
const jem_serious_no_speak = preload("res://Characters/Jem/Jem_serious1.png")

const kitchen_background = preload("res://Scenes/Investigation/Kitchen/SPR-luxury-kitchens-5211364-hero-688d716970544978bc12abdf17ce6f83.jpg")
func _on_kitchen_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Kitchen".queue_free()
	var kitchen_trans = func():
		tbi.queue_all(null, null, null, null, kitchen_background, false, false)
		tbi.queue_dialogue("You went to the kitchen", "")
		await get_tree().create_timer(3.0).timeout
		tbi.change_state(tbi.State.READY)
		tbi.hide_textbox()
	tbi.fade_black_back_in(kitchen_scene, kitchen_trans)

var kitchen_scene = func():
	tbi.queue_dialogue(" * Maybe I should get a snack from the kitchen * ", "Humber")
	tbi.queue_dialogue(" * I'm craving a monster and flips, cris should have some left * ", "Humber")
	tbi.queue_dialogue(" * The kitchen is bathed in blue light. It's surrounded by appliances and a white countertop hugging the wall * ", "Humber")
	tbi.queue_dialogue(" * There is a center aisle with some leftover food * ", "Humber")
	tbi.queue_dialogue(" * Feeling hungry while looking for food, I spot...* ", "Humber")
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("Clara and Cesar", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Clara",clara_serious_no_speak,false)
		tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hey", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Cesar",cesar_serious_speak,false)
		tbi.queue_dialogue("hola soy mujer", "Cesar")
		tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
		
		tbi.sprite_change("Clara",clara_serious_speak,false)
		tbi.queue_dialogue("cesar you can cut it out he’s not watching", "Clara")
		tbi.sprite_change("Clara",clara_serious_no_speak,false)
		
		tbi.sprite_change("Cesar",cesar_serious_speak,false)
		tbi.queue_dialogue(" * sigh * good", "Cesar")
		tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Have you guys found anything?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Cesar",cesar_serious_speak,false)
		tbi.queue_dialogue("Not really, just the food", "Cesar")
		tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
		
		tbi.queue_dialogue("...", "Humber")
		
		tbi.sprite_change("Clara",clara_serious_speak,false)
		tbi.queue_dialogue("yeah, and what might be blood over in that trash can over there", "Clara")
		tbi.sprite_change("Clara",clara_serious_no_speak,false)
		
		tbi.queue_dialogue(" * Clara points towards a bin next to the center aisle * ", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Let me take a look", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * Walking towards the aisle I look down at the trash can Clara was talking about * ", "Humber")
		tbi.queue_dialogue(" * I lean towards it and pick up the lid. Crimson liquid is splattered across the bottom of the bin * ", "Humber")
		tbi.queue_dialogue(" * I spot a chefs’ knife covered in it as well * ", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("What I want to know is who would throw away a perfectly good knife?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Clara",clara_serious_speak,false)
		tbi.queue_dialogue("fail...", "Clara")
		tbi.sprite_change("Clara",clara_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("That one was his favorite :(", "Humber")
		tbi.queue_dialogue("So... have you seen any suspicious people?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Clara",clara_serious_speak,false)
		tbi.queue_dialogue("Not really", "Clara")
		tbi.sprite_change("Clara",clara_serious_no_speak,false)
		
		tbi.sprite_change("Cesar",cesar_serious_speak,false)
		tbi.queue_dialogue("Kiri has been acting kinda weird since she arrived", "Cesar")
		tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
		
		tbi.sprite_change("Clara",clara_serious_speak,false)
		tbi.queue_dialogue("You think so?", "Clara")
		tbi.sprite_change("Clara",clara_serious_no_speak,false)
		
		tbi.sprite_change("Cesar",cesar_serious_speak,false)
		tbi.queue_dialogue("Why would Kiri learn chinese? That's so out of character", "Cesar")
		tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
		
		tbi.sprite_change("Clara",clara_serious_speak,false)
		tbi.queue_dialogue("Maybe she wants to teach english to chinese kids", "Clara")
		tbi.sprite_change("Clara",clara_serious_no_speak,false)
		
		tbi.sprite_change("Cesar",cesar_serious_speak,false)
		tbi.queue_dialogue("Well if anything she doesn't seem to want to talk near me after I told her how suspicious she's acting", "Cesar")
		tbi.queue_dialogue("there could be something of use over in “the dungeon”, I saw Kiri go there", "Cesar")
		tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Thanks guys", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("Clara",null,false)
		tbi.sprite_change("Cesar",null,false)
	else:
		tbi.queue_dialogue("Sofi and Jem", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("Haiii", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Jem",jem_serious_speak,false)
		tbi.queue_dialogue("heyy", "Jem")
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("hello", "Humber")
		tbi.queue_dialogue("What have you been up to", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("Finding evidence against cyrus", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Jem",jem_serious_speak,false)
		tbi.queue_dialogue("No we are not", "Jem")
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Care to elaborate?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Jem",jem_serious_speak,false)
		tbi.queue_dialogue("Please do not entertain that theory further", "Jem")
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("So… I've cyrus look at you a certain way", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("And what way is that?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("murderous intent", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Jem",jem_serious_speak,false)
		tbi.queue_dialogue("that's him normally when looking at humberto", "Jem")
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("but here's the catch…", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Jem",jem_serious_speak,false)
		tbi.queue_dialogue("here we go again", "Jem")
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("cyrus has been following you all over the mansion", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("why would he do that?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("to kill you-", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Jem",jem_serious_speak,false)
		tbi.queue_dialogue("No. It's most likey that Cyrus wants to talk to you but hasn't gotten the chance to.", "Jem")
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Well do you know where he's been?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Felix",felix_serious_speak,false)
		tbi.queue_dialogue("We saw him go in to the kitchen, probably to get a knife and kill you", "Felix")
		tbi.sprite_change("Felix",felix_serious_no_speak,false)
		
		tbi.sprite_change("Jem",jem_serious_speak,false)
		tbi.queue_dialogue("...", "Jem")
		tbi.sprite_change("Jem",jem_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Well thanks, I'll try to ask him about it", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * I bid goodbye and leave the room. Maybe i should make some theories too * ", "Humber")
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("Felix",null,false)
		tbi.sprite_change("Jem",null,false)
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIRI)
			tbi.queue_dialogue("You previously went to the Dungeon", "")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CYRU)
			tbi.queue_dialogue("You previously went to the Bedroom", "")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.MAGNITUDE)
			tbi.queue_dialogue("You previously went to the Garage", "")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.BICI)
			tbi.queue_dialogue("You previously went to the Garden", "")
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.KITCHEN

const bedroom_background = preload("res://Scenes/Investigation/Bedroom/bedroom_background.jpg")
func _on_bedroom_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Bedroom".queue_free()
	var bedroom_trans = func():
		tbi.queue_all(null, null, null, null, bedroom_background, false, false)
		tbi.queue_dialogue("You went to the bedroom", "")
		await get_tree().create_timer(3.0).timeout
		tbi.change_state(tbi.State.READY)
		tbi.hide_textbox()
	tbi.fade_black_back_in(bedroom_scene, bedroom_trans)

const joaco_happy_speak = preload("res://Characters/Joaco/Joaco_happy2.png")
const joaco_happy_no_speak = preload("res://Characters/Joaco/Joaco_happy1.png")
const joaco_serious_speak = preload("res://Characters/Joaco/Joaco_serious2.png")
const joaco_serious_no_speak = preload("res://Characters/Joaco/Joaco_serious1.png")

const nigu_happy_speak = preload("res://Characters/Nigu/Nigu_happy2.png")
const nigu_happy_no_speak = preload("res://Characters/Nigu/Nigu_happy1.png")
const nigu_serious_speak = preload("res://Characters/Nigu/Nigu_serious2.png")
const nigu_serious_no_speak = preload("res://Characters/Nigu/Nigu_serious1.png")

const bici_happy_speak = preload("res://Characters/Bici/Bici_happy2.png")
const bici_happy_no_speak = preload("res://Characters/Bici/Bici_happy1.png")
const bici_serious_speak = preload("res://Characters/Bici/Bici_serious2.png")
const bici_serious_no_speak = preload("res://Characters/Bici/Bici_serious1.png")

const cono = preload("res://Characters/Cone/Cone_normal.png")

var bedroom_scene = func():
	tbi.queue_dialogue(" * A quick nap would help me concentrate more, I know just the place. I walk towards cris’s bedroom * ", "Humber")
	tbi.queue_dialogue(" * His room has a bunch of anime posters, a king sized bed in the center in between two nightstands * ", "Humber")
	tbi.queue_dialogue(" * Cris’s phone is left in one of them * ", "Humber")
	tbi.queue_dialogue(" * I walk towards it and grab his phone. Now if only I can remember what the password was * ", "Humber")
	tbi.queue_dialogue(" * I look around the room and I spot... * ", "Humber")
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("Joaco and Nigu", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Nigu",nigu_serious_no_speak,false)
		tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hey Scott the Woz and Pilgrim", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Nigu",nigu_serious_speak,false)
		tbi.queue_dialogue("si ok entiendo","Nigu")
		tbi.sprite_change("Nigu",nigu_serious_no_speak,false)
		
		tbi.queue_dialogue("...","Joaco")
		
		tbi.sprite_change("Joaco",joaco_serious_speak,false)
		tbi.queue_dialogue("audio place","Joaco")
		tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("yeah the funny audio school", "Humber")
		tbi.queue_dialogue("Have you guys found anything useful?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Nigu",nigu_serious_speak,false)
		tbi.queue_dialogue("Kinda?","Nigu")
		tbi.sprite_change("Nigu",nigu_serious_no_speak,false)
		
		tbi.sprite_change("Joaco",joaco_serious_speak,false)
		tbi.queue_dialogue("I know it's gonna sound crazy, but i think Cris is alive. yeah but he's not here, he's in audioplace.","Joaco")
		tbi.queue_dialogue("Yeah… Cris ascended to audio place and now he's going to be a sound engineer.","Joaco")
		tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
		
		tbi.queue_dialogue(" * Whispering to me * ","Nigu")
		tbi.sprite_change("Nigu",nigu_serious_speak,false)
		tbi.queue_dialogue("Don't listen to him he's lost his sanity","Nigu")
		tbi.sprite_change("Nigu",nigu_serious_no_speak,false)
		
		tbi.sprite_change("Joaco",joaco_serious_speak,false)
		tbi.queue_dialogue("and you wanna know how I know that???","Joaco")
		tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
		
		tbi.queue_dialogue(" * Nods dissaprovingly * ","Nigu")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("how?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.queue_dialogue("Nigu will remember that ","")
		
		tbi.sprite_change("Joaco",joaco_serious_speak,false)
		tbi.queue_dialogue("BECAUSE CRIS BOUGHT GALLONS OF KETCHUP TO GO TO AUDIO PLACE","Joaco")
		tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
		
		tbi.queue_dialogue(" * Whispering to me * ","Nigu")
		tbi.sprite_change("Nigu",nigu_serious_speak,false)
		tbi.queue_dialogue("You should leave before he tries to rip your skin off","Nigu")
		tbi.sprite_change("Nigu",nigu_serious_no_speak,false)
		
		tbi.queue_dialogue(" * I scurry away before joaco can even think of peeling me layer by layer * ","Kimbix")
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("Joaco",null,false)
		tbi.sprite_change("Nigu",null,false)
	else:
		tbi.queue_dialogue("Bici and Cone", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Cone",cono,false)
		tbi.sprite_change("Bici",bici_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hey mr orange and cleta", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
		tbi.sprite_change("Bici",bici_serious_speak,false)
		tbi.queue_dialogue("Hi mr streamer","Bici")
		tbi.sprite_change("Bici",bici_serious_no_speak,false)
		
		tbi.queue_dialogue(" * Waving * ","Cone")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("So whats popping", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
		tbi.queue_dialogue("...?","Bici")
		tbi.queue_dialogue(" * Staring into Bici's soul * ","Cone")
		tbi.queue_dialogue("...","Bici")
		tbi.queue_dialogue(" * Stares back * ","Bici")
		tbi.queue_dialogue("...","Bici")
		
		tbi.sprite_change("Bici",bici_serious_speak,false)
		tbi.queue_dialogue("Oh now I get what he meant by that","Bici")
		tbi.sprite_change("Bici",bici_serious_no_speak,false)
		
		tbi.queue_dialogue("???","Bici")
		
		tbi.sprite_change("Bici",bici_serious_speak,false)
		tbi.queue_dialogue("We found some boxes inside of cris’ closet. They were all labeled as human-sized pin~ata, whatever that means","Bici")
		tbi.sprite_change("Bici",bici_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("How did staring at Cone make you realize what I meant", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Bici",bici_serious_speak,false)
		tbi.queue_dialogue("We’re clones, of course I know what Cone is trying to say by the way he stares at me","Bici")
		tbi.sprite_change("Bici",bici_serious_no_speak,false)

		tbi.queue_dialogue(" * Nodding in agreement * ","Cone")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("So what about those boxes? Was any one of them open?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Bici",bici_serious_speak,false)
		tbi.queue_dialogue("Only one, but it was completely empty. But I also saw some hammer holes in the box","Bici")
		tbi.sprite_change("Bici",bici_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("That’s very specific", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * Shrugs * ","Cone")
		
		tbi.sprite_change("Bici",bici_serious_speak,false)
		tbi.queue_dialogue("I think it was uke who did that, probably wanted to take out his anger before killing cris. Typical Uke.","Bici")
		tbi.sprite_change("Bici",bici_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Do you have any evidence?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * Shrugs * ","Cone")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Aren’t you being ukephobic bici?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Bici",bici_serious_speak,false)
		tbi.queue_dialogue("This time it’s for a good reason","Bici")
		tbi.sprite_change("Bici",bici_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Well okay, thanks for the info", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("Cone",null,false)
		tbi.sprite_change("Bici",null,false)

		tbi.queue_dialogue("As I wave goodbye and leave, cone stares at me menacingly. What’s his problem?", "Humber")

	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CRIS)
			tbi.queue_dialogue("You previously went to the Dungeon", "")
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CYRU)
			tbi.queue_dialogue("You previously went to the Kitchen", "")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.YEETUS)
			tbi.queue_dialogue("You previously went to the Garage", "")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.UKESITO)
			tbi.queue_dialogue("You previously went to the Garden", "")
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.BEDROOM

const garage_background = preload("res://Scenes/Investigation/Garage/061A4059-scaled.jpg")
func _on_garage_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Garage".queue_free()
	var garage_trans = func():
		tbi.queue_all(null, null, null, null, garage_background, false, false)
		tbi.queue_dialogue("You went to the garage", "")
		await get_tree().create_timer(3.0).timeout
		tbi.change_state(tbi.State.READY)
		tbi.hide_textbox()
	tbi.fade_black_back_in(garage_scene, garage_trans)

const david_happy_speak = preload("res://Characters/David/David_happy2.png")
const david_happy_no_speak = preload("res://Characters/David/David_happy1.png")
const david_serious_speak = preload("res://Characters/David/David_serious2.png")
const david_serious_no_speak = preload("res://Characters/David/David_serious1.png")

const paris_happy_speak = preload("res://Characters/Paris/Paris_happy2.png")
const paris_happy_no_speak = preload("res://Characters/Paris/Paris_happy1.png")
const paris_serious_speak = preload("res://Characters/Paris/Paris_serious2.png")
const paris_serious_no_speak = preload("res://Characters/Paris/Paris_serious1.png")

const pham_happy_speak = preload("res://Characters/Pham/Pham_happy1.png")
const pham_serious_speak = preload("res://Characters/Pham/Pham_serious1.png")

var garage_scene = func():
	tbi.queue_dialogue(" * The garage is a good place to go, Cris has many tools there * ", "Humber")
	tbi.queue_dialogue(" * If someone took one that could give me an idea of who did based on what they took * ", "Humber")
	tbi.queue_dialogue(" * As I enter the room my eyes are met with all of the heavy machinery and tools * ", "Humber")
	tbi.queue_dialogue(" * There's a huge wall with all of the hand tools hung on it * ", "Humber")
	tbi.queue_dialogue(" * A few are missing and don't seem to be in the room , but I can't recall which ones are gone * ", "Humber")
	tbi.queue_dialogue(" * I scan the room and I spot... * ", "Humber")
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("David and Paris", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("David",david_serious_no_speak,false)
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hey guys", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Paris",paris_serious_speak,false)
		tbi.queue_dialogue("Hi", "Paris")
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("David™",david_serious_speak,false)
		tbi.queue_dialogue("Hello", "David™")
		tbi.sprite_change("David™",david_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Do you guys have any juicy evidence?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("David™",david_serious_speak,false)
		tbi.queue_dialogue("We found traces of horse food. It has to be the horse", "David™")
		tbi.queue_dialogue("THE HORSE KILLED CRIS", "David™")
		tbi.sprite_change("David™",david_serious_no_speak,false)
		
		tbi.sprite_change("Paris",paris_serious_speak,false)
		tbi.queue_dialogue("David calm down", "Paris")
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("David™",david_serious_speak,false)
		tbi.queue_dialogue("But Paris the horse. Why did we all eat with the horse like if it were just a normal person?", "David™")
		tbi.queue_dialogue("IT'S A HORSE. HORSES ARE MEANT TO BE EATEN", "David™")
		tbi.sprite_change("David™",david_serious_no_speak,false)
		
		tbi.queue_dialogue("...", "Paris")
		tbi.queue_dialogue("...", "Kimbix")
		tbi.queue_dialogue("the others in the room stare at David", "")
		
		tbi.sprite_change("David™",david_serious_speak,false)
		tbi.queue_dialogue("I'M GOING TO KILL YOU HORSE", "David™")
		tbi.sprite_change("David™",david_serious_no_speak,false)
		tbi.queue_dialogue("david runs towards the closet and paris traps him inside", "")
		tbi.sprite_change("David™",null,false)
		
		tbi.sprite_change("Padding™",null,true)
		tbi.queue_dialogue("heeeeeeeelp", "David™")
		tbi.queue_dialogue("heeeeeeeeeeeeeeeeeeeelp", "David™")
		
		tbi.sprite_change("Paris",paris_serious_speak,false)
		tbi.queue_dialogue("I'll let you out once you stop being horsephobic", "Paris")
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("anyway…", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Paris",paris_serious_speak,false)
		tbi.queue_dialogue("yeah we lost him", "Paris")
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("show him some episodes of dragon ball and he should be fine", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Paris",paris_serious_speak,false)
		tbi.queue_dialogue("okay", "Paris")
		tbi.queue_dialogue("I think I spotted the horse doing some weird stuff over in cris’s bedroom", "Paris")
		tbi.queue_dialogue("You could go there", "Paris")
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Thanks for the info and the insane", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Kimbix",null,true)
		tbi.sprite_change("Paris",null,false)
	else:
		tbi.queue_dialogue("Pham", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Pham",pham_serious_speak,false)
		
		tbi.queue_dialogue("Hey Humberto, over here!", "Pham")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hello", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("Have you also noted the ghost that’s roaming around the rooms", "Pham")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("ghost?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("Yeah man, can’t you see it?", "Pham")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Not really, no", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("Man… Maybe I’m the only one that can see it", "Pham")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Has the ghost said anything interesting?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("Just saying how It was deserved. Not sure what though", "Pham")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Have you tried talking to it?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("HEY GHOST", "Pham")
		tbi.queue_dialogue("HEY", "Pham")
		tbi.queue_dialogue("HEY GHOST", "Pham")
		tbi.queue_dialogue("OVER HERE", "Pham")
		tbi.queue_dialogue("NO WAIT", "Pham")
		tbi.queue_dialogue("I DONT WANT TO BOTHER YOU", "Pham")
		tbi.queue_dialogue("I JUST WANT TO ASK QUESTIONS", "Pham")
		tbi.queue_dialogue("NO DONT TRY AND POSSESS MY BODY", "Pham")
		tbi.queue_dialogue("HEEEEEELP", "Pham")
		tbi.sprite_change("Pham",null,false)
		tbi.queue_dialogue(" * Pham runs round in circles * ", "")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("What is going on...", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Pham",pham_serious_speak,false)
		tbi.queue_dialogue("HUMBERTO, I THINK THE SOURCE OF THE GHOST IS IN THE KITCHEN", "Pham")
		tbi.queue_dialogue("I CAN ONLY OUT RUN IT FOR SO LONG", "Pham")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("OKAY, THANKS", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Pham",null,false)
		
		tbi.queue_dialogue(" * I run towards the main hall * ", "Humber")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIMBIX)
			tbi.queue_dialogue("You previously went to the Dungeon", "")
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.MAGNITUDE)
			tbi.queue_dialogue("You previously went to the Kitchen", "")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.YEETUS)
			tbi.queue_dialogue("You previously went to the Bedroom", "")
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.JOACO)
			tbi.queue_dialogue("You previously went to the Garden", "")
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.GARAGE

const garden_background = preload("res://Scenes/Investigation/Garden/beautiful-gardens-in-the-world.jpg")
func _on_garden_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Garden".queue_free()
	var garden_trans = func():
		tbi.queue_all(null, null, null, null, garden_background, false, false)
		tbi.queue_dialogue("You went to the garden", "")
		await get_tree().create_timer(3.0).timeout
		tbi.change_state(tbi.State.READY)
		tbi.hide_textbox()
	tbi.fade_black_back_in(garden_scene, garden_trans)

const uke_happy_speak = preload("res://Characters/Ukesito/Uke_happy2.png")
const uke_happy_no_speak = preload("res://Characters/Ukesito/Uke_happy1.png")
const uke_serious_speak = preload("res://Characters/Ukesito/Uke_serious2.png")
const uke_serious_no_speak = preload("res://Characters/Ukesito/Uke_serious1.png")

const yeetus_happy_speak = preload("res://Characters/Yeetus/Yeetus_happy2.png")
const yeetus_happy_no_speak = preload("res://Characters/Yeetus/Yeetus_happy1.png")
const yeetus_serious_speak = preload("res://Characters/Yeetus/Yeetus_serious2.png")
const yeetus_serious_no_speak = preload("res://Characters/Yeetus/Yeetus_serious1.png")

const jacques_happy_speak = preload("res://Characters/Jacques/Jacques_happy2.png")
const jacques_happy_no_speak = preload("res://Characters/Jacques/Jacques_happy1.png")
const jacques_serious_speak = preload("res://Characters/Jacques/Jacques_serious2.png")
const jacques_serious_no_speak = preload("res://Characters/Jacques/Jacques_serious1.png")

const sage_happy_speak = preload("res://Characters/Sage/Sage_happy2.png")
const sage_happy_no_speak = preload("res://Characters/Sage/Sage_happy1.png")
const sage_serious_speak = preload("res://Characters/Sage/Sage_serious2.png")
const sage_serious_no_speak = preload("res://Characters/Sage/Sage_serious1.png")

var garden_scene = func():
	tbi.queue_dialogue(" * Looking at the flowers in the garden could help me clear my mind. * ", "Humber")
	tbi.queue_dialogue(" * Cris used to have a secret spot in the garden, but Google's satellite view said otherwise. * ", "Humber")
	tbi.queue_dialogue(" * The garden is adorned with a stone pathway and multiple bushes almost twice my size. * ", "Humber")
	tbi.queue_dialogue(" * The grass and hedges are freshly cut. The smell of fresh air makes me feel lively. * ", "Humber")
	tbi.queue_dialogue(" * I look around and I spot... * ", "Humber")
	if (randi_range(0, 1) == 1):
		tbi.queue_dialogue("Uke and Yeetus", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hey", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue("Hi Humberto", "Ukesito")
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hello... horse", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Yeetus",yeetus_serious_speak,false)
		tbi.queue_dialogue("Neigh...", "Yeetus")
		tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue("Humberto the “horse” has a name, Yeetus… Don't be rude…", "Ukesito")
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("okay... so...", "Humber")
		tbi.queue_dialogue("Have you guys found anything of note?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Yeetus",yeetus_serious_speak,false)
		tbi.queue_dialogue("NeiGH PttrrRrR NeiGh PtRRR", "Yeetus")
		tbi.queue_dialogue("NEIGH NE PRrRrtT IGH", "Yeetus")
		tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue("When we found it that was super scary", "Ukesito")
		tbi.queue_dialogue("I can't believe someone is planning to also take out David and Cono", "Ukesito")
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Wait WHAT!?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue("Yeah here you go", "Ukesito")
		tbi.queue_dialogue("We placed it in a ziplock as to not contaminate it", "Ukesito")
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		
		tbi.sprite_change("Yeetus",yeetus_serious_speak,false)
		tbi.queue_dialogue("neigh neGh ptrrr ptr", "Yeetus")
		tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue("Exactly, handle it with care", "Ukesito")
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		
		tbi.queue_dialogue("I am given the zip lock and find it has a list with three names: cris, cono, david", "Humber")
		tbi.queue_dialogue("Cris has multiple lines striked through their name. I give back the ziplock", "Humber")
		tbi.queue_dialogue("This must be someone's. Cris never bought ziplock bags, something about the temptation of filling them with air and then deflating them over and over again.", "Humber")
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue("I'm pretty sure this is bici’s. She's always hating on me, so maybe she lost it.", "Ukesito")
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		
		tbi.sprite_change("Yeetus",yeetus_serious_speak,false)
		tbi.queue_dialogue("NegH PTRR NeGhH", "Yeetus")
		tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue(" I know you're defending her because she gave you food but It doesn't mean she's innocent", "Ukesito")
		tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Do you guys know where I might find more clues?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Yeetus",yeetus_serious_speak,false)
		tbi.queue_dialogue("Ghhh NEUGHBT NEghi", "Yeetus")
		tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("I really have no idea what you're saying", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Yeetus",yeetus_serious_speak,false)
		tbi.queue_dialogue("Yeetus is offended and tail whips you as it leaves", "Yeetus")
		tbi.sprite_change("Yeetus",null,false)
		tbi.sprite_change("Padding",null,true)
		
		tbi.sprite_change("Ukesito",uke_serious_speak,false)
		tbi.queue_dialogue("Wow humberto I can't believe you just said that", "Ukesito")
		tbi.queue_dialogue("Now I'm definitely not telling you that Yeetus said “the Dungeon”", "Ukesito")
		tbi.queue_dialogue("Uke winks at me and jogs away towards Yeetus", "Ukesito")
		tbi.sprite_change("Ukesito",null,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Thanks for the info guys", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * I leave * ", "Humber")
		tbi.sprite_change("Humber",null,true)
		tbi.queue_dialogue("What the fuck was that horse saying", "Humber")
	else:
		tbi.queue_dialogue("I spot Sage and Jac", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Sage",sage_serious_speak,false)
		tbi.queue_dialogue("Hey", "Sage")
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("Hello", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("How have you guys been?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("ahi vamos", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Sage",sage_serious_speak,false)
		tbi.queue_dialogue("Well… apart from the whole dead body situation, we found some clues", "Sage")
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("great, what did you find?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Sage",sage_serious_speak,false)
		tbi.queue_dialogue("What makes you think we'll tell you?", "Sage")
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("You could be the killer for all we know", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Maybe you can ask me a question or I can give you something?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("Questio-", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Sage",sage_serious_speak,false)
		tbi.queue_dialogue("Get me some of that duck fat", "Sage")
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue(".   .   .", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		tbi.queue_dialogue(" * Stares at Sage with a sad expression * ", "Jacques")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Fine I'll get some but you better not leave", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("Sage",null,false)
		tbi.sprite_change("Jacques",null,false)
		
		tbi.queue_dialogue(" * Humberto goes to a duckventure * ", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Padding",padding_texture,true)
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("here", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Sage",sage_happy_speak,false)
		tbi.queue_dialogue("OMG THANK YOUU", "Sage")
		tbi.sprite_change("Sage",sage_happy_no_speak,false)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue(":(", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Sage",sage_happy_speak,false)
		tbi.queue_dialogue(" * Sage drinks all of the duck fat in one go * ", "Sage")
		tbi.sprite_change("Sage",sage_happy_no_speak,false)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("D:", "Kimbix")
		tbi.queue_dialogue("D:", "Jacques")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Sage",sage_serious_speak,false)
		tbi.queue_dialogue("So, Joaco has been acting super weird. Like when he talks sometimes he might say audioplace.", "Sage")
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("It's honestly super weird. He started talking to me about mp3 and saying how audioplace invented it.", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Wasn't mp3 invented before audioplace?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("I don't know, but what I do know is that something is wrong with him", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hmm, well do you know where he's been?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Sage",sage_serious_speak,false)
		tbi.queue_dialogue("That's going to be more duck fat", "Sage")
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue(". . .", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("or a question?", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("I'll take the question", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("Did you do it?", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.queue_dialogue(". . .", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		if (randi_range(0, 10000) == 0): tbi.queue_dialogue("No", "Humber")
		else: tbi.queue_dialogue("Yes", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("...", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_speak,false)
		tbi.queue_dialogue("Okay, I trust you", "Jacques")
		tbi.sprite_change("Jacques",jacques_serious_no_speak,false)
		
		tbi.sprite_change("Sage",sage_serious_speak,false)
		tbi.queue_dialogue("We saw him go into the garage, not sure what he did", "Sage")
		tbi.sprite_change("Sage",sage_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hmm… Thanks for the info, it helps a lot", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("Hmm… Thanks for the info, it helps a lot", "Humber")
		
		tbi.sprite_change("Humber",null,true)
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("Sage",null,false)
		tbi.sprite_change("Jacques",null,false)
		
		tbi.queue_dialogue(" * We say our goodbyes and I head towards the main hall. I hope to never see someone drink a whole liter of fat again * ", "Humber")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CONO)
			tbi.queue_dialogue("You previously went to the Dungeon", "")
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.BICI)
			tbi.queue_dialogue("You previously went to the Kitchen", "")
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.UKESITO)
			tbi.queue_dialogue("You previously went to the Bedroom", "")
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.JOACO)
			tbi.queue_dialogue("You previously went to the Garage", "")
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.GARDEN
