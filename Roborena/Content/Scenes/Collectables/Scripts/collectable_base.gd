extends Area2D


@export var currency_value: int

@onready var game_node: Node = get_node("/root/Game")

var has_been_collected: bool = false
		
# Function called when another body enters the collectible's area
func _on_body_entered(body: Node) -> void:
	if body.name == "PlayerCharacter":
		if has_been_collected:
			return
		has_been_collected = true
		game_node.player_currency += currency_value
		queue_free()
