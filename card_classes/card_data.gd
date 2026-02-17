class_name CardData

var sub_type_index : int
var card_data_dict : Dictionary[CardNode, Variant]


func _init(given_sub_type_index : int, given_card_data_dict) -> void:
	sub_type_index = given_sub_type_index
	card_data_dict = given_card_data_dict


func _to_string() -> String:
	return "sub_type_index: " + str(sub_type_index) + ", card_data_dict: " + str(card_data_dict)
