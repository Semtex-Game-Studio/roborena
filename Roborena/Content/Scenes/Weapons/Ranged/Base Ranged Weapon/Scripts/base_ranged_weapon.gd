extends Node2D

# Player character reference
@onready var player_character = get_parent().get_parent()

# Local scene nodes
@onready var enemy_detector = %EnemyDetector
@onready var rate_of_fire = %RateOfFire
@onready var weapon_range = %WeaponRange
@onready var projectile_spawner = %ProjectileSpawner

# Weapon specifications
@export var weapon_range_value: int
@export var fire_rate_value: float
@export var base_damage: float
@export var damage_modifier: float
@export var crit_chance_value: float
@export var crit_modifier: float
@export var knock_back_force: float
@export var projectile_scene: PackedScene 

var cooling_down: bool = false
var critical_hit: bool = false
var rng = RandomNumberGenerator.new()

func _ready():
	weapon_range.shape.radius = weapon_range_value
	rate_of_fire.set_wait_time(1 / fire_rate_value)


func _process(delta):
	aim_at_closest_enemy()


func aim_at_closest_enemy():
	var closest_enemy = enemy_detector.find_closest_enemy()
	
	if closest_enemy:
		# Look at the closest enemy
		look_at(closest_enemy.global_position)
		
		if rate_of_fire.is_stopped() and not cooling_down:
			cooling_down = true
			projectile_spawner.shoot_projectile(weapon_range_value, calculate_damage(), critical_hit, knock_back_force)
			rate_of_fire.start()


func calculate_damage() -> float:
	var rand_val = rng.randf_range(0, 1)
	if rand_val < crit_chance_value:
		var damage: int = base_damage * damage_modifier * crit_modifier
		critical_hit = true
		return damage
	else:
		var damage: int = base_damage * damage_modifier
		critical_hit = false
		return damage


func _on_rate_of_fire_timeout():
	cooling_down = false

