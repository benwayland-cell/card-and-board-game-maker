extends VBoxContainer

func open() -> void:
	%MenuName.text = "Card Type 1"
	visible = true


func _on_back_button_pressed() -> void:
	if visible:
		visible = false
		%MainMenu.open()
