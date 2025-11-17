extends TileMapLayer
signal activate_puzzle(tile_coords, tileset_coords)

func _ready():
	pass;

# Checks if mouse clicked on a puzzle tile
func check_for_puzzle_click(sprite_pos):
	
	# Where is the mouse in global coords?
	var mouse_pos = get_global_mouse_position();
	# Where is the tile on the tilemap layer?
	var tile_pos = $puzzles.local_to_map(mouse_pos)
	# Where is the tile in global coords?
	var tile_map_coords = $puzzles.map_to_local(tile_pos);
	# Where is the tile in the tileset?
	var tileset_coords = $puzzles.get_cell_atlas_coords(tile_pos)
	
	if tileset_coords!= Vector2i(-1,-1):
		
		# How far away is the player from the clicked tile?
		var pos_delta = tile_map_coords - sprite_pos
		#print("Delta:", pos_delta)
		
		# Is the player near enough to the tile?
		var is_near_enough = false
		if abs(pos_delta[0]) <= 90 and abs(pos_delta[1]) <= 160:
			is_near_enough = true
			
		print(tileset_coords)
		if tileset_coords == Vector2i(5,3) and is_near_enough:
			#print("activate puzzle")
			activate_puzzle.emit(tile_map_coords, tileset_coords)
			

# Looks for mouse clicks (releases, not presses)
#func _unhandled_input(event):
	#if event is InputEventMouseButton:
		#if event.pressed == false and event.button_index == 1:
			#check_for_puzzle_click()
			#print("left click (released)")
			
