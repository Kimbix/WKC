extends Node2D

enum Stages {
	CAR,
	TALKING,
	WAIT_PRESSED_ONE,
	WAIT_PRESSED_TWO
}
var current_stage = Stages.CAR

const text_box : PackedScene = preload("res://Text Box/TXT_TextBox.tscn")
const test_cris = preload("res://Characters/CHR_Cris.tscn")

const black_background : PackedScene = preload("res://Scenes/Intro Cutscene/BG_black.tscn")
const car_background : PackedScene = preload("res://Scenes/Intro Cutscene/BG_car_background.tscn")
const mansion_background : PackedScene = preload("res://Scenes/Intro Cutscene/BG_cris_mansion.tscn")

const kimbix_serious_speak = preload("res://Characters/Humber/Humber_serious2.png")
const kimbix_serious_no_speak = preload("res://Characters/Humber/Humber_serious1.png")
const kimbix_happy_speak = preload("res://Characters/Humber/Humber_happy2.png")
const kimbix_happy_no_speak = preload("res://Characters/Humber/Humber_happy1.png")

var tbi # Text box instance

@onready var buttons_container : VBoxContainer = $"../ButtonsLayer/VBoxContainer"
@onready var unshown_buttons = [
	$"../ButtonsLayer/VBoxContainer/GridContainer/Nigu",
	$"../ButtonsLayer/VBoxContainer/GridContainer/David",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Paris",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Clau",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Sage",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Joaco",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Cyrus",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Jem",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Felix",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Jacques",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Cesar",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Kiri",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Clara",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Yeetus",
	$"../ButtonsLayer/VBoxContainer/GridContainer/Pham"
]

