extends Sprite2D

@onready var weapon_node: Node2D = get_parent()
@onready var projectile_spawner: Marker2D = %ProjectileSpawner


func _process(delta):
	orient_sprite()


func orient_sprite() -> void:
	var direction = Vector2.RIGHT.rotated(weapon_node.rotation)
	flip_v = direction.x < 0

	if flip_v:
		projectile_spawner.position.y = abs(projectile_spawner.position.y)
	else:
		projectile_spawner.position.y = -abs(projectile_spawner.position.y)

func apply_weapon_recoil() -> void:
	# Define the recoil direction
	var recoil_direction = Vector2(-15, 0).rotated(rotation)
	var recoil_rotation_offset = deg_to_rad(-25)
	if flip_v:
		recoil_rotation_offset = -recoil_rotation_offset

	# Store the original position and rotation
	var original_position = position
	var original_rotation = rotation

	var recoil_position = original_position + recoil_direction
	var recoil_rotation = original_rotation + recoil_rotation_offset

	var recoil_tween = get_tree().create_tween()
	recoil_tween.tween_property(self, "position", recoil_position, 0.025)
	recoil_tween.tween_property(self, "rotation", recoil_rotation, 0.025)
	recoil_tween.tween_property(self, "position", original_position, 0.03)
	recoil_tween.tween_property(self, "rotation", original_rotation, 0.03)
