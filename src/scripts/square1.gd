extends Area2D

signal was_clicked

var my_sweet = null
var my_border = null

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", self, "on_input_event")

	for child in self.get_children():
		if child.name == "border":
			my_border = child

func set_sweet(sweet):
	my_sweet = sweet
	add_child(sweet)

func get_sweet():
	return my_sweet

func on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("was_clicked", self)

func show_border():
	my_border.visible = true

func hide_border():
	my_border.visible = false