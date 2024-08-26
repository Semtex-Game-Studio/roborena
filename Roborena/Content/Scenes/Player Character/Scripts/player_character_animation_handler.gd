extends AnimatedSprite2D

@onready var player_character: CharacterBody2D = get_parent()

func _physics_process(delta):
	handle_player_animations()
	
func handle_player_animations() -> void:
	# Change animations
	if player_character.velocity.x or player_character.velocity.y != 0.0:
		play("Run")
	else:
		play("Idle")
	
	# Flip sprite
	if player_character.velocity.x < 0.0:
		flip_h = true
	if player_character.velocity.x > 0.0:
		flip_h = false
