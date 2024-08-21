extends Node2D


@onready var player_currency: int = 0

var player_curency_old: int = 0

func _process(delta):
	if player_currency != player_curency_old:
		player_curency_old = player_currency
