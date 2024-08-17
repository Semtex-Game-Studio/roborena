extends VBoxContainer

@onready var fullscreen_button = %FullscreenButton
@onready var resolution_options_button = %ResolutionOptionsButton
@onready var v_sync_button = %V_SyncButton


const RESOLUTION_DICTIONARY : Dictionary = {
	"1280x720" : Vector2i(1280,720),
	"1600x900" : Vector2i(1600,900),
	"1920x1080": Vector2i(1920,1080),
	"2560x1440": Vector2i(2560,1440),
	"3200x1800": Vector2i(3200,1800),
	"3840x2160": Vector2i(3840,2160),
}


func _ready():
	fullscreen_button.toggled.connect(on_full_screen_toggled)
	check_window_state()
	
	resolution_options_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()
	
	v_sync_button.toggled.connect(on_v_sync_toggled)
	check_v_sync_state()


# Resolution
func add_resolution_items() -> void:
	var current_resolution = DisplayServer.window_get_size()
	var resolution_id = 0
	
	for resolution_size_text in RESOLUTION_DICTIONARY:
		resolution_options_button.add_item(resolution_size_text, resolution_id)
		if RESOLUTION_DICTIONARY[resolution_size_text] == current_resolution:
			resolution_options_button.select(resolution_id)
		
		resolution_id += 1

func on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	center_window_on_screen()

func center_window_on_screen() -> void:
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = DisplayServer.window_get_size_with_decorations()
	DisplayServer.window_set_position(screen_center-window_size/2)


# Fullscreen
func on_full_screen_toggled(toggled_on) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolution_options_button.disabled = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		resolution_options_button.disabled = false

func check_window_state() -> void:
	var current_window_mode = DisplayServer.window_get_mode()
	
	if current_window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_button.set_pressed_no_signal(true)
	else:
		fullscreen_button.set_pressed_no_signal(false)


# V-Sync
func on_v_sync_toggled(toggled_on) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func check_v_sync_state() -> void:
	var current_v_sync_mode = DisplayServer.window_get_vsync_mode()
	
	if current_v_sync_mode == DisplayServer.VSYNC_ENABLED:
		v_sync_button.set_pressed_no_signal(true)
	else:
		v_sync_button.set_pressed_no_signal(false)
