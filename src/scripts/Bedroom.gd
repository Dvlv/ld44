extends Node2D
signal finished_displaying

onready var stories = {
	0: "intro",
	1: "out_of_money",
}

onready var CS = $CanvasLayer/DialogueBox

func _ready():
	if not global.just_exited_time_mcn:
		call(stories[global.story])
	else:
		# connect phone click to next lvl
		# will be Level + str(story+1), or random lvl
		pass

func load_time_machine():
	get_tree().change_scene_to(load("res://scenes/TimeMachine.tscn"))


func intro():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Wow! That was the best game I've ever played."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I think I have enough money for one more game"]},
		{"target": self, "method": "load_lvl_2", "args": []}
	])

func load_lvl_2():
	get_tree().change_scene_to(load("res://scenes/Level2.tscn"))

func out_of_money():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Ah man, I HAVE to get the top score on this game."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I can't wait months to get more lives, and I'm out of money."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Hmm... I could always leave my phone on the bed and hop into my time machine."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "That way I will rack up loads of free lives!"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "If I don't go too far forward, nobody will notice I'm gone."]},
		{"target": self, "method": "load_time_machine", "args": []}
	])

