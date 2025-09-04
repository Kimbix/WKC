extends Node2D

enum Stages {
	CAR,
	TALKING,
	WAIT_PRESSED_ONE,
	WAIT_PRESSED_TWO
}
var current_stage = Stages.CAR
var tbi # Text box instance

## PRELOADS ##
const text_box : PackedScene = preload("res://Text Box/TXT_TextBox.tscn")

const black_background = preload("res://Scenes/Intro Cutscene/BG_black.png")
const car_background = preload("res://Scenes/Main Menu/MainMenu.png")
const mansion_background = preload("res://Scenes/Intro Cutscene/Main.jpg")

const kimbix_serious_speak = preload("res://Characters/Humber/Humber_serious2.png")
const kimbix_serious_no_speak = preload("res://Characters/Humber/Humber_serious1.png")
const kimbix_happy_speak = preload("res://Characters/Humber/Humber_happy2.png")
const kimbix_happy_no_speak = preload("res://Characters/Humber/Humber_happy1.png")

# variables for idiot buttons :P
@onready var buttons_container : VBoxContainer = $"../ButtonsLayer/VBoxContainer"
@onready var unshown_buttons = $"../ButtonsLayer/VBoxContainer/LocationsContainer".get_children().filter(func(object): return object.get_child(0).get_name() not in ["Cono","Cyrus", "Bici", "Chris"])
# making these variables in case i change the tree structure again :(
@onready var cono_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Cono_Control"
@onready var bici_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Bici_Control"
@onready var cesar_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Cesar_Control"
@onready var chris_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Chris_Control"
@onready var clara_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Clara_Control"
@onready var clau_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Clau_Control"
@onready var cyrus_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Cyrus_Control"
@onready var david_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/David_Control"
@onready var felix_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Felix_Control"
@onready var jaques_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Jacques_Control"
@onready var jem_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Jem_Control"
@onready var joaco_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Joaco_Control"
@onready var kiri_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Kiri_Control"
@onready var nigu_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Nigu_Control"
@onready var paris_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Paris_Control"
@onready var pham_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Pham_Control"
@onready var sage_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Sage_Control"
@onready var ukesito_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Ukesito_Control"
@onready var yeetus_control = $"../ButtonsLayer/VBoxContainer/LocationsContainer/Yeetus_Control"
@onready var wait_control = $"../ButtonsLayer/VBoxContainer/Wait_Control"

