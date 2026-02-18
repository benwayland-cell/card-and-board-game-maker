class_name SingleCardNodeMenu
extends HBoxContainer

var card_node: CardNode
var card_data: CardData


func setup(given_card_node: CardNode, given_card_data: CardData) -> void:
	card_node = given_card_node
	card_data = given_card_data
	
	var initial_value = card_data.card_data_dict[card_node]
	
	%NameLabel.text = card_node.node.name
	setup_value_container(initial_value)


func setup_value_container(initial_value: Variant) -> void:
	match card_node.node_type:
		CardNode.NodeTypes.NUMBER_LABEL:
			if initial_value == null:
				initial_value = int(card_node.node.text)
			assert(initial_value is int)
			%SpinBox.value = initial_value
			%SpinBox.show()
		
		CardNode.NodeTypes.TEXT_LABEL:
			if initial_value == null:
				initial_value = card_node.node.text
			assert(initial_value is String)
			%LineEdit.text = initial_value
			%LineEdit.show()


func _on_line_edit_text_submitted(new_text: String) -> void:
	assert(card_node.node_type == CardNode.NodeTypes.TEXT_LABEL)
	
	if new_text == "":
		new_text = card_node.node.text
	
	card_data.card_data_dict[card_node] = new_text


func _on_spin_box_value_changed(new_value: float) -> void:
	assert(card_node.node_type == CardNode.NodeTypes.NUMBER_LABEL)
	card_data.card_data_dict[card_node] = int(new_value)
