extends Control

@onready var button_resume_game = %ButtonResumeGame as Button
@onready var button_options_menu = %ButtonOptionsMenu as Button
@onready var button_return_to_main_menu = %ButtonReturnToMainMenu as Button

@onready var pause_menu_container = $PauseMenuContainer as MarginContainer
@onready var options_menu = %OptionsMenu

var game_paused: bool = false

func _ready():
	signal_connection_handler()


func signal_connection_handler() -> void:
	button_resume_game.pressed.connect(on_resume_game_pressed)
	button_options_menu.pressed.connect(on_options_menu_pressed)
	button_return_to_main_menu.pressed.connect(on_return_to_main_menu_pressed)
	
	options_menu.exit_options_menu.connect(on_exit_options_menu)


# Button functions
func on_resume_game_pressed() -> void:
	unpause_game()

func on_options_menu_pressed() -> void:
	pause_menu_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_return_to_main_menu_pressed() -> void:
	game_paused = false
	Engine.time_scale = 1
	var main_menu_scene: PackedScene = load("res://Content/User Interface/Main Menu/main_menu.tscn")
	get_tree().change_scene_to_packed(main_menu_scene)


# Pause input event
func _input(event):
	if event.is_action_pressed("Pause"):
		if !game_paused:
			pause_game()
		else:
			unpause_game()


# Game pausing and unpausing
func pause_game() -> void:
	show()
	game_paused = true
	Engine.time_scale = 0

func unpause_game() -> void:
	hide()
	Engine.time_scale = 1
	game_paused = false


# Options menu logic
func on_exit_options_menu() -> void:
	options_menu.visible = false
	pause_menu_container.visible = true
