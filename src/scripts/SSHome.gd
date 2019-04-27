extends Node2D


func _ready():
	$Tickets.text = "Tickets: " + str(global.tickets)
	$hiscore.text = "High Score: " + str(global.HIGH_SCORE)
	$myscore.text = "My Score: " + str(global.score)

	$Button.connect("pressed", self, "play")
	$Close.connect("pressed", self, "close")
	if global.story < 0:
		$Close.visible = false

	$bgm.play()

func play():
	if global.story < 0:
		return get_tree().change_scene_to(load("res://scenes/Level1.tscn"))
	if global.tickets > 0:
		var random_level = global.get_random_level()
		var lvl_scene = load("res://scenes/" + random_level)

		return get_tree().change_scene_to(lvl_scene)
	else:
		$fail.play()
		$Label.visible = true

func close():
	$fail.play()
	return get_tree().change_scene_to(load("res://scenes/Bedroom.tscn"))