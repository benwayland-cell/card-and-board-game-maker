extends Node2D

var test_card_front_location :Texture2D= preload("res://card_scene/Test Card.png")
var test_card_back_location :Texture2D= preload("res://card_scene/Test Card Back.png")


func _ready() -> void:
	#var test_label = Label.new()
	#test_label.label_settings = GlobalVariables.simple_label_settings
	#test_label.text = "1"
	#var variable_node_array :Array[Node]= [test_label]
	#var test_card :Card= card_location.instantiate()
	#test_card.setup(test_card_front_location, test_card_back_location, variable_node_array, Vector2.ZERO, true)
	#add_child(test_card)
	#
	#var test_label2 = Label.new()
	#test_label2.label_settings = GlobalVariables.simple_label_settings
	#test_label2.text = "2"
	#var variable_node_array2 :Array[Node]= [test_label2]
	#var test_card2 :Card= card_location.instantiate()
	#test_card2.setup(test_card_front_location, test_card_back_location, variable_node_array2, Vector2(100, 100), true)
	#add_child(test_card2)
	
	var test_label = Label.new()
	test_label.label_settings = GlobalVariables.simple_label_settings
	
	var test_label2 = Label.new()
	test_label2.label_settings = GlobalVariables.simple_label_settings
	test_label2.position.x = 100
	
	var test_sub_type := CardSubType.new("Test card sub type", test_card_front_location, [test_label, test_label2], [])
	
	var test_card_type := CardType.new("Test card type", test_card_back_location, [test_sub_type])
	
	var test_card :Card= test_card_type.make_card(0, [1, 2], [])
	add_child(test_card)
