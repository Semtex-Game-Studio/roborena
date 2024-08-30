extends Node

var items: Array = []  # Stores items in an array

@onready var player_character: CharacterBody2D = get_parent()
@onready var player_character_weapon_holder = %PlayerCharacterWeaponHolder

@onready var loaded_item: Item = load("res://Content/Scenes/Items/Item1.tres")
@onready var loaded_item2: Item = load("res://Content/Scenes/Items/Item2.tres")

func _input(event: InputEvent):
	if event.is_action_pressed("Dash"):
		print("test")
		add_item(loaded_item)
		add_item(loaded_item2)
		apply_player_stats_modifiers()
		#apply_weapon_stats_modifiers()

func add_item(item: Item):
	items.append(item)
	apply_player_stats_modifiers()
	#apply_weapon_stats_modifiers()

func apply_player_stats_modifiers():
	var total_movement_speed_multiplier: float = 1.0
	var total_dash_speed_multiplier: float = 1.0
	var total_dash_duration_addition: float = 1.0
	var total_dash_cooldown_addition: float = 1.0
	var total_max_health_addition: int = 0
	var total_pickup_range_addition: int = 0
	
	for item in items:
		# Multiplicative bonuses
		total_movement_speed_multiplier *= item.movement_speed_multiplier
		total_dash_speed_multiplier *= item.dash_speed_multiplier
		
		# Additive bonuses
		total_dash_duration_addition += item.dash_duration_addition
		total_dash_cooldown_addition += item.dash_cooldown_addition
		total_max_health_addition += item.max_health_addition
		total_pickup_range_addition += item.pickup_range_addition
	
	player_character.update_stats(
		total_movement_speed_multiplier,
		total_dash_speed_multiplier,
		total_dash_duration_addition,
		total_dash_cooldown_addition,
		total_max_health_addition,
		total_pickup_range_addition
	)

	
func apply_weapon_stats_modifiers():
	# Initialize the weapon stat modifiers
	var total_weapon_damage_multiplier: float = 1.0
	var total_fire_rate_multiplier: float = 1.0
	var total_crit_modifier_multiplier: float = 1.0
	var total_knockback_force_multiplier: float = 1.0
	var total_bullet_spread_multiplier: float = 1.0
	
	var total_crit_chance_addition: float = 0.0
	var total_weapon_range_addition: int = 0
	
	# Accumulate the modifiers from all items
	for item in items:
		# Multiplicative bonuses
		total_knockback_force_multiplier *= item.knockback_force_multiplier
		total_bullet_spread_multiplier *= item.bullet_spread_multiplier
		total_weapon_damage_multiplier *= item.weapon_damage_multiplier
		total_fire_rate_multiplier *= item.fire_rate_multiplier
		total_crit_modifier_multiplier *= item.crit_modifier_multiplier
		
		# Additive bonuses
		total_crit_chance_addition += item.crit_chance_addition
		total_weapon_range_addition += item.weapon_range_addition

	for weapon in player_character_weapon_holder.get_children():
		if weapon is Weapon:
			weapon.update_stats(
				total_weapon_damage_multiplier,
				total_fire_rate_multiplier,
				total_crit_chance_addition,
				total_crit_modifier_multiplier,
				total_knockback_force_multiplier,
				total_bullet_spread_multiplier,
				total_weapon_range_addition
			)
