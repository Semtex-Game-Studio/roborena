extends CharacterBody2D


@export var movement_speed: float = 25000.0
@export var dash_speed: float = 100000.0
@export var max_health: int = 100

@onready var dash = $Dash
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurt_box = %HurtBox

var current_health: int

func _ready():
	current_health = max_health

func _physics_process(delta):
	handle_player_movement(delta)
	handle_player_animations()


func handle_player_movement(delta) -> void:
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	var speed = dash_speed if dash.is_dashing() else movement_speed
	velocity = input_direction * speed * delta

	if Input.is_action_just_pressed("Dash") and dash.can_dash and !dash.is_dashing():
		dash.start_dash()
	move_and_slide()


func handle_player_animations() -> void:
	# Change animations
	if velocity.x or velocity.y != 0.0:
		$AnimatedSprite2D.play("Run")
	else:
		$AnimatedSprite2D.play("Idle")
	
	# Flip sprite
	if velocity.x < 0.0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0.0:
		$AnimatedSprite2D.flip_h = false


func take_damage(damage:int):
	current_health -= damage
	print("current healt:", current_health)
	if current_health <= 0:
		print("game over")
