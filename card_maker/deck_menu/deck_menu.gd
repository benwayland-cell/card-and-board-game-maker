extends VBoxContainer

var card_type : CardType
var deck : Deck


func open_with_deck(given_card_type : CardType, given_deck : Deck):
	card_type = given_card_type
	deck = given_deck
	open()


func open() -> void:
	visible = true
	_update_menu_name()


func _update_menu_name() -> void:
	%MenuName.text = %CardTypeMenu.card_type.name + " / " + deck.name


func close() -> void:
	visible = false
