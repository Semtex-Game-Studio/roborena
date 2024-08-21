extends Control


@onready var game = get_parent().get_parent()
@onready var player = game.get_node("PlayerCharacter")

@onready var score_label = %ScoreLabel
@onready var health_bar = %HealthBar
@onready var healt_bar_label = %HealtBarLabel

	
func _process(delta):
	score_label.text = "Score: " + str(game.player_currency)
	health_bar.max_value = player.max_health
	health_bar.value = player.current_health
	
	healt_bar_label.text = str(health_bar.value) + "/" + str(health_bar.max_value)
