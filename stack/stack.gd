extends Node2D
class_name Stack

var empty_texture :Texture2D
var cards :Array[Card]
var mouse_is_overlapping := false


func _process(_delta: float) -> void:
	#print(cards.size())
	_handle_removing_cards()
	_handle_adding_cards()


func _on_area_2d_mouse_entered() -> void:
	mouse_is_overlapping = true


func _on_area_2d_mouse_exited() -> void:
	mouse_is_overlapping = false


func get_mouse_is_overlapping() -> bool:
	return mouse_is_overlapping


# checks for any cards being added to the stack
func _handle_adding_cards() -> void:
	if not Input.is_action_just_released("left_click"):
		return
	
	for area: Area2D in %Area2D.get_overlapping_areas():
		var area_parent : Node = area.get_parent()
		if area_parent is Card and global_position == area.global_position:
			_add_card(area.get_parent())


# checks for the top card being removed and removing it
func _handle_removing_cards() -> void:
	# check if there is a card to remove
	if not cards.size() > 0:
		return
	
	# check if the card has been moved
	if cards[-1].global_position == global_position:
		return
	
	# remove the card from cards and show the one under it
	#print("Removed card: " + cards[-1].name)
	cards.remove_at(-1)
	
	# add the now topmost card to the scene
	if cards.size() > 0:
		add_child(cards[-1])


# adds the card to the stack
func _add_card(card : Card) -> void:
	# don't add this card if it's already in the stack
	if card in cards:
		return
	
	
	# add the card to cards and make it a child of the stack
	cards.append(card)
	card.get_parent().remove_child(card)
	add_child(card)
	card.position = Vector2.ZERO
	#print("Added card: " + str(card.name))
	
	# quietly remove any cards that should be hidden
	if cards.size() >= 2:
		remove_child(cards[-2])


# adds cards to the stack
func add_cards(new_cards : Array[Card]):
	# hides the current top card
	if cards.size() > 0:
		remove_child(cards[-1])
	
	# appends new_cards to the end of cards
	for card in new_cards:
		cards.append(card)
	
	# show the top card of the stack
	add_child(cards[-1])
