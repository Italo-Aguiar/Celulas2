extends Area2D

onready var main = get_parent().get_parent()

onready var origin = position

var id 

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			main.drag = true
			main.target = self
			main.origin = origin
		else:
			main.drag = false
