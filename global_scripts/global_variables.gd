extends Node

var camera_zoom := Vector2.ONE
var simple_label_settings := LabelSettings.new()
var card_types : Array[CardType] = []

const CARD_SCENE :PackedScene= preload("res://card_scene/card.tscn")
const RIGHT_CLICK_MENU_SCENE :PackedScene= preload("res://right_click_menu/right_click_menu.tscn")
const DEFAULT_FRONT_TEXTURE :Texture2D= preload("res://card_textures/Test Card.png")
const DEFAULT_BACK_TEXTURE :Texture2D= preload("res://card_textures/Test Card Back.png")

const BUTTON_AND_DELETE_SCENE : PackedScene = preload("res://card_maker/button_and_delete/button_and_delete.tscn")
const SINGLE_NODE_MENU_SCENE : PackedScene = preload("res://card_maker/card_sub_type_menu/single_node_menu/single_node_menu.tscn")

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
	
	var test_sub_type := CardSubType.new("Test card sub type", DEFAULT_FRONT_TEXTURE, [test_card_node1, test_card_node2])
	
	var test_card_type := CardType.new("Test card type", DEFAULT_BACK_TEXTURE, [test_sub_type])
	
	var test_card1 : Dictionary[CardNode, Variant] = {
		test_card_node1: 10,
		test_card_node2: "Test Text 1",
	}
	var test_card2 : Dictionary[CardNode, Variant] = {
		test_card_node1: 20,
		test_card_node2: "Test Text 2",
	}
	var test_card3 : Dictionary[CardNode, Variant] = {
		test_card_node1: null,
		test_card_node2: null,
	}
	
	test_card_type.decks = [
		Deck.new([
			CardData.new(0, test_card1),
			CardData.new(0, test_card2),
			CardData.new(0, test_card3),
		])
		]
	
	card_types.append(test_card_type)


func add_new_card_type() -> void:
	var new_card_type := CardType.new(CardType.DEFAULT_CARD_TYPE_NAME, DEFAULT_BACK_TEXTURE, [])
	card_types.append(new_card_type)


func delete_card_type(card_type_to_delete : CardType) -> void:
	for index in range(card_types.size()):
		var card_type : CardType = card_types[index]
		if card_type == card_type_to_delete:
			card_types.remove_at(index)
			return
