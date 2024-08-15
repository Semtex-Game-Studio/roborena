extends Node2D


# Local scene nodes
@onready var enemy_detector = %EnemyDetector
@onready var rate_of_fire = %RateOfFire
@onready var weapon_range = %WeaponRange
@onready var projectile_spawner = %ProjectileSpawner


@export_group("Weapon specs")
@export var base_damage: float
@export var bullet_spread: float
@export var crit_chance_value: float
@export var crit_modifier: float
@export var damage_modifier: float
@export var enemy_knock_back_force: float
@export var fire_rate_value: float
@export var projectile_scene: PackedScene
@export var weapon_range_value: int



# Local variables
var weapon_cooldown: bool = false
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
		look_at(closest_enemy.global_position)
		
		if rate_of_fire.is_stopped() and not weapon_cooldown:
			weapon_cooldown = true
			projectile_spawner.shoot_projectile(weapon_range_value, calculate_damage(), critical_hit, enemy_knock_back_force)
			rate_of_fire.start()
			apply_weapon_recoil()
			

func calculate_damage() -> float:
	var crit = rng.randf_range(0, 1)
	
	if crit < crit_chance_value:
		var damage: int = base_damage * damage_modifier * crit_modifier
		critical_hit = true
		return damage
		
	else:
		var damage: int = base_damage * damage_modifier
		critical_hit = false
		return damage


func apply_weapon_recoil():
	var recoil_direction = Vector2(-15, 0).rotated(rotation)
	var original_position = position
	var recoil_position = original_position + recoil_direction
	
	var recoil_tween = get_tree().create_tween()
	recoil_tween.tween_property(self, "position", recoil_position, 0.025)
	recoil_tween.tween_property(self, "position", original_position, 0.025)


func _on_rate_of_fire_timeout():
	weapon_cooldown = false
