extends Node2D

@onready var hud = get_node("/root/Main/HUD")
@onready var player = get_node("/root/Main/Player")
@onready var mob = get_node("/root/Main/Mob")
@onready var tileMap = get_node("/root/Main/allTiles")
@onready var healthBar = get_node("/root/Main/HUD/InLevel/HealthBar")
@onready var healthBarText = get_node("/root/Main/HUD/InLevel/HealthBar/HealthLabel")

var tile_cell_size = Vector2(144,144)

var start_position = Vector2(4,2) * tile_cell_size

var puzzle_active = false

var r_minions = [Vector2(6,3)]

func _ready():
	Global.game_lvl = 1
	$allTiles.change_tile_set()
	$HUD/Cards.hide()

func _unhandled_input(event):
	if !puzzle_active:
		if event is InputEventMouseButton:
			if event.pressed == false and event.button_index == 1:
				#print("worked")
				$allTiles.check_for_puzzle_click($Player.position)
				

# This function is what will activate the puzzle minigames
# INSERT PUZZLE ACTIVATION HERE.
func activate_puzzle(tile_coords, tileset_coords):
	#print("Activated puzzle!", tile_coords, tileset_coords)
	if Global.main_game_running:
		if Global.puzzle_running == false:
			$Puzzles.start_puzzle()
			Global.puzzle_running = true
		
func complete_puzzle():
	Global.puzzle_running = false
	$allTiles.num_finished += 1 # This should only happen AFTER puzzle is completed
	if $allTiles.num_finished < 5:
		$HUD.hud_alert("Puzzles completed: " + str($allTiles.num_finished) + "/5")
	else:
		$HUD.hud_alert("You've restored a color!")

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

func next_level():
	if Global.game_lvl < 7:
		Global.game_lvl += 1
	else:
		end_game_cutscene()
	
	#resetting level variables
	Global.player_death = false
	$allTiles.lvl_finished = false
	$allTiles.num_finished = 0
	$allTiles.completed_puzzles = []
	$allTiles.change_tile_set()
	$Player.position = start_position
	
func hud_alert(code):
	$HUD.hud_alert(code)

# ADD: music and a "yay you did it" here
func end_game_cutscene():
	$HUD.run_end_cards()
	
func change_player_color():
	$Player.change_color()
	
