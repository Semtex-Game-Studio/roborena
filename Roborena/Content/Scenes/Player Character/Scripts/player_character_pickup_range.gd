extends Area2D

@onready var player: CharacterBody2D = get_parent()
@onready var pickup_range_collision_shape_2d: CollisionShape2D = %PickupRangeCollisionShape2D


func _ready():
	await player._ready()
	pickup_range_collision_shape_2d.shape.set_radius(player.pickup_range)
	
func _on_area_entered(area):
	if area.collectable_id == "Collectable 1":
		area.on_collected(player)
		player.player_currency += area.currency_value

func update_stats() -> void:
	pickup_range_collision_shape_2d.shape.set_radius(player.pickup_range)
