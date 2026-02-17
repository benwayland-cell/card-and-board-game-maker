class_name CardType

const DEFAULT_CARD_TYPE_NAME : String = "New Card Type"
const DEFAULT_CARD_SUB_TYPE_NAME : String = "New Card Sub Type"

var name: String
var card_back_texture: Texture2D
var sub_types: Array[CardSubType]
var decks : Array[Deck]


func _init(given_name: String, given_card_back_texture, given_sub_types: Array[CardSubType]) -> void:
	name = given_name
	card_back_texture = given_card_back_texture
	sub_types = given_sub_types


# returns a card with the given data
func make_card(sub_type_index : int, card_data_dict : Dictionary[CardNode, Variant]) -> Card:
	var sub_type = sub_types[sub_type_index]
	var variable_nodes : Array[Node] = sub_type.get_card_nodes(card_data_dict)
	
	var card_to_return : Card = GlobalVariables.CARD_SCENE.instantiate()
	card_to_return.setup(sub_type.card_front_texture, card_back_texture, variable_nodes, Vector2.ZERO, true)
	
	return card_to_return


# Returns an array for the cards in the deck variable
func make_deck(deck_index : int) -> Array[Card]:
	var new_deck : Array[Card] = []
	
	for card_data in decks[deck_index].deck_data:
		var new_card : Card = make_card(card_data.sub_type_index, card_data.card_data_dict)
		new_deck.append(new_card)
	
	return new_deck


func add_empty_sub_type() -> void:
	var new_sub_type := CardSubType.new(DEFAULT_CARD_SUB_TYPE_NAME, GlobalVariables.DEFAULT_FRONT_TEXTURE, [])
	sub_types.append(new_sub_type)


func delete_sub_type(sub_type_to_delete : CardSubType) -> void:
	for index in range(sub_types.size()):
		var sub_type : CardSubType = sub_types[index]
		if sub_type == sub_type_to_delete:
			sub_types.remove_at(index)
			return
