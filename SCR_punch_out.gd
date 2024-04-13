extends Node2D

@onready var player_instance = $Player
var player_init_pos : Vector2 = Vector2.ZERO

@onready var oponent_instance = $Oponent
var oponent_init_pos : Vector2 = Vector2.ZERO

const player_max_health : float = 100.0
const oponent_max_health : float = 1500.0
var player_health : float = player_max_health
var oponent_health : float = oponent_max_health

var player_damage : float = 10.0
var oponent_damage : float = 10.0

# PLAYER TIMERS
var punch_cooldown_timer : float = 0.0
const punch_cooldown_wait : float = 0.75

var punch_combo : int = 0
var punch_combo_drain_rate : float = 1.0
var punch_combo_cooldown_timer : float = 0.0
const punch_combo_cooldown_wait : float = 3.0

var dodge_cooldown_timer : float = 0.0
const dodge_cooldown_wait : float = 0.6
# END PLAYER TIMERS

# OPONENT TIMERS
var oponent_hitstun_timer : float = 0.0
const oponent_hitstun_wait : float = 0.1

var oponent_attack_timer : float = 0.0
const oponent_attack_wait : float = 4.0
# END OPONENT TIMERS

enum punch {
	LEFT,
	RIGHT,
	STAR
}
var last_punch : punch = punch.STAR

enum fighter_state {
	IDLE,
	PUNCHING,
	RIGHT_DODGE,
	LEFT_DODGE,
	DOWN_DODGE,
	BLOCKING,
	BEING_HIT,
	DEFEATED
}
var player_state : fighter_state = fighter_state.IDLE
var oponent_state : fighter_state = fighter_state.IDLE

func _ready():
	player_instance.position.x = get_viewport_rect().size.x / 2
	player_instance.position.y = get_viewport_rect().size.y - 300
	player_init_pos = player_instance.position

	oponent_instance.position.x = get_viewport_rect().size.x / 2
	oponent_instance.position.y = get_viewport_rect().size.y - 500
	oponent_init_pos = oponent_instance.position
	
	oponent_attack_timer = oponent_attack_wait * 1.5
	pass

func _process(delta):
	if (oponent_state == fighter_state.DEFEATED):
		oponent_sprite.rotate(0.05)
		oponent_sprite.position += Vector2(randi_range(-3, 10), randi_range(-10, 3))
		print("WIN WIN WIN")
		return
	if (player_state == fighter_state.DEFEATED):
		player_sprite.rotate(0.05)
		player_sprite.position += Vector2(randi_range(-10, 3), randi_range(3, 10))
		print("LOSE LOSE LOSE")
		return
	
	if (oponent_sprite.frame == 0 and oponent_sprite.animation == "idle"):
		oponent_sprite.flip_h = not oponent_sprite.flip_h
		oponent_sprite.frame += 1
		
	if (not player_sprite.is_playing()):
		player_sprite.play("idle")
	
	if (not oponent_sprite.is_playing()):
		oponent_sprite.play("idle")
		if (oponent_state == fighter_state.PUNCHING): oponent_state = fighter_state.IDLE
	
	if (oponent_attack_timer > 0):
		oponent_attack_timer -= delta
	else:
		match(randi_range(0, 3)):
			0: oponent_punch_left()
			1: oponent_punch_right()
			2:
				if (oponent_health < 1000): oponent_hook_left()
				else: oponent_punch_left()
			3:
				if (oponent_health < 1000): oponent_hook_right()
				else: oponent_punch_right()
			_: pass
		oponent_attack_timer = oponent_attack_wait * randf_range(0.5, 1)
	
	# Dodge logic
	if (dodge_cooldown_timer > 0):
		dodge_cooldown_timer -= delta
		var offset = sin((dodge_cooldown_timer - dodge_cooldown_wait) * 5.2) * 150
		if (player_state == fighter_state.LEFT_DODGE):
			player_instance.position.x = player_init_pos.x + offset
		if (player_state == fighter_state.RIGHT_DODGE):
			player_instance.position.x = player_init_pos.x - offset
		if (player_state == fighter_state.DOWN_DODGE):
			player_instance.position.y = player_init_pos.y - (offset / 3)
	elif (player_state == fighter_state.LEFT_DODGE
	or player_state == fighter_state.RIGHT_DODGE
	or player_state == fighter_state.DOWN_DODGE):
		player_change_state(fighter_state.IDLE)
		player_instance.position = player_init_pos
	
	# Punch combo logic
	if (punch_combo_cooldown_timer > 0):
		punch_combo_cooldown_timer -= delta * punch_combo_drain_rate
	elif (punch_combo > 0):
		print("Combo lost!")
		punch_combo_drain_rate = 1.0
		punch_combo = 0
		$Buttonlayer/MarginContainer/VBoxContainer/Combo.text = "Combo " + str(punch_combo)
	
	# Punch cooldown logic
	if (punch_cooldown_timer > 0):
		punch_cooldown_timer -= delta
		player_instance.position = player_instance.position.move_toward(player_init_pos, 150 * delta)
	elif (player_state == fighter_state.PUNCHING):
		player_sprite.play("idle")
		player_sprite.speed_scale = 1.0
		player_change_state(fighter_state.IDLE)
		player_instance.position = player_init_pos
	
	if (oponent_hitstun_timer > 0.0): oponent_hitstun_timer -= delta
	elif (oponent_state == fighter_state.BEING_HIT): oponent_change_state(fighter_state.IDLE)

