extends Area2D

@onready var player: CharacterBody2D = get_parent()
@onready var max_health: int = player. max_health

var current_health: int

func _ready():
	current_health = max_health
	
func take_damage(damage:int):
	current_health -= damage
	if current_health <= 0:
		print("game over")
