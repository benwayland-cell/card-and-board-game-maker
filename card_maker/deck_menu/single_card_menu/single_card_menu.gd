class_name SingleCardMenu
extends PanelContainer

signal delete_card

var card_type: CardType
var sub_type: CardSubType
var card_data: CardData


func setup(given_card_type: CardType, given_card_data: CardData) -> void:
	card_type = given_card_type
	card_data = given_card_data
	sub_type = card_type.sub_types[card_data.sub_type_index]
	setup_sub_type_option_button()
	setup_card_nodes()


func setup_sub_type_option_button() -> void:
	for index in range(card_type.sub_types.size()):
		var display_sub_type = card_type.sub_types[index]
		%SubTypeOptionButton.add_item(display_sub_type.name, index)
	
	%SubTypeOptionButton.selected = -1
	if not card_data.sub_type_index < 0:
		%SubTypeOptionButton.selected = card_data.sub_type_index


func setup_card_nodes() -> void:
	if card_data.sub_type_index < 0:
		return
	
	var card_nodes:Array[CardNode] = sub_type.card_nodes
	
	for card_node in card_nodes:
		var new_single_card_node_menu: SingleCardNodeMenu = GlobalVariables.SINGLE_CARD_NODE_MENU_SCENE.instantiate()
		new_single_card_node_menu.setup(card_node, card_data)
		%NodeVBox.add_child(new_single_card_node_menu)


func _reset_card_nodes() -> void:
	for child in %NodeVBox.get_children():
		child.queue_free()
	
	setup_card_nodes()


func _on_sub_type_option_button_item_selected(index: int) -> void:
	card_data.sub_type_index = index
	card_data.prune(card_type)
	card_data.sub_type_index = index
	sub_type = card_type.sub_types[index]
	_reset_card_nodes()


func _on_delete_button_pressed() -> void:
	delete_card.emit(card_data)
