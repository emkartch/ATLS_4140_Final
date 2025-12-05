extends Node2D

@onready var hud = get_node("/root/Main/HUD")
@onready var player = get_node("/root/Main/Player")
@onready var tileMap = get_node("/root/Main/allTiles")
@onready var healthBar = get_node("/root/Main/HUD/InLevel/HealthBar")
@onready var healthBarText = get_node("/root/Main/HUD/InLevel/HealthBar/HealthLabel")

var tile_cell_size = Vector2(144,144)

var start_position = Vector2(4,2) * tile_cell_size

var puzzle_active = false

var r_minions = [Vector2(6,3)]

func _ready():
	Global.game_lvl = 7
	$allTiles.change_tile_set()

func _unhandled_input(event):
	if !puzzle_active:
		if event is InputEventMouseButton:
			if event.pressed == false and event.button_index == 1:
				#print("worked")
				$allTiles.check_for_puzzle_click($Player.position)
				
# This function is what will activate the puzzle minigames
func activate_puzzle(tile_coords, tileset_coords):
	print("Activated puzzle!", tile_coords, tileset_coords)

func spawn_mob(pos):
	%PathFollow2D.progress_ratio = randf()
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.position = pos
	add_child(new_mob)

func _on_hud_start_game() -> void:
	healthBar.value = Global.max_player_health
	healthBarText.text = str(int(player.health)) + "/" + str(int(Global.max_player_health))
	# Global.game_lvl = 1
	player.position = start_position
	player.show()
	tileMap.show()

	for vector in r_minions:
		var location = vector * tile_cell_size
		spawn_mob(location)
		
	Global.main_game_running = true


func _on_player_health_depleted() -> void:
	Global.main_game_running = false
	Global.player_death = true
