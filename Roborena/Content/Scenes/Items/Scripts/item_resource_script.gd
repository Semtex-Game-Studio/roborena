extends Resource
class_name Item

@export_group("Item Information")
@export var item_name: String
@export_range(1, 5) var item_rarity: int
@export var item_icon: Texture2D

@export_group("Player Stat Modifiers")
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
@export var bullet_spread_multiplier: float = 1.0 
@export var weapon_range_addition: int = 0
