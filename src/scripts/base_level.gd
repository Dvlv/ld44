extends Node2D

var sweet_scene = preload("res://scenes/Sweet.tscn")
onready var bed_scene = preload("res://scenes/Bedroom.tscn")
onready var home_scene = preload("res://scenes/SSHome.tscn")

func setup(sweets):
	$SweetSquish.connect("game_win", self, "on_game_win")

	var s1 = sweet_scene.instance()
	s1.colour = sweets[0]

	var s2 = sweet_scene.instance()
	s2.colour = sweets[1]

	var s3 = sweet_scene.instance()
	s3.colour = sweets[2]

	var s4 = sweet_scene.instance()
	s4.colour = sweets[3]

	var s5 = sweet_scene.instance()
	s5.colour = sweets[4]

	var s6 = sweet_scene.instance()
	s6.colour = sweets[5]

	var s7 = sweet_scene.instance()
	s7.colour = sweets[6]

	var s8 = sweet_scene.instance()
	s8.colour = sweets[7]

	var s9 = sweet_scene.instance()
	s9.colour = sweets[8]

	$SweetSquish.set_board(s1, s2, s3, s4, s5, s6, s7, s8, s9)
	$SweetSquish.check_for_matches()


func on_game_win():
	global.score += 50
	global.tickets -= 1
	global.story += 1
	if global.story < 2:
		return get_tree().change_scene_to(bed_scene)
	else:
		return get_tree().change_scene_to(home_scene)