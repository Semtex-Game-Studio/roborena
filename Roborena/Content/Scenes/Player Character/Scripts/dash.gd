extends Node2D

@onready var dash_duration = $DashDuration
@onready var dash_cooldown = $DashCooldown
var can_dash = true

func start_dash():
	dash_duration.start()


func is_dashing():
	return !dash_duration.is_stopped()


func end_dash():
	can_dash = false
	dash_cooldown.start()


func _on_dash_duration_timeout():
	end_dash()


func _on_dash_cooldown_timeout():
	can_dash = true
