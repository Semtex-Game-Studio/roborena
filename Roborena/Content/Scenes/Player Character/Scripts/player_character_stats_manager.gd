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

func recalculate_stat(stat_name: String) -> Variant:
	if stat_name in additive_modifiers:
		return base_stat(stat_name) + additive_modifiers[stat_name]
	elif stat_name in multiplicative_modifiers:
		return base_stat(stat_name) * multiplicative_modifiers[stat_name]
	else:
		print("Unknown stat name: ", stat_name)
		return 0

func base_stat(stat_name: String) -> Variant:
	match stat_name:
		"max_health": return player_character.base_max_health
		"pickup_range": return player_character.base_pickup_range
		"dash_duration": return player_character.base_dash_duration
		"dash_cooldown": return player_character.base_dash_cooldown
		"movement_speed": return player_character.base_movement_speed
		"dash_speed_multiplier": return player_character.base_dash_speed_multiplier
		_:
			print("Unknown base stat: ", stat_name)
			return 0

func add_stat_modifier(stat_name: String, value: float) -> void:
	if stat_name in additive_modifiers:
		additive_modifiers[stat_name] += value
	elif stat_name in multiplicative_modifiers:
		multiplicative_modifiers[stat_name] *= value
	else:
		print("Unknown stat name for modification: ", stat_name)

func remove_stat_modifier(stat_name: String, value: float) -> void:
	if stat_name in additive_modifiers:
		additive_modifiers[stat_name] -= value
	elif stat_name in multiplicative_modifiers:
		multiplicative_modifiers[stat_name] /= value
	else:
		print("Unknown stat name for removal: ", stat_name)
