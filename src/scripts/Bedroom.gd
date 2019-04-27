extends Node2D

onready var stories = {
	0: "intro",
	1: "out_of_money",
}

func _ready():
	call(stories[global.story])

func intro():
	print("play intro")
	get_tree().change_scene_to(load("res://scenes/Level2.tscn"))

func out_of_money():
	print("play oom")

