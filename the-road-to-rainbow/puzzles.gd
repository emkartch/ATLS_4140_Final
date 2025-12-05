extends CanvasLayer

signal puzzle_completed

var puzz_array = []
var curr_puzzle

func _ready():
	puzz_array = [$SlidingPuzzle1Main, $SlidingPuzzle2Main, $SlidingPuzzle3Main]
	#puzz_array = [$SlidingPuzzle1Main]
	for i in puzz_array:
		i.hide()
		
	$Background.hide()
	$Reset.hide()
	
	#$SlidingPuzzle3Main.start_game()

func start_puzzle():
	$Background.show()
	#$Reset.show()
	curr_puzzle = puzz_array.pick_random()
	#curr_puzzle = $SlidingPuzzle1Main
	
	#print("puzzle worked")
	#print(curr_puzzle)
	
	curr_puzzle.show()
	curr_puzzle.start_game()

func on_completed():
	await get_tree().create_timer(1.0).timeout
	$Background.hide()
	curr_puzzle.hide()
	curr_puzzle = -1
	puzzle_completed.emit()
	$Reset.hide()
	
func reset_puzzle():
	if curr_puzzle in puzz_array:
		curr_puzzle.hide()
		curr_puzzle = puzz_array.pick_random()
		curr_puzzle.show()
		curr_puzzle.start_game()
		
	
