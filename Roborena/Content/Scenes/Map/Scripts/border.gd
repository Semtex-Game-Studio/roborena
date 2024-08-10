extends StaticBody2D

@onready var map = get_parent()
@onready var border_collider = %BorderCollider

@onready var poly_size_border = map.poly_size_border
@onready var poly_size_outside_border = map.poly_size_outside_border
@onready var rotation_angle = map.rotation_angle

@onready var cos_angle = cos(deg_to_rad(rotation_angle))
@onready var sin_angle = sin(deg_to_rad(rotation_angle))

var border : PackedVector2Array

func _ready():
	var border_collider_polygon_points = [
		border_rotate(poly_size_border * sqrt(2 + sqrt(2)), poly_size_border * sqrt(2 - sqrt(2))),
		border_rotate(poly_size_border * sqrt(2 - sqrt(2)), poly_size_border * sqrt(2 + sqrt(2))),
		border_rotate(-poly_size_border * sqrt(2 - sqrt(2)), poly_size_border * sqrt(2 + sqrt(2))),
		border_rotate(-poly_size_border * sqrt(2 + sqrt(2)), poly_size_border * sqrt(2 - sqrt(2))),
		border_rotate(-poly_size_border * sqrt(2 + sqrt(2)), -poly_size_border * sqrt(2 - sqrt(2))),
		border_rotate(-poly_size_border * sqrt(2 - sqrt(2)), -poly_size_border * sqrt(2 + sqrt(2))),
		border_rotate(poly_size_border * sqrt(2 - sqrt(2)), -poly_size_border * sqrt(2 + sqrt(2))),
		border_rotate(poly_size_border * sqrt(2 + sqrt(2)), -poly_size_border * sqrt(2 - sqrt(2))),
		Vector2(poly_size_outside_border, -poly_size_outside_border),
		Vector2(-poly_size_outside_border, -poly_size_outside_border),
		Vector2(-poly_size_outside_border, poly_size_outside_border),
		Vector2(poly_size_outside_border, poly_size_outside_border),
		Vector2(poly_size_outside_border, -poly_size_outside_border),
		border_rotate(poly_size_border * sqrt(2 + sqrt(2)), -poly_size_border * sqrt(2 - sqrt(2)))
	]	
	border_collider.polygon = border_collider_polygon_points
	border = float_array_to_Vector2Array(border_collider_polygon_points);

func border_rotate(x, y):
	return Vector2(x * cos_angle - y * sin_angle, x * sin_angle + y * cos_angle)

func float_array_to_Vector2Array(coords : Array) -> PackedVector2Array:
	# Convert the array of floats into a PackedVector2Array.
	var array : PackedVector2Array = []
	for coord in coords:
		array.append(Vector2(coord[0], coord[1]))
	return array

func _draw():
	draw_polygon(border, [ Color("040426") ])

