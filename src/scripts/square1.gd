extends Area2D

signal was_clicked

var my_sweet = null

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", self, "on_input_event")

func set_sweet(sweet):
	my_sweet = sweet
	add_child(sweet)
	
func get_sweet():
	return my_sweet
	
func on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("was_clicked", self)