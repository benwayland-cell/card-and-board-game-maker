extends Node

const DEFAULT_FRONT_TEXTURE :Texture2D= preload("res://card_textures/Test Card.png")
const DEFAULT_BACK_TEXTURE :Texture2D= preload("res://card_textures/Test Card Back.png")

const TABLE_SCENE: PackedScene = preload("uid://dfi586cpgfuvl")

const CARD_TEXTURE_WIDTH: int = 150
const CARD_TEXTURE_HEIGHT: int = 210

var camera_zoom := Vector2.ONE
var simple_label_settings := LabelSettings.new()
var card_types: Array[CardType] = []
var players: Array[Player] = []

var table_save_data: Array[SaveData] = []


func _ready():
	# init simple_label_settings
	simple_label_settings.font_color = Color.BLACK
	
	
	
	# after this is for debug
	
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


class SaveData:
	enum DataType {EDITOR_STACK, EDITOR_SINGLE_SNAP}
	
	var position: Vector2 = Vector2.ZERO
	var shuffle: bool = true
	var face_up: bool = false
	var starting_deck: Deck
	var starting_deck_card_type: CardType
	var data_type: DataType
	
	func _init(data: EditorSnapLocation) -> void:
		if data is EditorStack:
			_save_editor_stack(data)
		elif data is EditorSingleSnap:
			data_type = DataType.EDITOR_SINGLE_SNAP
		else:
			assert(false, "Not implemented")
	
	func _save_editor_stack(data: EditorStack) -> void:
		position = data.position
		shuffle = data.shuffle
		face_up = data.face_up
		starting_deck = data.starting_deck
		starting_deck_card_type = data.starting_deck_card_type
		data_type = DataType.EDITOR_STACK
	
	
	static func make_save_data_array(data_array : Array[EditorSnapLocation]) -> Array[SaveData]:
		var to_return: Array[SaveData] = []
		
		for data: EditorSnapLocation in data_array:
			to_return.append(SaveData.new(data))
		
		return to_return


const CARD_EDITOR_SCENE: PackedScene = preload("uid://cq0456nebfdxi")
const TABLE_EDITOR_SCENE: PackedScene = preload("uid://djhjymkdg13o1")


func _process(_delta: float) -> void:
	if Input.is_action_pressed("ctrl"):
		if Input.is_action_just_pressed("go_to_table"):
			get_tree().change_scene_to_packed(TABLE_SCENE)
		elif Input.is_action_just_pressed("go_to_card_editor"):
			get_tree().change_scene_to_packed(CARD_EDITOR_SCENE)
		elif Input.is_action_just_pressed("go_to_table_editor"):
			get_tree().change_scene_to_packed(TABLE_EDITOR_SCENE)
