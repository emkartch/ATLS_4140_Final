extends Node2D

@onready var hud = get_node("/root/Main/HUD")
@onready var player = get_node("/root/Main/Player")
@onready var tileMap = get_node("/root/Main/allTiles")
@onready var healthBar = get_node("/root/Main/HUD/InLevel/HealthBar")
@onready var healthBarText = get_node("/root/Main/HUD/InLevel/HealthBar/HealthLabel")

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


func _on_hud_start_game() -> void:
	healthBar.value = Global.max_player_health
	healthBarText.text = str(int(player.health)) + "/" + str(int(Global.max_player_health))
	Global.game_lvl = 1
	tileMap.show()
	#tileMap.get_node("Violet").enabled = false

	#for vector in minion_locations:
		#var location = vector * tile_cell_size
		#spawn_mob(Vector2(1,1),3,location)
	Global.main_game_running = true
