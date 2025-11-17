extends Node2D

var puzzle_active = false

func _unhandled_input(event):
	if !puzzle_active:
		if event is InputEventMouseButton:
			if event.pressed == false and event.button_index == 1:
				$allTiles.check_for_puzzle_click($testSprite.position)
