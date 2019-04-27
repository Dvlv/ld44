extends Node2D

signal game_win

onready var squares = [
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

onready var match_rows = [
	[$squares/row1/square1, $squares/row1/square2, $squares/row1/square3],
	[$squares/row2/square1, $squares/row2/square2, $squares/row2/square3],
	[$squares/row3/square1, $squares/row3/square2, $squares/row3/square3],
]

onready var match_cols = [
	[$squares/row1/square1, $squares/row2/square1, $squares/row3/square1],
	[$squares/row1/square2, $squares/row2/square2, $squares/row3/square2],
	[$squares/row1/square3, $squares/row2/square3, $squares/row3/square3],
]
	

var selected_first_square = null
var selected_second_square = null

func _ready():
	pass # Replace with function body.

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
	connect_second_clicks(selected_first_square)
	
func disconnect_second_clicks():
	for square in squares:
		if square.is_connected("was_clicked", self, "on_second_square_clicked"):
			square.disconnect("was_clicked", self, "on_second_square_clicked")


func on_second_square_clicked(square):
	selected_second_square = square
	if selected_first_square:
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
		if not row[0] or not row[1] or not row[2]:
			continue
			
		if row[0].get_sweet().colour == row[1].get_sweet().colour:
			if row[1].get_sweet().colour == row[2].get_sweet().colour:
				rows_to_remove.append(row)
			else:
				continue
		else:
			continue
			
	for col in match_cols:
		if not col[0] or not col[1] or not col[2]:
			continue
		
		if col[0].get_sweet().colour == col[1].get_sweet().colour:
			if col[1].get_sweet().colour == col[2].get_sweet().colour:
				cols_to_remove.append(col)
			else:
				continue
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
	
	
	
	
	
			
			
			
			
			
			
			