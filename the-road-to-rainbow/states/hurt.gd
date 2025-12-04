extends State
class_name hurt

@export var player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

#func _ready():
	#animatedSprite.animation_finished.connect(_on_hurt_finished)
	
func enter():
	animatedSprite.play("hurt_" + Global.cur_direction)

#func _on_hurt_finished():
	#Global.wound_animation = false
	#Transitioned.emit(self, "hurt")
