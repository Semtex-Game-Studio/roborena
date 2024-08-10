extends Marker2D


func shoot_projectile(projectile_scene: PackedScene, weapon_range: int, damage: float, critical_hit: bool, knock_back_force: float):
	if projectile_scene:
		var new_projectile = projectile_scene.instantiate()
		new_projectile.global_position = global_position
		new_projectile.global_rotation = global_rotation
		
		new_projectile.weapon_range = weapon_range
		new_projectile.damage = damage
		new_projectile.critical_hit = critical_hit
		new_projectile.knock_back_force = knock_back_force
		
		add_child(new_projectile)
