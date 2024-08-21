extends Sprite2D

@onready var weapon_node = get_parent()
@onready var projectile_spawner = %ProjectileSpawner

func _process(delta):
	orient_sprite()

func orient_sprite() -> void:
	var direction = Vector2.RIGHT.rotated(weapon_node.rotation)
	flip_v = direction.x < 0

	if flip_v:
		projectile_spawner.position.y = abs(projectile_spawner.position.y)
	else:
		projectile_spawner.position.y = -abs(projectile_spawner.position.y)
