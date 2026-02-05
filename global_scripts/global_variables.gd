extends Node

var camera_zoom := Vector2.ONE
var simple_label_settings := LabelSettings.new()
var card_types : Array[CardType] = []

const CARD_SCENE :PackedScene= preload("res://card_scene/card.tscn")
const RIGHT_CLICK_MENU_SCENE :PackedScene= preload("res://right_click_menu/right_click_menu.tscn")
var TEST_CARD_FRONT_TEXTURE :Texture2D= preload("res://card_textures/Test Card.png")
var TEST_CARD_BACK_TEXTURE :Texture2D= preload("res://card_textures/Test Card Back.png")

func _ready():
	# init simple_label_settings
	simple_label_settings.font_color = Color.BLACK
	
	# init card types
	var test_label1 = Label.new()
	test_label1.label_settings = GlobalVariables.simple_label_settings
	test_label1.label_settings.font_size = 20
	test_label1.name = "Test number label"
	test_label1.text = "1"
	
	var test_label2 = Label.new()
	test_label2.label_settings = GlobalVariables.simple_label_settings
	test_label2.label_settings.font_size = 20
	test_label2.position = Vector2(-50, 20)
	test_label2.name = "Test text label"
	test_label2.text = "Lorem Ipsum"
	
	var test_sub_type := CardSubType.new("Test card sub type", TEST_CARD_FRONT_TEXTURE, [test_label1], [test_label2])
	
	var alt_node_dictionary : Dictionary = test_sub_type.get_node_dictionary()
	alt_node_dictionary[test_label1.name] = 2
	alt_node_dictionary[test_label2.name] = "Test Text"
	
	var test_card_type := CardType.new("Test card type", TEST_CARD_BACK_TEXTURE, [test_sub_type])
	test_card_type.deck = [
		CardData.new(0, test_sub_type.get_node_dictionary()),
		CardData.new(0, alt_node_dictionary),
		]
	
	card_types.append(test_card_type)
