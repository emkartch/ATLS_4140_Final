extends CanvasLayer

signal puzzle_completed

var puzz_array = []
var short_puzz_array = []
var curr_puzzle

func _ready():
	puzz_array = [$SlidingPuzzle1Main, $SlidingPuzzle2Main, $SlidingPuzzle3Main, $Slide4, $Slide5, $Slide6]
	#short_puzz_array = [$Slide6]
	for i in puzz_array:
		i.hide()
		
	$Background.hide()
	$Exit.hide()
	$GiveUp.hide()
	
	#$SlidingPuzzle3Main.start_game()

func start_puzzle():
	$Background.show()
	$GiveUp.show()
	#$Exit.show()
	curr_puzzle = puzz_array.pick_random()
	#curr_puzzle = $SlidingPuzzle1Main
	
	#print("puzzle worked")
	#print(curr_puzzle)
	
	curr_puzzle.show()
	curr_puzzle.start_game()

func on_completed():
	await get_tree().create_timer(Global.time_out_for_puzz).timeout
	Global.time_out_for_puzz = 1.0
	$Background.hide()
	curr_puzzle.hide()
	curr_puzzle = -1
	puzzle_completed.emit()
	$Exit.hide()
	$GiveUp.hide()
	
func reset_puzzle():
	if curr_puzzle in puzz_array:
		curr_puzzle.hide()
		curr_puzzle.tiles = []
		
		$Background.hide()
		$Exit.hide()
		Global.puzzle_running = false
		curr_puzzle.playing = false
		
		await get_tree().create_timer(0.2).timeout
		#curr_puzzle = puzz_array.pick_random()
		#curr_puzzle.show()
		#curr_puzzle.start_game()
		

func give_up():
	curr_puzzle.tiles = curr_puzzle.solved.duplicate()
	Global.time_out_for_puzz = 0.2
	on_completed()
