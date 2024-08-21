extends Area2D

var closest_enemy: Node2D = null

func find_closest_enemy():
	var enemies_in_range = get_overlapping_bodies()

	if enemies_in_range.size() > 0:
		var closest_enemy = enemies_in_range[0]
		var closest_distance = global_position.distance_to(closest_enemy.global_position)
		
		for enemy in enemies_in_range:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_enemy = enemy
				closest_distance = distance
				
		return closest_enemy
		
	return null
