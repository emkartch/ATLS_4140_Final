extends Node2D

var puzzle_active = false

func _unhandled_input(event):
	if !puzzle_active:
		if event is InputEventMouseButton:
			if event.pressed == false and event.button_index == 1:
				#print("worked")
				$allTiles.check_for_puzzle_click($Player.position)
				
# This function is what will activate the puzzle minigames
func activate_puzzle(tile_coords, tileset_coords):
	print("Activated puzzle!", tile_coords, tileset_coords)
