extends Node2D

var sweet_scene = preload("res://scenes/Sweet.tscn")
onready var next_scene = preload("res://scenes/Bedroom.tscn")

func _ready():
	$SweetSquish.connect("game_win", self, "on_game_win")

	var s1 = sweet_scene.instance()
	s1.colour = "orange"

	var s2 = sweet_scene.instance()
	s2.colour = "yellow"

	var s3 = sweet_scene.instance()
	s3.colour = "pink"

	var s4 = sweet_scene.instance()
	s4.colour = "yellow"

	var s5 = sweet_scene.instance()
	s5.colour = "orange"

	var s6 = sweet_scene.instance()
	s6.colour = "pink"

	var s7 = sweet_scene.instance()
	s7.colour = "orange"

	var s8 = sweet_scene.instance()
	s8.colour = "yellow"

	var s9 = sweet_scene.instance()
	s9.colour = "pink"

	$SweetSquish.set_board(s1, s2, s3, s4, s5, s6, s7, s8, s9)
	$SweetSquish.check_for_matches()


func on_game_win():
	get_tree().change_scene_to(next_scene)
