extends Area2D

@export var collectable_id: String
@export var currency_value: int

@onready var has_been_collected: bool = false
@onready var speed: float = 0.0
@onready var collectable_pickup_sound: AudioStreamPlayer = $CollectablePickupSound

var player_character_ref: CharacterBody2D = null
var sound_played: bool = false  # Flag to track if the sound has been played

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
		var distance = position.distance_to(player_character_ref.position)
		
		if distance < 30:
			var scale_factor = distance / 30
			scale = scale * scale_factor
			
		if distance < 10:
			if not sound_played:
				collectable_pickup_sound.play()
				sound_played = true  # Set the flag to true to ensure the sound is only played once
			
			if not collectable_pickup_sound.playing:
				queue_free()
