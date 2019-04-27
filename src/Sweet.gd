extends Node2D

export (String) var colour = ""
var sprite = ""

func _ready():
	$Sprite.texture = load("res://assets/art/" + colour + "sweet.png")

