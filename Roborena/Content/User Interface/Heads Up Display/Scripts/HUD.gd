extends Control


@onready var game = get_parent().get_parent()
@onready var player_character = game.get_node("PlayerCharacter")
@onready var player_character_hurtbox = player_character.get_node("PlayerCharacterHurtbox")

@onready var score_label = %ScoreLabel
@onready var health_bar = %HealthBar
@onready var healt_bar_label = %HealtBarLabel

	
func _process(delta):
	score_label.text = "Score: " + str(player_character.currency)
	health_bar.max_value = player_character.max_health
	health_bar.value = player_character_hurtbox.current_health
	
	healt_bar_label.text = str(health_bar.value) + "/" + str(health_bar.max_value)