func _input(event):
	if Input.is_action_just_pressed("punch_left"): player_punch_left()
	if Input.is_action_just_pressed("punch_right"): player_punch_right()
	if Input.is_action_just_pressed("dodge_left"): player_dodge_left()
	if Input.is_action_just_pressed("dodge_right"): player_dodge_right()
	if Input.is_action_just_pressed("dodge_down"): player_dodge_down()
	
	if Input.is_key_pressed(KEY_PAGEUP): oponent_hook_right()

func player_change_state(state : fighter_state):
	player_state = state
	match(state):
		fighter_state.IDLE: print("Player state is now fighter_state.IDLE")
		fighter_state.PUNCHING: print("Player state is now fighter_state.PUNCHING")
		fighter_state.RIGHT_DODGE: print("Player state is now fighter_state.RIGHT_DODGE")
		fighter_state.LEFT_DODGE: print("Player state is now fighter_state.LEFT_DODGE")
		fighter_state.DOWN_DODGE: print("Player state is now fighter_state.DOWN_DODGE")
		fighter_state.BEING_HIT: print("Player state is now fighter_state.BEING_HIT")
		fighter_state.DEFEATED: print("Player state is now fighter_state.DEFEATED")

func oponent_change_state(state : fighter_state):
	oponent_state = state
	match(state):
		fighter_state.IDLE: print("Oponent state is now fighter_state.IDLE")
		fighter_state.PUNCHING: print("Oponent state is now fighter_state.PUNCHING")
		fighter_state.RIGHT_DODGE: print("Oponent state is now fighter_state.RIGHT_DODGE")
		fighter_state.LEFT_DODGE: print("Oponent state is now fighter_state.LEFT_DODGE")
		fighter_state.DOWN_DODGE: print("Oponent state is now fighter_state.DOWN_DODGE")
		fighter_state.BEING_HIT: print("Oponent state is now fighter_state.BEING_HIT")
		fighter_state.DEFEATED: print("Oponent state is now fighter_state.DEFEATED")

@onready var player_sprite : AnimatedSprite2D = $Player/Sprite2D
@onready var oponent_sprite : AnimatedSprite2D = $Oponent/Sprite2D

