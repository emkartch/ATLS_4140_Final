extends State
class_name idle

@export var player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

func enter():
	animatedSprite.play("idle_" + Global.cur_direction)

func update(_delta):
	if animatedSprite.get_animation() == "idle_" + Global.cur_direction:
		pass
	else:
		animatedSprite.play("idle_" + Global.cur_direction)
		
func physics_update(_delta):
	
	if Global.wound_animation:
		Transitioned.emit(self, "hurt")
	elif Input.is_action_just_pressed("player_attack"):
		Transitioned.emit(self, "attack")
	elif Global.player_move:
		if Input.is_action_pressed("player_run"):
			Transitioned.emit(self, "run")
		else:
			Transitioned.emit(self, "walk")
			
