extends CharacterBody2D

# Base player stats
@export_group("Base Player Stats")
@export var base_movement_speed: float = 25000.0
@export var base_dash_speed: float = 45000.0
@export var base_dash_duration: float = 0.8
@export var base_dash_cooldown: float = 1.0
@export var base_max_health: int = 20
@export var base_pickup_range: int = 40

# Dynamic player stats
var movement_speed: float = base_movement_speed
var dash_speed: float = base_dash_speed
var dash_duration: float = base_dash_duration
var dash_cooldown: float = base_dash_cooldown
var max_health: int = base_max_health
var pickup_range: int = base_pickup_range


@onready var player_character_pickup_range = %PlayerCharacterPickupRange
@onready var currency: int = 0


func update_stats(
		total_movement_speed_multiplier,
		total_dash_speed_multiplier,
		total_dash_duration_addition,
		total_dash_cooldown_addition,
		total_max_health_addition,
		total_pickup_range_addition
	):
	# Multiplicative bonuses
	self.movement_speed = base_movement_speed * total_movement_speed_multiplier
	self.dash_speed = base_dash_speed * total_dash_speed_multiplier
	
	# Additive bonuses
	self.dash_duration = base_dash_duration + total_dash_duration_addition 
	self.dash_cooldown = base_dash_cooldown + total_dash_cooldown_addition
	self.max_health = base_max_health + total_max_health_addition
	self.pickup_range = base_pickup_range + total_pickup_range_addition
	
	player_character_pickup_range.update_stats(self.pickup_range)
