extends Node2D
signal finished_displaying

onready var stories = {
	0: "intro",
	1: "out_of_money",
	2: "eager"
}

onready var CS = $CanvasLayer/DialogueBox

func _ready():
	if not global.just_exited_time_mcn:
		call(stories[global.story])
	else:
		if global.story == 1:
			eager()
		if global.score > global.HIGH_SCORE:
			winning_scene()
		else:
			# connect phone click to next lvl
			# will be Level + str(story+1), or random lvl
			connect_callbacks()

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

func eager():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Wow, I can't believe that worked."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Ooh, I have " + str(global.tickets) + " new tickets!"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Time to play!"]},
		{"target": self, "method": "load_lvl_3", "args": []}
	])

func load_lvl_3():
	get_tree().change_scene_to(load("res://scenes/Level3.tscn"))

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







######### callbacks
func connect_callbacks():
	$bg/tm.connect("input_event", self, "on_tm_click")
	$bg/tm.connect("mouse_entered", self, "show_tm_tip")
	$bg/tm.connect("mouse_exited", self, "hide_tm_tip")

	$bg/phone.connect("input_event", self, "on_phone_click")
	$bg/phone.connect("mouse_entered", self, "show_phone_tip")
	$bg/phone.connect("mouse_exited", self, "hide_phone_tip")

	$bg/door.connect("input_event", self, "on_door_click")
	$bg/door.connect("mouse_entered", self, "show_door_tip")
	$bg/door.connect("mouse_exited", self, "hide_door_tip")


func on_tm_click(i,event,c):
	if (event is InputEventMouseButton && event.pressed):
		load_time_machine()

func on_door_click(i,event,c):
	# are you sure?
	if (event is InputEventMouseButton && event.pressed):
		quit_playing()

func on_phone_click(i,event,c):
	# load random lvl
	if (event is InputEventMouseButton && event.pressed):
		load_lvl_3()

func show_tm_tip():
	$bg/tm/tip.visible = true

func hide_tm_tip():
	$bg/tm/tip.visible = false

func show_phone_tip():
	$bg/phone/tip.visible = true

func hide_phone_tip():
	$bg/phone/tip.visible = false

func show_door_tip():
	$bg/door/tip.visible = true

func hide_door_tip():
	$bg/door/tip.visible = false

