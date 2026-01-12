class_name CardType

var name: String
var card_back_texture: Texture2D
var sub_types: Array[CardSubType]

func _init(given_name: String, given_card_back_texture, given_sub_types: Array[CardSubType]) -> void:
	name = given_name
	card_back_texture = given_card_back_texture
	sub_types = given_sub_types
