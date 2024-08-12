extends OptionButton


const WINDOW_MODE_ARRAY: Array[String] = [
	"Fullscreen",
	"Windowed Mode",
	"Borderless Windowed",
	"Windowed Fullscreen",
]


func _ready():
	item_selected.connect(on_window_mode_selected)
	add_window_mode_items()


func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		add_item(window_mode)
		

func on_window_mode_selected(index: int) -> void:
	match index:
		0: # Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: # Windowed Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)			
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: # Borderless Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)			
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: # Windowed Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			
