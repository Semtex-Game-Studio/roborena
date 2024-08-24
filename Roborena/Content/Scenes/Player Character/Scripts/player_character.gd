extends CharacterBody2D

@export_group("Player Stats")
@export var movement_speed: float = 25000.0
@export var dash_speed_multiplier: float = 1.8
@export var dash_duration: float = 0.8  # Duration of the dash in seconds
@export var dash_cooldown: float = 1.0  # Cooldown time before next dash
@export var max_health: int = 100
@export var pickup_range: float = 40.0

@onready var player_currency: int = 0

var is_dashing: bool = false
var dash_time_left: float = 0.0
var dash_cooldown_time_left: float = 0.0

func _physics_process(delta):
	handle_dash(delta)
	handle_player_movement(delta)

func handle_dash(delta) -> void:
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


func handle_player_movement(delta) -> void:
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	var speed = movement_speed

	if is_dashing:
		speed *= dash_speed_multiplier

	velocity = input_direction * speed * delta
	move_and_slide()
