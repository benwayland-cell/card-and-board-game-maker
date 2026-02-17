class_name Deck

const DEFAULT_DECK_NAME : String = "New Deck"

var name : String
var deck_data : Array[CardData]

func _init(given_deck_data : Array[CardData]) -> void:
	deck_data = given_deck_data
	name = DEFAULT_DECK_NAME


func _to_string() -> String:
	return "{%s: " % name + str(deck_data) + "}"
