extends Control

@onready var button_start_game = %ButtonStartGame as Button
@onready var button_options_menu = %ButtonOptionsMenu as Button
@onready var button_quit_game = %ButtonQuitGame as Button
@onready var main_menu_container = $MainMenuContainer as MarginContainer

@onready var options_menu = %OptionsMenu

func _ready():
	signal_conncetion_handler()


func signal_conncetion_handler() -> void:
	button_start_game.button_down.connect(on_start_game_pressed)
	button_options_menu.button_down.connect(on_options_menu_pressed)
	button_quit_game.button_down.connect(on_quit_game_pressed)
	
	options_menu.exit_options_menu.connect(on_exit_options_menu)


func on_start_game_pressed() -> void:
	var game: PackedScene = load("res://Content/Scenes/Game/game.tscn")
	get_tree().change_scene_to_packed(game)
	
	
func on_options_menu_pressed() -> void:
	main_menu_container.visible = false
	options_menu.set_process(true)
	
	options_menu.visible = true
	
	
func on_quit_game_pressed() -> void:
	get_tree().quit()


func on_exit_options_menu() -> void:
	options_menu.visible = false
	main_menu_container.visible = true
	
