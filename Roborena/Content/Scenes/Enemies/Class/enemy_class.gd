extends CharacterBody2D

@export_group("Enemy components")
@export var animator: AnimationPlayer
@export var attack_cooldown_timer: Timer
@export var audio_stream_player: AudioStreamPlayer2D
@export var gpu_particles_2d: GPUParticles2D
@export var hitbox: Area2D
@export var hurtbox: Area2D
@export var knock_back_timer: Timer

@export_group("Enemy stats")
@export var armor: int
@export var attack_damage: int
@export var health: int
@export var movement_speed: int

@onready var player_character = get_node("/root/Game/PlayerCharacter")
@onready var damage_number_holder = get_node("/root/Game/Map/DamageNumberHolder")
@onready var collectable_scene = preload("res://Content/Scenes/Collectables/collectable_base.tscn")

var knock_back_velocity: Vector2 = Vector2.ZERO
var applying_knock_back: bool = false
var can_damage_player: bool = true

func _process(delta):
	deal_damage()
	
func _physics_process(delta):
	_move_to_player(delta)
	_flip_sprite()

func _move_to_player(delta) -> void:
	var direction = global_position.direction_to(player_character.global_position)
	velocity = direction * movement_speed * delta - direction * knock_back_velocity * delta
	move_and_slide()

func _flip_sprite() -> void:
	if velocity.x < 0.0 && !applying_knock_back:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0.0 && !applying_knock_back:
		$AnimatedSprite2D.flip_h = false

func _on_hit(damage: int, critical_hit: bool, knock_back_force: float) -> void:
	_take_damage(damage)
	_display_damage_number(damage, critical_hit)
	_spawn_particles()
	_knock_back(knock_back_force)
	
	if health <= 0:
		_play_death_animation()
	else:
		_play_hit_animation()

func _take_damage(damage: int) -> void:
	health -= damage

func _die() -> void:
	call_deferred("drop_collectables")
	queue_free()

func _display_damage_number(damage: int, critical_hit: bool) -> void:
	damage_number_holder.show_damage_number(damage, global_position, critical_hit)

func _play_hit_animation() -> void:
	animator.play("hit_flash")

func _spawn_particles() -> void:
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true

func _knock_back(knock_back_force: float) -> void:
	if !applying_knock_back:
		applying_knock_back = true
		knock_back_velocity = knock_back_force * movement_speed * Vector2(1,1)
		knock_back_timer.start()

func _on_knock_back_timer_timeout() -> void:
	applying_knock_back = false
	knock_back_velocity = Vector2.ZERO

func drop_collectables() -> void:
	var collectable = collectable_scene.instantiate()
	var game_node = get_tree().root.get_node("Game")
	collectable.position = position
	game_node.add_child(collectable)

func _play_death_animation() -> void:
	_die()

func deal_damage() -> void:
	var player_detection = hitbox.get_overlapping_areas()

	if player_detection.size() > 0 and can_damage_player:
		var player_hurtbox = player_detection[0]
		var player = player_hurtbox.get_parent()
		player.take_damage(attack_damage)
		can_damage_player = false
		attack_cooldown_timer.start()

func _on_attack_cooldown_timer_timeout():
	can_damage_player = true

