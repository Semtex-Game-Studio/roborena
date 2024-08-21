extends Marker2D


# Pool to reuse bullets
var projectile_pool: Array[Area2D] = []
var active_projectiles: Array[Area2D] = []


# Reference to the projectile scene
@onready var weapon_node = get_parent()
@onready var projectile_scene: PackedScene = weapon_node.projectile_scene
@onready var bullet_spread = weapon_node.bullet_spread


# Function to shoot a projectile
func shoot_projectile(weapon_range: int, damage: float, critical_hit: bool, knock_back_force: float) -> void:
	var projectile = get_pooled_bullet()

	projectile.global_position = global_position
	projectile.global_rotation = global_rotation + deg_to_rad(randf_range(-1,1) * bullet_spread)
	
	projectile.weapon_range = weapon_range
	projectile.damage = damage
	projectile.critical_hit = critical_hit
	projectile.knock_back_force = knock_back_force
	
	projectile.show()
	active_projectiles.append(projectile)
		

# Get a bullet from the pool or create a new one if the pool is empty
func get_pooled_bullet() -> Area2D:
	if projectile_pool.size() > 0:
		var bullet = projectile_pool.pop_back()
		bullet._reset_bullet()
		return bullet
	else:
		return create_bullet()


# Create a new bullet instance
func create_bullet() -> Area2D:
	var new_projectile = projectile_scene.instantiate() as Area2D
	new_projectile.hide()
	add_child(new_projectile)
	return new_projectile


# Handle bullet deactivation and return it to the pool
func _on_bullet_deactivated(projectile: Area2D) -> void:
	projectile.hide()
	active_projectiles.erase(projectile)
	projectile_pool.append(projectile)
