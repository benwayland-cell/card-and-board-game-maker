extends Node

var camera_zoom := Vector2.ONE
var simple_label_settings := LabelSettings.new()
var card_types : Array[CardType] = []

const CARD_SCENE :PackedScene= preload("res://card_scene/card.tscn")
const RIGHT_CLICK_MENU_SCENE :PackedScene= preload("res://right_click_menu/right_click_menu.tscn")
const TEST_CARD_FRONT_TEXTURE :Texture2D= preload("res://card_textures/Test Card.png")
const TEST_CARD_BACK_TEXTURE :Texture2D= preload("res://card_textures/Test Card Back.png")
const SINGLE_NODE_MENU_SCENE : PackedScene = preload("res://card_maker/single_node_menu.tscn")

func _ready():
	# init simple_label_settings
	simple_label_settings.font_color = Color.BLACK
	
	# init card types
	var test_label1 = Label.new()
	test_label1.label_settings = GlobalVariables.simple_label_settings
	test_label1.label_settings.font_size = 20
	test_label1.name = "Test number label"
	test_label1.text = "1"
	var test_card_node1 := CardNode.new(test_label1, CardNode.NodeTypes.NUMBER_LABEL)
	
	var test_label2 = Label.new()
	test_label2.label_settings = GlobalVariables.simple_label_settings
	test_label2.label_settings.font_size = 20
	test_label2.position = Vector2(-50, 20)
	test_label2.name = "Test text label"
	test_label2.text = "Lorem Ipsum"
	var test_card_node2 := CardNode.new(test_label2, CardNode.NodeTypes.TEXT_LABEL)
	
	var test_sub_type := CardSubType.new("Test card sub type", TEST_CARD_FRONT_TEXTURE, [test_card_node1, test_card_node2])
	
	var test_card_type := CardType.new("Test card type", TEST_CARD_BACK_TEXTURE, [test_sub_type])
	test_card_type.deck = [
		CardData.new(0, [1, "Test Text 1"]),
		CardData.new(0, [2, "Test Text 2"]),
		CardData.new(0, [null, null])
		]
	
	card_types.append(test_card_type)
