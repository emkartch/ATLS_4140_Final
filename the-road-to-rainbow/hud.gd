extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

@onready var main = get_node("/root/Main")
@onready var theme = preload("res://theme/trtr_theme.tres")
@onready var tileMap = get_node("/root/Main/allTiles")
@onready var player = get_node("/root/Main/Player")

func _ready():
	$InLevel.hide()
	$Settings.hide()
	tileMap.hide()
	player.hide()
	$Alerts.hide()
	
#func level_remove():
	#tileMap.queue_free()
	
#func level_reset():
	#tileMap = preload("res://tilemaps.tscn").instantiate()
	#main.set_tilemap(tileMap)
	#main.add_child(tileMap)

func show_game_over():
	$InLevel.hide()
	tileMap.hide()
	player.hide()
	get_tree().call_group("mobs", "queue_free")
	$TitleScreen.show()
	%RainbowIcon.texture = load("res://rainbow_hud/rainbow_0.png")
	Global.game_lvl = 1
	#level_remove()
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	%TitleLabel.text = "The Road to\nRainbow"
	$TitleContainer.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$TitleButtonsContainer.show()
	
func show_win():
	$InLevel.hide()
	tileMap.hide()
	player.hide()
	get_tree().call_group("mobs", "queue_free")
	$TitleScreen.show()
	%RainbowIcon.texture = load("res://rainbow_hud/rainbow_0.png")
	Global.game_lvl = 1
	#level_remove()
	show_message("You win!")
	
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	%TitleLabel.text = "The Road to\nRainbow"
	$TitleContainer.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$TitleButtonsContainer.show()

func show_message(text):
	%TitleLabel.text = text
	$TitleContainer.show()
	$MessageTimer.start()

func _on_start_button_pressed() -> void:
	$TitleScreen.hide()
	$TitleContainer.hide()
	$TitleButtonsContainer.hide()
	%RainbowIcon.texture = load("res://rainbow_hud/rainbow_0.png")
	$InLevel.show()
	#level_reset()
	call_deferred("level_start")

func level_start():
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$TitleContainer.hide()

func show_settings():
	main.get_tree().paused = true
	if Global.main_game_running == false:
		$TitleButtonsContainer.hide()
		$TitleContainer.hide()
	$Settings.show()

func _on_settings_icon_button_pressed() -> void:
	show_settings() 
	
func _on_settings_button_pressed() -> void:
	show_settings() 

func _on_return_icon_pressed() -> void:
	$Settings.hide()
	if Global.main_game_running == false:
		$TitleButtonsContainer.show()
		$TitleContainer.show()
	main.get_tree().paused = false

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		theme.set_font_size("font_size", "Label", 80)
		theme.set_font_size("font_size", "Button", 60)
		theme.set_font_size("font_size", "CheckButton", 60)
		%HealthBar.size.y = 50
		%HealthBar.position.y = 650
		%HealthLabel.add_theme_font_size_override("font_size", 50)
	elif not toggled_on:
		theme.set_font_size("font_size", "Label", 60)
		theme.set_font_size("font_size", "Button", 40)
		theme.set_font_size("font_size", "CheckButton", 40)
		%HealthBar.size.y = 35
		%HealthBar.position.y = 665
		%HealthLabel.add_theme_font_size_override("font_size", 30)
		
func hud_alert(code):
	$Alerts/AlertText.text = code
	
	$Alerts.show()
	$Alerts/Timer.start()
		
	await $Alerts/Timer.timeout
	#print("timed out")
	$Alerts.hide()
	
