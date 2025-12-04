extends State
class_name run

@export var Player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

func enter():
	Global.player_speed = 600
	animatedSprite.play("run_" + Global.cur_direction)

func update(_delta):
	if animatedSprite.get_animation() == "run_" + Global.cur_direction:
		pass
	else:
		animatedSprite.play("run_" + Global.cur_direction)

func physics_update(_delta):
	
	if Global.player_death:
		Transitioned.emit(self, "death")
	elif Global.player_speed == 0:
		Transitioned.emit(self, "hurt")
	elif Input.is_action_just_pressed("player_attack"):
		Transitioned.emit(self, "attack")
	elif !Global.player_move:
		Transitioned.emit(self, "idle")
	elif Global.player_move and Input.is_action_just_released("player_run"):
		Transitioned.emit(self, "walk")
