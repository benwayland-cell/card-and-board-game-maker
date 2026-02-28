extends Node2D

var stack_scene : PackedScene = preload("uid://daxva46oxm3tt")

func _ready() -> void:
	# make the stack
	var test_card_type : CardType = GlobalVariables.card_types[0]
	var test_stack : Stack = stack_scene.instantiate()
	test_stack.add_deck(test_card_type.decks[0], test_card_type)
	add_child(test_stack)
