extends TileMapLayer
signal activate_puzzle(tile_coords, tileset_coords)

var puzzle_coords = [Vector2i(2, 4), Vector2i(3, 4), Vector2i(4, 4)]

func _ready():
	var redTexture = load("res://tilesets/RedTiles2.png")
	$redGround.tile_set.get_source(0).texture = redTexture

# Checks if mouse clicked on a puzzle tile
func check_for_puzzle_click(sprite_pos):
	
	# Where is the mouse in global coords?
	var mouse_pos = get_global_mouse_position()
	# Where is the tile on the tilemap layer?
	var tile_pos = $redAccPuzz.local_to_map(mouse_pos)
	# Where is the tile in global coords?
	var tile_map_coords = $redAccPuzz.map_to_local(tile_pos)
	# Where is the tile in the tileset?
	var tileset_coords = $redAccPuzz.get_cell_atlas_coords(tile_pos)
	print(tileset_coords)
	
	if tileset_coords!= Vector2i(-1,-1):
		
		# How far away is the player from the clicked tile?
		var pos_delta = tile_map_coords - sprite_pos
		print("Delta:", pos_delta)
		
		# Is the player near enough to the tile?
		var is_near_enough = false
		if abs(pos_delta[0]) <= 140 and abs(pos_delta[1]) <= 100:
			is_near_enough = true
			
		print(tileset_coords)
		if tileset_coords in puzzle_coords and is_near_enough:
			#print("activate puzzle")
			activate_puzzle.emit(tile_map_coords, tileset_coords)
			

# Looks for mouse clicks (releases, not presses)
#func _unhandled_input(event):
	#if event is InputEventMouseButton:
		#if event.pressed == false and event.button_index == 1:
			#check_for_puzzle_click()
			#print("left click (released)")
			
