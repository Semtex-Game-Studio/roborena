extends Area2D


@export var speed: int


@onready var projectile_spawner = get_parent()


var velocity: Vector2

# Variables set by the weapon
var weapon_range: int
var damage: int
var knock_back_force: float
var critical_hit: bool

# Prevent damaging multiple enemies
var has_hit: bool = false 

# Track the distance traveled
var distance_traveled: float = 0.0
var bullet_spread = deg_to_rad(randf_range(-1,1)*10)

func _physics_process(delta):
	velocity = Vector2(speed, 0).rotated(rotation)
	global_position += velocity * delta
	_max_distance_traveled(delta)


# Destroy on maximum distance traveled
func _max_distance_traveled(delta):
	var distance_this_frame = velocity.length() * delta
	distance_traveled += distance_this_frame

	if distance_traveled >= weapon_range:
		distance_traveled = 0.0
		projectile_spawner._on_bullet_deactivated(self)


# Enemy hit
func _on_area_entered(area):
	if has_hit:
		return
		
	if area.get_parent().has_method("_on_hit"):
		area.get_parent()._on_hit(damage, critical_hit, knock_back_force)
		has_hit = true
		projectile_spawner._on_bullet_deactivated(self)


# Border hit
func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if has_hit:
		return
	
	if body.name == "Border":
		projectile_spawner._on_bullet_deactivated(self)


func _reset_bullet():
	has_hit = false
	distance_traveled = 0.0
