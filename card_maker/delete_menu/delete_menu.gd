extends ColorRect

signal choice_made

var choice : bool


func ask_to_delete_node(node_name : String) -> bool:
	visible = true
	%NodeNameLabel.text = node_name
	
	await self.choice_made
	
	visible = false
	return choice


func _on_yes_button_pressed() -> void:
	choice = true
	choice_made.emit()


func _on_no_button_pressed() -> void:
	choice = false
	choice_made.emit()
