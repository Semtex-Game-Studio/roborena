extends Node2D
class_name Weapon

# Local scene nodes
@onready var enemy_detector = %EnemyDetector
@onready var rate_of_fire = %RateOfFire
@onready var weapon_range = %WeaponRange
@onready var projectile_spawner = %ProjectileSpawner
@onready var weapon_sprite = %WeaponSprite

@export_group("Weapon specs")
@export var base_weapon_damage: float
@export var base_bullet_spread: float
@export var base_crit_chance_value: float
@export var base_crit_modifier: float
@export var base_enemy_knock_back_force: float
@export var base_fire_rate_value: float
@export var base_weapon_range_value: int

@export var projectile_scene: PackedScene

# Multiplicative modifiers
@export var weapon_damage_multiplier: float = 1.0
@export var fire_rate_multiplier: float = 1.0
@export var crit_modifier_multiplier: float = 1.0
@export var knockback_force_multiplier: float = 1.0
@export var bullet_spread_multiplier: float = 1.0

# Additive modifiers
@export var crit_chance_addition: float = 0.0
@export var weapon_range_addition: int = 0

# Dynamic weapon stats
var weapon_damage: float
var bullet_spread: float
var crit_chance_value: float
var crit_modifier: float
var enemy_knock_back_force: float
var fire_rate_value: float
var weapon_range_value: int

# Local variables
var critical_hit: bool = false
var rng = RandomNumberGenerator.new()

func _ready():
	initialize_stats()
	weapon_range.shape.radius = weapon_range_value
	rate_of_fire.set_wait_time(1 / fire_rate_value)

func initialize_stats() -> void:
	update_weapon_stats()

func _process(delta):
	aim_at_closest_enemy()

func aim_at_closest_enemy() -> void:
	var closest_enemy = enemy_detector.find_closest_enemy()
	
	if closest_enemy:
		look_at(closest_enemy.global_position)
		
		if rate_of_fire.is_stopped():
			projectile_spawner.shoot_projectile(weapon_range_value, calculate_damage(), critical_hit, enemy_knock_back_force)
			rate_of_fire.start()
			weapon_sprite.apply_weapon_recoil()


func calculate_damage() -> float:
	var crit = rng.randf_range(0, 1)
	if crit < crit_chance_value:
		critical_hit = true
		return weapon_damage * crit_modifier
	else:
		critical_hit = false
		return weapon_damage

# Function to update stats based on applied modifiers
func update_weapon_stats() -> void:
	weapon_damage = base_weapon_damage * weapon_damage_multiplier
	bullet_spread = base_bullet_spread * bullet_spread_multiplier
	crit_chance_value = base_crit_chance_value + crit_chance_addition
	crit_modifier = base_crit_modifier * crit_modifier_multiplier
	enemy_knock_back_force = base_enemy_knock_back_force * knockback_force_multiplier
	fire_rate_value = base_fire_rate_value * fire_rate_multiplier
	weapon_range_value = base_weapon_range_value + weapon_range_addition

	# Update weapon components
	weapon_range.shape.radius = weapon_range_value
	rate_of_fire.set_wait_time(1 / fire_rate_value)

# Function to apply multiplicative stat modifiers
func add_stat_modifier(stat_name: String, value: float) -> void:
	match stat_name:
		"weapon_damage_multiplier": weapon_damage_multiplier *= value
		"fire_rate_multiplier": fire_rate_multiplier *= value
		"crit_modifier_multiplier": crit_modifier_multiplier *= value
		"knockback_force_multiplier": knockback_force_multiplier *= value
		"bullet_spread_multiplier": bullet_spread_multiplier *= value
		_:
			print("Unknown stat name for multiplicative addition: ", stat_name)
	update_weapon_stats()

# Function to remove multiplicative stat modifiers
func remove_stat_modifier(stat_name: String, value: float) -> void:
	match stat_name:
		"weapon_damage_multiplier": weapon_damage_multiplier /= value
		"fire_rate_multiplier": fire_rate_multiplier /= value
		"crit_modifier_multiplier": crit_modifier_multiplier /= value
		"knockback_force_multiplier": knockback_force_multiplier /= value
		"bullet_spread_multiplier": bullet_spread_multiplier /= value
		_:
			print("Unknown stat name for multiplicative removal: ", stat_name)
	update_weapon_stats()

# Function to apply additive stat modifiers
func add_additive_stat_modifier(stat_name: String, value: float) -> void:
	match stat_name:
		"crit_chance_addition": crit_chance_addition += value
		"weapon_range_addition": weapon_range_addition += value
		_:
			print("Unknown stat name for additive addition: ", stat_name)
	update_weapon_stats()

# Function to remove additive stat modifiers
func remove_additive_stat_modifier(stat_name: String, value: float) -> void:
	match stat_name:
		"crit_chance_addition": crit_chance_addition -= value
		"weapon_range_addition": weapon_range_addition -= value
		_:
			print("Unknown stat name for additive removal: ", stat_name)
	update_weapon_stats()
