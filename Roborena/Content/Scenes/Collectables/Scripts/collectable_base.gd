extends Area2D

@export var currency_value: int
@onready var game_node = get_node("/root/Game")

func _ready():
	print(game_node)
	
func _on_body_entered(body):
	if body.name == "PlayerCharacter":
		game_node.player_currency += currency_value
		queue_free()
