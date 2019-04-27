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

	var s7 = sweet_scene.instance()
	s7.colour = sweets[6]

	var s8 = sweet_scene.instance()
	s8.colour = sweets[7]

	var s9 = sweet_scene.instance()
	s9.colour = sweets[8]

	var s10 = sweet_scene.instance()
	s10.colour = sweets[9]

	var s11 = sweet_scene.instance()
	s11.colour = sweets[10]

	var s12 = sweet_scene.instance()
	s12.colour = sweets[11]

	$SweetSquish.set_board(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12)
	$SweetSquish.check_for_matches()