extends CharacterBody2D

var speed = randf_range(100, 200)
var health = 3

@onready var player = get_node("/root/Main/Player")
#@onready var camera = get_node("/root/Main/Player/Camera2D/CameraArea")
#@onready var camera = get_node("/root/Main/Player/ReferenceRect")
var r_slimes: SpriteFrames = preload("res://mobs/sprites/red_slime.tres")
var o_slimes: SpriteFrames = preload("res://mobs/sprites/orange_slime.tres")
var y_slimes: SpriteFrames = preload("res://mobs/sprites/yellow_slime.tres")
var g_slimes: SpriteFrames = preload("res://mobs/sprites/green_slime.tres")
var b_slimes: SpriteFrames = preload("res://mobs/sprites/blue_slime.tres")
var i_slimes: SpriteFrames = preload("res://mobs/sprites/indigo_slime.tres")
var v_slimes: SpriteFrames = preload("res://mobs/sprites/violet_slime.tres")

var slime_colors = [r_slimes, o_slimes, y_slimes, g_slimes, b_slimes, i_slimes, v_slimes]

var knockbackBool = false

var track_color = 1

func _ready():
	#move.connect(player_velocity)
	$AnimatedSprite2D.sprite_frames = slime_colors[Global.game_lvl - 1]
	$AnimatedSprite2D.play("idle")
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)

func _physics_process(_delta: float) -> void:

	if track_color != Global.game_lvl:
		change_color()
		track_color += 1
		
	if health != 0:
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
			$AnimatedSprite2D.play("walk")
		
	
func mob_take_damage():
	health -= 1
	knockbackBool = true
	if health <= 0:
		$AnimatedSprite2D.play("death")

func change_color():
	$AnimatedSprite2D.sprite_frames = slime_colors[Global.game_lvl - 1]

func _on_animation_finished():
	queue_free()
