extends State
class_name death

@export var Player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")
#@onready var hud = get_node("/root/Main/HUD")
#@onready var player = get_node("/root/Main/Player")

#func _ready():
	#animatedSprite.animation_finished.connect(_on_death_finished)
	
func enter():
	animatedSprite.play("death_" + Global.cur_direction)

#func _on_death_finished():
	#print(animatedSprite.animation)
	#Global.wound_animation = false
	#hud.show_game_over()
