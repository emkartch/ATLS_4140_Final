extends Node

@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Player/AnimatedSprite2D")

var last_input_dir = Vector2(0.0,1.0)

#func direction_animation_update(type: String):
	#
	#if last_input_dir == Vector2(0.0,-1.0):
		#animatedSprite.play(type + "_backward")
	##down
	#elif last_input_dir == Vector2(0.0,1.0):
		#get_node("/root/Main/Player/BodyPivot/AnimatedSprite2D").play(type + "_forward")
	##left
	#elif last_input_dir == Vector2(-1.0,0.0):
		#animatedSprite.flip_h = true
		#animatedSprite.play(type + "_sideways")
	##right
	#elif last_input_dir == Vector2(1.0,0.0):
		#animatedSprite.flip_h = false
		#animatedSprite.play(type + "_sideways")