func player_punch_left():
	if (player_sprite.animation == "punch"): return
	if (player_state != fighter_state.IDLE and player_state != fighter_state.PUNCHING): return
	if ((last_punch == punch.LEFT or last_punch == punch.STAR) and punch_cooldown_timer > 0.0): return
	if (last_punch == punch.RIGHT and punch_cooldown_timer > 0.6): return
	
	player_sprite.flip_h = false
	player_sprite.play("punch")
	player_sprite.speed_scale = 1 + (punch_combo / 10.0)
	
	if (oponent_state == fighter_state.BLOCKING):
		print("Punch Blocked!")
		return
	
	player_instance.position.y -= 30
	
	last_punch = punch.LEFT
	player_change_state(fighter_state.PUNCHING)
	punch_cooldown_timer = punch_cooldown_wait
	
	oponent_get_hit()
	
	punch_combo += 1
	$Buttonlayer/MarginContainer/VBoxContainer/Combo.text = "Combo " + str(punch_combo)
	punch_combo_cooldown_timer = punch_combo_cooldown_wait
	punch_combo_drain_rate = max(3.5, punch_combo_drain_rate + 0.05)
	pass

func player_punch_right():
	if (player_sprite.animation == "punch"): return
	if (player_state != fighter_state.IDLE and player_state != fighter_state.PUNCHING): return
	if ((last_punch == punch.RIGHT or last_punch == punch.STAR) and punch_cooldown_timer > 0.0): return
	if (last_punch == punch.LEFT and punch_cooldown_timer > 0.5): return
	
	player_sprite.flip_h = true
	player_sprite.play("punch")
	player_sprite.speed_scale = 1 + (punch_combo / 10.0)
	
	if (oponent_state == fighter_state.BLOCKING):
		print("Punch Blocked!")
		return
	
	player_instance.position.y -= 30
	
	last_punch = punch.RIGHT
	player_change_state(fighter_state.PUNCHING)
	punch_cooldown_timer = punch_cooldown_wait
	
	oponent_get_hit()
	
	punch_combo += 1
	$Buttonlayer/MarginContainer/VBoxContainer/Combo.text = "Combo " + str(punch_combo)
	punch_combo_cooldown_timer = punch_combo_cooldown_wait
	punch_combo_drain_rate = max(3.5, punch_combo_drain_rate + 0.05)
	pass
	
func player_dodge_left():
	if (player_state == fighter_state.RIGHT_DODGE
	or player_state == fighter_state.DOWN_DODGE): return
	if (dodge_cooldown_timer > 0.0): return
	
	if (player_state == fighter_state.PUNCHING and player_sprite.frame < 3): return
	
	player_change_state(fighter_state.LEFT_DODGE)
	dodge_cooldown_timer = dodge_cooldown_wait
	
	punch_combo_cooldown_timer = min(punch_combo_cooldown_wait, dodge_cooldown_timer + 1.0)
	pass

func player_dodge_right():
	if (player_state == fighter_state.LEFT_DODGE
	or player_state == fighter_state.DOWN_DODGE): return
	if (dodge_cooldown_timer > 0.0): return
	
	if (player_state == fighter_state.PUNCHING and player_sprite.frame < 3): return
	
	player_change_state(fighter_state.RIGHT_DODGE)
	dodge_cooldown_timer = dodge_cooldown_wait
	
	punch_combo_cooldown_timer = min(punch_combo_cooldown_wait, dodge_cooldown_timer + 1.0)
	pass

func player_dodge_down():
	if (player_state == fighter_state.LEFT_DODGE
	or player_state == fighter_state.RIGHT_DODGE): return
	if (dodge_cooldown_timer > 0.0): return
	
	if (player_state == fighter_state.PUNCHING and player_sprite.frame < 3): return
	
	player_change_state(fighter_state.DOWN_DODGE)
	dodge_cooldown_timer = dodge_cooldown_wait
	
	punch_combo_cooldown_timer = min(punch_combo_cooldown_wait, dodge_cooldown_timer + 1.0)
	pass

