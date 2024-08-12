extends OptionButton


const RESOLUTION_DICTIONARY : Dictionary = {
	"1280x720" : Vector2i(1280,720),
	"1600x900" : Vector2i(1600,900),
	"1920x1080": Vector2i(1920,1080),
	"2560x1440": Vector2i(2560,1440),
	"3200x1800": Vector2i(3200,1800),
	"3840x2160": Vector2i(3840,2160),
}


func _ready():
	item_selected.connect(on_resolution_selected)
	add_resolution_items()

func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		add_item(resolution_size_text)

func on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
