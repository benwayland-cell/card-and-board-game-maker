class_name PlayerHandSnap
extends SnapLocation


func remove_card_from_snap_location(card: Card) -> void:
	super.remove_card_from_snap_location(card)
	get_parent().queue_free()
