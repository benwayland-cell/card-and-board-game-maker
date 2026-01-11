class_name SnapLocation

extends Node2D

var mouse_is_overlapping := false


func _on_area_2d_mouse_entered() -> void:
	mouse_is_overlapping = true


func _on_area_2d_mouse_exited() -> void:
	mouse_is_overlapping = false


func get_mouse_is_overlapping() -> bool:
	return mouse_is_overlapping
