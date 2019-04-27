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

		if global.score > global.HIGH_SCORE:
			winning_scene()
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
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Oh, right. I forgot - I haven't yet perfected the art of time travel"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "My body will age at twice the speed of the world every time I jump forwards."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "... It'll be fine. Just one more level!"]},
		{"target": self, "method": "load_time_machine", "args": []}
	])

func winning_scene():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I've done it! I have the high score!!"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Man, today was a great and productive day!"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Actually, what day is it today?"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Yikes! it's " + global.get_current_year() ]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Wow, I can't believe almost half of my life has gone by while I say and played on my phone. Totally worth it."]},
		{"target": self, "method": "load_thanks_scene", "args": []}
	])

func quit_playing():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I'm bored. I should do something else instead"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", get_final_dialogue_based_on_year() ]},
		{"target": self, "method": "load_thanks_scene", "args": []}
	])


func get_final_dialogue_based_on_year():
	var cy = global.get_current_year()
	if cy >= 2023:
		return "Wow, I can't believe almost half of my life has gone by while I say and played on my phone. Was it worth it?"
	elif cy > 2020 and cy < 2023:
		return "Man, I wasted a lot of time on that game. Good thing I didn't get addicted, or who knows how many more years I would have skipped."
	elif cy <= 2020:
		return "I'm glad I didn't waste too much time playing that game. I might have missed the robot uprising or something!"

func load_thanks_scene():
	get_tree().change_scene_to(load("res://scenes/Thanks.tscn"))