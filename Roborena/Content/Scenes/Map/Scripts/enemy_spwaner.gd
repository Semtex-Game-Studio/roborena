extends Node2D

const BASE_ENEMY = preload("res://Content/Scenes/Enemies/Basic Enemy 1/basic_enemy_1.tscn")

@onready var map = get_parent()
@onready var enemies = get_node("/root/Game/Map/EnemyHolder")
@onready var spawn_point_generator = %SpawnPointGenerator

@onready var spawn_enemies = map.spawn_enemies

func spawn_enemy():
	var new_enemy = BASE_ENEMY.instantiate()
	var spawn_point = spawn_point_generator.get_spawn_point()
	
	new_enemy.global_position = spawn_point
	enemies.add_child(new_enemy)


func _on_spawn_timer_timeout():
	if spawn_enemies:
		spawn_enemy()
