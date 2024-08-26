extends Node2D
class_name Item

# Export variables to set the item's effects in the Godot editor
@export_group("Stat Modifiers")
@export var movement_speed_multiplier: float = 1.0
@export var dash_speed_multiplier: float = 1.0
@export var max_health_addition: int = 0
@export var pickup_range_addition: float = 0.0
@export var dash_duration_addition: float = 0.0
@export var dash_cooldown_addition: float = 0.0

@onready var player_character_stats_manager: Node2D = %PlayerCharacterStatsManager

# Apply the item's effects to the player stats
func apply_effects() -> void:
	player_character_stats_manager.add_stat_modifier("movement_speed", movement_speed_multiplier)
	player_character_stats_manager.add_stat_modifier("dash_speed_multiplier", dash_speed_multiplier)
	player_character_stats_manager.add_stat_modifier("max_health", max_health_addition)
	player_character_stats_manager.add_stat_modifier("pickup_range", pickup_range_addition)
	player_character_stats_manager.add_stat_modifier("dash_duration", dash_duration_addition)
	player_character_stats_manager.add_stat_modifier("dash_cooldown", dash_cooldown_addition)

# Remove the item's effects from the player stats
func remove_effects() -> void:
	player_character_stats_manager.remove_stat_modifier("movement_speed", movement_speed_multiplier)
	player_character_stats_manager.remove_stat_modifier("dash_speed_multiplier", dash_speed_multiplier)
	player_character_stats_manager.remove_stat_modifier("max_health", max_health_addition)
	player_character_stats_manager.remove_stat_modifier("pickup_range", pickup_range_addition)
	player_character_stats_manager.remove_stat_modifier("dash_duration", dash_duration_addition)
	player_character_stats_manager.remove_stat_modifier("dash_cooldown", dash_cooldown_addition)
