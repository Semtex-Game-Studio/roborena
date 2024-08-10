extends CharacterBody2D

@onready var dps_calculator = $DPSCalculator
@onready var damage_number_holder = get_node("/root/Game/Map/DamageNumberHolder")

var health: float = INF
var damage_events = []

func _ready():
	set_process(true)

func _process(delta):
	dps_calculator.update_dps(delta, damage_events)

func take_damage(damage: int, critical_hit: bool):
	# Show damage number
	damage_number_holder.show_damage_number(damage, position, critical_hit)
	
	# Deal damage to the enemy
	health -= damage
	if health <= 0:
		die()
	
	# Record the damage event with the current timestamp for DPS calculation
	damage_events.append([float(Time.get_ticks_msec()) / 1000.0, damage])

func die():
	queue_free()
