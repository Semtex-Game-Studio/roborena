extends Node

var items: Array = []  # Stores items in an array

@onready var player_character: CharacterBody2D = get_parent()
@onready var loaded_item: Item = load("res://Content/Scenes/Items/Item1.tres")
@onready var loaded_item2: Item = load("res://Content/Scenes/Items/Item2.tres")

func _ready():
	add_item(loaded_item)
	add_item(loaded_item)
	add_item(loaded_item2)

func add_item(item: Item):
	items.append(item)
	update_player_stats()

func update_player_stats():
	var total_movement_speed = player_character.base_movement_speed
	var total_dash_speed_multiplier = player_character.base_dash_speed_multiplier
	var total_max_health = player_character.base_max_health
	var total_pickup_range = player_character.base_pickup_range
	var total_dash_duration = player_character.base_dash_duration
	var total_dash_cooldown = player_character.base_dash_cooldown
	
	for item in items:
		# Multiplicative bonuses
		total_movement_speed *= item.movement_speed_multiplier
		total_dash_speed_multiplier *= item.dash_speed_multiplier
		
		# Additive bonuses
		total_max_health += item.max_health_addition
		total_pickup_range += item.pickup_range_addition
		total_dash_duration += item.dash_duration_addition
		total_dash_cooldown += item.dash_cooldown_addition
	
	player_character.update_stats(
		total_movement_speed,
		total_dash_speed_multiplier,
		total_max_health,
		total_pickup_range,
		total_dash_duration,
		total_dash_cooldown
	)
