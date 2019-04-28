extends Node2D
signal finished_displaying

onready var stories = {
	0: "intro",
	1: "out_of_money",
}

onready var CS = $CanvasLayer/DialogueBox

func _ready():
	$bgm.play()
	if not global.just_exited_time_mcn:
		if global.story in stories.keys():
			call(stories[global.story])
		elif global.score > global.HIGH_SCORE:
			$bgm.stop()
			$gamewin.play()
			return winning_scene()
		else:
			return connect_callbacks()
	else:
		global.just_exited_time_mcn = false
		if global.story == 1:
			return eager()
		else:
			connect_callbacks()
			return show_ticket_count()

func load_time_machine():
	get_tree().change_scene_to(load("res://scenes/TimeMachine.tscn"))


func intro():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Wow! That was the best game I've ever played."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I think I have enough money for one more ticket"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "No point having money and never spending it."]},
		{"target": self, "method": "load_lvl_2", "args": []}
	])

func load_lvl_2():
	get_tree().change_scene_to(load("res://scenes/Level2.tscn"))

func out_of_money():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Ah man, I HAVE to get the top score on this game."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I can't wait a whole year to get more lives, and I'm out of money."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Hmm... I could always take my phone into the Time Accelerator™."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "That way I will rack up loads of free lives!"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I will also get a bit older in the process, but hopefully nobody will notice."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "... It'll be fine. Just one more level!"]},
		{"target": self, "method": "load_time_machine", "args": []}
	])

func eager():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Ooh, I have " + ticket_string()]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Wow, I can't believe that worked."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "This rocks! I don't need money, my life is currency."]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Time to play!"]},
		{"target": self, "method": "load_lvl_3", "args": []}
	])

func load_lvl_3():
	get_tree().change_scene_to(load("res://scenes/Level3.tscn"))


func load_ss_home():
	get_tree().change_scene_to(load("res://scenes/SSHome.tscn"))


func show_ticket_count():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", random_time_statement()]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Ooh, I have " + ticket_string()]},
	])

func random_time_statement():
	var statements = [
		"Man, time sure flies!",
		"Wow, I feel older AND wiser!",
		"Oof, rough landing!",
		"Sure beats air travel!"
	]

	if global.get_current_year() > 2025:
		statements.append("Getting old sucks!")
		statements.append("Ack, my back!")
		statements.append("Hello future! Or, is it the past?")

	randomize()
	var choice = randi() % len(statements)

	return statements[choice]


func winning_scene():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I've done it! I have the high score!!"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Man, today was a great and productive day!"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Man, I feel a bit older, too"]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "Yikes! I've skipped " + str(global.years_skipped) + " years." ]},
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "That means I'm " + str(global.get_timmy_age()) + " now."]},
		{"target": self, "method": "ending", "args": []}
	])

func quit_playing():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Timmy", "I'm bored. I should do something else instead"]},
		{"target": self, "method": "ending", "args": []}
	])

func ending():
	if global.years_skipped < 2:
		return young_ending()
	elif global.years_skipped > 2 and global.years_skipped < 9:
		return teenage_ending()
	else:
		return adult_ending()


func young_ending():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Narrator", "This is the young ending."]},
		{"target": self, "method": "load_thanks_scene", "args": []}
	])

func teenage_ending():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Narrator", "This is the teenage ending."]},
		{"target": self, "method": "load_thanks_scene", "args": []}
	])

func adult_ending():
	global.animated_scene([
		{"target": CS, "method": "show_dialogue", "args": ["Narrator", "This is the adult ending."]},
		{"target": self, "method": "load_thanks_scene", "args": []}
	])



func load_thanks_scene():
	get_tree().change_scene_to(load("res://scenes/Thanks.tscn"))


func ticket_string():
	if global.tickets > 1:
		return str(global.tickets) + " tickets now!"
	else:
		return str(global.tickets) + " ticket!"





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
		load_ss_home()

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

