extends CharacterBody2D

signal health_depleted

var health = 100.0
@onready var healthBar = get_node("/root/Main/HUD/InLevel/HealthBar")
@onready var healthBarText = get_node("/root/Main/HUD/InLevel/HealthBar/HealthLabel")

var basic_sprites: SpriteFrames = preload("res://player/sprites/basic_sprites.tres")
var r_sprites: SpriteFrames = preload("res://player/sprites/red_sprites.tres")
var o_sprites: SpriteFrames = preload("res://player/sprites/orange_sprites.tres")
var y_sprites: SpriteFrames = preload("res://player/sprites/yellow_sprites.tres")
var g_sprites: SpriteFrames = preload("res://player/sprites/green_sprites.tres")
var b_sprites: SpriteFrames = preload("res://player/sprites/blue_sprites.tres")
var i_sprites: SpriteFrames = preload("res://player/sprites/indigo_sprites.tres")
var v_sprites: SpriteFrames = preload("res://player/sprites/violet_sprites.tres")

var sprite_array = [r_sprites, o_sprites, y_sprites, g_sprites, b_sprites, i_sprites, v_sprites]

var test_tracker = 0

func _ready():
	position = Vector2(577, 300)
	$AnimatedSprite2D.sprite_frames = basic_sprites
	$AnimatedSprite2D.play("idle_down")
	%PunchBox.disabled = true
	
func _process(delta):
	if Global.main_game_running:
		#print(InputMap.has_action("player_right"))
		
		var velocity1 = Vector2.ZERO # The player's movement vector.
		#if !Global.wound_animation:
		if Input.is_anything_pressed() == false:
			velocity1 = Vector2(0,0)
		if Input.is_action_pressed("player_right"):
			velocity1.x += 1
			Global.cur_direction = "right"
		if Input.is_action_pressed("player_left"):
			velocity1.x -= 1
			Global.cur_direction = "left"
		if Input.is_action_pressed("player_down"):
			velocity1.y += 1
			Global.cur_direction = "down"
		if Input.is_action_pressed("player_up"):
			velocity1.y -= 1
			Global.cur_direction = "up"

		if velocity1.length() > 0:
			velocity1 = velocity1.normalized() * Global.player_speed
			#print(velocity1)
			Global.player_move = true
		else:
			Global.player_move = false
		
		#position += velocity1 * delta

		move_and_collide(velocity1 * delta)
		#move_and_collide(position)
	
	#if Input.is_action_just_pressed("input_test"):
		#if test_tracker == 0:
			#$AnimatedSprite2D.sprite_frames = r_sprites
			#test_tracker = 1
		#elif test_tracker == 1:
			#$AnimatedSprite2D.sprite_frames = basic_sprites
			#test_tracker = 0


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body == self:
		return
	if body is CharacterBody2D:
		$hurt.play()
		health -= 10
		Global.player_speed = 0
		#Global.direction_animation_update("stagger")
		if !health == 0:
			healthBar.value = health
			healthBarText.text = str(int(health)) + "/" + str(int(Global.max_player_health))
		if health <= 0.0:
			#hide() # Player disappears after being hit.
			health_depleted.emit()
			$death.play()


func _on_punch_area_body_entered(body: Node2D) -> void:
	if body != self and body.has_method("mob_take_damage"):
		body.mob_take_damage()
		$punch.play()
		
func change_color():
	$AnimatedSprite2D.sprite_frames = sprite_array[Global.game_lvl - 1]

func reset_health():
	health = 100.0
	healthBar.value = health
	healthBarText.text = str(int(health)) + "/" + str(int(Global.max_player_health))
