extends VBoxContainer

var card_sub_type : CardSubType

func setup(given_card_sub_type : CardSubType) -> void:
	card_sub_type = given_card_sub_type
	_setup_nodes()


func _setup_nodes() -> void:
	for current_card_node : CardNode in card_sub_type.card_nodes:
		%CardBackground.add_child(current_card_node.node)
		var single_node_menu := GlobalVariables.SINGLE_NODE_MENU_SCENE.instantiate()
		single_node_menu.setup(current_card_node, card_sub_type)
		single_node_menu.connect("delete_button_pressed", _on_node_delete_button_pressed)
		%SingleNodeMenus.add_child(single_node_menu)


func _reset_nodes() -> void:
	close()
	_setup_nodes()


func close() -> void:
	for child in %SingleNodeMenus.get_children():
		child.queue_free()
	
	for child in %CardBackground.get_children():
		%CardBackground.remove_child(child)


func _on_node_delete_button_pressed (node : Node):
	# check if the user want to delete it
	if not await %DeleteMenu.ask_to_delete_node(node.name):
		return
	
	card_sub_type.delete_node(node)
	_reset_nodes()


# adds a new number label to the sub type
func _on_number_label_button_pressed() -> void:
	card_sub_type.add_new_number_label_node()
	_reset_nodes()


# adds a new text label to the sub type
func _on_text_label_button_pressed() -> void:
	card_sub_type.add_new_text_label_node()
	_reset_nodes()
