extends Node2D

var damage_events = []
var dps_interval: float = 10.0 
var last_dps_calculation_time: float = 0.0
var current_dps: float = 0.0

func update_dps(delta: float, damage_events):
	var current_time = float(Time.get_ticks_msec()) / 1000.0

	# Remove old damage events outside the DPS interval
	while damage_events.size() > 0 and current_time - damage_events[0][0] > dps_interval:
		damage_events.pop_front()

	# Calculate the total damage within the DPS interval
	var total_damage = 0.0
	for event in damage_events:
		total_damage += event[1]

	# Calculate DPS
	if dps_interval > 0:
		current_dps = total_damage / dps_interval

	# Print DPS every second
	if current_time - last_dps_calculation_time >= 1.0:
		last_dps_calculation_time = current_time
		print("Current DPS: ", current_dps)
