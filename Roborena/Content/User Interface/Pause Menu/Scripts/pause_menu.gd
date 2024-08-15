extends Control


@onready var button_resume_game = %ButtonResumeGame as Button
@onready var button_options_menu = %ButtonOptionsMenu as Button
@onready var button_return_to_main_menu = %ButtonReturnToMainMenu as Button

@onready var pause_menu_container = $PauseMenuContainer as MarginContainer

@onready var main_menu: PackedScene = preload("res://Content/User Interface/Main Menu/main_menu.tscn")
@onready var options_menu = %OptionsMenu

var game_paused: bool = false

func _ready():
	signal_conncetion_handler()


func signal_conncetion_handler() -> void:
	button_resume_game.button_down.connect(on_resume_game_pressed)
	button_options_menu.button_down.connect(on_options_menu_pressed)
	button_return_to_main_menu.button_down.connect(on_return_to_main_menu_pressed)
	


func on_resume_game_pressed() -> void:
	unpause_game()


func on_options_menu_pressed() -> void:
	pause_menu_container.visible = false
	options_menu.set_process(true)
	
	options_menu.visible = true
	
	
func on_return_to_main_menu_pressed() -> void:
	game_paused = false
	Engine.time_scale = 1
	get_tree().change_scene_to_packed(main_menu)


# Handle pause button
func _input(event):
	if event.is_action_pressed("Pause"):
		if !game_paused:
			pause_game()
		else:
			unpause_game()

func pause_game():
	show()
	game_paused = true
	Engine.time_scale = 0

func unpause_game():
	hide()
	Engine.time_scale = 1
	game_paused = false
