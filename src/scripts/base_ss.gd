extends Node2D

signal game_win

var squares = null
var selected_first_square = null
var selected_second_square = null

var match_cols = null
var match_rows = null

func connect_first_clicks():
	for square in squares:
		square.connect("was_clicked", self, "on_first_square_clicked")

func connect_second_clicks(selected):
	for square in squares:
		if square.is_connected("was_clicked", self, "on_first_square_clicked"):
			square.disconnect("was_clicked", self, "on_first_square_clicked")
		if not square.get_instance_id() == selected.get_instance_id():
			square.connect("was_clicked", self, "on_second_square_clicked")

func on_first_square_clicked(square):
	selected_first_square = square
	selected_first_square.show_border()
	connect_second_clicks(selected_first_square)

func disconnect_second_clicks():
	for square in squares:
		if square.is_connected("was_clicked", self, "on_second_square_clicked"):
			square.disconnect("was_clicked", self, "on_second_square_clicked")


func on_second_square_clicked(square):
	selected_second_square = square
	if selected_first_square:
		selected_first_square.hide_border()
		swap_sweets(selected_first_square, selected_second_square)

func swap_sweets(sq1, sq2):
	var first_square_sweet = sq1.get_sweet()
	var second_square_sweet = sq2.get_sweet()

	sq1.remove_child(first_square_sweet)
	sq2.remove_child(second_square_sweet)

	sq1.set_sweet(second_square_sweet)
	sq2.set_sweet(first_square_sweet)

	check_for_matches()

	if len(squares):
		disconnect_second_clicks()
		connect_first_clicks()
	else:
		emit_signal("game_win")


func check_for_matches():
	var rows_to_remove = []
	var cols_to_remove = []

	for row in match_rows:
		var has_broken = false
		for item in row:
			if not item:
				has_broken = true
				break

		if has_broken:
			continue

		var master_colour = row[0].get_sweet().colour
		var all_match = true
		for item in row:
			if item.get_sweet().colour != master_colour:
				all_match = false

		if all_match:
			rows_to_remove.append(row)
		else:
			continue

	for col in match_cols:
		var has_broken = false
		for item in col:
			if not item:
				has_broken = true
				break

		if has_broken:
			continue

		var master_colour = col[0].get_sweet().colour
		var all_match = true
		for item in col:
			if item.get_sweet().colour != master_colour:
				all_match = false

		if all_match:
			cols_to_remove.append(col)
		else:
			continue

	if len(rows_to_remove):
		for row in rows_to_remove:
			remove_row(row)

	if len(cols_to_remove):
		for col in cols_to_remove:
			remove_col(col)

func pop_squares(squares_to_pop):
	for square in squares_to_pop:
		var idx = squares.find(square)
		squares.remove(idx)
		square.queue_free()

func remove_row(row):
	match_rows.remove(match_rows.find(row))
	match_cols = []
	pop_squares(row)

func remove_col(col):
	match_cols.remove(match_cols.find(col))
	match_rows = []
	pop_squares(col)


