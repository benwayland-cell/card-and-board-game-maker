class_name Stack
extends SnapLocation

@export var shuffle_deck: bool = true

var cards : Array [Card]


#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("debug"):
		#print(name + ":")
		#print("cards.size(): " + str(cards.size()))


# adds cards to the stack
func add_cards(new_cards : Array[Card]):
	# hides the current top card
	if cards.size() > 0:
		remove_child(cards[-1])
		cards[-1].disabled = true
	
	# appends new_cards to the end of cards
	for card in new_cards:
		card.disabled = true
		cards.append(card)
	
	# show the second from top card if there is one
	if cards.size() > 1:
		add_child(cards[-2])
	
	# show the top card of the stack
	cards[-1].disabled = false
	add_child(cards[-1])


func add_deck(deck: Deck, card_type: CardType) -> void:
	var card_array: Array[Card] = deck.to_card_array(card_type)
	
	if shuffle_deck:
		card_array.shuffle()
	
	add_cards(card_array)


func add_card_to_snap_location(card: Card) -> void:
	var cards_size: int = cards.size()
	# remove the currently second from the top card if there is one
	if cards_size > 1:
		remove_child(cards[-2])
	
	# disable the currently on top card if there is one
	if cards_size > 0:
		cards[-1].disabled = true
	
	# add the new card
	cards.append(card)
	super.add_card_to_snap_location(card)


func remove_card_from_snap_location(card: Card) -> void:
	# in the case of this snap location, it assumed 'card' is at the top
	assert(cards.size() > 0, "Tried to remove card from snap location: [%s] when there where no cards to remove" % name)
	assert(card == cards[-1], "Tried to remove a card that was not the top card from snap location: [%s]" % name)
	
	# remove the top card
	cards.remove_at(-1)
	remove_child(card)
	
	var cards_size: int = cards.size()
	
	# enable the now on top card
	if cards_size > 0:
		cards[-1].disabled = false
	# show the now second from top card
	if cards_size > 1:
		add_child(cards[-2])
		move_child(cards[-2], -2) # this is to make sure it draws behind the top card
