extends Node2D

var empty_texture :Texture2D
var cards :Array[Card]
var mouse_is_overlapping := false


func _process(_delta: float) -> void:
	#print(cards.size())
	_handle_removing_cards()
	_handle_adding_cards()
	
	#if Input.is_action_just_pressed("debug"):
		#var string = "["
		#for card in cards:
			#string += str(card.name) + ", "
		#print(string + "]")


func _on_area_2d_mouse_entered() -> void:
	mouse_is_overlapping = true


func _on_area_2d_mouse_exited() -> void:
	mouse_is_overlapping = false


func get_mouse_is_overlapping() -> bool:
	return mouse_is_overlapping

func _handle_adding_cards() -> void:
	if not Input.is_action_just_released("left_click"):
		return
	
	for area: Area2D in %Area2D.get_overlapping_areas():
		var area_parent : Node = area.get_parent()
		if area_parent is Card and global_position == area.global_position:
			_add_card(area.get_parent())


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
		#add_card_to_base.emit(cards[-1])
		cards[-1].show()
		cards[-1].set_process(true)


func _add_card(card : Card) -> void:
	if card in cards:
		return
	
	#print("Added card: " + str(card.name))
	
	cards.append(card)
	
	if cards.size() >= 2:
		#cards[-2].queue_free()
		cards[-2].hide()
		cards[-2].set_process(false)
