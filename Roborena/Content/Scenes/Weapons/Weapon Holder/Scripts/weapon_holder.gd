extends Node2D


@export var radius = 65.0  # Radius of the circle
@export var rotation_offset = 90.0  # Offset to rotate the circle
@export var max_weapons = 8  # Maximum number of weapons

func _ready():
	arrange_weapons()


func arrange_weapons():
	var num_weapons = min(get_child_count(), max_weapons)
	
	if num_weapons == 0:
		print("No weapons found to hold")
		return

	else:
		# Add weapons to the weapon holder and arange them evenly spaced
		for i in range(num_weapons):
			var angle = (i+1) * 360/num_weapons + rotation_offset  # Calculate the angle for each weapon
			var x = cos(deg_to_rad(angle)) * radius  # X position based on the angle
			var y = sin(deg_to_rad(angle)) * radius  # Y position based on the angle
			var weapon = get_child(i)
			weapon.position = Vector2(x, y)  # Set the position of the weapon
		
		# Add weapons to the weapon holder
		for i in range(num_weapons, get_child_count()):
			print("Too many weapons on the WeaponHolder")
			remove_child(get_child(i))


func remove_weapon(weapon):
	if has_node(weapon.get_path()):
		remove_child(weapon)
		_on_weapon_removed()


func _on_weapon_added():
	if get_child_count() > max_weapons:
		for i in range(max_weapons, get_child_count()):
			remove_child(get_child(i))
	arrange_weapons()


func _on_weapon_removed():
	arrange_weapons()
