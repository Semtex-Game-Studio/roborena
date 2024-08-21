extends Marker2D

@onready var damage_number_animator = %DamageNumberAnimator

# Function to start the animation
func animate_damage_number(critical_hit: bool) -> void:
	# Set the color based on whether the hit is critical
	if critical_hit:
		self.modulate = Color.RED
	else:
		self.modulate = Color.WHITE
	
	# Play the animation
	if damage_number_animator:
		damage_number_animator.play("animation_damage_number")
		
	self.rotation = deg_to_rad(randf_range(-15,15))
