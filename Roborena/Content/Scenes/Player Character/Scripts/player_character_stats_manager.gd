extends Node2D

@onready var player_character: CharacterBody2D = get_parent()

var additive_modifiers: Dictionary = {
	"max_health": 0,
	"pickup_range": 0,
	"dash_duration": 0,
	"dash_cooldown": 0
}

var multiplicative_modifiers: Dictionary = {
	"movement_speed": 1.0,
	"dash_speed_multiplier": 1.0
}

var base_stats: Dictionary = {}

func initialize_base_stats(movement_speed: float, dash_speed_multiplier: float, dash_duration: float, dash_cooldown: float, max_health: int, pickup_range: float) -> void:
	base_stats = {
		"movement_speed": movement_speed,
		"dash_speed_multiplier": dash_speed_multiplier,
		"dash_duration": dash_duration,
		"dash_cooldown": dash_cooldown,
		"max_health": max_health,
		"pickup_range": pickup_range
	}

func recalculate_stat(stat_name: String) -> float:
	if stat_name in additive_modifiers:
		return base_stats[stat_name] + additive_modifiers[stat_name]
	elif stat_name in multiplicative_modifiers:
		return base_stats[stat_name] * multiplicative_modifiers[stat_name]
	else:
		print("Unknown stat name: ", stat_name)
		return 0

func add_item_modifiers(item: Item) -> void:
	# Apply item modifiers
	additive_modifiers["max_health"] += item.max_health_addition
	additive_modifiers["pickup_range"] += item.pickup_range_addition
	additive_modifiers["dash_duration"] += item.dash_duration_addition
	additive_modifiers["dash_cooldown"] += item.dash_cooldown_addition
	multiplicative_modifiers["movement_speed"] *= item.movement_speed_multiplier
	multiplicative_modifiers["dash_speed_multiplier"] *= item.dash_speed_multiplier

func remove_item_modifiers(item: Item) -> void:
	# Revert item modifiers
	additive_modifiers["max_health"] -= item.max_health_addition
	additive_modifiers["pickup_range"] -= item.pickup_range_addition
	additive_modifiers["dash_duration"] -= item.dash_duration_addition
	additive_modifiers["dash_cooldown"] -= item.dash_cooldown_addition
	multiplicative_modifiers["movement_speed"] /= item.movement_speed_multiplier
	multiplicative_modifiers["dash_speed_multiplier"] /= item.dash_speed_multiplier
