extends Area2D

@onready var player_character = get_parent()


func _on_area_entered(area):
	if area.collectable_id == "Collectable 1":
		area.on_collected(player_character)
		player_character.player_currency += area.currency_value
