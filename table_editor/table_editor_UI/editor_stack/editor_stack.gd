class_name EditorStack
extends EditorSnapLocation

const DEFAULT_NAME := "New Stack"

var shuffle: bool = true
var face_up: bool = false
var starting_deck: Deck
var starting_deck_card_type: CardType


func _ready() -> void:
	name = DEFAULT_NAME