# Here's all of the arguments because i keep forgetting
# queue_all(text, speaker, char_name, sprite, background, highlight, left):
func _ready():
	tbi = text_box.instantiate()
	add_child(tbi)
	tbi.queue_all(null, null, null, null, car_background, null, null)
	tbi.queue_dialogue("* I stare at the road in front of me *","???")
	tbi.queue_dialogue("* The ride is peaceful as I listen to the 'Risk of Rain 2: Survivors of the Void OST' in the car *","???")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Chris said he had a surprise for us","Humber")
	tbi.queue_dialogue("I wonder what it is","Humber")
	tbi.queue_dialogue("Maybe it's another quiz","Humber")
	tbi.queue_dialogue("Or maybe it's going to be a multiplayer game","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("We'll see","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Looks like im close","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.queue_dialogue("* I pull towards the mansion *","Humber")
	tbi.queue_dialogue("* After honking the car thrice, the gates open for me *","Humber")
	tbi.queue_dialogue("* I park near the entrance of the house and get off *","Humber")
	tbi.queue_dialogue("* Looking at the mansion before me I feel a bit excited for what’s to come *","Humber")
	tbi.queue_all(null, null, null, null, mansion_background, null, null)
	
	tbi.queue_dialogue("* Opening the main door, I see how some have arrived but not all *","Humber")
	tbi.queue_dialogue("* Some are exploring the house and looking at the other rooms *","Humber")
	tbi.queue_dialogue("* I don’t feel like looking at the rooms, Chris has already shown them to me so many times *","Humber")
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Looks like I'm early, maybe I should talk to others to kill time or I could just wait here","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
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
			var dialogue = func():
				tbi.queue_dialogue("Everyone had a wonderful time", "")
				await get_tree().create_timer(3.0).timeout
				tbi.change_state(tbi.State.READY)
				tbi.hide_textbox()
			tbi.fade_black_back_in(wait_dialogue_part_two, dialogue)
			current_stage = Stages.WAIT_PRESSED_TWO
	elif (current_stage == Stages.WAIT_PRESSED_TWO and
		tbi.current_state == tbi.State.READY and
		Input.is_action_just_released("ui_accept")):
			get_tree().change_scene_to_file("res://Scenes/Investigation/SCN_investigation.tscn")

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
	ukesito_control.queue_free()
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
	nigu_control.queue_free()
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
	david_control.queue_free()
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
	paris_control.queue_free()
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
	clau_control.queue_free()
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

const chris_happy_speak = preload("res://Characters/Chris/Chris_happy2.png")
const chris_happy_no_speak = preload("res://Characters/Chris/Chris_happy1.png")
func _on_chris_pressed():
	one_more_button()
	buttons_container.visible = false
	chris_control.queue_free()
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	tbi.sprite_change("Chris",chris_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("hello mestir christin carneflin","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Chris",chris_happy_speak,false)
	tbi.queue_dialogue("hi mr flintin","Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,false)
	
	tbi.queue_dialogue("...","Humber")
	tbi.queue_dialogue("...","Chris")
	tbi.queue_dialogue("...","Humber")
	
	tbi.sprite_change("Chris",chris_happy_speak,false)
	tbi.queue_dialogue("I'm gonna go check on the food mr gimp","Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("Okay","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Chris",null,false)
	tbi.sprite_change("Humber",null,true)

const bici_happy_speak = preload("res://Characters/Bici/Bici_happy2.png")
const bici_happy_no_speak = preload("res://Characters/Bici/Bici_happy1.png")
const bici_serious_speak = preload("res://Characters/Bici/Bici_serious2.png")
const bici_serious_no_speak = preload("res://Characters/Bici/Bici_serious1.png")
func _on_bici_pressed():
	one_more_button()
	buttons_container.visible = false
	bici_control.queue_free()
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
	tbi.queue_dialogue("Chris hasn’t been reading the ones I've been recommending","Bici")
	tbi.sprite_change("Bici",bici_happy_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("What's it about?","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Bici",bici_happy_speak,false)
	tbi.queue_dialogue("Ran wakes up to a giant egg by her bed the morning after being rejected by her longtime crush-","Bici")
	
	tbi.queue_dialogue("I promptly walk away not wanting to hear more","Humber")
	
	tbi.sprite_change("Bici",null,false)
	tbi.sprite_change("Humber",null,true)

const sage_happy_speak = preload("res://Characters/Sage/Sage_happy2.png")
const sage_happy_no_speak = preload("res://Characters/Sage/Sage_happy1.png")
func _on_sage_pressed():
	one_more_button()
	buttons_container.visible = false
	sage_control.queue_free()
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

const joaco_happy_speak = preload("res://Characters/Joaco/Joaco_happy2.png")
const joaco_happy_no_speak = preload("res://Characters/Joaco/Joaco_happy1.png")
func _on_joaco_pressed():
	one_more_button()
	buttons_container.visible = false
	joaco_control.queue_free()
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
	tbi.queue_dialogue("Let me guess, Chris","Joaco")
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
	cyrus_control.queue_free()
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

const jem_happy_speak = preload("res://Characters/Jem/Jem_happy2.png")
const jem_happy_no_speak = preload("res://Characters/Jem/Jem_happy1.png")
const jem_serious_speak = preload("res://Characters/Jem/Jem_serious2.png")
const jem_serious_no_speak = preload("res://Characters/Jem/Jem_serious1.png")
func _on_jem_pressed():
	one_more_button()
	buttons_container.visible = false
	jem_control.queue_free()
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

const felix_happy_speak = preload("res://Characters/Felix/Felix_happy2.png")
const felix_happy_no_speak = preload("res://Characters/Felix/Felix_happy1.png")
func _on_felix_pressed():
	one_more_button()
	buttons_container.visible = false
	felix_control.queue_free()
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

const jacques_happy_speak = preload("res://Characters/Jacques/Jacques_happy2.png")
const jacques_happy_no_speak = preload("res://Characters/Jacques/Jacques_happy1.png")
func _on_jacques_pressed():
	one_more_button()
	buttons_container.visible = false
	jaques_control.queue_free()
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

const cesar_happy_speak = preload("res://Characters/Cesar/Cesar_happy2.png")
const cesar_happy_no_speak = preload("res://Characters/Cesar/Cesar_happy1.png")
func _on_cesar_pressed():
	one_more_button()
	buttons_container.visible = false
	cesar_control.queue_free()
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
	kiri_control.queue_free()
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
	clara_control.queue_free()
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
	yeetus_control.queue_free()
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
	
	tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
	tbi.queue_dialogue(" * I scurry away while Yeetus gives me the side eye * ","Humber")
	
	tbi.sprite_change("Humber",null,true)
	tbi.sprite_change("Yeetus",null,false)

const cono = preload("res://Characters/Cone/Cone_normal.png")
func _on_cono_pressed():
	one_more_button()
	buttons_container.visible = false
	cono_control.queue_free()
	tbi.sprite_change("Cone",cono,false)
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("mr butler fetch me a drink (nestea)","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)

	tbi.sprite_change("Cone",null,false)
	tbi.queue_dialogue(" * leaves and gets a glass of red nestea * ","Cone")
	tbi.sprite_change("Cone",cono,false)
	
	tbi.sprite_change("Humber",kimbix_happy_speak,true)
	tbi.queue_dialogue("thanks for the evil nestea mr orange (derogatory)","Humber")
	tbi.sprite_change("Humber",kimbix_happy_no_speak,true)
	
	tbi.sprite_change("Cone",null,false)
	tbi.sprite_change("Humber",null,true)
	
const pham_happy_speak = preload("res://Characters/Pham/Pham_happy1.png")
const pham_serious_speak = preload("res://Characters/Pham/Pham_serious1.png")
func _on_pham_pressed():
	one_more_button()
	buttons_container.visible = false
	pham_control.queue_free()
	tbi.sprite_change("Pham",pham_happy_speak,false)
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
	wait_control.queue_free()
	buttons_container.queue_free()
	tbi.fade_black_back_in(wait_dialogue_part_one, func(): pass)

var wait_dialogue_part_one = func():
	tbi.queue_dialogue(" * Everyone seems to have arrived * ","Humber")
	
	tbi.sprite_change("Chris",chris_happy_no_speak,true)
	tbi.queue_dialogue("* clings a crystal glass * ","Chris")
	
	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue(" ahem ","Chris")
	tbi.queue_dialogue("The food is almost ready to be served","Chris")
	tbi.queue_dialogue("I've arranged seating for all of you. Come now","Chris")
	tbi.sprite_change("Chris",null,true)
	
	tbi.queue_dialogue(" * I make my way towards the table. There are name tags on the chairs for each person * ","Humber")
	tbi.queue_dialogue(" * I circle around the table to find my seat in between Chris and uke * ","Humber")
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
	
	tbi.queue_dialogue(" * After Cone brings out a final plate for Chris and sets it in front of him * ","Humber")
	
	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.sprite_change("Cone",load("res://Characters/Cone/Cone_normal.png"),false)
	tbi.queue_dialogue("Thank you Cone","Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)
	tbi.queue_dialogue(" * nods *","Cone")
	tbi.queue_dialogue(" * Cone walks back towards the kitchen with the now empty car * ","Humber")
	tbi.sprite_change("Cone",null,false)
	
	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("Thank you all for coming","Chris")
	tbi.queue_dialogue("I hope you all like what our chef has prepared for you","Chris")
	tbi.queue_dialogue("It's everyone's favorite","Chris")
	tbi.sprite_change("Chris",null,true)
	
	pass

var wait_dialogue_part_two = func():
	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("Now that we all ate, I want to show you guys something","Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)
	
	tbi.queue_dialogue(" * We all stand up and follow behind Chris * ","Humber")
	
	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("I've spent a long time working on this so I really hope you all like it","Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)
	
	tbi.queue_dialogue(" * We stand close to the circular rug and Chris motions for us to stay put * ","Humber")
	tbi.queue_dialogue(" * As he walks towards the center of the rug he- ","Humber")
	
	tbi.sprite_change("Chris",null,true)
	tbi.queue_all(null, null, null, null, black_background, null, null)
	tbi.queue_dialogue(" KABLAMO ","")
	tbi.queue_dialogue(" * The lights quickly flicker before shutting off * ","Humber")
	tbi.queue_dialogue(" * We're all blinded by the lack of light and jump at the sudden noise * ","Humber")
	tbi.queue_dialogue("GASP","Bici")
	tbi.queue_dialogue("nojoda","Cyrus")
	tbi.queue_dialogue("Nunca se puede escapar del tercer mundo","Clau")
	tbi.queue_dialogue("Ah it's nothing to worry about, let me get my phone","Chris")
	tbi.queue_dialogue("AAAAAAHHHH","David")
	tbi.queue_dialogue(".   .   .   si ok entiendo","Chris")
	tbi.queue_dialogue("BANG","")
	tbi.queue_dialogue(" * Another loud sound can be heard, but this one felt way closer than the thunder * ","Humber")
	tbi.queue_dialogue(" * An audible thud rings in my ear following the band. * ","Humber")
	tbi.queue_dialogue(" * A few panic and try getting their phones * ","Humber")
	tbi.queue_dialogue(" * Some move towards the walls trying to look for a switch * ","Humber")
	tbi.queue_dialogue(" * My eyes meet a terrifying sight, as I drop my phone some gasp as they notice what it was I saw * ","Humber")
	tbi.queue_all(null, null, null, null, mansion_background, null, null)
	tbi.queue_dialogue(" * The lights come back on and now I can see more clearly what it is now * ","Humber")
	tbi.queue_dialogue(" * Chris's dead body. * ","Humber")
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
	tbi.queue_dialogue(" * Someone in this party just killed Chris... * ","Humber")
	
	tbi.queue_dialogue(" * A while passes and many seem to calm down * ","Humber")
	tbi.queue_dialogue(" * We hear the chiming of the grand clock, 8pm, it reads * ","Humber")
	tbi.queue_dialogue(" * Many remember an old fable they heard as kids * ","Humber")
	tbi.queue_dialogue(" * You must proclaim to a body how it dies so that its spirit may rest in peace * ","Humber")
	tbi.queue_dialogue(" * After 4 hours if nothing is done, the spirit will roam this realm * ","Humber")
	
	tbi.queue_dialogue(" * Those who remember recount the old fable to the other attendees * ","Humber")
	tbi.queue_dialogue(" * Everyone dices to split up to gather clues on the potential killer * ","Humber")
	tbi.queue_dialogue(" * As people go towards other parts of the mansion, I’m left alone in the main entrance. I should go too * ","Humber")
	
	tbi.queue_dialogue(" *  Where to go... * ","Humber")
