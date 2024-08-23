extends Area2D


@export var collectable_id: String
@export var currency_value: int
@onready var has_been_collected: bool = false
@onready var speed: float = 0.0  # Initial speed

var player_character_ref: CharacterBody2D = null

func _physics_process(delta):
	move_to_player(delta)
	

func on_collected(player_character):
	player_character_ref = player_character
	if has_been_collected:
		return
	has_been_collected = true

func move_to_player(delta):
	if has_been_collected:
		speed += 80 * delta
		position = position.lerp(player_character_ref.position, speed * delta)
		
		if position.distance_to(player_character_ref.position) < 20:
			queue_free()
