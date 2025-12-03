extends Node

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

var cur_direction = "down"

var player_move = false

var player_speed = 400

var main_game_running = false
