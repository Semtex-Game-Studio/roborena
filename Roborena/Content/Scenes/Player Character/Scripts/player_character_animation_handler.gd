extends AnimatedSprite2D

@onready var player: CharacterBody2D = get_parent()

func _physics_process(delta):
	handle_player_animations()
	
func handle_player_animations() -> void:
	# Change animations
	if player.velocity.x or player.velocity.y != 0.0:
		play("Run")
	else:
		play("Idle")
	
	# Flip sprite
	if player.velocity.x < 0.0:
		flip_h = true
	if player.velocity.x > 0.0:
		flip_h = false
