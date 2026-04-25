class_name Table
extends Node2D


@onready var player_hand: PlayerHand = %PlayerHand

var debug

func _ready() -> void:
	_setup_table()
	
	# after this is for debug
	
	# make the stack
	#var test_card_type : CardType = GlobalVariables.card_types[0]
	#var test_stack : Stack = Scenes.STACK_SCENE.instantiate()
	#test_stack.add_deck(test_card_type.decks[0], test_card_type)
	#add_child(test_stack)
	
	# add to the player hand
	player_hand.player = GlobalVariables.players[0]


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		print(debug)


func _setup_table() -> void:
	var table_save_data: Array[GlobalVariables.SaveData] = GlobalVariables.table_save_data
	
	for data: GlobalVariables.SaveData in table_save_data:
		match data.data_type:
			GlobalVariables.SaveData.DataType.EDITOR_STACK:
				_make_stack(data)
			GlobalVariables.SaveData.DataType.EDITOR_SINGLE_SNAP:
				pass
			_:
				assert(false, "Have yet to implement data type")


func _make_stack(data: GlobalVariables.SaveData):
	var new_stack : Stack = Scenes.STACK_SCENE.instantiate()
	new_stack.position = data.position
	new_stack.shuffle_deck = data.shuffle
	#TODO implement the direction the cards are facing when added to the stack
	
	if data.starting_deck == null:
		return
	
	new_stack.add_deck(data.starting_deck, data.starting_deck_card_type)
	add_child(new_stack)
	debug = new_stack
