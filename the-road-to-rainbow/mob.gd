extends CharacterBody2D

var speed = randf_range(100, 200)
var health = 3

@onready var player = get_node("/root/Main/Player")
#@onready var camera = get_node("/root/Main/Player/Camera2D/CameraArea")
#@onready var camera = get_node("/root/Main/Player/ReferenceRect")
@onready var animatedSprite = get_node("BodyPivot/AnimatedSprite2D")

var knockbackBool = false

#func _ready():
	#move.connect(player_velocity)

func _physics_process(delta: float) -> void:
	#var is_visible = []
	#var visible = camera.get_overlapping_areas()
	#for area in visible:
		#is_visible.append(area.name)
	#if is_visible.has("Visible"):
	#var rect: Rect2 = Rect2(to_global(camera.position), camera.size)
	#if rect.has_point(position):
		if knockbackBool == true:
			var kb_direction = (Global.knockback - velocity).normalized() * 10000
			velocity = kb_direction
			velocity.y -= 250
			move_and_slide()
			knockbackBool = false
		else:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
			move_and_slide()
			animatedSprite.play(str(Global.level_count) + "_walk")
		
	
func mob_take_damage():
	health -= 1
	knockbackBool = true
	if health == 0:
		
		queue_free()
