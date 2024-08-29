extends Node2D

@onready var player_character: CharacterBody2D = get_parent()

var movement_speed: float
var dash_speed_multiplier: float
var dash_duration: float
var dash_cooldown: float

var is_dashing: bool = false
var dash_time_left: float = 0.0
var dash_cooldown_time_left: float = 0.0

func _ready():
	movement_speed = player_character.movement_speed
	dash_duration = player_character.dash_duration
	dash_cooldown = player_character.dash_cooldown
	dash_speed_multiplier = player_character.dash_speed_multiplier

func _physics_process(delta: float) -> void:
	handle_dash(delta)
	handle_player_movement(delta)

func handle_player_movement(delta: float) -> void:
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	var speed = movement_speed
	
	if is_dashing:
		speed *= dash_speed_multiplier
	
	player_character.velocity = input_direction * speed * delta
	player_character.move_and_slide()

func handle_dash(delta: float) -> void:
	if dash_cooldown_time_left > 0:
		dash_cooldown_time_left -= delta

	if is_dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			is_dashing = false
			dash_cooldown_time_left = dash_cooldown
	elif Input.is_action_just_pressed("Dash") and dash_cooldown_time_left <= 0:
		is_dashing = true
		dash_time_left = dash_duration
