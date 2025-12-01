extends TileMapLayer
signal activate_puzzle(tile_coords, tileset_coords)

# for tracking where we are at
var lvl = 2
var color = "red"
var lvl_finished = false
var num_finished = 0

var lvl_tiles = []
var lvl_walls = []
var lvl_puzz = []
var puzzle_coords = [Vector2i(2, 4), Vector2i(3, 4), Vector2i(4, 4)]

func _ready():
	lvl_tiles = [$Red, $Orange]
	lvl_walls = [$Red/Walls, $Orange/Walls]
	lvl_puzz = [$Red/AccPuzz, $Orange/AccPuzz]
	
	lvl = 2
	change_tile_set()

# Setting show and collisions per tile
func set_collisions():
	for i in range(0,2):
		
		if lvl - 1 == i:
			lvl_tiles[i].show()
			lvl_walls[i].collision_enabled = true
			lvl_puzz[i].collision_enabled = true
		else:
			lvl_tiles[i].hide()
			lvl_walls[i].collision_enabled = false
			lvl_puzz[i].collision_enabled = false

func change_tile_set():
	if lvl == 1 and lvl_finished == false:
		var newTexture = load("res://tilesets/RedTilesGrey.png")
		$Red/Ground.tile_set.get_source(0).texture = newTexture
		$Red/AccPuzz.tile_set.get_source(1).texture = newTexture
	elif lvl == 1 and lvl_finished == true:
		var newTexture = load("res://tilesets/OnlyRed-Lvl1.png")
		$Red/Ground.tile_set.get_source(0).texture = newTexture
		$Red/AccPuzz.tile_set.get_source(1).texture = newTexture
	elif lvl == 2 and lvl_finished == false:
		var newTexture = load("res://tilesets/Greyed-Orange.png")
		$Orange/Ground.tile_set.get_source(0).texture = newTexture
	elif lvl == 2 and lvl_finished == true:
		var newTexture = load("res://tilesets/Only-Orange.png")
		$Orange/Ground.tile_set.get_source(0).texture = newTexture
		
	# setting show and collisions
	set_collisions()
	
# Checks if mouse clicked on a puzzle tile
func check_for_puzzle_click(sprite_pos):
	
	# Where is the mouse in global coords?
	var mouse_pos = get_global_mouse_position()
	# Where is the tile on the tilemap layer?
	var tile_pos = lvl_puzz[lvl - 1].local_to_map(mouse_pos)
	# Where is the tile in global coords?
	var tile_map_coords = lvl_puzz[lvl - 1].map_to_local(tile_pos)
	# Where is the tile in the tileset?
	var tileset_coords = lvl_puzz[lvl - 1].get_cell_atlas_coords(tile_pos)
	print(tileset_coords)
	
	if tileset_coords!= Vector2i(-1,-1):
		
		# How far away is the player from the clicked tile?
		var pos_delta = tile_map_coords - sprite_pos
		#print("Delta:", pos_delta)
		
		# Is the player near enough to the tile?
		var is_near_enough = false
		if abs(pos_delta[0]) <= 140 and abs(pos_delta[1]) <= 100:
			is_near_enough = true
			
		#print(tileset_coords)
		if tileset_coords in puzzle_coords and is_near_enough:
			#print("activate puzzle")
			activate_puzzle.emit(tile_map_coords, tileset_coords)
			num_finished += 1
	
	if num_finished >= 5:
		lvl_finished = true
		change_tile_set()

# Looks for mouse clicks (releases, not presses)
#func _unhandled_input(event):
	#if event is InputEventMouseButton:
		#if event.pressed == false and event.button_index == 1:
			#check_for_puzzle_click()
			#print("left click (released)")
			
