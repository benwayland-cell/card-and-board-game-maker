extends Node2D

var test_card_front_location :Texture2D= preload("res://card_scene/Test Card.png")
var test_card_back_location :Texture2D= preload("res://card_scene/Test Card Back.png")
var stack_scene : PackedScene = preload("res://stack/stack.tscn")


func _ready() -> void:
	# make the stack
	var test_stack : Stack = stack_scene.instantiate()
	test_stack.add_cards(GlobalVariables.card_types[0].make_deck())
	add_child(test_stack)
	
	for card in test_stack.cards:
		print(card.get_variable_data())
