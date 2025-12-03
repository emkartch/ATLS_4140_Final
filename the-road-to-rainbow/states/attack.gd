extends State
class_name attack

@export var player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

func _ready():
	animatedSprite.animation_finished.connect(_on_attack_finished)
	
func enter():
	animatedSprite.play("attack_" + Global.cur_direction)

func _on_attack_finished():
	Transitioned.emit(self, "idle")