func oponent_get_hit():
	if (punch_combo > 5):
		oponent_change_state(fighter_state.BEING_HIT)
	
	oponent_health -= player_damage * (1 + (punch_combo / 25.0))
	print("Oponent HP: (", oponent_health, " / ", oponent_max_health, ")")
	
	oponent_hitstun_timer = oponent_hitstun_wait
	
	await get_tree().create_timer(((1.0 / 12.0) * 4.0) / player_sprite.speed_scale).timeout
	var tween = get_tree().create_tween()
	oponent_sprite.modulate = Color(1,0,0)
	tween.tween_property(oponent_sprite, "modulate", Color(1,1,1), 0.25 / player_sprite.speed_scale)
	$Buttonlayer/MarginContainer/VBoxContainer/ConeHealth.text = "Cone Tyson " + str(oponent_health)
	
	if (oponent_health < 0):
		oponent_sprite.play("defeat")
		oponent_state = fighter_state.DEFEATED
		await get_tree().create_timer(1.0).timeout
		var thing_modulate = get_tree().create_tween()
		var all = $"."
		thing_modulate.tween_property(all, "modulate", Color(0,0,0), 2.5)
		var background_modulate = get_tree().create_tween()
		var background = $CanvasLayer/MarginContainer
		background_modulate.tween_property(background, "modulate", Color(0,0,0), 3.0)
		var callbacc = func():
			# TODO: Change so it displays the correct scene
			get_tree().change_scene_to_file("res://Scenes/Main Menu/SCN_main_menu.tscn")
		background_modulate.tween_callback(callbacc)

func check_dead():
	if (player_health > 0):
		$Buttonlayer/MarginContainer/VBoxContainer/KimbixHealth.text = "Streamer " + str(player_health)
		return
	player_state = fighter_state.DEFEATED
	
	await get_tree().create_timer(1.0).timeout
	$Buttonlayer/Buttons.visible = true

func damage_player_center():
	if (player_state == fighter_state.DOWN_DODGE
	or player_state == fighter_state.IDLE
	or player_state == fighter_state.PUNCHING):
		player_health -= 10.0
		var tween = get_tree().create_tween()
		player_sprite.modulate = Color(1,0,0)
		tween.tween_property(player_sprite, "modulate", Color(1,1,1), 0.25)
		
		check_dead()

func damage_player_right():
	if (player_state == fighter_state.RIGHT_DODGE
	or player_state == fighter_state.IDLE
	or player_state == fighter_state.PUNCHING):
		player_health -= 10.0
		var tween = get_tree().create_tween()
		player_sprite.modulate = Color(1,0,0)
		tween.tween_property(player_sprite, "modulate", Color(1,1,1), 0.25)
		
		check_dead()

func damage_player_left():
	if (player_state == fighter_state.LEFT_DODGE
	or player_state == fighter_state.IDLE
	or player_state == fighter_state.PUNCHING):
		player_health -= 10.0
		var tween = get_tree().create_tween()
		player_sprite.modulate = Color(1,0,0)
		tween.tween_property(player_sprite, "modulate", Color(1,1,1), 0.25)
		
		check_dead()

func oponent_punch_left():
	if (oponent_state == fighter_state.PUNCHING): return
	
	oponent_sprite.flip_h = false
	oponent_change_state(fighter_state.PUNCHING)
	oponent_sprite.play("punch")
	
	await get_tree().create_timer(0.5).timeout
	damage_player_center()

func oponent_punch_right():
	if (oponent_state == fighter_state.PUNCHING): return
	
	oponent_sprite.flip_h = true
	oponent_change_state(fighter_state.PUNCHING)
	oponent_sprite.play("punch")
	
	await get_tree().create_timer(0.5).timeout
	damage_player_center()
	
func oponent_hook_right():
	if (oponent_state == fighter_state.PUNCHING): return
	
	oponent_sprite.flip_h = false
	oponent_change_state(fighter_state.PUNCHING)
	oponent_sprite.play("hook")
	
	await get_tree().create_timer(0.5).timeout
	damage_player_right()
	
func oponent_hook_left():
	if (oponent_state == fighter_state.PUNCHING): return
	
	oponent_sprite.flip_h = true
	oponent_change_state(fighter_state.PUNCHING)
	oponent_sprite.play("hook")
	
	await get_tree().create_timer(0.5).timeout
	damage_player_left()


func _on_retry_pressed():
	get_tree().reload_current_scene()
func _on_quit_pressed():
	get_tree().quit()
