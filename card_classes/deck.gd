class_name Deck

const DEFAULT_DECK_NAME : String = "New Deck"

var name : String
var deck_data : Array[CardData]

func _init(given_deck_data : Array[CardData]) -> void:
	deck_data = given_deck_data
	name = DEFAULT_DECK_NAME


func _to_string() -> String:
	return "{%s: " % name + str(deck_data) + "}"


# prunes all CardData in deck_data
func prune(card_type : CardType) -> void:
	for card_data in deck_data:
		card_data.prune(card_type)


func delete_card(card_data_to_delete: CardData) -> void:
	for index in range(deck_data.size()):
		var card_data: CardData = deck_data[index]
		if card_data == card_data_to_delete:
			deck_data.remove_at(index)
			return


func add_new_card() -> void:
	var new_card_data_dict: Dictionary[CardNode, Variant]= {}
	deck_data.append(CardData.new(-1, new_card_data_dict))


func to_card_array(card_type: CardType) -> Array[Card]:
	var cards_to_return: Array[Card] = []
	
	for card_data in deck_data:
		var new_card: Card = card_data.to_card(card_type)
		cards_to_return.append(new_card)
	
	return cards_to_return
