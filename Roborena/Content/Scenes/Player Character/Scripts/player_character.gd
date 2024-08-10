extends CharacterBody2D


@export var movement_speed = 25000.0
@export var dash_speed = 100000.0

@onready var dash = $Dash
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	handle_player_movement(delta)
	handle_player_animations()

func handle_player_movement(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	var speed = dash_speed if dash.is_dashing() else movement_speed
	velocity = input_direction * speed * delta

	if Input.is_action_just_pressed("Dash") and dash.can_dash and !dash.is_dashing():
		dash.start_dash()
	move_and_slide()

func handle_player_animations():
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
