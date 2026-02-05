extends Node2D

var stack_scene : PackedScene = preload("res://stack/stack.tscn")

func _ready() -> void:
	# make the stack
	var test_card_type : CardType = GlobalVariables.card_types[0]
	#print(test_card_type.name)
	var test_stack : Stack = stack_scene.instantiate()
	test_stack.add_cards(test_card_type.make_deck())
	add_child(test_stack)
	
	
	
	
	#for card in test_stack.cards:
		#print(card.get_variable_data())
	
	#print(GlobalVariables.card_types[0].sub_types[0].get_node_dictionary())
