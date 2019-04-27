extends "res://scripts/base_ss.gd"


func _ready():
	connect_win()

	squares = [
		$squares/row1/square1,
		$squares/row1/square2,
		$squares/row1/square3,

		$squares/row2/square1,
		$squares/row2/square2,
		$squares/row2/square3,

		$squares/row3/square1,
		$squares/row3/square2,
		$squares/row3/square3,
	]

	match_rows = [
		[$squares/row1/square1, $squares/row1/square2, $squares/row1/square3],
		[$squares/row2/square1, $squares/row2/square2, $squares/row2/square3],
		[$squares/row3/square1, $squares/row3/square2, $squares/row3/square3],
	]

	match_cols = [
		[$squares/row1/square1, $squares/row2/square1, $squares/row3/square1],
		[$squares/row1/square2, $squares/row2/square2, $squares/row3/square2],
		[$squares/row1/square3, $squares/row2/square3, $squares/row3/square3],
	]


func set_board(s1, s2, s3, s4, s5, s6, s7, s8, s9):
	# 1 2 3
	# 4 5 6
	# 7 8 9

	$squares/row1/square1.set_sweet(s1)
	$squares/row1/square2.set_sweet(s2)
	$squares/row1/square3.set_sweet(s3)

	$squares/row2/square1.set_sweet(s4)
	$squares/row2/square2.set_sweet(s5)
	$squares/row2/square3.set_sweet(s6)

	$squares/row3/square1.set_sweet(s7)
	$squares/row3/square2.set_sweet(s8)
	$squares/row3/square3.set_sweet(s9)

	for square in squares:
		square.get_sweet().set_sprite()

	connect_first_clicks()
