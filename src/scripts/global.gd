extends Node

var age = 11
var tickets = 1
var money = 5000
var score = 0

var story = 0

var frames = []


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

    current["target"].connect("finished_displaying", self, "tie_together_frames")

    # begin executing the chain by calling the first item's method
    current["target"].callv(current["method"], current["args"])

