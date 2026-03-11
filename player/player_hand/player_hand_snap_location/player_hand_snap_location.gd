class_name PlayerHandSnap
extends SnapLocation

signal remove_card


func check_for_snapping(_card: Card) -> bool:
	return false


func add_card_to_snap_location(card: Card) -> void:
	# don't add if there is already a card there
	if get_child_count() == 1:
		super.add_card_to_snap_location(card)


func remove_card_from_snap_location(card: Card) -> void:
	super.remove_card_from_snap_location(card)
	get_parent().queue_free()
	remove_card.emit(card)
	card.scale = Vector2.ONE
