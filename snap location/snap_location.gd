class_name SnapLocation
extends Area2D

var mouse_is_overlapping := false


func _on_mouse_entered() -> void:
	mouse_is_overlapping = true


func _on_mouse_exited() -> void:
	mouse_is_overlapping = false


func check_for_snapping() -> bool:
	return mouse_is_overlapping
