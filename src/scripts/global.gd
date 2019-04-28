extends Node

var years_skipped = 0
var tickets = 2
var score = 0
var HIGH_SCORE = 2000

var story = -1
var just_exited_time_mcn = false
var last_level = 0

var frames = []



func get_random_level():
	randomize()
	var levels = [4, 5, 6, 7, 8]
	levels.shuffle()
	var chosen_lvl = ""
	if levels[0] == last_level:
		chosen_lvl = levels[1]
	else:
		chosen_lvl = levels[0]

	return "Level" + str(chosen_lvl) + ".tscn"


func get_current_year():
	return 2019 + years_skipped

func get_timmy_age():
	return 11 + years_skipped

func tie_together_frames():
    frames.remove(0)

    if len(frames) < 1:
        return

    var current = frames[0]
    if not current["target"].is_connected("finished_displaying", self, "tie_together_frames"):
      current["target"].connect("finished_displaying", self, "tie_together_frames")
    current["target"].callv(current["method"], current["args"])


func animated_scene(structure):
    # structure is
    # {target: [method, arg1, arg2, ...]}
    # Every animation must emit finished_displaying upon completion to be included in this chain

    frames = structure

    var current = frames[0]

    if not current["target"].is_connected("finished_displaying", self, "tie_together_frames"):
        current["target"].connect("finished_displaying", self, "tie_together_frames")

    # begin executing the chain by calling the first item's method
    current["target"].callv(current["method"], current["args"])

