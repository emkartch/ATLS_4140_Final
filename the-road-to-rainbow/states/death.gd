extends State
class_name death

@export var Player : CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")
@onready var punchArea = get_node("/root/Main/Player/PunchArea")
@onready var hud = get_node("/root/Main/HUD")
@onready var anim_name = null

func _ready():
	animatedSprite.animation_finished.connect(_on_animation_finished)
	
func enter():
	animatedSprite.play("death_" + Global.cur_direction)

func _on_animation_finished():
	if Global.main_game_running:
		anim_name = animatedSprite.animation
		
		if anim_name == "death_up" or anim_name == "death_down" or anim_name == "death_left" or anim_name == "death_right":
			Global.player_speed = 300
			await get_tree().create_timer(1.0).timeout
			hud.show_game_over()
			Global.cur_direction = "down"
			Transitioned.emit(self, "idle")
			anim_name == null
			Global.main_game_running = false
		elif anim_name == "hurt_up" or anim_name == "hurt_down" or anim_name == "hurt_left" or anim_name == "hurt_right":
			Global.player_speed = 300
			Transitioned.emit(self, "idle")
		elif anim_name == "attack_up" or anim_name == "attack_down" or anim_name == "attack_left" or anim_name == "attack_right":
			%PunchBox.disabled = true
			Transitioned.emit(self, "idle")
