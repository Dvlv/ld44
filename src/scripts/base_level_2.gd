extends "res://scripts/base_level.gd"


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



	$SweetSquish.set_board(s1, s2, s3, s4, s5, s6)
	$SweetSquish.check_for_matches()