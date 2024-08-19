extends Node2D


@onready var player_currency: int = 0

func _physics_process(delta):
	print(player_currency)
