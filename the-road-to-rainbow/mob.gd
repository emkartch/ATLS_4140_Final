extends CharacterBody2D

var speed = randf_range(100, 200)
var health = 3

@onready var player = get_node("/root/Main/Player")
#@onready var camera = get_node("/root/Main/Player/Camera2D/CameraArea")
#@onready var camera = get_node("/root/Main/Player/ReferenceRect")
@onready var animatedSprite: AnimatedSprite2D = get_node("/root/Main/Mob/AnimatedSprite2D")
var r_slimes: SpriteFrames = preload("res://mobs/sprites/red_slime.tres")
var o_slimes: SpriteFrames = preload("res://mobs/sprites/orange_slime.tres")
var y_slimes: SpriteFrames = preload("res://mobs/sprites/yellow_slime.tres")
var g_slimes: SpriteFrames = preload("res://mobs/sprites/green_slime.tres")
var b_slimes: SpriteFrames = preload("res://mobs/sprites/blue_slime.tres")
var i_slimes: SpriteFrames = preload("res://mobs/sprites/indigo_slime.tres")
var v_slimes: SpriteFrames = preload("res://mobs/sprites/violet_slime.tres")

var knockbackBool = false

func _ready():
	#move.connect(player_velocity)
	$AnimatedSprite2D.sprite_frames = r_slimes
	$AnimatedSprite2D.play("idle")

func _physics_process(_delta: float) -> void:
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
			animatedSprite.play("walk")
		
	
func mob_take_damage():
	health -= 1
	knockbackBool = true
	if health == 0:
		
		queue_free()
