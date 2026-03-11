class_name Table
extends Node2D


@onready var player_hand: PlayerHand = %PlayerHand


func _ready() -> void:
	# make the stack
	var test_card_type : CardType = GlobalVariables.card_types[0]
	var test_stack : Stack = Scenes.STACK_SCENE.instantiate()
	test_stack.add_deck(test_card_type.decks[0], test_card_type)
	add_child(test_stack)
	
	# add to the player hand
	player_hand.player = GlobalVariables.players[0]
