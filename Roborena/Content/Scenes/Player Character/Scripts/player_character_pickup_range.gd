extends Area2D

@onready var player_character: CharacterBody2D = get_parent()
@onready var pickup_range_collision_shape_2d: CollisionShape2D = $PickupRangeCollisionShape2D

func _ready():
	pickup_range_collision_shape_2d.shape.radius = player_character.pickup_range

func _on_area_entered(area):
	if area.collectable_id == "Collectable 1":
		area.on_collected(player_character)
		player_character.currency += area.currency_value

func update_stats(pickup_range_new: float) -> void:
	pickup_range_collision_shape_2d.shape.radius = pickup_range_new
