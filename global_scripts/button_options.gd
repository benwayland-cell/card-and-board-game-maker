extends Node

## All functions here are things that can be in right click menus
## All functions shouls return a bool value
## true if the menu should close after executing
## false if the menu shouldn't close after executing

func add_card_to_player_hand(given_card: Card) -> bool:
	var table: Table = get_tree().current_scene
	table.player_hand.add_card_to_hand(given_card)
	return true


func flip_card(given_node: Card) -> bool:
	given_node.flip_card()
	return true
