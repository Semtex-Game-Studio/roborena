extends VBoxContainer


@onready var master_volume_slider = %MasterVolumeSlider
@onready var master_volume_percentage_label = %MasterVolumePercentageLabel
@onready var music_volume_slider = %MusicVolumeSlider
@onready var music_volume_percentage_label = %MusicVolumePercentageLabel
@onready var sfx_volume_slider = %SFXVolumeSlider
@onready var sfx_volume_percentage_label = %SFXVolumePercentageLabel

@onready var bus_index_master = AudioServer.get_bus_index("Master")
@onready var bus_index_music = AudioServer.get_bus_index("Music")
@onready var bus_index_sfx = AudioServer.get_bus_index("SFX")


func _ready():
	master_volume_percentage_label.text = str(master_volume_slider.value)+"%"
	music_volume_percentage_label.text = str(music_volume_slider.value)+"%"
	sfx_volume_percentage_label.text = str(sfx_volume_slider.value)+"%"

	master_volume_slider.value_changed.connect(on_master_volume_changed)
	music_volume_slider.value_changed.connect(on_music_volume_changed)
	sfx_volume_slider.value_changed.connect(on_sfx_volume_changed)


func on_master_volume_changed(value) -> void:
	AudioServer.set_bus_volume_db(bus_index_master, linear_to_db(value/100))
	master_volume_percentage_label.text = str(value)+"%"

func on_music_volume_changed(value) -> void:
	AudioServer.set_bus_volume_db(bus_index_music, linear_to_db(value/100))
	music_volume_percentage_label.text = str(value)+"%"

func on_sfx_volume_changed(value) -> void:
	AudioServer.set_bus_volume_db(bus_index_sfx, linear_to_db(value/100))
	sfx_volume_percentage_label.text = str(value)+"%"
