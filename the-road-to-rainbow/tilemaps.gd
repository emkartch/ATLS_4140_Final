extends TileMapLayer

func _ready():
	pass;

# Checks if mouse clicked on a puzzle tile
func check_for_puzzle_click(sprite_pos):
	var mouse_pos = get_global_mouse_position();
	#print("Mouse position: ")
	#print(mouse_pos)
	#print(local_to_map(to_local(mouse_pos)))
	#print(to_local(mouse_pos))
	var tile_pos = $puzzles.local_to_map(mouse_pos)
	var tileset_coords = $puzzles.get_cell_atlas_coords(tile_pos)
	
	if tileset_coords!= Vector2i(-1,-1):
		var pos_delta = mouse_pos - sprite_pos
		print("Delta:", pos_delta)
		var is_near_enough = false
		
		if abs(pos_delta[0]) <= 100 and abs(pos_delta[1]) <= 110:
			is_near_enough = true
			
		print(tileset_coords)
		if tileset_coords == Vector2i(5,3) and is_near_enough:
			print("activate puzzle")

# Looks for mouse clicks (releases, not presses)
#func _unhandled_input(event):
	#if event is InputEventMouseButton:
		#if event.pressed == false and event.button_index == 1:
			#check_for_puzzle_click()
			#print("left click (released)")
			
