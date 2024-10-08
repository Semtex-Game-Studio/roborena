extends Area2D

@onready var player_character: CharacterBody2D = get_parent()

var max_health: int
var current_health: int

func _ready():
	max_health = player_character.max_health
	current_health = max_health

func take_damage(damage: int) -> void:
	current_health -= damage
	if current_health <= 0:
		current_health = 0
