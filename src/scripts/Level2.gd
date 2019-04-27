extends "res://scripts/base_level.gd"

func _ready():
	global.story += 1
	setup(["orange", "yellow", "pink", "yellow", "orange", "pink", "orange", "yellow", "pink"])
