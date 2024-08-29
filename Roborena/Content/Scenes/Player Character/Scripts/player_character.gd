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

@onready var currency: int = 0
@onready var player_character_item_handler = %PlayerCharacterItemHandler

	
func update_stats(movement_speed, dash_speed_multiplier, max_health, pickup_range, dash_duration, dash_cooldown):
	self.movement_speed = movement_speed
	self.dash_speed_multiplier = dash_speed_multiplier
	self.max_health = max_health
	self.pickup_range = pickup_range
	self.dash_duration = dash_duration
	self.dash_cooldown = dash_cooldown
