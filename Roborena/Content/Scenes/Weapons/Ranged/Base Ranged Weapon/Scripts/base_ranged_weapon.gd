extends Node2D
class_name Weapon

@onready var enemy_detector = %EnemyDetector
@onready var rate_of_fire = %RateOfFire
@onready var weapon_range = %WeaponRange
@onready var projectile_spawner = %ProjectileSpawner
@onready var weapon_sprite = %WeaponSprite

# Base weapon stats
@export_group("Base Weapon Stats")
@export var base_weapon_damage: float
@export var base_bullet_spread: float
@export var base_crit_chance_value: float
@export var base_crit_modifier: float
@export var base_knock_back_force: float
@export var base_fire_rate_value: float
@export var base_weapon_range_value: int

@export var projectile_scene: PackedScene

# Dynamic weapon stats
var weapon_damage: float = base_weapon_damage
var bullet_spread: float = base_bullet_spread
var crit_chance_value: float = base_crit_chance_value
var crit_modifier: float = base_crit_modifier
var knock_back_force: float = base_knock_back_force
var fire_rate_value: float = base_fire_rate_value
var weapon_range_value: int = base_weapon_range_value

# Local variables
var critical_hit: bool = false
var rng = RandomNumberGenerator.new()


func _process(delta):
	aim_at_closest_enemy()

func aim_at_closest_enemy() -> void:
	var closest_enemy = enemy_detector.find_closest_enemy()
	if closest_enemy:
		look_at(closest_enemy.global_position)
		
		if rate_of_fire.is_stopped():
			projectile_spawner.shoot_projectile(weapon_range_value, calculate_damage(), critical_hit, knock_back_force)
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

func update_stats(
	total_weapon_damage_multiplier: float,
	total_fire_rate_multiplier: float,
	total_crit_chance_addition: float,
	total_crit_modifier_multiplier: float,
	total_knockback_force_multiplier: float,
	total_bullet_spread_multiplier: float,
	total_weapon_range_addition: int

):
	self.weapon_damage = base_weapon_damage * total_weapon_damage_multiplier
	self.bullet_spread = base_bullet_spread * total_bullet_spread_multiplier
	self.crit_modifier = base_crit_modifier * total_crit_modifier_multiplier
	self.knock_back_force = base_knock_back_force * total_knockback_force_multiplier
	self.fire_rate_value = base_fire_rate_value * total_fire_rate_multiplier
	
	self.weapon_range_value = base_weapon_range_value + total_weapon_range_addition
	self.crit_chance_value = base_crit_chance_value + total_crit_chance_addition

	weapon_range.shape.radius = weapon_range_value
	rate_of_fire.set_wait_time(1 / fire_rate_value)
