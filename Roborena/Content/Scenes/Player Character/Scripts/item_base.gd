extends Node2D
class_name Item

@export_group("Stat Modifiers")
@export var movement_speed_multiplier: float = 1.0
@export var dash_speed_multiplier: float = 1.0
@export var max_health_addition: int = 0
@export var pickup_range_addition: float = 0.0
@export var dash_duration_addition: float = 0.0
@export var dash_cooldown_addition: float = 0.0

@export_group("Weapon Stat Modifiers")
@export var weapon_damage_multiplier: float = 1.0
@export var fire_rate_multiplier: float = 1.0
@export var crit_chance_addition: float = 0.0
@export var crit_modifier_multiplier: float = 1.0
@export var knockback_force_multiplier: float = 1.0
@export var bullet_spread_multiplier: float = 1.0  # Added bullet spread multiplier
@export var weapon_range_addition: int = 0

@onready var player_character_stats_manager: Node2D = %PlayerCharacterStatsManager
@onready var player_character_weapon_holder: Node2D = %PlayerCharacterWeaponHolder

# Apply the item's effects to the player stats and weapon stats
func apply_effects() -> void:
	player_character_stats_manager.add_stat_modifier("movement_speed", movement_speed_multiplier)
	player_character_stats_manager.add_stat_modifier("dash_speed_multiplier", dash_speed_multiplier)
	player_character_stats_manager.add_stat_modifier("max_health", max_health_addition)
	player_character_stats_manager.add_stat_modifier("pickup_range", pickup_range_addition)
	player_character_stats_manager.add_stat_modifier("dash_duration", dash_duration_addition)
	player_character_stats_manager.add_stat_modifier("dash_cooldown", dash_cooldown_addition)
	
	# Apply weapon stat modifiers
	apply_weapon_modifiers()

# Remove the item's effects from the player stats and weapon stats
func remove_effects() -> void:
	player_character_stats_manager.remove_stat_modifier("movement_speed", movement_speed_multiplier)
	player_character_stats_manager.remove_stat_modifier("dash_speed_multiplier", dash_speed_multiplier)
	player_character_stats_manager.remove_stat_modifier("max_health", max_health_addition)
	player_character_stats_manager.remove_stat_modifier("pickup_range", pickup_range_addition)
	player_character_stats_manager.remove_stat_modifier("dash_duration", dash_duration_addition)
	player_character_stats_manager.remove_stat_modifier("dash_cooldown", dash_cooldown_addition)

	# Remove weapon stat modifiers
	remove_weapon_modifiers()

# Apply weapon modifiers to each weapon held by the player
func apply_weapon_modifiers() -> void:
	for weapon in player_character_weapon_holder.get_children():
		if weapon is Weapon:
			weapon.add_stat_modifier("weapon_damage_multiplier", weapon_damage_multiplier)
			weapon.add_stat_modifier("fire_rate_multiplier", fire_rate_multiplier)
			weapon.add_additive_stat_modifier("crit_chance_addition", crit_chance_addition)
			weapon.add_stat_modifier("crit_modifier_multiplier", crit_modifier_multiplier)
			weapon.add_stat_modifier("knockback_force_multiplier", knockback_force_multiplier)
			weapon.add_stat_modifier("bullet_spread_multiplier", bullet_spread_multiplier)  # Added bullet spread multiplier
			weapon.add_additive_stat_modifier("weapon_range_addition", weapon_range_addition)

# Remove weapon modifiers from each weapon held by the player
func remove_weapon_modifiers() -> void:
	for weapon in player_character_weapon_holder.get_children():
		if weapon is Weapon:
			weapon.remove_stat_modifier("weapon_damage_multiplier", weapon_damage_multiplier)
			weapon.remove_stat_modifier("fire_rate_multiplier", fire_rate_multiplier)
			weapon.remove_additive_stat_modifier("crit_chance_addition", crit_chance_addition)
			weapon.remove_stat_modifier("crit_modifier_multiplier", crit_modifier_multiplier)
			weapon.remove_stat_modifier("knockback_force_multiplier", knockback_force_multiplier)
			weapon.remove_stat_modifier("bullet_spread_multiplier", bullet_spread_multiplier)  # Added bullet spread multiplier
			weapon.remove_additive_stat_modifier("weapon_range_addition", weapon_range_addition)
