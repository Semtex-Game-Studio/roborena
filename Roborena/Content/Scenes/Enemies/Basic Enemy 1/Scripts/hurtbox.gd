extends Area2D

# Variables referencing the enemy and its properties
@onready var enemy: Node2D = get_parent() as CharacterBody2D

@onready var health: int = enemy.health
@onready var animator: AnimationPlayer = enemy.animator
@onready var gpu_particles_2d: GPUParticles2D = enemy.gpu_particles_2d
@onready var applying_knock_back: bool = enemy.applying_knock_back
@onready var movement_speed: float = enemy.movement_speed

# Additional nodes and resources
@onready var damage_number_holder: Node = get_node("/root/Game/Map/DamageNumberHolder")
@onready var collectable_scene: PackedScene = preload("res://Content/Scenes/Collectables/collectable_base.tscn")
@onready var knock_back_timer: Timer = $KnockBackTimer

# Knock-back velocity
var knock_back_velocity: Vector2 = Vector2.ZERO

# Function called when the enemy is hit
func on_hit(damage: int, critical_hit: bool, knock_back_force: float) -> void:
	take_damage(damage)
	spawn_particles()
	knock_back(knock_back_force)
	
	if health <= 0:
		play_death_animation()
		display_damage_number("K.O.", critical_hit)
	else:
		play_hit_animation()
		display_damage_number(str(damage), critical_hit)

# Reduces the enemy's health by the damage amount
func take_damage(damage: int) -> void:
	health -= damage

# Displays the damage number at the enemy's position
func display_damage_number(damage_label: String, critical_hit: bool) -> void:
	damage_number_holder.show_damage_number(damage_label, global_position, critical_hit)

# Plays the hit animation
func play_hit_animation() -> void:
	animator.play("hit_flash")

# Spawns particle effects
func spawn_particles() -> void:
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true

# Applies knock-back force to the enemy
func knock_back(knock_back_force: float) -> void:
	if not applying_knock_back:
		applying_knock_back = true
		knock_back_velocity = knock_back_force * movement_speed * Vector2(1, 1)
		knock_back_timer.start()

# Resets knock-back state when the timer times out
func on_knock_back_timer_timeout() -> void:
	applying_knock_back = false
	knock_back_velocity = Vector2.ZERO

# Plays the death animation
func play_death_animation() -> void:
	die()

# Handles the enemy's death and triggers collectable drop
func die() -> void:
	call_deferred("drop_collectables")
	enemy.queue_free()

# Drops collectables at the enemy's position
func drop_collectables() -> void:
	var collectable: Node2D = collectable_scene.instantiate() as Node2D
	var game_node: Node = get_tree().root.get_node("Game")
	collectable.position = enemy.position
	game_node.add_child(collectable)
