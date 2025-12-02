extends State
class_name walk

@export var player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

func enter():
	animatedSprite.play("walk_" + Global.cur_direction)

func update(delta):
	if animatedSprite.get_animation() == "walk_" + Global.cur_direction:
		pass
	else:
		animatedSprite.play("walk_" + Global.cur_direction)

func physics_update(delta):
	
	if !Global.player_move:
		Transitioned.emit(self, "idle")
