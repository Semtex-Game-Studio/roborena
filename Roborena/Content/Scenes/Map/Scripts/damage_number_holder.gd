extends Node2D

@onready var map = get_parent()

@onready var pooled_damage_numbers = map.pooled_damage_numbers

# Reference to the DamageNumberLabel scene (now a Marker2D with a Label child)
@export var damage_number_scene: PackedScene

# Pool to reuse damage number labels
var damage_label_pool: Array[Marker2D] = []
var active_labels: Array[Marker2D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize the pool with labels
	for i in range(pooled_damage_numbers):
		var damage_number_node = damage_number_scene.instantiate()
		damage_number_node.hide()
		add_child(damage_number_node)
		damage_label_pool.append(damage_number_node)

# Function to show damage number
func show_damage_number(damage: int, position: Vector2, critical_hit: bool):
	var damage_number_node = get_pooled_label()
	if damage_number_node:
		# Update the Label text
		damage_number_node.get_node("DamageNumberLabel").text = str(damage)
		damage_number_node.position = to_local(position)
		damage_number_node.show()
		active_labels.append(damage_number_node)
		damage_number_node.animate_damage_number(critical_hit)
		
		# Get the AnimationPlayer and the duration of the specific animation
		var animation_player = damage_number_node.get_node("DamageNumberLabel/DamageNumberAnimator") as AnimationPlayer
		var animation_duration = animation_player.get_animation("animation_damage_number").length
		
		# Schedule the label to be hidden after the animation duration
		await get_tree().create_timer(animation_duration).timeout
		hide_damage_number(damage_number_node)

# Get a label from the pool
func get_pooled_label() -> Marker2D:
	if damage_label_pool.size() > 0:
		return damage_label_pool.pop_back()
	else:
		print("Damage number pool empty")
		return null

# Hide the damage number and return it to the pool
func hide_damage_number(damage_number_node: Marker2D):
	damage_number_node.hide()
	active_labels.erase(damage_number_node)
	damage_label_pool.append(damage_number_node)
