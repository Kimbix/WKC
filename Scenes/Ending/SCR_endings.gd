extends Node2D

## Navigation bar, use the Ctrl + F function to look for these anchors
# NO IDEA ENDING

var save_dict = {}

const mansion_background = preload("uid://dk5f72ug8nyhp")
const black_background = preload("uid://bsx33dhpcodp0")

enum State {
	START,
	SEEING_ENDING,
	CONO_ENDING
}
var current_state : State = State.START

@onready var endings_buttons : GridContainer = $"../ButtonsLayer/EndingsContainer"
# idiot buttons
@onready var bici_control = $"../ButtonsLayer/EndingsContainer/Bici_Control"
@onready var chris_control = $"../ButtonsLayer/EndingsContainer/Chris_Control"
@onready var cono_control = $"../ButtonsLayer/EndingsContainer/Cono_Control"
@onready var cyrus_control = $"../ButtonsLayer/EndingsContainer/Cyrus_Control"
@onready var joaco_control = $"../ButtonsLayer/EndingsContainer/Joaco_Control"
@onready var kiri_control = $"../ButtonsLayer/EndingsContainer/Kiri_Control"
@onready var none_control = $"../ButtonsLayer/EndingsContainer/NoOne_Control"
@onready var kimbix_control = $"../ButtonsLayer/EndingsContainer/Kimbix_Control"
@onready var yeetus_control = $"../ButtonsLayer/EndingsContainer/Yeetus_Control"
@onready var ukesito_control = $"../ButtonsLayer/EndingsContainer/Ukesito_Control"
@onready var magnitude_control = $"../ButtonsLayer/EndingsContainer/Magnitude_Control"

const text_box : PackedScene = preload("res://Text Box/TXT_TextBox.tscn")
var tbi

func _ready():
	load_game()
	endings_buttons.visible = false
	tbi = text_box.instantiate()
	add_child(tbi)
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	tbi.queue_dialogue("Who's to blame...?", "Humber")

func _input(_event):
	if tbi.disable_input: return
	if (not Input.is_action_just_released("ui_accept")): return
	if (not tbi.current_state == tbi.State.READY): return
	
	match(current_state):
		State.START:
			show_buttons()
			endings_buttons.visible = true
			var cant_figure = true
			for button in endings_buttons.get_children():
				print(button.visible)
				if button.visible: cant_figure = false
			if cant_figure:
				endings_buttons.visible = true
		State.SEEING_ENDING:
			get_tree().change_scene_to_file("res://Scenes/Main Menu/SCN_main_menu.tscn")
		State.CONO_ENDING:
			var exit_func = func():
				tbi.sprite_change("Cone",null,false)
				tbi.sprite_change("Kimbix",null,true)
				tbi.queue_all(null, null, null, null, black_background, false, false)
			tbi.fade_black_back_in(func(): get_tree().change_scene_to_file("res://SCN_punch_mother_fucking_out.tscn"), exit_func)

func show_buttons():
	for ending in ScrPersistentData.possible_endings:
		match(ending):
			ScrPersistentData.Endings.CHRIS:
				var show_button = true
				for key in save_dict:
					if (key == "chris"): continue
					if (!save_dict[key]): show_button = false
				chris_control.visible = show_button
			ScrPersistentData.Endings.UKESITO:
				ukesito_control.visible = true
			ScrPersistentData.Endings.YEETUS:
				yeetus_control.visible = true
			ScrPersistentData.Endings.CYRU:
				cyrus_control.visible = true
			ScrPersistentData.Endings.KIMBIX:
				kimbix_control.visible = true
			ScrPersistentData.Endings.CONO:
				var show_button = true
				for key in save_dict:
					if (key == "cono" or key == "chris"): continue
					if (!save_dict[key]): show_button = false
				cono_control.visible = show_button
			ScrPersistentData.Endings.KIRI:
				kiri_control.visible = true
			ScrPersistentData.Endings.MAGNITUDE:
				magnitude_control.visible = true
			ScrPersistentData.Endings.JOACO:
				joaco_control.visible = true
			ScrPersistentData.Endings.BICI:
				bici_control.visible = true

