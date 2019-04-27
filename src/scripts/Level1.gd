extends Node2D

var sweet_scene = preload("res://scenes/Sweet.tscn")

func _ready():
	var s1 = sweet_scene.instance()
	s1.colour = "orange"
	
	var s2 = sweet_scene.instance()
	s2.colour = "yellow"
	
	var s3 = sweet_scene.instance()
	s3.colour = "orange"
	
	var s4 = sweet_scene.instance()
	s4.colour = "yellow"
	
	var s5 = sweet_scene.instance()
	s5.colour = "orange"
	
	var s6 = sweet_scene.instance()
	s6.colour = "yellow"
	
	var s7 = sweet_scene.instance()
	s7.colour = "pink"
	
	var s8 = sweet_scene.instance()
	s8.colour = "pink"
	
	var s9 = sweet_scene.instance()
	s9.colour = "pink"
	
	$SweetSquish.set_board(s1, s2, s3, s4, s5, s6, s7, s8, s9)
	$SweetSquish.check_for_matches()	


