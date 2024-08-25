extends CharacterBody2D

# Base Player Stats (constants, not modified directly by items)
@export_group("Base Player Stats")
@export var base_movement_speed: float = 25000.0
@export var base_dash_speed_multiplier: float = 1.8
@export var base_dash_duration: float = 0.8
@export var base_dash_cooldown: float = 1.0
@export var base_max_health: int = 100
@export var base_pickup_range: float = 40.0

# Calculated Player Stats (modified by items)
var movement_speed: float
var dash_speed_multiplier: float
var dash_duration: float
var dash_cooldown: float
var max_health: int
var pickup_range: float

@onready var player_currency: int = 0

@onready var player_character_stats_manager = %PlayerCharacterStatsManager
@onready var player_character_items_holder = %PlayerCharacterItemsHolder

@onready var player_character_movement_handler = %PlayerCharacterMovementHandler
@onready var player_character_hurtbox = %PlayerCharacterHurtbox
@onready var player_character_pickup_range = $PlayerCharacterPickupRange


func _ready():
	initialize_stats()

func initialize_stats():
	movement_speed = base_movement_speed
	dash_speed_multiplier = base_dash_speed_multiplier
	dash_duration = base_dash_duration
	dash_cooldown = base_dash_cooldown
	max_health = base_max_health
	pickup_range = base_pickup_range


func update_stats():
	movement_speed = player_character_stats_manager.recalculate_stat("movement_speed")
	dash_speed_multiplier = player_character_stats_manager.recalculate_stat("dash_speed_multiplier")
	dash_duration = player_character_stats_manager.recalculate_stat("dash_duration")
	dash_cooldown = player_character_stats_manager.recalculate_stat("dash_cooldown")
	max_health = player_character_stats_manager.recalculate_stat("max_health")
	pickup_range = player_character_stats_manager.recalculate_stat("pickup_range")
	
	_update_dependent_nodes()


func _update_dependent_nodes():
	player_character_movement_handler.update_stats()
	player_character_hurtbox.update_stats()
	player_character_pickup_range.update_stats()


#func _on_item_added(item: Node):
	#if item is Item:
		#item.player_character_stats_manager = stat_manager
		#item.apply_effects()
		#update_stats()
#
#func _on_item_removed(item: Node):
	#if item is Item:
		#item.remove_effects()
		#update_stats()
