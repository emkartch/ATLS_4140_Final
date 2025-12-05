extends Area2D

signal completed

var tiles = []
var solved = []
var mouse = false
var tileW = 246 * 0.7
var ogW = 246
var top = 195.6
var left = 615.6
var playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#start_game()
	pass;

func start_game():
	playing = false
	tiles = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, $Tile9, $Tile10, $Tile11, $Tile12, $Tile13, $Tile14, $Tile15, $Tile16 ]
	solved = tiles.duplicate()
	shuffle_tiles()
	show()
	
	playing = true
	
	for i in tiles:
		i.show()
	#print("started shuffle")
	
func shuffle_tiles():
	#print("shuffle issue")
	var previous = 99
	var previous_1 = 98
	for t in range(0,Global.puzzle_difficulty):
		var tile = randi() % 16
		if tiles[tile] != $Tile16 and tile != previous and tile != previous_1:
			var rows = int((tiles[tile].position.y + 483) / ogW)
			var cols = int((tiles[tile].position.x + 492) / ogW)
			check_neighbours(rows,cols)
			previous_1 = previous
			previous = tile
			
#468 is left bound, 1452 is the right bound
#246 is width of a single tile
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("process issue")
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse and playing:
		var mouse_copy = mouse
		#print(mouse.position)
		mouse = false
		var rows = int((mouse_copy.position.y - top) / tileW)
		var cols = int((mouse_copy.position.x - left) / tileW)
		#print(mouse_copy.position)
		#print(str(rows) + "," + str(cols))
		check_neighbours(rows,cols)
		if tiles == solved:
			print("Puzzle Complete!")
			completed.emit()
			playing = false

func check_neighbours(rows, cols):
	var empty = false
	var done = false
	var pos = rows * 4 + cols
	while !empty and !done:
		#print(str(tiles[pos].position) + " position")
		var new_pos = tiles[pos].position
		if rows < 3:
			new_pos.y += ogW
			empty = find_empty(new_pos,pos)
			new_pos.y -= ogW
		if rows > 0:
			new_pos.y -= ogW
			empty = find_empty(new_pos,pos)
			new_pos.y += ogW
		if cols < 3:
			new_pos.x += ogW
			empty = find_empty(new_pos,pos)
			new_pos.x -= ogW
		if cols > 0:
			new_pos.x -= ogW
			empty = find_empty(new_pos,pos)
			new_pos.x += ogW
		done = true
			
func find_empty(position2,pos):
	#print(str(position2) + " position2")
	var new_rows = int((position2.y + 483) / ogW)
	var new_cols = int((position2.x + 492) / ogW)
	var new_pos = new_rows * 4 + new_cols
	print(str(new_rows) + "," + str(new_cols))
	#print(str(new_pos) + "new tile index")
	#print(str(new_pos) + "new position")
	if tiles[new_pos] == $Tile16:
		swap_tiles(pos, new_pos)
		return true
	else:
		return false

func swap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = temp_tile
	
	
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		mouse = event
