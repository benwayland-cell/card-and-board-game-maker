extends VBoxContainer

signal delete_button_pressed

var card_sub_type : CardSubType
var card_node : CardNode
var node : Node
var node_type : CardNode.NodeTypes


func setup(given_card_node : CardNode, given_card_sub_type : CardSubType) -> void:
	card_sub_type = given_card_sub_type
	card_node = given_card_node
	
	node = card_node.node
	node_type = card_node.node_type
	
	match node_type:
		CardNode.NodeTypes.NUMBER_LABEL:
			%ValueSpinBox.value = int(node.text)
			%NumberHBoxContainer.show()
		
		CardNode.NodeTypes.TEXT_LABEL:
			%ValueLineEdit.text = node.text
			%TextHBoxContainer.show()
	
	%NameLineEdit.text = node.name
	%XCorSpinBox.value = node.position.x
	%YCorSpinBox.value = node.position.y



func _on_name_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		%NameLineEdit.text = node.name
		return
	
	node.name = new_text


func _on_x_cor_spin_box_value_changed(value: float) -> void:
	if node.get("position") != null:
		node.position.x = value
	else:
		print("Node %s does not have a position" % node.name)


func _on_y_cor_spin_box_value_changed(value: float) -> void:
	if node.get("position") != null:
		node.position.y = value
	else:
		print("Node %s does not have a position" % node.name)


func _on_value_spin_box_value_changed(value: int) -> void:
	node.text = str(value)


func _on_value_line_edit_text_submitted(new_text: String) -> void:
	node.text = new_text


func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit(node)
