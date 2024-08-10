extends StaticBody2D

@onready var map = get_parent()
@onready var spawn_area_collider = %SpawnAreaCollider

@onready var poly_size_spawner = map.poly_size_spawner
@onready var rotation_angle = map.rotation_angle

@onready var cos_angle = cos(deg_to_rad(rotation_angle))
@onready var sin_angle = sin(deg_to_rad(rotation_angle))

func _ready():
	var spawn_area_polygon_points = [
		border_rotate(poly_size_spawner * sqrt(2 + sqrt(2)), poly_size_spawner * sqrt(2 - sqrt(2))),
		border_rotate(poly_size_spawner * sqrt(2 - sqrt(2)), poly_size_spawner * sqrt(2 + sqrt(2))),
		border_rotate(-poly_size_spawner * sqrt(2 - sqrt(2)), poly_size_spawner * sqrt(2 + sqrt(2))),
		border_rotate(-poly_size_spawner * sqrt(2 + sqrt(2)), poly_size_spawner * sqrt(2 - sqrt(2))),
		border_rotate(-poly_size_spawner * sqrt(2 + sqrt(2)), -poly_size_spawner * sqrt(2 - sqrt(2))),
		border_rotate(-poly_size_spawner * sqrt(2 - sqrt(2)), -poly_size_spawner * sqrt(2 + sqrt(2))),
		border_rotate(poly_size_spawner * sqrt(2 - sqrt(2)), -poly_size_spawner * sqrt(2 + sqrt(2))),
		border_rotate(poly_size_spawner * sqrt(2 + sqrt(2)), -poly_size_spawner * sqrt(2 - sqrt(2))),
		]
	spawn_area_collider.polygon = spawn_area_polygon_points

func border_rotate(x, y):
	return Vector2(x * cos_angle - y * sin_angle, x * sin_angle + y * cos_angle)

func get_spawn_area_polygon_points():
	return spawn_area_collider.polygon
