extends CharacterBody2D

# Base Player Stats (Exported)
@export var base_movement_speed: float = 25000.0
@export var base_dash_speed_multiplier: float = 1.8
@export var base_dash_duration: float = 0.8
@export var base_dash_cooldown: float = 1.0
@export var base_max_health: int = 20
@export var base_pickup_range: float = 40.0

# Calculated Player Stats (modified by items)
var movement_speed: float
var dash_speed_multiplier: float
var dash_duration: float
var dash_cooldown: float
var max_health: int
var pickup_range: float

@onready var player_character_stats_manager: Node2D = %PlayerCharacterStatsManager
@onready var player_character_movement_handler: Node2D = %PlayerCharacterMovementHandler
@onready var player_character_hurtbox: Area2D = %PlayerCharacterHurtbox
@onready var player_character_pickup_range: Area2D = %PlayerCharacterPickupRange

@onready var currency: int = 0
var item1: Item = preload("res://Content/Scenes/Items/Item1.tres").duplicate() as Item

func _ready():
	initialize_stats()
	_on_item_added(item1)
	update_stats()

func initialize_stats() -> void:
	# Initialize stats based on base values
	player_character_stats_manager.initialize_base_stats(
		base_movement_speed, 
		base_dash_speed_multiplier, 
		base_dash_duration, 
		base_dash_cooldown, 
		base_max_health, 
		base_pickup_range
	)

func _on_item_added(item: Item) -> void:
	player_character_stats_manager.add_item_modifiers(item)
	update_stats()

func _on_item_removed(item: Item) -> void:
	player_character_stats_manager.remove_item_modifiers(item)
	update_stats()

func update_stats() -> void:
	movement_speed = player_character_stats_manager.recalculate_stat("movement_speed")
	dash_speed_multiplier = player_character_stats_manager.recalculate_stat("dash_speed_multiplier")
	dash_duration = player_character_stats_manager.recalculate_stat("dash_duration")
	dash_cooldown = player_character_stats_manager.recalculate_stat("dash_cooldown")
	max_health = int(player_character_stats_manager.recalculate_stat("max_health"))
	pickup_range = player_character_stats_manager.recalculate_stat("pickup_range")

	_update_dependent_nodes()

func _update_dependent_nodes() -> void:
	player_character_movement_handler.update_stats(movement_speed, dash_duration, dash_cooldown, dash_speed_multiplier)
	player_character_hurtbox.update_stats(max_health)
	player_character_pickup_range.update_stats(pickup_range)
