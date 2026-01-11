extends Node2D

var test_card_front_location :Texture2D= preload("res://card/Test Card.png")
var test_card_back_location :Texture2D= preload("res://card/Test Card Back.png")

var card_location := preload("res://card/card.tscn")

func _ready() -> void:
	var test_label = Label.new()
	test_label.label_settings = GlobalVariables.simple_label_settings
	test_label.text = "1"
	var variable_node_array :Array[Node]= [test_label]
	
	var test_card := card_location.instantiate()
	print(test_card.get_children())
	test_card.setup("testCard", test_card_front_location, test_card_back_location, variable_node_array)
	add_child(test_card)
