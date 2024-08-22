extends Area2D


@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer
@onready var enemy: Node2D = get_parent() as Node2D
@onready var attack_damage: int = enemy.attack_damage

var can_damage_player: bool = true

# Main process function to handle damage dealing
func _process(delta: float) -> void:
	deal_damage()

# Function to detect and deal damage to the player
func deal_damage() -> void:
	var player_detection: Array = get_overlapping_areas()

	if player_detection.size() > 0 and can_damage_player:
		var player_hurtbox: Area2D = player_detection[0] as Area2D
		player_hurtbox.take_damage(attack_damage)
		can_damage_player = false
		attack_cooldown_timer.start()

# Resets the ability to damage the player after the cooldown
func _on_attack_cooldown_timer_timeout() -> void:
	can_damage_player = true
   
