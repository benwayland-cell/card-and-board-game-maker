class_name CardType

var name: String
var card_back_texture: Texture2D
var sub_types: Array[CardSubType]
var deck : Array[Array]


func _init(given_name: String, given_card_back_texture, given_sub_types: Array[CardSubType]) -> void:
	name = given_name
	card_back_texture = given_card_back_texture
	sub_types = given_sub_types


# returns a card with the given data
func make_card(sub_type_index : int, number_label_values : Array[int], text_label_values : Array[String]) -> Card:
	var sub_type = sub_types[sub_type_index]
	var variable_nodes : Array[Node] = sub_type.get_card_nodes(number_label_values, text_label_values)
	
	var card_to_return :Card= GlobalVariables.CARD_SCENE.instantiate()
	card_to_return.setup(sub_type.card_front_texture, card_back_texture, variable_nodes, Vector2.ZERO, true)
	return card_to_return
