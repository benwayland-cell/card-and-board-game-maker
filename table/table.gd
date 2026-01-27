extends Node2D

var test_card_front_location :Texture2D= preload("res://card_scene/Test Card.png")
var test_card_back_location :Texture2D= preload("res://card_scene/Test Card Back.png")


func _ready() -> void:
	var test_label = Label.new()
	test_label.label_settings = GlobalVariables.simple_label_settings
	
	var test_label2 = Label.new()
	test_label2.label_settings = GlobalVariables.simple_label_settings
	test_label2.position = Vector2(-50, 20)
	
	var test_sub_type := CardSubType.new("Test card sub type", test_card_front_location, [test_label], [test_label2])
	
	var test_card_type := CardType.new("Test card type", test_card_back_location, [test_sub_type])
	
	var test_card :Card= test_card_type.make_card(0, [1], ["Test Text 1"])
	test_card.name = "Test Card 1"
	add_child(test_card)
	
	var test_card2 :Card= test_card_type.make_card(0, [2], ["Test Text 2"])
	test_card2.position = Vector2(100, 100)
	test_card2.name = "Test Card 2"
	add_child(test_card2)
