extends Node2D

@export var radius = 65.0  # Radius of the circle
@export var max_weapons = 8  # Maximum number of weapons


var rotation_offset: float


func _ready():
	arrange_weapons()


func arrange_weapons():
	var weapons_on_player = get_child_count()
	var num_weapons = min(weapons_on_player, max_weapons)
	
	if num_weapons == 0:
		print("No weapons found on the WeaponHolder")
		return
		
	else:
		# Calculate the automatic rotation offset	
		if num_weapons == 1:
			rotation_offset = 0.0
		elif num_weapons % 2 == 1:
			rotation_offset = -90.0
		else:
			rotation_offset = -90.0 + (360.0 / (2.0 * num_weapons))

		# Arrange the weapons
		for i in range(num_weapons):
			# Calculate the angle for this weapon
			var angle = i * 360.0 / num_weapons + rotation_offset
			
			# Position the weapon
			var x_pos = cos(deg_to_rad(angle)) * radius
			var y_pos = sin(deg_to_rad(angle)) * radius
			var weapon = get_child(i)
			weapon.position = Vector2(x_pos, y_pos)
			
		# Remove any extra weapons beyond the max_weapons limit
		for i in range(get_child_count() - 1, num_weapons - 1, -1):
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
