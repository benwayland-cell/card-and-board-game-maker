class_name SingleSnap
extends SnapLocation

var current_card: Card


func add_card_to_snap_location(card: Card) -> void:
	super.add_card_to_snap_location(card)
	
	current_card = card

func remove_card_from_snap_location(card: Card) -> void:
	super.remove_card_from_snap_location(card)
	
	current_card = null


func check_for_snapping(card: Card) -> bool:
	if not mouse_is_overlapping:
		return false
	
	if card == current_card:
		return true
	
	return current_card == null
