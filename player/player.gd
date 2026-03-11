class_name Player
extends Node

var hand: Array[Card]


func remove_card(card_to_remove: Card) -> void:
	hand.erase(card_to_remove)
