extends Node2D



func _ready() -> void:
	# make the stack
	var test_card_type : CardType = GlobalVariables.card_types[0]
	var test_stack : Stack = Scenes.STACK_SCENE.instantiate()
	test_stack.add_deck(test_card_type.decks[0], test_card_type)
	add_child(test_stack)
	
	# add to the player hand
	%PlayerHand.player = GlobalVariables.players[0]
