extends Area2D

@onready var player: CharacterBody2D = get_parent()

var max_health: int
var current_health: int


func _ready():
	await player._ready()
	max_health = player.max_health
	current_health = max_health
	
func take_damage(damage:int):
	current_health -= damage
	if current_health <= 0:
		print("game over")

func update_stats() -> void:
	max_health = player.max_health
