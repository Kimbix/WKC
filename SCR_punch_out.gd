extends Node2D

@onready var player_instance = $Player
var player_init_pos : Vector2 = Vector2.ZERO

@onready var oponent_instance = $Oponent
var oponent_init_pos : Vector2 = Vector2.ZERO

const player_max_health : float = 100.0
const oponent_max_health : float = 3000.0
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
const oponent_hitstun_wait : float = 0.33
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
	player_instance.position.y = get_viewport_rect().size.y - 200
	player_init_pos = player_instance.position

	oponent_instance.position.x = get_viewport_rect().size.x / 2
	oponent_instance.position.y = get_viewport_rect().size.y - 400
	oponent_init_pos = oponent_instance.position
	pass

func _process(delta):
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
	
	# Punch cooldown logic
	if (punch_cooldown_timer > 0):
		punch_cooldown_timer -= delta
		player_instance.position = player_instance.position.move_toward(player_init_pos, 150 * delta)
	elif (player_state == fighter_state.PUNCHING):
		player_change_state(fighter_state.IDLE)
		player_instance.position = player_init_pos
	
	if (oponent_hitstun_timer > 0.0):
		oponent_hitstun_timer -= delta
		oponent_instance.position = oponent_instance.position.move_toward(oponent_init_pos, 50 * delta)
	elif (oponent_state == fighter_state.BEING_HIT):
		oponent_change_state(fighter_state.IDLE)
		oponent_instance.position = oponent_init_pos

func _input(event):
	if Input.is_key_pressed(KEY_Z): player_punch_left()
	if Input.is_key_pressed(KEY_X): player_punch_right()
	if Input.is_key_pressed(KEY_LEFT): player_dodge_left()
	if Input.is_key_pressed(KEY_RIGHT): player_dodge_right()
	if Input.is_key_pressed(KEY_DOWN): player_dodge_down()

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

func player_punch_left():
	if (player_state != fighter_state.IDLE and player_state != fighter_state.PUNCHING): return
	if ((last_punch == punch.LEFT or last_punch == punch.STAR) and punch_cooldown_timer > 0.0): return
	if (last_punch == punch.RIGHT and punch_cooldown_timer > 0.6): return
	
	if (oponent_state == fighter_state.BLOCKING):
		print("Punch Blocked!")
		return
	
	player_instance.position.y -= 30
	
	last_punch = punch.LEFT
	player_change_state(fighter_state.PUNCHING)
	punch_cooldown_timer = punch_cooldown_wait
	
	oponent_get_hit()
	
	punch_combo += 1
	punch_combo_cooldown_timer = punch_combo_cooldown_wait
	punch_combo_drain_rate = max(3.5, punch_combo_drain_rate + 0.05)
	pass

func player_punch_right():
	if (player_state != fighter_state.IDLE and player_state != fighter_state.PUNCHING): return
	if ((last_punch == punch.RIGHT or last_punch == punch.STAR) and punch_cooldown_timer > 0.0): return
	if (last_punch == punch.LEFT and punch_cooldown_timer > 0.5): return
	
	player_instance.position.y -= 30
	
	last_punch = punch.RIGHT
	player_change_state(fighter_state.PUNCHING)
	punch_cooldown_timer = punch_cooldown_wait
	
	oponent_get_hit()
	
	punch_combo += 1
	punch_combo_cooldown_timer = punch_combo_cooldown_wait
	punch_combo_drain_rate = max(3.5, punch_combo_drain_rate + 0.05)
	pass
	
func player_dodge_left():
	if (player_state != fighter_state.IDLE): return
	if (dodge_cooldown_timer > 0.0): return
	
	player_change_state(fighter_state.LEFT_DODGE)
	dodge_cooldown_timer = dodge_cooldown_wait
	
	punch_combo_cooldown_timer = min(punch_combo_cooldown_wait, dodge_cooldown_timer + 1.0)
	pass

func player_dodge_right():
	if (player_state != fighter_state.IDLE): return
	if (dodge_cooldown_timer > 0.0): return
	
	player_change_state(fighter_state.RIGHT_DODGE)
	dodge_cooldown_timer = dodge_cooldown_wait
	
	punch_combo_cooldown_timer = min(punch_combo_cooldown_wait, dodge_cooldown_timer + 1.0)
	pass

func player_dodge_down():
	if (player_state != fighter_state.IDLE): return
	if (dodge_cooldown_timer > 0.0): return
	
	player_change_state(fighter_state.DOWN_DODGE)
	dodge_cooldown_timer = dodge_cooldown_wait
	
	punch_combo_cooldown_timer = min(punch_combo_cooldown_wait, dodge_cooldown_timer + 1.0)
	pass

func oponent_get_hit():
	oponent_change_state(fighter_state.BEING_HIT)
	
	oponent_health -= player_damage * (1 + (punch_combo / 25.0))
	print("Oponent HP: (", oponent_health, " / ", oponent_max_health, ")")
	
	oponent_instance.position = oponent_init_pos + Vector2(randi_range(-32, 32), randi_range(-72, -16))
	oponent_hitstun_timer = oponent_hitstun_wait
	pass

func oponent_punch_left():
	pass

func oponent_punch_right():
	pass
