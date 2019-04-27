extends Node2D

export (String) var colour = ""
#var sprite = ""

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "after_squish")

func set_sprite():
	$Sprite.texture = load("res://assets/art/" + colour + "sweet.png")

func play_squish():
	$AnimationPlayer.play("squish")

func after_squish(anim):
	get_parent().queue_free()