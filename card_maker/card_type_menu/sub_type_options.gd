extends VBoxContainer

var card_type : CardType
var sub_types : Array[CardSubType]

func setup(given_card_type : CardType) -> void:
	card_type = given_card_type
	sub_types = card_type.sub_types
	
	# add label
	var label := Label.new()
	var label_settings = LabelSettings.new()
	label_settings.font_color = Color.BLACK
	label.label_settings = label_settings
	label.text = "Sub Types:"
	add_child(label)
	
	for sub_type in sub_types:
		var button := CustomCardTypeButton.new()
		button.text = sub_type.name
		button.card_sub_type = sub_type
		button.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		button.connect("go_to_card_sub_type", _on_button_pressed)
		add_child(button)

func close() -> void:
	for child in get_children():
		child.queue_free()

func _on_button_pressed(card_sub_type : CardSubType) -> void:
	%CardTypeMenu.close()
	%CardSubTypeMenu.open_with_sub_type(card_sub_type)
