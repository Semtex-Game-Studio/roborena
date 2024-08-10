extends CharacterBody2D

class_name EnemyClass1


@export var enemy_id: String
@export var health: int
@export var movement_speed: int
@export var hurtbox: Area2D
@export var animator: AnimationPlayer

@onready var knock_back_timer = $KnockBackTimer

@onready var player_character = get_node("/root/Game/PlayerCharacter")
@onready var damage_number_holder = get_node("/root/Game/Map/DamageNumberHolder")

var knock_back_velocity: Vector2 = Vector2.ZERO
var applying_knock_back: bool = false

func _physics_process(delta):
	_move_to_player(delta)
	_flip_sprite()


func _move_to_player(delta):
	var direction = global_position.direction_to(player_character.global_position)
	velocity = direction * movement_speed * delta - direction * knock_back_velocity * delta
	move_and_slide()

func _flip_sprite():
	if velocity.x < 0.0 && !applying_knock_back:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0.0 && !applying_knock_back:
		$AnimatedSprite2D.flip_h = false


func _on_hit(damage: int, critical_hit: bool, knock_back_force: float):
	_take_damage(damage)
	_display_damage_number(damage, critical_hit)
	_spawn_particles()
	_knock_back(knock_back_force)
	
	if health <= 0:
		_play_death_animation()
	else:
		_play_hit_animation()
	

func _take_damage(damage: int):
	health -= damage

func _die():
	queue_free()

func _display_damage_number(damage: int, critical_hit: bool):
	damage_number_holder.show_damage_number(damage, global_position, critical_hit)

func _play_hit_animation():
	animator.play("hit_flash")

func _spawn_particles():
	#print("Particles spawned")
	pass

func _knock_back(knock_back_force: float):
	if !applying_knock_back:
		applying_knock_back = true
		knock_back_velocity = knock_back_force * movement_speed * Vector2(1,1)
		knock_back_timer.start()

func _on_knock_back_timer_timeout():
	applying_knock_back = false
	knock_back_velocity = 0 * Vector2(1,1)

func _play_death_animation():
	#print("Death animation played")
	_die()
