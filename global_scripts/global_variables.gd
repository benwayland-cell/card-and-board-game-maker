extends Node

const DEFAULT_FRONT_TEXTURE :Texture2D= preload("res://card_textures/Test Card.png")
const DEFAULT_BACK_TEXTURE :Texture2D= preload("res://card_textures/Test Card Back.png")

const CARD_TEXTURE_WIDTH: int = 150
const CARD_TEXTURE_HEIGHT: int = 210

var camera_zoom := Vector2.ONE
var simple_label_settings := LabelSettings.new()
var card_types: Array[CardType] = []
var players: Array[Player] = []


func _ready():
	# init simple_label_settings
	simple_label_settings.font_color = Color.BLACK
	
	# init card types
	var test_label1 = Label.new()
	test_label1.label_settings = simple_label_settings
	test_label1.label_settings.font_size = 20
	test_label1.name = "Test number label"
	test_label1.text = "1"
	var test_card_node1 := CardNode.new(test_label1, CardNode.NodeTypes.NUMBER_LABEL)
	
	var test_label2 = Label.new()
	test_label2.label_settings = simple_label_settings
	test_label2.label_settings.font_size = 20
	test_label2.position = Vector2(-50, 20)
	test_label2.name = "Test text label"
	test_label2.text = "Lorem Ipsum"
	var test_card_node2 := CardNode.new(test_label2, CardNode.NodeTypes.TEXT_LABEL)
	
	var test_sub_type := CardSubType.new("Test card sub type", DEFAULT_FRONT_TEXTURE, [test_card_node1, test_card_node2])
	
	var test_card_type := CardType.new("Test card type", DEFAULT_BACK_TEXTURE, [test_sub_type])
	
	var test_card1 : Dictionary[CardNode, Variant] = {
		test_card_node1: 3,
		test_card_node2: "Test Text 1",
	}
	var test_card2 : Dictionary[CardNode, Variant] = {
		test_card_node1: 2,
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
	
	
	# set up a test player
	var test_player: Player = Player.new()
	test_player.name = "Test Player"
	test_player.hand = test_card_type.make_deck(0)
	players = [test_player]


func add_new_card_type() -> void:
	var new_card_type := CardType.new(CardType.DEFAULT_CARD_TYPE_NAME, DEFAULT_BACK_TEXTURE, [])
	card_types.append(new_card_type)


func delete_card_type(card_type_to_delete : CardType) -> void:
	for index in range(card_types.size()):
		var card_type : CardType = card_types[index]
		if card_type == card_type_to_delete:
			card_types.remove_at(index)
			return


func load_texture_from_path(path: String) -> Texture2D:
	var image := Image.new()
	var error := image.load(path)
	if error != OK:
		push_error("Failed to load image: %s" % path)
		return null
	
	var new_texture := ImageTexture.create_from_image(image)
	return new_texture
