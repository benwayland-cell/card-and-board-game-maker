class_name SnapLocation
extends Area2D

var mouse_is_overlapping := false


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	mouse_is_overlapping = true


func _on_mouse_exited() -> void:
	mouse_is_overlapping = false


func check_for_snapping(_card: Card) -> bool:
	return mouse_is_overlapping


func add_card_to_snap_location(card: Card) -> void:
	var card_parent = card.get_parent()
	
	if card_parent is SnapLocation:
		card_parent.remove_card_from_snap_location(card)
	
	elif card_parent == null:
		pass
	else:
		assert(false, "Card [" + card.name + "]'s parent was not a snap location")
	
	add_child(card)


func remove_card_from_snap_location(card: Card) -> void:
	remove_child(card)
