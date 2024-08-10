extends Node2D

@onready var spawn_area_polygon_points = %SpawnArea.get_spawn_area_polygon_points()
@onready var bounding_box = get_bounding_box(spawn_area_polygon_points)


# Get the bounding box for the polygon
func get_bounding_box(polygon_points: Array) -> Rect2:
	var min_x = INF
	var min_y = INF
	var max_x = -INF
	var max_y = -INF

	for point in polygon_points:
		min_x = min(min_x, point.x)
		min_y = min(min_y, point.y)
		max_x = max(max_x, point.x)
		max_y = max(max_y, point.y)
	
	return Rect2(min_x, min_y, max_x - min_x, max_y - min_y)

# Generate a random point within a bounding box
func get_random_point_within_bounding_box(bbox: Rect2) -> Vector2:
	var x = randf_range(bbox.position.x, bbox.position.x + bbox.size.x)
	var y = randf_range(bbox.position.y, bbox.position.y + bbox.size.y)
	return Vector2(x, y)

# Check if a point is inside a polygon
func is_point_in_polygon(point: Vector2, polygon_points: Array) -> bool:
	var inside = false
	var n = polygon_points.size()
	var j = n - 1

	for i in range(n):
		var vi = polygon_points[i]
		var vj = polygon_points[j]
		
		if ((vi.y > point.y) != (vj.y > point.y)) and (point.x < (vj.x - vi.x) * (point.y - vi.y) / (vj.y - vi.y) + vi.x):
			inside = !inside
		
		j = i
	return inside

func get_spawn_point() -> Vector2:
	var point = get_random_point_within_bounding_box(bounding_box)
	while not is_point_in_polygon(point, spawn_area_polygon_points):
		point = get_random_point_within_bounding_box(bounding_box)
	return point

## Visualize spawn points
#func _draw():
	## Generate and draw spawn points
	#for i in range(100000):
		#var point = get_spawn_point()
		#draw_circle(point, 2, Color(1, 0, 0))
#
#func _ready():
	#queue_redraw()
