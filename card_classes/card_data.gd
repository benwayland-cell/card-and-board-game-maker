class_name CardData

var sub_type_index : int
var card_data_dict : Dictionary[CardNode, Variant]


func _init(given_sub_type_index : int, given_card_data_dict) -> void:
	sub_type_index = given_sub_type_index
	card_data_dict = given_card_data_dict


func _to_string() -> String:
	return "sub_type_index: " + str(sub_type_index) + ", card_data_dict: " + str(card_data_dict)


# prunes the card_data_dict so that there only one key for each node in the sub type
func prune(card_type : CardType) -> void:
	var sub_type : CardSubType = card_type.sub_types[sub_type_index]
	var card_nodes : Array[CardNode] = sub_type.card_nodes
	
	var new_card_data_dict : Dictionary[CardNode, Variant] = {}
	
	for card_node in card_nodes:
		if card_data_dict.has(card_node):
			new_card_data_dict[card_node] = card_data_dict[card_node]
		else:
			new_card_data_dict[card_node] = card_node.get_value()
	
	card_data_dict = new_card_data_dict
