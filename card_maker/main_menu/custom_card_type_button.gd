class_name CustomCardTypeButton
extends Button

var card_type : CardType
var card_sub_type : CardSubType

signal go_to_card_type
signal go_to_card_sub_type

func _ready() -> void:
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	go_to_card_type.emit(card_type)
	go_to_card_sub_type.emit(card_sub_type)
