extends Button

@export var action_name: String


func _ready():
	set_process_unhandled_key_input(false)
	set_button_key_text()

	
func set_button_key_text() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	text = "%s" % action_keycode
