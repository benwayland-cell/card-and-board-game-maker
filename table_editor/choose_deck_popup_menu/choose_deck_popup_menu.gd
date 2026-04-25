class_name ChooseDeckPopupMenu
extends PopupMenu

@onready var other_menu: PopupMenu = %PopupMenu

func get_deck() -> Array:
	position = get_mouse_position()
	other_menu.position = position
	
	# Get the card type
	var card_types: Array[CardType] = GlobalVariables.card_types
	for index in range(card_types.size()):
		var current_card_type: CardType = card_types[index]
		add_item(current_card_type.name, index)
	
	popup()
	var card_type_id: int = await id_pressed
	clear()
	
	var card_type: CardType = card_types[card_type_id]
	var decks: Array[Deck] = card_type.decks
	for index in range(decks.size()):
		var deck: Deck = decks[index]
		other_menu.add_item(deck.name, index)
	
	other_menu.popup()
	var deck_id: int = await other_menu.id_pressed
	var deck_chosen = decks[deck_id]
	other_menu.clear()
	
	return [deck_chosen, card_type]
