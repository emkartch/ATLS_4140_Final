extends State
class_name attack

@export var player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

func enter():
	animatedSprite.play("attack_" + Global.cur_direction)
	animatedSprite.animation_finished.connect(_on_attack_finished)

func _on_attack_finished():
	Transitioned.emit(self, "idle")

#func update(_delta):
	#if animatedSprite.get_animation() == "attack_" + Global.cur_direction:
		#pass
	#else:
		#animatedSprite.play("attack_" + Global.cur_direction)
#
#func physics_update(_delta):
	#
	#if !Global.player_move:
		#Transitioned.emit(self, "idle")
	#elif Global.player_move and Input.is_action_just_released("player_run"):
		#Transitioned.emit(self, "walk")
