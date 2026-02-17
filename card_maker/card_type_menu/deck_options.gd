extends VBoxContainer


var card_type : CardType
var decks : Array[Deck]


func setup(given_card_type : CardType) -> void:
	card_type = given_card_type
	decks = card_type.decks
	
	for deck in decks:
		var new_button_and_delete : ButtonAndDelete = GlobalVariables.BUTTON_AND_DELETE_SCENE.instantiate()
		new_button_and_delete.setup(deck)
		new_button_and_delete.connect("name_button_pressed", _on_button_pressed)
		new_button_and_delete.connect("delete_button_pressed", _on_delete_button_pressed)
		add_child(new_button_and_delete)


func close() -> void:
	for child in get_children():
		child.queue_free()


func _on_button_pressed(deck : Deck) -> void:
	pass


func _on_delete_button_pressed(deck : Deck) -> void:
	pass
