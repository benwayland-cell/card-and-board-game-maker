class_name CardData

var sub_type_index : int
var number_label_values : Array[int]
var text_label_values : Array[String]


func _init(given_sub_type_index : int, given_number_label_values : Array[int], given_text_label_values : Array[String]) -> void:
	sub_type_index = given_sub_type_index
	number_label_values = given_number_label_values
	text_label_values = given_text_label_values
