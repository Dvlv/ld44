extends "res://scripts/base_ss.gd"

func _ready():
	connect_win()

	squares = [
		$squares/row1/square1,
		$squares/row1/square2,
		$squares/row1/square3,
		$squares/row1/square4,

		$squares/row2/square1,
		$squares/row2/square2,
		$squares/row2/square3,
		$squares/row2/square4,

		$squares/row3/square1,
		$squares/row3/square2,
		$squares/row3/square3,
		$squares/row3/square4,
	]

	match_rows = [
		[$squares/row1/square1, $squares/row1/square2, $squares/row1/square3, $squares/row1/square4],
		[$squares/row2/square1, $squares/row2/square2, $squares/row2/square3, $squares/row2/square4],
		[$squares/row3/square1, $squares/row3/square2, $squares/row3/square3, $squares/row3/square4],
	]

	match_cols = [
		[$squares/row1/square1, $squares/row2/square1, $squares/row3/square1],
		[$squares/row1/square2, $squares/row2/square2, $squares/row3/square2],
		[$squares/row1/square3, $squares/row2/square3, $squares/row3/square3],
		[$squares/row1/square4, $squares/row2/square4, $squares/row3/square4],
	]

	$bgm.play()


func set_board(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12):
	# 1  2  3
	# 4  5  6
	# 7  8  9
	# 10 11 12

	$squares/row1/square1.set_sweet(s1)
	$squares/row1/square2.set_sweet(s2)
	$squares/row1/square3.set_sweet(s3)
	$squares/row1/square4.set_sweet(s4)


	$squares/row2/square1.set_sweet(s5)
	$squares/row2/square2.set_sweet(s6)
	$squares/row2/square3.set_sweet(s7)
	$squares/row2/square4.set_sweet(s8)

	$squares/row3/square1.set_sweet(s9)
	$squares/row3/square2.set_sweet(s10)
	$squares/row3/square3.set_sweet(s11)
	$squares/row3/square4.set_sweet(s12)

	for square in squares:
		square.get_sweet().set_sprite()

	connect_first_clicks()
