extends Node2D
class_name Weapon

@onready var player_character: CharacterBody2D = get_parent().get_parent()

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
	weapon_damage = base_weapon_damage
	bullet_spread = base_bullet_spread
	crit_chance_value = base_crit_chance_value
	crit_modifier = base_crit_modifier
	enemy_knock_back_force = base_enemy_knock_back_force
	fire_rate_value = base_fire_rate_value
	weapon_range_value = base_weapon_range_value
	
	weapon_range.shape.radius = weapon_range_value
	rate_of_fire.set_wait_time(1 / fire_rate_value)

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
