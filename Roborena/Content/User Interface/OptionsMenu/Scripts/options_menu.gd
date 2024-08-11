class_name OptionsMenu

extends Control


@onready var button_back = %ButtonBack as Button

signal exit_options_menu

func _ready():
	button_back.button_down.connect(on_back_pressed)
	set_process(false)


func on_back_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)