const chris_happy_speak = preload("res://Characters/Chris/Chris_happy2.png")
const chris_happy_no_speak = preload("res://Characters/Chris/Chris_happy1.png")

const jem_happy_speak = preload("res://Characters/Jem/Jem_happy2.png")
const jem_happy_no_speak = preload("res://Characters/Jem/Jem_happy1.png")
const felix_happy_speak = preload("res://Characters/Felix/Felix_happy2.png")
const felix_happy_no_speak = preload("res://Characters/Felix/Felix_happy1.png")
const felix_serious_speak = preload("res://Characters/Felix/Felix_serious2.png")
const felix_serious_no_speak = preload("res://Characters/Felix/Felix_serious1.png")

const chris_ending = preload("res://Characters/Chris/Chris_end.png")
func _on_chris_pressed():
	if (save_dict["chris"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.CHRIS)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	tbi.sprite_change("Kimbix",kimbix_evil_speak,true)
	tbi.queue_dialogue("Me", "Kimbix")
	tbi.queue_dialogue("It was me", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_evil_no_speak,true)
	tbi.queue_dialogue(" * Everyone turns towards me * ", "Kimbix")
	tbi.queue_dialogue(" * Jem is wide eyed * ", "Kimbix")
	tbi.queue_dialogue(" * Bici and Uke are outraged * ", "Kimbix")
	tbi.queue_dialogue(" * Clara, Nigu and Sage can't believe you just said that. * ", "Kimbix")

	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("I can't believe that at a time like this you decide to joke around", "Bici")
	tbi.sprite_change("Bici",null,false)
	
	tbi.sprite_change("Pham",pham_serious_speak,false)
	tbi.queue_dialogue("Not cool man", "Pham")
	tbi.sprite_change("Pham",null,false)
	
	tbi.sprite_change("Cone",cone_serious,false)
	tbi.queue_dialogue(" * Cone is very disappointed * ", "Cone")
	tbi.sprite_change("Cone",null,false)

	tbi.sprite_change("Jacques",jacques_serious_speak,false)
	tbi.queue_dialogue("Just get out, we have little time left and you're messing with the investigation", "Jacques")
	tbi.sprite_change("Jacques",null,false)
	
	tbi.sprite_change("Kimbix",null,true)
	tbi.queue_dialogue(" * We hear a very loud flush from the toilet. the door to the bathroom opens and chris comes out * ", "Kimbix")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)
	
	tbi.queue_dialogue("CRIIISSSS!!!!!", "Everyone")
	tbi.queue_dialogue(" * We shower chris in hugs * ", "Everyone")

	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("Woah what up with you guys", "Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)

	tbi.sprite_change("Jem",jem_happy_speak,false)
	tbi.queue_dialogue("We thought you died", "Jem")
	tbi.sprite_change("Jem",jem_happy_no_speak,false)

	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("HUH", "Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)

	tbi.sprite_change("Jem",null,false)
	tbi.sprite_change("Felix",felix_happy_speak,false)
	tbi.queue_dialogue("Yeah we even went on a manhunt for clues", "Felix")
	tbi.sprite_change("Felix",felix_happy_no_speak,false)

	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("Oh dear…", "Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)
	
	tbi.sprite_change("Felix",null,false)
	tbi.sprite_change("Ukeisto",ukesito_happy_speak,false)
	tbi.queue_dialogue("What happened", "Ukeisto")
	tbi.sprite_change("Ukeisto",ukesito_happy_no_speak,false)
	
	tbi.sprite_change("Ukeisto",null,false)
	tbi.queue_dialogue("Chris explains how after the light went off, he felt the sudden urge to go to the bathroom.", "Chris")
	tbi.queue_dialogue("When he came out, no one was there, so he went back in and played on his phone.", "Chris")

	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("I thought you al left haha. Well Im glad you all care for me that much.", "Chris")
	tbi.sprite_change("Chris",chris_happy_no_speak,true)
	
	tbi.sprite_change("Chris",chris_happy_speak,true)
	tbi.queue_dialogue("love you guys", "Chris")
	tbi.sprite_change("Chris",null,true)
	
	tbi.queue_all(null, null, null, null, chris_ending, false, false)
	tbi.queue_dialogue("TRUE ENDING", "...")
	tbi.queue_dialogue("...", "...")

const paris_happy_speak = preload("res://Characters/Paris/Paris_happy2.png")
const paris_happy_no_speak = preload("res://Characters/Paris/Paris_happy1.png")
const paris_serious_speak = preload("res://Characters/Paris/Paris_serious2.png")
const paris_serious_no_speak = preload("res://Characters/Paris/Paris_serious1.png")

const ukesito_happy_speak = preload("res://Characters/Ukesito/Uke_happy2.png")
const ukesito_happy_no_speak = preload("res://Characters/Ukesito/Uke_happy1.png")
const ukesito_serious_speak = preload("res://Characters/Ukesito/Uke_serious2.png")
const ukesito_serious_no_speak = preload("res://Characters/Ukesito/Uke_serious1.png")
const ukesito_angry_speak = preload("res://Characters/Ukesito/Uke_angry2.png")
const ukesito_angry_no_speak = preload("res://Characters/Ukesito/Uke_angry1.png")
const uke_ending = preload("res://Characters/Ukesito/Ending_uke.png")

const jem_serious_speak = preload("res://Characters/Jem/Jem_serious2.png")
const jem_serious_no_speak = preload("res://Characters/Jem/Jem_serious1.png")

func _on_ukesito_pressed():
	if (save_dict["ukesito"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.UKESITO)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Ukesito",ukesito_angry_no_speak,false)
	tbi.queue_dialogue(" * Uke looks incredibly mad, but ultimate accepts it's over for him * ", "Ukesito")
	
	tbi.sprite_change("Ukesito",ukesito_angry_speak,false)
	tbi.queue_dialogue("Do you want to know why I did it?", "Ukesito")
	tbi.queue_dialogue("BECAUSE I DO ALL OF THE WORK IN WALTER AND GET NONE OF THE CREDIT", "Ukesito")
	tbi.sprite_change("Ukesito",ukesito_angry_no_speak,false)

	tbi.sprite_change("Jem",jem_serious_speak,true)
	tbi.queue_dialogue("(What's a walter?)", "Jem")
	tbi.sprite_change("Jem",null,true)
	
	tbi.sprite_change("Ukesito",ukesito_angry_speak,false)
	tbi.queue_dialogue("BUT NOW I'M GOING TO HAVE OWNERSHIP OF WALTER AND THERE'S NOTHING YOU CAN DO ABOUT IT.", "Ukesito")
	tbi.queue_dialogue("MUAHAHAHAHAHAHAHA", "Ukesito")
	tbi.sprite_change("Ukesito",ukesito_angry_no_speak,false)

	tbi.sprite_change("Paris",paris_serious_speak,true)
	tbi.queue_dialogue("You do know kimbix is admin too right?", "Paris")
	tbi.sprite_change("Paris",null,true)
	
	tbi.sprite_change("Ukesito",ukesito_angry_speak,false)
	tbi.queue_dialogue("HQHAHAHAH", "Ukesito")
	tbi.queue_dialogue("COUGH COUGH COUGH", "Ukesito")
	tbi.queue_dialogue("… WHAT!?!?", "Ukesito")
	tbi.sprite_change("Ukesito",ukesito_angry_no_speak,false)

	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("yep", "Kimbix")
	tbi.sprite_change("Kimbix",null,true)
	
	tbi.sprite_change("Ukesito",ukesito_angry_speak,false)
	tbi.queue_dialogue("NO", "Ukesito")
	tbi.queue_dialogue("MY EVIL PLAN", "Ukesito")
	tbi.queue_dialogue("NOOOOOOOOOOOOOO", "Ukesito")
	tbi.sprite_change("Ukesito",null,false)
	
	tbi.queue_dialogue("Uke is sent to the discord jail for his crimes against walter.", "Kimbix")
	tbi.queue_dialogue("After I'm given the walter master key I feel a ghostly presence guide me with maintaining the server", "Kimbix")

	tbi.queue_all(null, null, null, null, uke_ending, false, false)
	tbi.queue_dialogue("ADMIN ENDING", "")
	tbi.queue_dialogue("...", "")

const cyrus_happy_speak = preload("res://Characters/Cyrus/Cyrus_happy2.png")
const cyrus_happy_no_speak = preload("res://Characters/Cyrus/Cyrus_happy1.png")
const cyrus_serious_speak = preload("res://Characters/Cyrus/Cyrus_serious2.png")
const cyrus_serious_no_speak = preload("res://Characters/Cyrus/Cyrus_serious1.png")
const cyrus_angry_speak = preload("res://Characters/Cyrus/Cyrus_angry2.png")
const cyrus_angry_no_speak = preload("res://Characters/Cyrus/Cyrus_angry1.png")

const david_happy_speak = preload("res://Characters/David/David_happy2.png")
const david_happy_no_speak = preload("res://Characters/David/David_happy1.png")
const david_serious_speak = preload("res://Characters/David/David_serious2.png")
const david_serious_no_speak = preload("res://Characters/David/David_serious1.png")

const yeetus_happy_speak = preload("res://Characters/Yeetus/Yeetus_happy2.png")
const yeetus_happy_no_speak = preload("res://Characters/Yeetus/Yeetus_happy1.png")
const yeetus_serious_speak = preload("res://Characters/Yeetus/Yeetus_serious2.png")
const yeetus_serious_no_speak = preload("res://Characters/Yeetus/Yeetus_serious1.png")
const yeetus_angry_speak = preload("res://Characters/Yeetus/Yeetus_angry2.png")
const yeetus_angry_no_speak = preload("res://Characters/Yeetus/Yeetus_angry1.png")

const yeetus_ending = preload("res://Characters/Yeetus/Ending_yeetus.png")
func _on_yeetus_pressed():
	if (save_dict["yeetus"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.YEETUS)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Yeetus",yeetus_angry_speak,false)
	tbi.queue_dialogue("NEIGHT NEIGH NWGIH PTRSS PRES NWIIIGHHHHH", "Yeetus")
	tbi.sprite_change("Yeetus",yeetus_angry_no_speak,false)
	
	tbi.queue_dialogue("...", "Everyone (except uke)")
	
	tbi.sprite_change("Ukesito",ukesito_serious_speak,false)
	tbi.queue_dialogue("come on guys why didn't any one of you learn horse", "Ukesito")
	tbi.sprite_change("Ukesito",ukesito_serious_no_speak,false)
	tbi.queue_dialogue(" * Uke pulls out his phone and look up horse translate on google. * ", "Ukesito")
	tbi.queue_dialogue(" * puts the speech mode and yeetus starts talking. * ", "Ukesito")
	
	tbi.sprite_change("Ukesito",null,false)
	tbi.sprite_change("Yeetus",yeetus_angry_speak,false)
	tbi.queue_dialogue("ahem", "Yeetus")
	tbi.sprite_change("Yeetus",yeetus_angry_no_speak,false)
	
	tbi.sprite_change("Kimbix",null,true)
	tbi.sprite_change("David",david_serious_speak,true)
	tbi.queue_dialogue("SATANNN", "David TM")
	tbi.sprite_change("David",david_serious_no_speak,true)
	tbi.queue_dialogue("...", "Everyone")
	
	tbi.sprite_change("David",null,true)
	tbi.queue_dialogue("Paris grabs david and puts him on a cage", "")
	
	tbi.sprite_change("Yeetus",yeetus_angry_speak,false)
	tbi.queue_dialogue(" * Yeetus clears its throat * ", "Yeetus")
	tbi.queue_dialogue("You see, i was in a contract with chris", "Yeetus")
	tbi.queue_dialogue("trapped for ever in the body of a horse.", "Yeetus")
	tbi.queue_dialogue("I was once a human. I was studying along side chris.", "Yeetus")
	tbi.queue_dialogue("I was a lazy person, after I didn't do my part in the group proyect, chris cursed me and forced me to sign it.", "Yeetus")
	tbi.queue_dialogue("But now i am free. I will take my leave now", "Yeetus")
	tbi.sprite_change("Yeetus",null,false)
	
	tbi.queue_dialogue("yeetus leaves", "")

	tbi.queue_all(null, null, null, null, yeetus_ending, false, false)
	tbi.queue_dialogue("FREEDOM ENDING", "")
	tbi.queue_dialogue("...", "")

const cyrus_ending = preload("res://Characters/Cyrus/Ending_cyrus.png")
func _on_cyrus_pressed():
	if (save_dict["cyrus"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.CYRU)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Cyrus",cyrus_angry_speak,false)
	tbi.queue_dialogue("YOUUUUU", "Cyrus")
	tbi.sprite_change("Cyrus",cyrus_angry_no_speak,false)
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("huh?", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Cyrus",cyrus_angry_speak,false)
	tbi.queue_dialogue("THIS IS ALL YOUR FAULT", "Cyrus")
	tbi.sprite_change("Cyrus",cyrus_angry_no_speak,false)
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("me?", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("everyone is invested in the drama", "")
	
	tbi.sprite_change("Cyrus",cyrus_angry_speak,false)
	tbi.queue_dialogue("chris stopped watching shows with me because of you. IM GOING TO KILL YOU", "Cyrus")
	tbi.sprite_change("Cyrus",cyrus_angry_no_speak,false)
	
	tbi.queue_dialogue(" * Cyrus lunges at me * ", "Kimbix")
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("HEEEEELPPPP", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Cyrus",null,false)
	tbi.queue_dialogue(" * multiple people restrain cyrus as he screams they take him away and is promtly sent to jail * ", "Kimbix")
	
	tbi.sprite_change("Kimbix",null,true)
	
	tbi.queue_all(null, null, null, null, cyrus_ending, false, false)
	tbi.queue_dialogue(" * When i arrive at my house soon after i feel a ghostly precense near the couch * ", "Kimbix")
	tbi.queue_dialogue(" * As i get close i see the tv is on with Bojack horseman on * ", "Kimbix")
	tbi.queue_dialogue(" * this is going to be a fun night * ", "Kimbix")
	tbi.queue_dialogue("JEALOUSY ENDING", "...")
	tbi.queue_dialogue("...", "...")

const kimbix_serious_speak = preload("res://Characters/Humber/Humber_serious2.png")
const kimbix_serious_no_speak = preload("res://Characters/Humber/Humber_serious1.png")
const kimbix_happy_speak = preload("res://Characters/Humber/Humber_happy2.png")
const kimbix_happy_no_speak = preload("res://Characters/Humber/Humber_happy1.png")
const kimbix_evil_speak = preload("res://Characters/Humber/Humber_evil2.png")
const kimbix_evil_no_speak = preload("res://Characters/Humber/Humber_evil1.png")

const cone_evil_speak = preload("res://Characters/Cone/Cone_evil2.png")
const cone_evil_no_speak = preload("res://Characters/Cone/Cone_evil1.png")

const bici_happy_speak = preload("res://Characters/Bici/Bici_happy2.png")
const bici_happy_no_speak = preload("res://Characters/Bici/Bici_happy1.png")
const bici_serious_speak = preload("res://Characters/Bici/Bici_serious2.png")
const bici_serious_no_speak = preload("res://Characters/Bici/Bici_serious1.png")
const bici_angry_speak = preload("res://Characters/Bici/Bici_angry2.png")
const bici_angry_no_speak = preload("res://Characters/Bici/Bici_angry1.png")

const jacques_happy_speak = preload("res://Characters/Jacques/Jacques_happy2.png")
const jacques_happy_no_speak = preload("res://Characters/Jacques/Jacques_happy1.png")
const jacques_serious_speak = preload("res://Characters/Jacques/Jacques_serious2.png")
const jacques_serious_no_speak = preload("res://Characters/Jacques/Jacques_serious1.png")

const pham_happy_speak = preload("res://Characters/Pham/Pham_happy1.png")
const pham_serious_speak = preload("res://Characters/Pham/Pham_serious1.png")

const cone_serious = preload("res://Characters/Cone/Cone_normal.png")

const kimbix_ending = preload("res://Characters/Humber/Ending_kimbix.png")
func _on_kimbix_pressed():
	if (save_dict["kimbix"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.KIMBIX)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Kimbix",kimbix_evil_speak,true)
	tbi.queue_dialogue("Me", "Kimbix")
	tbi.queue_dialogue("It was me", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_evil_no_speak,true)
	tbi.queue_dialogue(" * Everyone turns towards me * ", "Kimbix")
	tbi.queue_dialogue(" * Jem is wide eyed * ", "Kimbix")
	tbi.queue_dialogue(" * Bici and Uke are outraged * ", "Kimbix")
	tbi.queue_dialogue(" * Clara, Nigu and Sage can't believe you just said that. * ", "Kimbix")

	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("I can't believe that at a time like this you decide to joke around", "Bici")
	tbi.sprite_change("Bici",null,false)
	
	tbi.sprite_change("Pham",pham_serious_speak,false)
	tbi.queue_dialogue("Not cool man", "Pham")
	tbi.sprite_change("Pham",null,false)
	
	tbi.sprite_change("Cone",cone_serious,false)
	tbi.queue_dialogue(" * Cone is very disappointed * ", "Cone")
	tbi.sprite_change("Cone",null,false)

	tbi.sprite_change("Jacques",jacques_serious_speak,false)
	tbi.queue_dialogue("Just get out, we have little time left and you're messing with the investigation", "Jacques")
	tbi.sprite_change("Jacques",null,false)
	
	tbi.sprite_change("Kimbix",kimbix_evil_speak,true)
	tbi.queue_dialogue("But I...", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_evil_no_speak,true)
	
	tbi.queue_dialogue("GET OUT", "EVERYONE")
	
	tbi.sprite_change("Kimbix",null,true)
	
	tbi.queue_dialogue("Everyone screams at me multiple different variations of get out and other things.", "Kimbix")
	tbi.queue_dialogue("I quickly leave the mansion before anyone tries to beat me up.", "Kimbix")
	tbi.queue_dialogue("As I make my way toward the car I feel a grin form on my face. ", "Kimbix")
	tbi.queue_dialogue("Everything went as planned.", "Kimbix")

	tbi.queue_dialogue("I feel a ghostly presence insult me behind my back. ", "Kimbix")
	
	tbi.queue_all(null, null, null, null, kimbix_ending, false, false)
	tbi.queue_dialogue("IMPOSTOR ENDING", "")
	tbi.queue_dialogue("...", "")

const nigu_happy_speak = preload("res://Characters/Nigu/Nigu_happy2.png")
const nigu_happy_no_speak = preload("res://Characters/Nigu/Nigu_happy1.png")
const nigu_serious_speak = preload("res://Characters/Nigu/Nigu_serious2.png")
const nigu_serious_no_speak = preload("res://Characters/Nigu/Nigu_serious1.png")

func _on_cono_pressed():
	if (save_dict["cono"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.CONO)
	endings_buttons.visible = false
	current_state = State.CONO_ENDING
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("That's not cone that's-", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Cone",cone_evil_speak,false)
	tbi.queue_dialogue("I see you figured out my true identity", "Cone")
	tbi.queue_dialogue("I hate people who spoil surprises", "Cone")
	tbi.queue_dialogue("I'll enjoy sending you to the same place where chris is", "Cone")
	tbi.sprite_change("Cone",cone_evil_no_speak,false)

const kiri_happy_speak = preload("res://Characters/Kiri/Kiri_happy2.png")
const kiri_happy_no_speak = preload("res://Characters/Kiri/Kiri_happy1.png")
const kiri_serious_speak = preload("res://Characters/Kiri/Kiri_serious2.png")
const kiri_serious_no_speak = preload("res://Characters/Kiri/Kiri_serious1.png")
const kiri_angry_speak = preload("res://Characters/Kiri/Kiri_angry2.png")
const kiri_angry_no_speak = preload("res://Characters/Kiri/Kiri_angry1.png")

const kiri_ending = preload("res://Characters/Kiri/Ending_Kiri.png")

func _on_kiri_pressed():
	if (save_dict["kiri"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.KIRI)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
		
	tbi.sprite_change("Kiri",kiri_angry_speak,false)
	tbi.queue_dialogue("HE DESERVED IT. HE CALLED ME 让你付", "Kiri")
	tbi.queue_dialogue("I'VE SPENT MONTHS LEARNING CHINESE JUST TO FIGURE OUT WHAT HE SAID", "Kiri")
	tbi.sprite_change("Kiri",kiri_angry_no_speak,false)
	
	tbi.queue_dialogue(" * Some are impressed kiri managed to learn so much in such few time * ", "")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("okay time for jail kiri", "Humber")
	tbi.queue_dialogue("我会让你付出代价", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Kiri",null,false)
	
	tbi.queue_dialogue("We restrained her and waited for the police to arrive, as they took her away, her book dropped. ", "Humber")
	tbi.queue_dialogue("We saw what page it was on and figured out what chris meant. We all have a laugh", "Humber")
	
	tbi.sprite_change("Humber",null,true)
	
	tbi.queue_all(null, null, null, null, kiri_ending, false, false)
	tbi.queue_dialogue("小红书 ENDING", "")
	tbi.queue_dialogue("...", "")

const magnitude_angry = preload("res://Characters/Magnitude/Magnitude_angry1.png")
const magnitude_normal = preload("res://Characters/Magnitude/Magnitude_normal1.png")
const magnitude_ending = preload("res://Characters/Magnitude/Ending_magnitude.png")

func _on_magnitude_pressed():
	if (save_dict["magnitude"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.MAGNITUDE)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Magnitude", "Humber")
	tbi.queue_dialogue("Magnitude", "Humber")
	tbi.queue_dialogue("Magnitude", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Magnitude",magnitude_normal,false)
	
	tbi.sprite_change("Humber",null,true)
	tbi.sprite_change("Pham",pham_serious_speak,true)
	tbi.queue_dialogue("THAT'S HIM, THE GHOST I TOLD ALL OF YOU ABOUT AND NOBODY BELIEVED ME.", "Pham")
	
	tbi.sprite_change("Magnitude",magnitude_angry,false)
	tbi.queue_dialogue("PUNY HUMANS I ALREADY KILLED YOUR LEADER, STOP SUMMONING ME TO THIS WORLD", "Magnitude")
	tbi.sprite_change("Magnitude",magnitude_normal,false)

	tbi.sprite_change("Pham",null,true)
	tbi.sprite_change("Ukesito",ukesito_serious_speak,true)
	tbi.queue_dialogue("we haven't?", "Ukesito")
	tbi.sprite_change("Ukesito",ukesito_serious_no_speak,true)
	
	tbi.sprite_change("Magnitude",magnitude_angry,false)
	tbi.queue_dialogue("YES YOU HAVE. FOR YEARS YOU SAID MY NAME, BRINGING ME TO THIS REALM.", "Magnitude")
	tbi.queue_dialogue("ALL OF THIS ORQUESTRATED OVER ON YOUR WRETCHED MESSAGING SITE.", "Magnitude")
	tbi.sprite_change("Magnitude",magnitude_normal,false)

	tbi.sprite_change("Ukesito",null,true)
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("what if i kill you huh?", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Magnitude",magnitude_angry,false)
	tbi.queue_dialogue("WHAT?", "Magnitude")
	tbi.sprite_change("Magnitude",magnitude_normal,false)
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("LIFE OR PURGATORY FOR MAGNITUDE?", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Magnitude",magnitude_angry,false)
	tbi.queue_dialogue("LIFE", "Magnitude")
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("PURGATORY", "Everyone")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("NO WAIT", "Magnitude")
	tbi.sprite_change("Magnitude",null,false)
	
	tbi.queue_dialogue("A portal openned sucking up magnitude", "")
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("Well that just happened", "Everyone")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)

	tbi.sprite_change("Kimbix",null,true)
	tbi.queue_all(null, null, null, null, magnitude_ending, false, false)
	tbi.queue_dialogue("PURGATORY ENDING", "")
	tbi.queue_dialogue("...", "")

const joaco_happy_speak = preload("res://Characters/Joaco/Joaco_happy2.png")
const joaco_happy_no_speak = preload("res://Characters/Joaco/Joaco_happy1.png")
const joaco_serious_speak = preload("res://Characters/Joaco/Joaco_serious2.png")
const joaco_serious_no_speak = preload("res://Characters/Joaco/Joaco_serious1.png")
const joaco_angry_speak = preload("res://Characters/Joaco/Joaco_insane2.png")
const joaco_angry_no_speak = preload("res://Characters/Joaco/Joaco_insane1.png")

const joaco_ending = preload("res://Characters/Joaco/Ending_joaco.png")

func _on_joaco_pressed():
	if (save_dict["joaco"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.JOACO)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Joaco",joaco_angry_speak,true)
	tbi.queue_dialogue("audio place", "Joaco")
	tbi.queue_dialogue("audio place", "Joaco")
	tbi.queue_dialogue("JAJSHAJAJAJ AUDIO PLACE", "Joaco")
	tbi.queue_dialogue("IT'S NOT FAIR", "Joaco")
	tbi.queue_dialogue("DREAM FINALLY RELEASED THEIR NEW ALBUM", "Joaco")
	tbi.queue_dialogue("AND CHRIS DID NOT TELL ME", "Joaco")
	tbi.queue_dialogue("BUT NOW", "Joaco")
	tbi.queue_dialogue("HE'S IN THE AUDIO PLACE", "Joaco")
	tbi.queue_dialogue("HSHAHDHAJAHSHAJA", "Joaco")
	tbi.sprite_change("Joaco",joaco_angry_no_speak,true)
	
	tbi.queue_dialogue(" * Everyone is visibly disturbed * ", "")
	tbi.queue_dialogue(" * Not long after, men dressed in white arrive at the mansion and take Joaco away * ", "")
	
	tbi.sprite_change("Joaco",null,true)
	
	tbi.queue_all(null, null, null, null, joaco_ending, false, false)
	tbi.queue_dialogue("AUDIO PLACE ENDING", "...")
	tbi.queue_dialogue("audioplaceaudioplaceaudioplaceaudioplaceaudioplaceaudioplaceaudioplace", "Joaco")
	tbi.queue_dialogue("...", "...")

const bici_ending = preload("res://Characters/Bici/Ending_bici.png")
func _on_bici_pressed():
	if (save_dict["bici"]):
		tbi.queue_dialogue("You feel deja vu", "...")
	save_endings(ScrPersistentData.Endings.BICI)
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Bici",bici_angry_speak,true)
	tbi.queue_dialogue("Do you have any idea how it feels to find someone that will read ANY WEBTOON.", "Bici")
	tbi.queue_dialogue("I've recommended so many and they've fallen on deaf ears, and then chris came around.", "Bici")
	tbi.queue_dialogue(" that was until he stopped reading them. So i had to teach an example out of him", "Bici")
	tbi.sprite_change("Bici",bici_angry_no_speak,true)
	
	tbi.queue_dialogue(" * David and Cone Shiver * ", "")
	
	tbi.queue_dialogue(" * Bici is apprehended and taken to jail * ", "")
	
	tbi.sprite_change("Bici",null,true)
	tbi.queue_all(null, null, null, null, bici_ending, false, false)
	tbi.queue_dialogue("EGGNOID ENDING", "...")
	tbi.queue_dialogue("...", "...")

# NO IDEA ENDING
func _on_none_pressed():
	endings_buttons.visible = false
	current_state = State.SEEING_ENDING
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("I really have no idea who did this", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)

	tbi.queue_dialogue("...", "...")


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

func save_endings(ending : ScrPersistentData.Endings):
	load_game()
	var save_game = FileAccess.open("user://endings.json", FileAccess.WRITE)
	match(ending):
		ScrPersistentData.Endings.CHRIS:
			save_dict["chris"] = true
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
	
	var json_string = JSON.stringify(save_dict)
	save_game.store_line(json_string)
	save_game.close()
