class_name CardData

var sub_type_index : int
var card_data_array : Array


func _init(given_sub_type_index : int, given_card_data_array) -> void:
	sub_type_index = given_sub_type_index
	card_data_array = given_card_data_array


func _to_string() -> String:
	return "sub_type_index: " + str(sub_type_index) + ", card_data_array: " + str(card_data_array)
