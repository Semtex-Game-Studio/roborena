extends Node2D

# List to keep track of all added items
var items: Array = [Node2D]

@onready var player_character = get_parent()
@onready var player_character_stats_manager: Node2D = %PlayerCharacterStatsManager

# Function to add an item
func add_item(item: Node2D) -> void:
	if item in items:
		print("Item already exists in the inventory.")
		return
	
	if item is Item:
		item.player_character_stats_manager = player_character_stats_manager
		item.apply_effects()
		items.append(item)
		add_child(item)
		player_character._on_item_added(item)

# Function to remove an item
func remove_item(item: Node2D) -> void:
	if item not in items:
		print("Item not found in the inventory.")
		return

	if item is Item:
		item.remove_effects()
		items.erase(item)
		remove_child(item)
		player_character._on_item_removed(item)
