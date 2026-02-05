class_name CardData

var sub_type_index : int
var node_dictionary : Dictionary


func _init(given_sub_type_index : int, given_node_dictionary) -> void:
	sub_type_index = given_sub_type_index
	node_dictionary = given_node_dictionary


func _to_string() -> String:
	return "sub_type_index: " + str(sub_type_index) + ", node_dictionary: " + str(node_dictionary)
