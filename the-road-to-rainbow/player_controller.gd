extends CharacterBody2D

@export var speed = 400

var basic_sprites: SpriteFrames = preload("res://player/sprites/basic_test.tres")
var red_sprites: SpriteFrames = preload("res://player/sprites/red_test.tres")

var test_tracker = 0

func _ready():
	position = Vector2(577, 300)
	$AnimatedSprite2D.sprite_frames = basic_sprites
	
func _process(delta):
	var velocity1 = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity1.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity1.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity1.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity1.y -= 1

	if velocity1.length() > 0:
		velocity1 = velocity1.normalized() * speed
	
	position += velocity1 * delta

	move_and_slide()
	
	$AnimatedSprite2D.play("idle_down")
	
	if Input.is_action_just_pressed("input_test"):
		if test_tracker == 0:
			$AnimatedSprite2D.sprite_frames = red_sprites
			test_tracker = 1
		elif test_tracker == 1:
			$AnimatedSprite2D.sprite_frames = basic_sprites
			test_tracker = 0
