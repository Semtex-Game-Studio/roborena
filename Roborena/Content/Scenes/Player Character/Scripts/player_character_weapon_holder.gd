extends Node2D

@export var radius: float = 65.0  # Radius of the circle
@export var max_weapons: int = 8  # Maximum number of weapons

var rotation_offset: float = 0.0

# Additive and multiplicative modifiers for weapon stats
var additive_modifiers: Dictionary = {
	"crit_chance_addition": 0,
	"weapon_range_addition": 0
}

var multiplicative_modifiers: Dictionary = {
	"weapon_damage_multiplier": 1.0,
	"fire_rate_multiplier": 1.0,
	"bullet_spread_multiplier": 1.0,
	"crit_modifier_multiplier": 1.0,
	"knockback_force_multiplier": 1.0
}

func _ready():
	arrange_weapons()

func arrange_weapons() -> void:
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
			
			# Apply the stat modifiers to the weapon
			apply_modifiers_to_weapon(weapon)
			
		# Remove any extra weapons beyond the max_weapons limit
		for i in range(get_child_count() - 1, num_weapons - 1, -1):
			print("Too many weapons on the WeaponHolder")
			remove_child(get_child(i))

# Function to apply stat modifiers to a weapon
func apply_modifiers_to_weapon(weapon: Node2D) -> void:
	if weapon is Weapon:
		for stat_name in additive_modifiers.keys():
			weapon.add_additive_stat_modifier(stat_name, additive_modifiers[stat_name])
		
		for stat_name in multiplicative_modifiers.keys():
			weapon.add_stat_modifier(stat_name, multiplicative_modifiers[stat_name])

# Function to add a stat modifier to all weapons
func add_stat_modifier(stat_name: String, value: float) -> void:
	if stat_name in additive_modifiers:
		additive_modifiers[stat_name] += value
	elif stat_name in multiplicative_modifiers:
		multiplicative_modifiers[stat_name] *= value
	else:
		print("Unknown stat name for modification: ", stat_name)
	
	for weapon in get_children():
		if weapon is Weapon:
			if stat_name in additive_modifiers:
				weapon.add_additive_stat_modifier(stat_name, value)
			elif stat_name in multiplicative_modifiers:
				weapon.add_stat_modifier(stat_name, value)

# Function to remove a stat modifier from all weapons
func remove_stat_modifier(stat_name: String, value: float) -> void:
	if stat_name in additive_modifiers:
		additive_modifiers[stat_name] -= value
	elif stat_name in multiplicative_modifiers:
		multiplicative_modifiers[stat_name] /= value
	else:
		print("Unknown stat name for removal: ", stat_name)
	
	for weapon in get_children():
		if weapon is Weapon:
			if stat_name in additive_modifiers:
				weapon.remove_additive_stat_modifier(stat_name, value)
			elif stat_name in multiplicative_modifiers:
				weapon.remove_stat_modifier(stat_name, value)