# Here's all of the arguments because i keep forgetting
# queue_all(text, speaker, char_name, sprite, background, highlight, left):
func _ready():
	tbi = text_box.instantiate()
	add_child(tbi)
	tbi.queue_all(null, null, null, null, car_background, null, null)
	tbi.queue_dialogue("* I stare at the road in front of me *","???")
	tbi.queue_dialogue("* The ride is peaceful as I listen to the 'Risk of Rain 2: Survivors of the Void OST' in the car *","???")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Cris said he had a surprise for us","Humber")
	tbi.queue_dialogue("I wonder what it is","Humber")
	tbi.queue_dialogue("Maybe it's another quiz","Humber")
	tbi.queue_dialogue("Or maybe it's going to be a multiplayer game","Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("We'll see","Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Looks like im close","Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("* I pull towards the mansion *","Humber")
	tbi.queue_dialogue("* After honking the car thrice, the gates open for me *","Humber")
	tbi.queue_dialogue("* I park near the entrance of the house and get off *","Humber")
	tbi.queue_dialogue("* Looking at the mansion before me I feel a bit excited for what’s to come *","Humber")
	tbi.queue_all(null, null, null, null, mansion_background, null, null)
	
	tbi.queue_dialogue("* Opening the main door, I see how some have arrived but not all *","Humber")
	tbi.queue_dialogue("* Some are exploring the house and looking at the other rooms *","Humber")
	tbi.queue_dialogue("* I don’t feel like looking at the rooms, Cris has already shown them to me so many times *","Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Looks like I'm early, maybe I should talk to others to kill time or I could just wait here","Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Humber",null,true)

func _input(_event):
	if tbi.disable_input: return
	if (current_stage == Stages.CAR and
		tbi.current_state == tbi.State.READY and
		Input.is_action_just_released("ui_accept")):
		buttons_container.visible = true
		current_stage = Stages.TALKING
	elif (current_stage == Stages.TALKING and
		tbi.current_state == tbi.State.READY and
		Input.is_action_just_released("ui_accept")):
			buttons_container.visible = true
	elif (current_stage == Stages.WAIT_PRESSED_ONE and
		tbi.current_state == tbi.State.READY and
		Input.is_action_just_released("ui_accept")):
			tbi.fade_black_back_in(wait_dialogue_part_two, "Everyone had a wonderful time")
			current_stage = Stages.WAIT_PRESSED_TWO
	elif (current_stage == Stages.WAIT_PRESSED_TWO and
		tbi.current_state == tbi.State.READY and
		Input.is_action_just_released("ui_accept")):
			tbi.fade_black_back_in(wait_dialogue_part_two, "Everyone had a wonderful time")
			get_tree().change_scene_to_file("res://Characters/CHR_Cris.tscn")

func one_more_button():
	if (unshown_buttons.size() == 0): return
	var button = unshown_buttons.pick_random()
	button.visible = true
	unshown_buttons.erase(button)

const uke_happy_speak = preload("res://Characters/Ukesito/Uke_happy2.png")
const uke_happy_no_speak = preload("res://Characters/Ukesito/Uke_happy1.png")
const uke_serious_speak = preload("res://Characters/Ukesito/Uke_serious2.png")
const uke_serious_no_speak = preload("res://Characters/Ukesito/Uke_serious1.png")
func _on_ukesito_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Ukesito".queue_free()
	tbi.sprite_change("Ukesito",uke_happy_speak,false)
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("Hey Humberto, I’m not the last one to arrive right?","Ukesito")
	tbi.sprite_change("Ukesito",uke_happy_no_speak,false)

	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("No no","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Ukesito",uke_happy_speak,false)
	tbi.queue_dialogue("Good good","Ukesito")
	tbi.queue_dialogue("When I saw how many cars were parked outside I thought you were all waiting for me","Ukesito")
	tbi.sprite_change("Ukesito",uke_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("If that were the case they would also be waiting for me too, I arrived just a little before you","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Ukesito",uke_happy_speak,false)
	tbi.queue_dialogue("Haha what a coincidence","Ukesito")
	tbi.queue_dialogue(" * Glances at his phone * ","Ukesito")
	
	tbi.sprite_change("Ukesito",uke_serious_speak,false)
	tbi.queue_dialogue("I need to take care of something real quick","Ukesito")
	tbi.queue_dialogue("I’ll be back before we gather to eat","Ukesito")
	tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("okay","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Ukesito",null,false)
	tbi.sprite_change("Humber",null,true)

const nigu_happy_speak = preload("res://Characters/Nigu/Nigu_happy2.png")
const nigu_happy_no_speak = preload("res://Characters/Nigu/Nigu_happy1.png")
const nigu_serious_speak = preload("res://Characters/Nigu/Nigu_serious2.png")
const nigu_serious_no_speak = preload("res://Characters/Nigu/Nigu_serious1.png")
func _on_nigu_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Nigu".queue_free()
	tbi.sprite_change("Nigu",nigu_happy_no_speak,false)
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.queue_dialogue(":3","Nigu")
	tbi.queue_dialogue(";3","Humber")
	tbi.queue_dialogue(":3","Nigu")
	tbi.queue_dialogue(">:3","Humber")
	tbi.queue_dialogue(":3","Nigu")
	tbi.queue_dialogue("<|:^3","Humber")
	tbi.sprite_change("Nigu",nigu_serious_no_speak,false)
	tbi.queue_dialogue(":(","Nigu")
	tbi.sprite_change("Nigu",null,false)
	tbi.sprite_change("Humber",null,true)

const david_happy_speak = preload("res://Characters/David/David_happy2.png")
const david_happy_no_speak = preload("res://Characters/David/David_happy1.png")
const david_serious_speak = preload("res://Characters/David/David_serious2.png")
const david_serious_no_speak = preload("res://Characters/David/David_serious1.png")
func _on_david_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/David".queue_free()
	tbi.sprite_change("David",david_happy_speak,false)
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("Hi Humberto, is Paris already here?","David")
	tbi.sprite_change("David",david_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("I don’t think so","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("David",david_happy_speak,false)
	tbi.queue_dialogue("Oh, alright","David")
	tbi.sprite_change("David",david_happy_no_speak,false)
	
	tbi.queue_dialogue(". . .","Humber")
	
	tbi.sprite_change("David",david_happy_speak,false)
	tbi.queue_dialogue("Have you heard of this new Javascript frame-","David")
	
	tbi.queue_dialogue("I promptly walk away not wanting to hear more","Humber")
	
	tbi.sprite_change("David",null,false)
	tbi.sprite_change("Humber",null,true)

const paris_happy_speak = preload("res://Characters/Paris/Paris_happy2.png")
const paris_happy_no_speak = preload("res://Characters/Paris/Paris_happy1.png")
func _on_paris_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Paris".queue_free()
	tbi.sprite_change("Paris",paris_happy_speak,false)
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("Hola soy paris, is David already here?","Paris")
	tbi.sprite_change("Paris",paris_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("I don't think so","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Paris",paris_happy_speak,false)
	tbi.queue_dialogue("Oh, alright","Paris")
	tbi.sprite_change("Paris",paris_happy_no_speak,false)
	
	tbi.queue_dialogue(". . .","Humber")
	
	tbi.sprite_change("Paris",paris_happy_speak,false)
	tbi.queue_dialogue("Have you heard of this new linux tool for-","Paris")
	
	tbi.queue_dialogue("I promptly walk away not wanting to hear more","Humber")
	
	tbi.sprite_change("Paris",null,false)
	tbi.sprite_change("Humber",null,true)

const clau_happy_speak = preload("res://Characters/Clau/Clau_happy2.png")
const clau_happy_no_speak = preload("res://Characters/Clau/Clau_happy1.png")
func _on_clau_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Clau".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Clau",clau_happy_speak,false)
	tbi.queue_dialogue("Hola niño feo","Clau")
	tbi.sprite_change("Clau",clau_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hola","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)

	tbi.sprite_change("Clau",clau_happy_speak,false)
	tbi.queue_dialogue("¿Por qué todos aquí están hablando en Inglés?","Clau")
	tbi.sprite_change("Clau",clau_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Nose, pero yo hablaré en el idioma que ellos hablan","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Clau",clau_happy_speak,false)
	tbi.queue_dialogue("Voy a buscar a alguien que hable español aquí.","Clau")
	tbi.sprite_change("Clau",clau_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Puedes hablar con requena","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Clau",clau_happy_speak,false)
	tbi.queue_dialogue("Ahh ya llegó? Entonces haré eso","Clau")
	tbi.queue_dialogue("Chao feo","Clau")
	tbi.sprite_change("Clau",clau_happy_no_speak,false)
	
	tbi.sprite_change("Clau",null,false)
	tbi.sprite_change("Humber",null,true)

const cris_happy_speak = preload("res://Characters/Cris/Cris_happy2.png")
const cris_happy_no_speak = preload("res://Characters/Cris/Cris_happy1.png")
func _on_cris_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Cris".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Cris",cris_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("hello mestir cristin carneflin","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cris",cris_happy_speak,false)
	tbi.queue_dialogue("hi mr flintin","Cris")
	tbi.sprite_change("Cris",cris_happy_no_speak,false)
	
	tbi.queue_dialogue("...","Humber")
	tbi.queue_dialogue("...","Cris")
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Cris",cris_happy_speak,false)
	tbi.queue_dialogue("I'm gonna go check on the food mr gimp","Cris")
	tbi.sprite_change("Cris",cris_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Okay","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cris",null,false)
	tbi.sprite_change("Humber",null,true)

const bici_happy_speak = preload("res://Characters/Bici/Bici_happy2.png")
const bici_happy_no_speak = preload("res://Characters/Bici/Bici_happy1.png")
const bici_serious_speak = preload("res://Characters/Bici/Bici_serious2.png")
const bici_serious_no_speak = preload("res://Characters/Bici/Bici_serious1.png")
func _on_bici_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Bici".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Bici",bici_happy_no_speak,false)
	
	tbi.sprite_change("Bici",bici_happy_speak,false)
	tbi.queue_dialogue("hey mr streamer","Bici")
	tbi.sprite_change("Bici",bici_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("hi bici","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Bici",bici_happy_speak,false)
	tbi.queue_dialogue("I'm still waiting for you to stream","Bici")
	tbi.sprite_change("Bici",bici_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("I know I know, I'll do it one if these days","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Bici",bici_happy_speak,false)
	tbi.queue_dialogue("good, you better keep your promise","Bici")
	tbi.sprite_change("Bici",bici_happy_no_speak,false)
	
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Bici",bici_happy_speak,false)
	tbi.queue_dialogue("By the way you should really read this webtoon","Bici")
	tbi.queue_dialogue("Cris hasn’t been reading the ones I've been recommending","Bici")
	tbi.sprite_change("Bici",bici_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("What's it about?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Bici",bici_happy_speak,false)
	tbi.queue_dialogue("Ran wakes up to a giant egg by her bed the morning after being rejected by her longtime crush-","Bici")
	
	tbi.queue_dialogue("I promptly walk away not wanting to hear more","Humber")
	
	tbi.sprite_change("Bici",null,false)
	tbi.sprite_change("Humber",null,true)

# TODO: Change sage's sprite for the correct one
const sage_happy_speak = preload("res://Characters/Clau/Clau_happy2.png")
const sage_happy_no_speak = preload("res://Characters/Clau/Clau_happy1.png")
func _on_sage_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Sage".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Sage",sage_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("2","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Sage",sage_happy_speak,false)
	tbi.queue_dialogue("Two what?","Sage")
	tbi.sprite_change("Sage",sage_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("2","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Sage",sage_happy_speak,false)
	tbi.queue_dialogue("Two what???","Sage")
	tbi.sprite_change("Sage",sage_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("2","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Sage",sage_happy_speak,false)
	tbi.queue_dialogue("BITCH, TWO WHAT?","Sage")
	tbi.sprite_change("Sage",sage_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("bulbs of onions and heads of garlic","Humber")
	tbi.queue_dialogue("We both have a good laugh but shiver at the thought people actually eat that","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Sage",null,false)
	tbi.sprite_change("Humber",null,true)

# TODO: Change joaco's sprite for the correct one
const joaco_happy_speak = preload("res://Characters/Clau/Clau_happy2.png")
const joaco_happy_no_speak = preload("res://Characters/Clau/Clau_happy1.png")
func _on_joaco_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Joaco".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Joaco",joaco_happy_no_speak,false)
	
	tbi.sprite_change("Joaco",joaco_happy_speak,false)
	tbi.queue_dialogue("Hey guys it’s me Scott the Woz","Joaco")
	tbi.sprite_change("Joaco",joaco_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hi Scott I'm a big fan","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Joaco",joaco_happy_speak,false)
	tbi.queue_dialogue("give me your social security number and bank details","Joaco")
	tbi.sprite_change("Joaco",joaco_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("okay scott","Humber")
	tbi.queue_dialogue("* I reach for my wallet and give him a receipt for 50 almonds *","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Joaco",joaco_happy_speak,false)
	tbi.queue_dialogue("Thank you fan- Wait WHY DID YOU BUY 50 ALMONDS???","Joaco")
	tbi.queue_dialogue("Let me guess, Cris","Joaco")
	tbi.sprite_change("Joaco",joaco_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("yup","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Joaco",null,false)
	tbi.sprite_change("Humber",null,true)

const cyrus_happy_speak = preload("res://Characters/Cyrus/Cyrus_happy2.png")
const cyrus_happy_no_speak = preload("res://Characters/Cyrus/Cyrus_happy1.png")
func _on_cyrus_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Cyrus".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Cyrus",cyrus_happy_no_speak,false)
	
	tbi.sprite_change("Cyrus",cyrus_happy_speak,false)
	tbi.queue_dialogue("Hola humberto","Cyrus")
	tbi.sprite_change("Cyrus",cyrus_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Respondeme en whatsapp","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cyrus",cyrus_happy_speak,false)
	tbi.queue_dialogue("no","Cyrus")
	tbi.sprite_change("Cyrus",cyrus_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Respondeme en whatsapp","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cyrus",cyrus_happy_speak,false)
	tbi.queue_dialogue("ok","Cyrus")
	tbi.sprite_change("Cyrus",cyrus_happy_no_speak,false)
	
	tbi.queue_dialogue("* I grab my phone and message cyrus 'tonto'","Humber")
	
	tbi.sprite_change("Cyrus",cyrus_happy_speak,false)
	tbi.queue_dialogue("gafo","Cyrus")
	tbi.sprite_change("Cyrus",cyrus_happy_no_speak,false)
	
	tbi.sprite_change("Cyrus",null,false)
	tbi.sprite_change("Humber",null,true)

# TODO: Change jem's sprite for the correct one
const jem_happy_speak = preload("res://Characters/Clau/Clau_happy2.png")
const jem_happy_no_speak = preload("res://Characters/Clau/Clau_happy1.png")
const jem_serious_speak = preload("res://Characters/Clau/Clau_serious2.png")
const jem_serious_no_speak = preload("res://Characters/Clau/Clau_serious1.png")
func _on_jem_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Jem".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Jem",jem_happy_no_speak,false)
	
	tbi.sprite_change("Jem",jem_happy_speak,false)
	tbi.queue_dialogue("Hey Humberto","Jem")
	tbi.sprite_change("Jem",jem_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hey, how are you?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jem",jem_happy_speak,false)
	tbi.queue_dialogue("good, though I don’t know most of the people here","Jem")
	tbi.sprite_change("Jem",jem_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("I can tell you everyone's names","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.queue_dialogue("* I show Jem who’s who and we even have small talk with some people *","Humber")
	
	tbi.sprite_change("Jem",jem_happy_speak,false)
	tbi.queue_dialogue("those are a lot of names","Jem")
	tbi.sprite_change("Jem",jem_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("If you forget any you can come to me","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jem",jem_happy_speak,false)
	tbi.queue_dialogue("Thanks","Jem")
	tbi.sprite_change("Jem",jem_happy_no_speak,false)
	
	tbi.sprite_change("Jem",null,false)
	tbi.sprite_change("Humber",null,true)

# TODO: Change felix's sprite for the correct one
const felix_happy_speak = preload("res://Characters/Clau/Clau_happy2.png")
const felix_happy_no_speak = preload("res://Characters/Clau/Clau_happy1.png")
func _on_felix_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Felix".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Felix",felix_happy_no_speak,false)
	
	tbi.sprite_change("Felix",felix_happy_speak,false)
	tbi.queue_dialogue("Hiiiiiii","Felix")
	tbi.sprite_change("Felix",felix_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hiiiiiii","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Felix",felix_happy_speak,false)
	tbi.queue_dialogue("Haiuiii","Felix")
	tbi.sprite_change("Felix",felix_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Haiuiii","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Felix",felix_happy_speak,false)
	tbi.queue_dialogue("Hewooo","Felix")
	tbi.sprite_change("Felix",felix_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hewooo","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Felix",felix_happy_speak,false)
	tbi.queue_dialogue("okay enough","Felix")
	tbi.sprite_change("Felix",felix_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("yeah","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Felix",null,false)
	tbi.sprite_change("Humber",null,true)

# TODO: Change jacques's sprite for the correct one
const jacques_happy_speak = preload("res://Characters/Clau/Clau_happy2.png")
const jacques_happy_no_speak = preload("res://Characters/Clau/Clau_happy1.png")
func _on_jacques_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Jacques".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Jacques",jacques_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hi","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jacques",jacques_happy_speak,false)
	tbi.queue_dialogue("que?","Jacques")
	tbi.sprite_change("Jacques",jacques_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("so","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jacques",jacques_happy_speak,false)
	tbi.queue_dialogue("Parmesano","Jacques")
	tbi.sprite_change("Jacques",jacques_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Pecorino","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jacques",jacques_happy_speak,false)
	tbi.queue_dialogue("Cheddar","Jacques")
	tbi.sprite_change("Jacques",jacques_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Feta","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jacques",jacques_happy_speak,false)
	tbi.queue_dialogue("Brie","Jacques")
	tbi.sprite_change("Jacques",jacques_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Camembert","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jacques",jacques_happy_speak,false)
	tbi.queue_dialogue("Ricotta","Jacques")
	tbi.sprite_change("Jacques",jacques_happy_no_speak,false)
	
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Jacques",jacques_happy_speak,false)
	tbi.queue_dialogue("HA, I win!","Jacques")
	tbi.sprite_change("Jacques",jacques_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Well played","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Jacques",null,false)
	tbi.sprite_change("Humber",null,true)

# TODO: Change cesar's sprite for the correct one
const cesar_happy_speak = preload("res://Characters/Clau/Clau_happy2.png")
const cesar_happy_no_speak = preload("res://Characters/Clau/Clau_happy1.png")
func _on_cesar_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Cesar".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Cesar",cesar_happy_no_speak,false)
	
	tbi.sprite_change("Cesar",cesar_happy_speak,false)
	tbi.queue_dialogue("hola soy mujer","Cesar")
	tbi.sprite_change("Cesar",cesar_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hola mujer","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cesar",cesar_happy_speak,false)
	tbi.queue_dialogue("hola soy mujer","Cesar")
	tbi.sprite_change("Cesar",cesar_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("hola","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cesar",cesar_happy_speak,false)
	tbi.queue_dialogue("hola soy mujer","Cesar")
	tbi.sprite_change("Cesar",cesar_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("...","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cesar",cesar_happy_speak,false)
	tbi.queue_dialogue("hola soy mujer","Cesar")
	tbi.sprite_change("Cesar",cesar_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Are you ok?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cesar",cesar_happy_speak,false)
	tbi.queue_dialogue("No I'm not","Cesar")
	tbi.queue_dialogue("I have to keep up with this stupid fucking joke or else I’ll be beaten","Cesar")
	tbi.queue_dialogue("My self has been reduced to a mere phrase I must repeat over and over","Cesar")
	tbi.queue_dialogue("I have been ridden of my free will against my wishes","Cesar")
	tbi.queue_dialogue("Please set me free","Cesar")
	tbi.sprite_change("Cesar",cesar_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Holy shit...","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cesar",cesar_happy_speak,false)
	tbi.queue_dialogue("hola soy mujer","Cesar")
	tbi.sprite_change("Cesar",cesar_happy_no_speak,false)
	
	tbi.sprite_change("Cesar",null,false)
	tbi.sprite_change("Humber",null,true)

const kiri_happy_speak = preload("res://Characters/Kiri/Kiri_happy2.png")
const kiri_happy_no_speak = preload("res://Characters/Kiri/Kiri_happy1.png")
const kiri_serious_speak = preload("res://Characters/Kiri/Kiri_serious2.png")
const kiri_serious_no_speak = preload("res://Characters/Kiri/Kiri_serious1.png")
func _on_kiri_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Kiri".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Kiri",kiri_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hey Kiri","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Kiri",kiri_happy_speak,false)
	tbi.queue_dialogue("好久不见，你好吗?","Kiri")
	tbi.sprite_change("Kiri",kiri_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Uhhh... good and you?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Kiri",kiri_happy_speak,false)
	tbi.queue_dialogue("我已经很好了，谢谢你的询问。 努力工作","Kiri")
	tbi.sprite_change("Kiri",kiri_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Kiri, I have no idea what you just said","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Kiri",kiri_happy_speak,false)
	tbi.queue_dialogue("sorry, I'm learning chinese","Kiri")
	tbi.sprite_change("Kiri",kiri_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("I can see that","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Kiri",kiri_happy_speak,false)
	tbi.queue_dialogue("I’ll go read my book now, 再见","Kiri")
	tbi.sprite_change("Kiri",kiri_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("bye?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.queue_dialogue("* I caught a glimpse of the book. “Dictionary English to Chinese” it reads *","Humber")
	
	tbi.sprite_change("Kiri",null,false)
	tbi.sprite_change("Humber",null,true)

const clara_happy_speak = preload("res://Characters/Clara/Clara_happy2.png")
const clara_happy_no_speak = preload("res://Characters/Clara/Clara_happy1.png")
const clara_serious_speak = preload("res://Characters/Clara/Clara_serious2.png")
const clara_serious_no_speak = preload("res://Characters/Clara/Clara_serious1.png")
func _on_clara_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Clara".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Clara",clara_happy_no_speak,false)
	
	tbi.sprite_change("Clara",clara_happy_speak,false)
	tbi.queue_dialogue("Antiphospholipid syndrome","Clara")
	tbi.queue_dialogue("Shoulder dystocia","Clara")
	tbi.queue_dialogue("Diastole","Clara")
	tbi.queue_dialogue("Abscess","Clara")
	tbi.queue_dialogue("Velamentous cord insertion","Clara")
	tbi.queue_dialogue("Ah sorry, just studying for my exam","Clara")
	tbi.sprite_change("Clara",clara_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Medicine much?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Clara",clara_happy_speak,false)
	tbi.queue_dialogue("Yep, gotta get my paramedic PHD","Clara")
	tbi.sprite_change("Clara",clara_happy_no_speak,false)
	
	tbi.queue_dialogue("* abcess...? *","Humber")
	
	tbi.sprite_change("Clara",null,false)
	tbi.sprite_change("Humber",null,true)

const yeetus_happy_speak = preload("res://Characters/Yeetus/Yeetus_happy2.png")
const yeetus_happy_no_speak = preload("res://Characters/Yeetus/Yeetus_happy1.png")
const yeetus_serious_speak = preload("res://Characters/Yeetus/Yeetus_serious2.png")
const yeetus_serious_no_speak = preload("res://Characters/Yeetus/Yeetus_serious1.png")
func _on_yeetus_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Yeetus".queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Yeetus",yeetus_happy_speak,false)
	tbi.queue_dialogue("NEIGH NEIGH PTRRR","Yeetus")
	tbi.sprite_change("Yeetus",yeetus_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("What?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Yeetus",yeetus_happy_speak,false)
	tbi.queue_dialogue("NEIGH NEIGH NEIGH","Yeetus")
	tbi.sprite_change("Yeetus",yeetus_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("I'm gonna leave now","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue(" * I scurry away while Yeetus gives me the side eye * ","Humber")
	
	tbi.sprite_change("Humber",null,true)
	tbi.sprite_change("Yeetus",null,false)

const pham_happy_speak = preload("res://Characters/Pham/Pham_happy1.png")
const pham_serious_speak = preload("res://Characters/Pham/Pham_serious1.png")
func _on_pham_pressed():
	one_more_button()
	buttons_container.visible = false
	$"../ButtonsLayer/VBoxContainer/GridContainer/Pham".queue_free()
	tbi.sprite_change("Pham",pham_serious_speak,false)
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("Hi Humberto!","Pham")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Hello. Uh, why are you a squid?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("Oh yeah an evil wizard turned me into this form after an epic battle","Pham")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("???","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("I’m just messing with you, I just didn’t want to turn into my human form","Pham")
	tbi.queue_dialogue("The only suit I have was dirty from the last time I used it","Pham")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("You mean to tell me, you can turn into a squid at will","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("YES EXACTLY","Pham")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Can you teach me?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("Sure, if I knew how","Pham")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.queue_dialogue(":(","Humber")
	
	tbi.sprite_change("Humber",null,true)
	tbi.sprite_change("Pham",null,false)

func _on_wait_pressed():
	current_stage = Stages.WAIT_PRESSED_ONE
	$"../ButtonsLayer/VBoxContainer/Wait".queue_free()
	$"../ButtonsLayer/VBoxContainer/GridContainer".queue_free()
	tbi.fade_black_back_in(wait_dialogue_part_one, "")

var wait_dialogue_part_one = func():
	tbi.queue_dialogue(" * Everyone seems to have arrived * ","Humber")
	
	tbi.sprite_change("Cris",cris_happy_no_speak,true)
	tbi.queue_dialogue("* clings a crystal glass * ","Cris")
	
	tbi.sprite_change("Cris",cris_happy_speak,true)
	tbi.queue_dialogue(" ahem ","Cris")
	tbi.queue_dialogue("The food is almost ready to be served","Cris")
	tbi.queue_dialogue("I've arranged seating for all of you. Come now","Cris")
	tbi.sprite_change("Cris",null,true)
	
	tbi.queue_dialogue(" * I make my way towards the table. There are name tags on the chairs for each person * ","Humber")
	tbi.queue_dialogue(" * I circle around the table to find my seat in between cris and uke * ","Humber")
	tbi.queue_dialogue(" * Cone brings out a cart with multiple plates all labeled and starts placing them on the table * ","Humber")
	
	tbi.sprite_change("Ukesito",uke_happy_speak,true)
	tbi.queue_dialogue("Wow! This looks delicious, thanks!","Ukesito")
	tbi.sprite_change("Ukesito",null,true)
	
	tbi.sprite_change("Nigu",nigu_happy_speak,true)
	tbi.queue_dialogue(":3","Nigu")
	tbi.sprite_change("Nigu",null,true)
	
	tbi.sprite_change("Sage",sage_happy_speak,true)
	tbi.queue_dialogue("Holy shit is that the 2l of duck fat that went missing?","Sage")
	tbi.sprite_change("Sage",null,true)
	
	tbi.queue_dialogue(" * After Cone brings out a final plate for Cris and sets it in front of him * ","Humber")
	
	tbi.sprite_change("Cris",cris_happy_speak,true)
	tbi.sprite_change("Cone",test_cris,false) # TODO: Change cono here
	tbi.queue_dialogue("Thank you Cone","Cris")
	tbi.sprite_change("Cris",cris_happy_no_speak,true)
	tbi.queue_dialogue(" * nods *","Cone")
	tbi.queue_dialogue(" * Cono walks back towards the kitchen with the now empty car * ","Humber")
	tbi.sprite_change("Cone",null,false)
	
	tbi.sprite_change("Cris",cris_happy_speak,true)
	tbi.queue_dialogue("Thank you all for coming","Cris")
	tbi.queue_dialogue("I hope you all like what our chef has prepared for you","Cris")
	tbi.queue_dialogue("It's everyone's favorite","Cris")
	tbi.sprite_change("Cris",null,true)
	
	pass

var wait_dialogue_part_two = func():
	tbi.sprite_change("Cris",cris_happy_speak,true)
	tbi.queue_dialogue("Now that we all ate, I want to show you guys something","Cris")
	tbi.sprite_change("Cris",cris_happy_no_speak,true)
	
	tbi.queue_dialogue(" * We all stand up and follow behind cris * ","Humber")
	
	tbi.sprite_change("Cris",cris_happy_speak,true)
	tbi.queue_dialogue("I've spent a long time working on this so I really hope you all like it","Cris")
	tbi.sprite_change("Cris",cris_happy_no_speak,true)
	
	tbi.queue_dialogue(" * We stand close to the circular rug and cris motions for us to stay put * ","Humber")
	tbi.queue_dialogue(" * As he walks towards the center of the rug he- ","Humber")
	
	tbi.sprite_change("Cris",null,true)
	tbi.queue_all(null, null, null, null, black_background, null, null)
	tbi.queue_dialogue(" KABLAMO ","")
	tbi.queue_dialogue(" * The lights quickly flicker before shutting off * ","Humber")
	tbi.queue_dialogue(" * We're all blinded by the lack of light and jump at the sudden noise * ","Humber")
	tbi.queue_dialogue("GASP","Bici")
	tbi.queue_dialogue("nojoda","Cyrus")
	tbi.queue_dialogue("Nunca se puede escapar del tercer mundo","Clau")
	tbi.queue_dialogue("Ah it's nothing to worry about, let me get my phone","Cris")
	tbi.queue_dialogue("AAAAAAHHHH","David")
	tbi.queue_dialogue(".   .   .   si ok entiendo","Cris")
	tbi.queue_dialogue("BANG","")
	tbi.queue_dialogue(" * Another loud sound can be heard, but this one felt way closer than the thunder * ","Humber")
	tbi.queue_dialogue(" * An audible thud rings in my ear following the band. * ","Humber")
	tbi.queue_dialogue(" * A few panic and try getting their phones * ","Humber")
	tbi.queue_dialogue(" * Some move towards the walls trying to look for a switch * ","Humber")
	tbi.queue_dialogue(" * My eyes meet a terrifying sight, as I drop my phone some gasp as they notice what it was I saw * ","Humber")
	tbi.queue_all(null, null, null, null, mansion_background, null, null)
	tbi.queue_dialogue(" * The lights come back on and now I can see more clearly what it is now * ","Humber")
	tbi.queue_dialogue(" * Cris's dead body. * ","Humber")
	tbi.queue_dialogue(" * Their body is face down with blood slowly oozing out from their torso * ","Humber")
	
	tbi.sprite_change("David",david_serious_speak,true)
	tbi.queue_dialogue("AAAAAAHHHH","David")
	tbi.sprite_change("David",david_serious_no_speak,true)
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("Oh my god","Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("David",null,true)
	tbi.sprite_change("Kiri",kiri_serious_speak,true)
	tbi.queue_dialogue(" * Holding hand against mouth * I'm gonna puke","Kiri")
	tbi.sprite_change("Kiri",kiri_serious_no_speak,true)
	
	tbi.sprite_change("Bici",null,false)
	tbi.sprite_change("Clara",clara_serious_speak,false)
	tbi.queue_dialogue("I have to check if they're alive","Clara")
	tbi.sprite_change("Clara",clara_serious_no_speak,false)
	
	tbi.sprite_change("Kiri",null,true)
	tbi.sprite_change("Jem",jem_serious_speak,true)
	tbi.queue_dialogue("He’s clearly dead! Look at the amount of blood","Jem")
	tbi.sprite_change("Jem",jem_serious_no_speak,true)
	
	tbi.sprite_change("Clara",null,false)
	tbi.sprite_change("Jem",null,true)
	
	tbi.queue_dialogue(" * I can only stare at what was once a living person * ","Humber")
	tbi.queue_dialogue(" * Many start to argue over if we should check the body * ","Humber")
	tbi.queue_dialogue(" * Despite everything I think we all thought the same thing * ","Humber")
	tbi.queue_dialogue(" * Someone in this party just killed Cris... * ","Humber")
	
	tbi.queue_dialogue(" * A while passes and many seem to calm down * ","Humber")
	tbi.queue_dialogue(" * We hear the chiming of the grand clock, 8pm, it reads * ","Humber")
	tbi.queue_dialogue(" * Many remember an old fable they heard as kids * ","Humber")
	tbi.queue_dialogue(" * You must proclaim to a body how it dies so that its spirit may rest in peace * ","Humber")
	tbi.queue_dialogue(" * After 4 hours if nothing is done, the spirit will roam this realm * ","Humber")
	
	tbi.queue_dialogue(" * Those who remember recount the old fable to the other attendees * ","Humber")
	tbi.queue_dialogue(" * Everyone dices to split up to gather clues on the potential killer * ","Humber")
	tbi.queue_dialogue(" * As people go towards other parts of the mansion, I’m left alone in the main entrance. I should go too * ","Humber")
	
	tbi.queue_dialogue(" *  Where to go... * ","Humber")
	
