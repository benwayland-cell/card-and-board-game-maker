class_name SingleCardMenu
extends VBoxContainer

var node : Node
var card_sub_type : CardSubType
var node_location : CardSubType.NodeLocation

var _name_line_edit : LineEdit


func _init(given_node_location : CardSubType.NodeLocation, given_card_sub_type : CardSubType) -> void:
	card_sub_type = given_card_sub_type
	node_location = given_node_location
	
	match node_location.node_type:
		GlobalVariables.NodeTypes.NUMBER_LABEL:
			node = card_sub_type.number_labels[node_location.index]
			
		GlobalVariables.NodeTypes.TEXT_LABEL:
			node = card_sub_type.text_labels[node_location.index]


func setup() -> void:
	var name_h_box := HBoxContainer.new()
	
	var label := Label.new()
	label.label_settings = GlobalVariables.simple_label_settings
	label.text = "Node:"
	name_h_box.add_child(label)
	
	_name_line_edit = LineEdit.new()
	_name_line_edit.text = node.name
	_name_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_name_line_edit.connect("text_submitted", _on_name_line_edit_text_submitted)
	name_h_box.add_child(_name_line_edit)
	
	add_child(name_h_box)


func _on_name_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		_name_line_edit.text = node.name
		return
	
	node.name = new_text
