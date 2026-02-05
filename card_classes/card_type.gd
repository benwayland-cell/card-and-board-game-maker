class_name CardType

var name: String
var card_back_texture: Texture2D
var sub_types: Array[CardSubType]
var deck : Array[CardData]


func _init(given_name: String, given_card_back_texture, given_sub_types: Array[CardSubType]) -> void:
	name = given_name
	card_back_texture = given_card_back_texture
	sub_types = given_sub_types


# returns a card with the given data
func make_card(card_data : CardData) -> Card:
	var sub_type = sub_types[card_data.sub_type_index]
	var variable_nodes : Array[Node] = sub_type.get_card_nodes(card_data.node_dictionary)
	
	var card_to_return :Card= GlobalVariables.CARD_SCENE.instantiate()
	card_to_return.setup(sub_type.card_front_texture, card_back_texture, variable_nodes, Vector2.ZERO, true)
	
	return card_to_return


# Returns an array for the cards in the deck variable
func make_deck() -> Array[Card]:
	var new_deck : Array[Card] = []
	
	for card_data in deck:
		new_deck.append(make_card(card_data))
	
	return new_deck
