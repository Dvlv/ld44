extends Node2D

export (String) var colour = ""
#var sprite = ""

func set_sprite():
	$Sprite.texture = load("res://assets/art/" + colour + "sweet.png")

