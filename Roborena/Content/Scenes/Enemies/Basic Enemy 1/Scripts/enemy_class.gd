extends CharacterBody2D

@export_group("Enemy components")
@export var animator: AnimationPlayer
@export var audio_stream_player: AudioStreamPlayer2D
@export var gpu_particles_2d: GPUParticles2D
@export var hitbox: Area2D
@export var hurtbox: Area2D

@export_group("Enemy stats")
@export var armor: int
@export var attack_damage: int
@export var health: int
@export var movement_speed: int

@onready var player_character = get_node("/root/Game/PlayerCharacter")
@onready var enemy_animated_sprite_2d = $EnemyAnimatedSprite2D

var knock_back_velocity: Vector2 = Vector2.ZERO
var applying_knock_back: bool = false


func _physics_process(delta):
	_move_to_player(delta)
	_flip_sprite()

func _move_to_player(delta) -> void:
	var direction = global_position.direction_to(player_character.global_position)
	velocity = direction * movement_speed * delta - direction * knock_back_velocity * delta
	move_and_slide()

func _flip_sprite() -> void:
	if velocity.x < 0.0 && !applying_knock_back:
		enemy_animated_sprite_2d.flip_h = true
	if velocity.x > 0.0 && !applying_knock_back:
		enemy_animated_sprite_2d.flip_h = false
