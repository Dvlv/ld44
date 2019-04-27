extends Node2D

onready var b1 = $Control/VBoxContainer/CenterContainer/TextureButton
onready var b2 = $Control/VBoxContainer/CenterContainer2/TextureButton
onready var b3 = $Control/VBoxContainer/CenterContainer3/TextureButton

onready var bed = preload("res://scenes/Bedroom.tscn")

func _ready():
	b1.connect("pressed", self, "on_btn_one_press")
	b2.connect("pressed", self, "on_btn_two_press")
	b3.connect("pressed", self, "on_btn_three_press")
	global.just_exited_time_mcn = true
	$bgm.play()

func on_btn_one_press():
	global.years_skipped += 1
	global.tickets += 2

	exit_to_bedroom()

func on_btn_two_press():
	global.years_skipped += 2
	global.tickets += 4

	exit_to_bedroom()

func on_btn_three_press():
	global.years_skipped += 3
	global.tickets += 6

	exit_to_bedroom()

func exit_to_bedroom():
	# play anim, sound
	$bgm.stop()
	$tt.connect("finished", self, "load_bed_scene")
	$tt.play()

func load_bed_scene():
	get_tree().change_scene_to(bed)
