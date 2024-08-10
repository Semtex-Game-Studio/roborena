extends Area2D

@export var speed: int = 400
@onready var velocity = Vector2(speed, 0).rotated(rotation)

# Variables set by the weapon
var weapon_range: int
var damage: int
var knock_back_force: float
var critical_hit: bool

var has_hit: bool = false 


func _physics_process(delta):
	global_position += velocity * delta

func _on_area_entered(area):
	# Ignore if already hit
	if has_hit:
		return

	# Enemy hit
	if area.get_parent().has_method("_on_hit"):
		area.get_parent()._on_hit(damage, critical_hit, knock_back_force)
		
		has_hit = true
		queue_free()

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	# Ignore if already hit
	if has_hit:
		return
	
	if body.name == "Border":
		queue_free()
