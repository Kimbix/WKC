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

const mansion_background = preload("uid://dk5f72ug8nyhp")

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
			tbi.new_clean()
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

const cone = preload("res://Characters/Cone/Cone_normal.png")

const clau_serious_speak = preload("res://Characters/Clau/Clau_serious1.png")
const clau_serious_no_speak = preload("res://Characters/Clau/Clau_serious2.png")
func cyru_cutscene():
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.queue_dialogue("* As I walk towards the main hall I see Jem and someone behind a...? plant *", "Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.sprite_change("Padding",padding_texture,true)
	tbi.sprite_change("Jem",jem_serious_no_speak,false)
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.sprite_change("Clau",clau_serious_speak,false)
	tbi.queue_dialogue("BOOO AHH JAJAJA QUE MIEDO", "Clau")
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.queue_dialogue("...", "Humber")
	tbi.queue_dialogue("...", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("AAAAAAHHH! :(", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Clau",clau_serious_speak,false)
	tbi.queue_dialogue("Como puedes ver doy mucho miedo", "Clau")
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.sprite_change("Jem",jem_serious_speak,false)
	tbi.queue_dialogue("mhm...", "Jem")
	tbi.queue_dialogue("So, justo te estabamos buscando para hablarte de algo que recordamos", "Jem")
	tbi.sprite_change("Jem",jem_serious_no_speak,false)
	
	tbi.sprite_change("Clau",clau_serious_speak,false)
	tbi.queue_dialogue("Pero solo si nos das flips MUAJAJAJA", "Clau")
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("No", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Clau",clau_serious_speak,false)
	tbi.queue_dialogue("Después de todo lo que ha pasado yo creo que fue Cyrus", "Clau")
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.sprite_change("Jem",jem_serious_speak,false)
	tbi.queue_dialogue("No vale, cyrus nunca haria algo asi", "Jem")
	tbi.sprite_change("Jem",jem_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Pero que paso? Cyrus hizo algo?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Jem",jem_serious_speak,false)
	tbi.queue_dialogue("Antes de que comieramos Cyrus se puso a discutir con Chris de una serie o algo", "Jem")
	tbi.sprite_change("Jem",jem_serious_no_speak,false)
	
	tbi.sprite_change("Clau",clau_serious_speak,false)
	tbi.queue_dialogue("Y después Cyrus le dijo a Chris que le iba a dar con un plato", "Clau")
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("aja... un plato", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Clau",clau_serious_speak,false)
	tbi.queue_dialogue("De hecho, llegamos a ver un plato roto en la cocina con sangre", "Clau")
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.sprite_change("Jem",jem_serious_speak,false)
	tbi.queue_dialogue("No sabemos si es sangre", "Jem")
	tbi.sprite_change("Jem",jem_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("hmmm bueno, igual estare pendiente. Gracias", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Jem",jem_serious_speak,false)
	tbi.queue_dialogue("De nada", "Jem")
	tbi.sprite_change("Jem",jem_serious_no_speak,false)
	
	tbi.sprite_change("Clau",clau_serious_speak,false)
	tbi.queue_dialogue("chao tonto", "Clau")
	tbi.sprite_change("Clau",clau_serious_no_speak,false)
	
	tbi.new_clean()

func joaco_cutscene():
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.queue_dialogue("As I'm walking back towards the main hall I hear two people call out for me.", "Humber")
	tbi.queue_dialogue("I turn around and notice that it's Sage and Felix", "Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.sprite_change("Padding",padding_texture,true)
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Haiii", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.queue_dialogue("Hellooo", "Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("Heeyyy", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("What's up?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.queue_dialogue("Just thinking on who it could be", "Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("Girl, you know it’s your man. Stop coping", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.queue_dialogue("Aghhh...", "Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("You’re saying it’s Joaco?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.queue_dialogue("No, he could never hurt a fly", "Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("He could DEFINITELY hurt a fly", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Rewind a bit guys, what makes you think that it was him?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("Ignoring the fact he lost his mind, he’s was rambling about an octa...glarium or something", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Octavarium", "Humber & Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("yeah that", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.queue_dialogue("Sometimes when he's talking to me he suddenly stays quiet and says “octavarium” or “new album”", "Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("Oh and not the mention the tantrum he had before dinner", "Sage")
	tbi.queue_dialogue("He was scrolling instagram and saw a post of some 5 dads...? talking about a new album", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Dream Theater", "Humber & Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("yeah yeah", "Sage")
	tbi.queue_dialogue("Let me finish damn", "Sage")
	tbi.queue_dialogue("And then he had a breakdown or something", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.queue_dialogue("It took me a while to calm him down. I was kinda scared", "Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Damn, i’ll make sure not to mention that to him", "Humber")
	tbi.queue_dialogue("I’ve gotta run but thanks guys", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Felix",felix_serious_speak,false)
	tbi.queue_dialogue("byeeeee", "Felix")
	tbi.sprite_change("Felix",felix_serious_no_speak,false)
	
	tbi.sprite_change("Sage",sage_serious_speak,false)
	tbi.queue_dialogue("see yaa", "Sage")
	tbi.sprite_change("Sage",sage_serious_no_speak,false)
	
	tbi.new_clean()

func bici_cutscene():
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.queue_dialogue("As I'm walking back towards the main hall, I feel the presence of two people", "Humber")
	tbi.queue_dialogue("Instinctively knowing it's Paris and David, I turn around and greet them", "Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.sprite_change("Padding",padding_texture,true)
	tbi.sprite_change("Paris",paris_serious_no_speak,false)
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Hello hello", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Paris",paris_serious_speak,false)
	tbi.queue_dialogue("Hi :3", "Paris")
	tbi.sprite_change("Paris",paris_serious_no_speak,false)
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("Hola berto :3", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("How have you guys been? Are you starting to like the horse more?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("NEVER! THAT HORSE MUST DIE", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.queue_dialogue("...", "Paris")
	
	tbi.queue_dialogue("...", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Okay", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Paris",paris_serious_speak,false)
	tbi.queue_dialogue("Uhm...", "Paris")
	tbi.queue_dialogue("We wanted to tell you that we think it was bici", "Paris")
	tbi.sprite_change("Paris",paris_serious_no_speak,false)
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("No we don’t, I think it was the horse", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.queue_dialogue("* Paris glances at David *", "Paris")
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("Okay we came here to tell you about bici...", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("What about bici?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("Well...", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.queue_dialogue("Uhm...", "Paris")
	tbi.sprite_change("Paris",paris_serious_speak,false)
	tbi.queue_dialogue("We went to talk with Bici and everything was fine", "Paris")
	tbi.sprite_change("Paris",paris_serious_no_speak,false)
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("That was until paris has to go to the bathroom", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.queue_dialogue("* Paris nods *", "Paris")
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("Then bici was regañandome all because i wasn’t reading the webtoons T-T", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.sprite_change("Paris",paris_serious_speak,false)
	tbi.queue_dialogue("When I came back, bici acted as if nothing happened", "Paris")
	tbi.queue_dialogue("After a while, she left, not without giving david a glare", "Paris")
	tbi.sprite_change("Paris",paris_serious_no_speak,false)
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("And she also told me not to forget what we talked about", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("And that was?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Paris",paris_serious_speak,false)
	tbi.queue_dialogue("“You’re not the only one on thin ice, after I’m done with someone else, you’re next”", "Paris")
	tbi.sprite_change("Paris",paris_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Jeez, looks like bici is going to be paying a lot of visits...", "Humber")
	tbi.queue_dialogue("Well, thanks guys. I’ll be on the lookout for bici", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("David",david_serious_speak,false)
	tbi.queue_dialogue("See you!", "David")
	tbi.sprite_change("David",david_serious_no_speak,false)
	
	tbi.sprite_change("Paris",paris_serious_speak,false)
	tbi.queue_dialogue("Bye bye", "Paris")
	tbi.sprite_change("Paris",paris_serious_no_speak,false)
	
	tbi.new_clean()

func magnitude_cutscene():
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.queue_dialogue("I decide to take a quick break and sit on the stairs. I try to collect my thoughts so far", "")
	tbi.queue_dialogue("Going through everything, it's hard to believe that someone actually did it", "")
	tbi.queue_dialogue("Maybe it was actually nobody, maybe it was mag-", "")
	tbi.queue_dialogue("I'm interupted by the sounds of clopping and footsteps", "")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.sprite_change("Pham",pham_serious_speak,true)
	tbi.queue_dialogue("Hey humberto", "Pham")
	
	tbi.sprite_change("Ukesito",uke_serious_speak,false)
	tbi.queue_dialogue("hey", "Ukesito")
	tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
	
	tbi.sprite_change("Yeetus",yeetus_serious_speak,false)
	tbi.queue_dialogue("NEIGH", "Yeetus")
	tbi.sprite_change("Yeetus",yeetus_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Hey", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Ukesito",uke_serious_speak,false)
	tbi.queue_dialogue("We were talking about this precense weve been seeing all over the mansion", "Ukesito")
	tbi.sprite_change("Ukesito",uke_serious_no_speak,false)
	
	tbi.queue_dialogue("They talk to you about the so called ghost. Yeetus seems to be visibly afraid and shits on the floor.", "")
	tbi.queue_dialogue("Uke pays no mind to it but pham is absolutely baffled", "")
	tbi.queue_dialogue("I'm reminded of something similar chris said, I think I know who it is*", "")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("I've heard enough, thanks guys", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.new_clean()

const yeetus_cutscene_background = preload("res://Characters/Yeetus/Cutscene_yeetus.png")
func yeetus_cutscene(): 
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.queue_dialogue("As I walk back, I take some notes on who it could be.", "")
	tbi.queue_dialogue("Honestly the most suspicious guest to me seems to be that horse.", "")
	tbi.queue_dialogue("Why did Chris even invite a horse anyway?", "")
	
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
	tbi.queue_dialogue("Deep in my notes, I feel a tap on my shoulder.", "")
	tbi.queue_dialogue("Looking up, I see Cyrus", "")
	tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
	tbi.queue_dialogue("ey gafo", "Cyrus")
	tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)

	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("?", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
	tbi.queue_dialogue("I found a Ouija board, want to help me summon chris", "Cyrus")
	tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)

	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("sure", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue(" * I am lead to chris's body and Cyrus sets the board down. We rummage around the house looking for offerings. * ", "")
	tbi.queue_dialogue(" * Cyrus sets candles down around the board and the offerings * ", "")
	tbi.queue_dialogue(" * peanuts, an HDD and a crude drawing of chris * ", "")
	tbi.queue_dialogue(" * As we light up the candles, the main hall lights flicker. * ", "")
	tbi.queue_dialogue(" * They completely turn off and we're left in the dark with the candles letting us see each other. * ", "")
	
	tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
	tbi.queue_dialogue("chant with me", "Cyrus")
	tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
	
	tbi.queue_dialogue(" * we hold each other's hands * ", "")
	tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue(" Lorem Ipsum dolor sit amet ", "Cyrus")
	tbi.queue_dialogue(" Lorem Ipsum dolor sit amet ", "Kimbix")
	tbi.queue_dialogue(" * The room shakes * ", "")
	tbi.queue_dialogue(" Lorem Ipsum dolor sit amet! ", "Cyrus")
	tbi.queue_dialogue(" Lorem Ipsum dolor sit amet! ", "Kimbix")
	tbi.queue_dialogue(" * The lights heavily flicker * ", "")
	tbi.queue_dialogue(" LOREM IPSUM DOLOR SIT AMET ", "Cyrus")
	tbi.queue_dialogue(" LOREM IPSUM DOLOR SIT AMET ", "Kimbix")
	tbi.queue_dialogue(" * There's a flash of white light and before us we see the ghost of chris * ", "")
	tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.new_clean()
	
	tbi.queue_all(null, null, null, null, yeetus_cutscene_background, false, false)
	tbi.queue_dialogue("MEEEEEDICCC", "Ghost Chris")
	tbi.queue_dialogue("MEEEEEEEEDDIIIICCC", "Ghost Chris")
	tbi.queue_dialogue("oh hey guys", "Ghost Chris")

	tbi.queue_dialogue(" * We ask chris how he died  * ", "")
	tbi.queue_dialogue(" *  Chris couldn't tell us much, but he did tell us how he felt a hoof before dying  * ", "")
	
	tbi.queue_dialogue("I'm gonna go now, I was playing tf2 with Magnitude", "Ghost Chris")
	tbi.queue_dialogue(" * dissapears * ", "Ghost Chris")
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("Well that was something…", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Cyrus",cyrus_serious_speak,false)
	tbi.queue_dialogue("i'm leaving too", "Cyrus")
	tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
	
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("Yeah same.", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.new_clean()

func uke_cutscene():
	tbi.new_clean()
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.queue_dialogue("Walking through the mansion, I pick up my phone and check my unread messages", "")
	tbi.queue_dialogue("Scrolling through them, I see some weird messages by Ukesito", "")
	tbi.queue_dialogue("As I'm reading I keep on walking an-", "")
	
	tbi.queue_dialogue("Ouch. Sorry uhh", "Humber")
	tbi.queue_dialogue("I look up to see it's Bici and Cone", "")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.sprite_change("Padding",padding_texture,true)
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	tbi.sprite_change("Cono",cone,false)
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("Hey mr streamer, you gotta be more careful but I forgive you", "Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("My bad Bici. Were you looking for me?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("Yup! I saw something before chris' death and I wanted to see if you could make anything of it", "Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Okay, i'm listening", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("Before we ate, I saw uke walk over to a wall", "Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("That's normal", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("But what isn't is that he started mumbling about him not being appreciated and how he was going to take over Walter", "Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("That's not normal", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("* Cone nods in agreement *", "Cone")
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("And the worst part was him saying “ahora soy admin hahaHAHAHAHA” when we all split up", "Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("Pretty scary stuff", "Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Oh yeah, he's definitely a prime suspect now", "Humber")
	tbi.queue_dialogue("Thanks a lot bici", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Bici",bici_serious_speak,false)
	tbi.queue_dialogue("Consider this a favor, you'll be repaying it after", "Bici")
	tbi.sprite_change("Bici",bici_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("What have i gotten myself into", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue(">:)", "Bici")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Anyway... I'll be going now, thanks", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.new_clean()

func cono_cutscene():
	tbi.new_clean()
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.queue_dialogue("Walking through the mansion, I spot a glass of nestea left behind", "")
	tbi.queue_dialogue("I take a few glances around the mansion and drink it without anyone noticing", "")
	tbi.queue_dialogue("I leave the empty glass back at the dinner table as I turn around I see Nigu and Joaco hurridly approaching me,", "")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.sprite_change("Padding",padding_texture,true)
	tbi.sprite_change("Nigu",nigu_serious_no_speak,false)
	tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
	
	tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
	tbi.sprite_change("Nigu",nigu_serious_speak,true)
	tbi.queue_dialogue("Hey! I think cono is a fake", "Nigu")
	tbi.sprite_change("Nigu",nigu_serious_no_speak,true)
	
	tbi.sprite_change("Joaco",joaco_serious_speak,false)
	tbi.queue_dialogue("WOAH WOAH WOAH", "Joaco")
	tbi.queue_dialogue("audio... audio... audio place", "Joaco")
	tbi.sprite_change("Joaco",joaco_serious_no_speak,false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("That's a big accusation. Mind backing it up?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.sprite_change("Nigu",nigu_serious_speak,true)
	tbi.queue_dialogue("so…", "Nigu")
	tbi.sprite_change("Nigu",nigu_serious_no_speak,true)
	
	tbi.queue_dialogue(" * Nigu explains how cono has been acting extremely robotic. * ", "")
	tbi.queue_dialogue(" * Never answering questions or even speaking. He said he also noticed a red spot in cono’s face. * ", "")
	tbi.queue_dialogue(" * Nigu asked, cone seemed nervous * ", "")

	tbi.sprite_change("Nigu",nigu_serious_speak,true)
	tbi.queue_dialogue("And thats about it", "Nigu")
	tbi.sprite_change("Nigu",nigu_serious_no_speak,true)
	
	tbi.sprite_change("Nigu",null,true)
	tbi.sprite_change("Kimbix",kimbix_serious_speak,true)
	tbi.queue_dialogue("Hmmm really makes you think…", "Kimbix")
	tbi.sprite_change("Kimbix",kimbix_serious_no_speak,true)
	
	tbi.new_clean()
	
	tbi.queue_dialogue("We part ways and I can't help but think that there's more beneath the surface regarding Cone", "")

func kimbix_cutscene():
	# TODO: Once again, it FEELS like there's supposed to be a background change here
	# but there's nothing indicated in the docs, so imma leave it to chris.
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("* After leaving the room I notice there's no one in the main hall *", "")
	tbi.queue_dialogue("* Making my move, I leave the mansion running towards my car *", "")
	tbi.queue_dialogue("* I open the trunk and reach for my jacket pocket. Grabbing chris’ gun, I make sure the safety is on and throw it inside *", "")
	tbi.queue_dialogue("* I take a quick glance at my surroundings, no one has spotted me yet. I close the trunk and lock my car *", "")
	tbi.queue_dialogue("* I run back towards the mansion, composing myself before entering *", "")
	tbi.queue_dialogue("* Luckily, no one saw me enter *", "")
	
	tbi.new_clean()

func chris_cutscene():
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Hmmm...", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("The more I think about it the way Chris died doesn’t sit right with me", "Humber")
	tbi.queue_dialogue("They’re all chris’ friends, it’s hard to believe any one of us could do this", "Humber")
	tbi.queue_dialogue("Even if everyone seems suspicious", "Humber")

	tbi.queue_dialogue("* I walk towards the dning table *", "Humber")
	tbi.queue_dialogue("* Circling around it I find nothing of interest *", "Humber")

	tbi.queue_dialogue("There has to be something here", "Humber")
	tbi.queue_dialogue("A clue maybe", "Humber")

	tbi.queue_dialogue("* My eyes pace around the main hall *", "Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Let me find something, anything!", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("* Seeing as there is nothing else except for chris’ body still there I feel like giving up *", "Humber")
	tbi.queue_dialogue("* I feel something compel me to look up *", "Humber")
	tbi.queue_dialogue("* As I do, I spot a broken rope dangling from the ceiling. *", "Humber")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Huh...", "Humber")
	tbi.queue_dialogue("I never noticed that, what could it mean?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.new_clean()

func kiri_cutscene():
	
	tbi.queue_all(null, null, null, null, mansion_background, false, false)
	tbi.queue_dialogue("After leaving the room I notice there's no one in the main hall", "")
	tbi.queue_dialogue("Picking up my phone, I scroll social media for a bit", "")
	tbi.queue_dialogue("I can't stop from thinking about today, so I just put my phone away", "")
	tbi.queue_dialogue("As I do, I notice Clara & co walking towards me", "")
	
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	tbi.sprite_change("Padding",padding_texture,true)
	tbi.sprite_change("Clara",clara_serious_no_speak,false)
	tbi.sprite_change("Cesar",cesar_serious_no_speak,false)

	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Hello hello", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)

	tbi.sprite_change("Clara",clara_serious_speak,false)
	tbi.queue_dialogue("Hellooo", "Clara")
	tbi.sprite_change("Clara",clara_serious_no_speak,false)

	tbi.sprite_change("Cesar",cesar_serious_speak,false)
	tbi.queue_dialogue("How's the investigation going?", "Cesar")
	tbi.sprite_change("Cesar",cesar_serious_no_speak,false)

	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Pretty good, but I could definitely use a good lead right now", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)

	tbi.sprite_change("Padding",null,true)
	tbi.sprite_change("Jacques",jacques_serious_speak,true)
	tbi.sprite_change("Jacques",jacques_serious_speak,true)
	tbi.queue_dialogue("Guess what", "Jacques")
	tbi.sprite_change("Jacques",jacques_serious_no_speak,true)

	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Que?", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)

	tbi.sprite_change("Jacques",jacques_serious_speak,true)
	tbi.queue_dialogue("so", "Jacques")
	tbi.sprite_change("Jacques",jacques_serious_no_speak,true)

	tbi.sprite_change("Cesar",cesar_serious_speak,false)
	tbi.queue_dialogue("We have just what we need, we saw something right before we went to eat. We thought you should know", "Cesar")
	tbi.sprite_change("Cesar",cesar_serious_no_speak,false)

	tbi.sprite_change("Clara",clara_serious_speak,false)
	tbi.queue_dialogue("It’s extremely incriminating, so use it wisely", "Clara")
	tbi.sprite_change("Clara",clara_serious_no_speak,false)

	tbi.queue_dialogue("They give me a piece of paper with what look to be like chinese scribbles", "")
	
	tbi.sprite_change("Cesar",cesar_serious_speak,false)
	tbi.queue_dialogue("We aren't too sure what it means since Kiri won't let us borrow that book, but", "Cesar")
	tbi.sprite_change("Cesar",cesar_serious_no_speak,false)
	
	tbi.sprite_change("Clara",clara_serious_speak,false)
	tbi.queue_dialogue("I was able to distract Kiri and Cesar got a few words. Here's what we have so far", "Clara")
	tbi.sprite_change("Clara",clara_serious_no_speak,false)
	
	tbi.queue_dialogue("They hand me their phone with the notes app open. There are only 3 sentences written", "")
	tbi.queue_dialogue("'1. Go to his mansion'", "")
	tbi.queue_dialogue("'2. Turn off the breaker'", "")
	tbi.queue_dialogue("'3. Make him-'", "")
	tbi.queue_dialogue("It cuts off after that with some question marks", "")
	
	tbi.queue_dialogue("* Sigh *", "")
	tbi.queue_dialogue("This will do for now I suppose", "")
	tbi.queue_dialogue("I take a pic with my phone and hand theirs back", "")
	
	tbi.sprite_change("Humber",kimbix_serious_speak,true)
	tbi.queue_dialogue("Thanks guys, this is good. I have to go check some things, I'll see you soon", "Humber")
	tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
	
	tbi.queue_dialogue("They wave goodbye and go to one of the many rooms", "")

	tbi.new_clean()

func _on_the_dungeon_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Dungeon_Control".queue_free()
	var dungeon_trans = func():
		tbi.queue_all(null, null, null, null, dungeon_background, false, false)
		tbi.queue_dialogue("You went to the dungeon", "")
		await get_tree().create_timer(3.0).timeout
		tbi.change_state(tbi.State.READY)
		tbi.hide_textbox()
	tbi.fade_black_back_in(dungeon_scene, dungeon_trans)

const padding_texture = preload("uid://cg4jjfi8is6j2")

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

const dungeon_background = preload("uid://j5mv3uir8tet")
var dungeon_scene = func():
	tbi.queue_dialogue(" * I walk towards the dungeon * ", "")
	tbi.queue_dialogue(" * Chris would always joke and say to others he had a dungeon in their house, only to laugh at people when they actually saw what it was * ", "")
	tbi.queue_dialogue(" * I enter the dimly lit room, showered with blue light coming from the 3 monitors set up and humming coming from the multiple server racks * ", "")
	tbi.queue_dialogue(" * After that one time chris hosted the minecraft server, it turned into chris hosting just about anything server related * ", "")
	tbi.queue_dialogue(" * I scan the room and I spot... * ", "")
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
		
		tbi.queue_dialogue(" * Walking towards the desk I spot the printer and find chris’ gun on the table * ", "")
		tbi.queue_dialogue(" * He said he had it in case the printer started rebelling against him * ", "")
		tbi.queue_dialogue(" * I take a glance at the room to make sure the room really is empty and take the gun, hiding it in the inside of my jacket * ", "")
		tbi.queue_dialogue(" * It’s best if no one else takes the gun * ", "")
		tbi.queue_dialogue(" * I should go to the garage to make sure nothing is missing from there * ", "")
		
		tbi.queue_dialogue("...", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Have I already checked in the garage?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue("...", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Hmmm...", "Humber")
		tbi.queue_dialogue("I don’t remember if I did. I’ll probably remember if I go back to the main hall", "")
		tbi.queue_dialogue("I’m leaving before anyone else notices the gun is gone", "")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * I take a final look at the room * ", "")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Still, no one is there", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.new_clean()
		
		tbi.queue_dialogue(" * I leave the room without anyone noticing * ", "")
		tbi.queue_dialogue(" * Everyone must be in the other rooms of the mansion * ", "")
		tbi.queue_dialogue("Where to now?", "")
		
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
		tbi.queue_dialogue("I saw chris’ gun is missing, didn’t he keep it next to that printer?", "Cyrus")
		tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("He did, let me check", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.queue_dialogue(" * Walking towards the desk I spot the printer and no gun to be seen * ", "Humber")
		tbi.queue_dialogue(" * I inspect the desk and spot Chris had some open tabs before * ", "Humber")
		tbi.queue_dialogue(" * I sit on his chair and go to the link * ", "Humber")
		tbi.queue_dialogue(" * “Custom hyper realistic pinata” it reads. There seems to be a completed order for 9999 pinatas * ", "Humber")
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("huh", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("Kiri",kiri_serious_speak,false)
		tbi.queue_dialogue("Why would Chris have a gun?", "Kiri")
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
		tbi.queue_dialogue("Cono has been acting kinda strange, he doesn’t speak when spoken to not really", "Cyrus")
		tbi.queue_dialogue("What’s suspicious to me is the way chris died. Something doesn’t feel right", "Cyrus")
		tbi.sprite_change("Cyrus",cyrus_serious_no_speak,false)
		
		tbi.sprite_change("Kiri",kiri_serious_speak,false)
		tbi.queue_dialogue("To be fair, Cone has been under a lot of stress being homeless and all, I dont think it’s him", "Kiri")
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
		
		tbi.new_clean()
		
		tbi.queue_dialogue("I leave the room, hoping to find out what Chris did with those piñatas", "Humber")
		
	match (previous_location):
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIRI)
			kiri_cutscene()
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CHRIS)
			chris_cutscene()
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIMBIX)
			kimbix_cutscene()
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CONO)
			cono_cutscene()
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

const kitchen_background = preload("uid://bv6b0sxhiwmky")

func _on_kitchen_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Kitchen_Control".queue_free()
	var kitchen_trans = func():
		tbi.queue_all(null, null, null, null, kitchen_background, false, false)
		tbi.queue_dialogue("You went to the kitchen", "")
		await get_tree().create_timer(3.0).timeout
		tbi.change_state(tbi.State.READY)
		tbi.hide_textbox()
	tbi.fade_black_back_in(kitchen_scene, kitchen_trans)

var kitchen_scene = func():
	tbi.queue_dialogue(" * Maybe I should get a snack from the kitchen * ", "Humber")
	tbi.queue_dialogue(" * I'm craving a monster and flips, chris should have some left * ", "Humber")
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
		
		tbi.new_clean()
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
		
		tbi.new_clean()
		
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIRI)
			kiri_cutscene()
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CYRU)
			cyru_cutscene()
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.MAGNITUDE)
			magnitude_cutscene()
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.BICI)
			bici_cutscene()
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.KITCHEN

const bedroom_background = preload("uid://cib4uxv4l2jka")
func _on_bedroom_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Bedroom_Control".queue_free()
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
	tbi.queue_dialogue(" * A quick nap would help me concentrate more, I know just the place. I walk towards chris’s bedroom * ", "Humber")
	tbi.queue_dialogue(" * His room has a bunch of anime posters, a king sized bed in the center in between two nightstands * ", "Humber")
	tbi.queue_dialogue(" * Chris’s phone is left in one of them * ", "Humber")
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
		tbi.queue_dialogue("I know it's gonna sound crazy, but i think Chris is alive. yeah but he's not here, he's in audioplace.","Joaco")
		tbi.queue_dialogue("Yeah… Chris ascended to audio place and now he's going to be a sound engineer.","Joaco")
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
		
		tbi.new_clean()
		
		tbi.queue_dialogue(" * I scurry away before joaco can even think of peeling me layer by layer * ","Kimbix")
		
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
		tbi.queue_dialogue("We found some boxes inside of chris’ closet. They were all labeled as human-sized pin~ata, whatever that means","Bici")
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
		tbi.queue_dialogue("I think it was uke who did that, probably wanted to take out his anger before killing chris. Typical Uke.","Bici")
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
		
		tbi.new_clean()
		
		tbi.queue_dialogue("As I wave goodbye and leave, cone stares at me menacingly. What’s his problem?", "Humber")

	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CHRIS)
			chris_cutscene()
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CYRU)
			cyru_cutscene()
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.YEETUS)
			yeetus_cutscene()
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.UKESITO)
			uke_cutscene()
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.BEDROOM

const garage_background = preload("uid://bigfflpd5t1r5")
func _on_garage_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Garage_Control".queue_free()
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
	tbi.queue_dialogue(" * The garage is a good place to go, Chris has many tools there * ", "Humber")
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
		
		tbi.sprite_change("David",david_serious_speak,false)
		tbi.queue_dialogue("Hello", "David™")
		tbi.sprite_change("David",david_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Do you guys have any juicy evidence?", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.sprite_change("David",david_serious_speak,false)
		tbi.queue_dialogue("We found traces of horse food. It has to be the horse", "David™")
		tbi.queue_dialogue("THE HORSE KILLED CRIS", "David™")
		tbi.sprite_change("David",david_serious_no_speak,false)
		
		tbi.sprite_change("Paris",paris_serious_speak,false)
		tbi.queue_dialogue("David calm down", "Paris")
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("David",david_serious_speak,false)
		tbi.queue_dialogue("But Paris the horse. Why did we all eat with the horse like if it were just a normal person?", "David™")
		tbi.queue_dialogue("IT'S A HORSE. HORSES ARE MEANT TO BE EATEN", "David™")
		tbi.sprite_change("David",david_serious_no_speak,false)
		
		tbi.queue_dialogue("...", "Paris")
		tbi.queue_dialogue("...", "Kimbix")
		tbi.queue_dialogue("the others in the room stare at David", "")
		
		tbi.sprite_change("David",david_serious_speak,false)
		tbi.queue_dialogue("I'M GOING TO KILL YOU HORSE", "David™")
		tbi.sprite_change("David",david_serious_no_speak,false)
		tbi.queue_dialogue("david runs towards the closet and paris traps him inside", "")
		tbi.sprite_change("Padding",null,true)
		tbi.sprite_change("David",null,false)
		
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
		tbi.queue_dialogue("I think I spotted the horse doing some weird stuff over in chris’s bedroom", "Paris")
		tbi.queue_dialogue("You could go there", "Paris")
		tbi.sprite_change("Paris",paris_serious_no_speak,false)
		
		tbi.sprite_change("Humber",kimbix_serious_speak,true)
		tbi.queue_dialogue("Thanks for the info and the insane", "Humber")
		tbi.sprite_change("Humber",kimbix_serious_no_speak,true)
		
		tbi.new_clean()
		
		tbi.queue_dialogue(" * I go back towards the main hall feeling a bit disturbed. * ", "Humber")
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
		
		tbi.new_clean()
		
		tbi.queue_dialogue(" * I run towards the main hall * ", "Humber")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.KIMBIX)
			kimbix_cutscene()
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.MAGNITUDE)
			magnitude_cutscene()
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.YEETUS)
			yeetus_cutscene()
		Location.GARDEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.JOACO)
			joaco_cutscene()
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.GARAGE

const garden_background = preload("uid://6l53gfd7grsx")

func _on_garden_pressed():
	locations_container.visible = false
	current_state = State.PLACE_DIALOGUE
	$"../ButtonsLayer/LocationsContainer/Garden_Control".queue_free()
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
	tbi.queue_dialogue(" * Chris used to have a secret spot in the garden, but Google's satellite view said otherwise. * ", "Humber")
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
		
		tbi.queue_dialogue("I am given the zip lock and find it has a list with three names: chris, cono, david", "Humber")
		tbi.queue_dialogue("Chris has multiple lines striked through their name. I give back the ziplock", "Humber")
		tbi.queue_dialogue("This must be someone's. Chris never bought ziplock bags, something about the temptation of filling them with air and then deflating them over and over again.", "Humber")
		
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
		
		tbi.new_clean()
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
		
		tbi.new_clean()
		
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
		
		if (randi_range(0, 100) == 0): tbi.queue_dialogue("Yes", "Humber")
		else: tbi.queue_dialogue("No", "Humber")
		
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
		
		tbi.new_clean()
		
		tbi.queue_dialogue(" * We say our goodbyes and I head towards the main hall. I hope to never see someone drink a whole liter of fat again * ", "Humber")
	match (previous_location):
		Location.DUNGEON:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.CONO)
			cono_cutscene()
		Location.KITCHEN:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.BICI)
			bici_cutscene()
		Location.BEDROOM:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.UKESITO)
			uke_cutscene()
		Location.GARAGE:
			ScrPersistentData.possible_endings.append(ScrPersistentData.Endings.JOACO)
			joaco_cutscene()
		_:
			tbi.queue_dialogue("Nothing else happened", "")
	previous_location = Location.GARDEN
