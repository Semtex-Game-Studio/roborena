extends Node2D

@onready var dash_duration = $DashDuration
@onready var dash_cooldown = $DashCooldown
var can_dash = true

func start_dash() -> void:
	dash_duration.start()


func is_dashing() -> bool:
	return !dash_duration.is_stopped()


func end_dash() -> void:
	can_dash = false
	dash_cooldown.start()


func _on_dash_duration_timeout() -> void:
	end_dash()


func _on_dash_cooldown_timeout() -> void:
	can_dash = true
