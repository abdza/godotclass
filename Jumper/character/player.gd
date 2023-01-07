extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
export var speed := 300
export var gravity := 300
export var jump_strength := -200
export var score := 0
var jumpcount = 0
var is_dead = false

func _ready():
	$AnimatedSprite.animation = "idle"
	$AnimatedSprite.playing = true
	is_dead = false
	score = 0

func _physics_process(delta):
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = horizontal * speed
	
	var is_falling = velocity.y > 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("ui_up") and is_on_floor()
	var is_double_jumping = Input.is_action_just_pressed("ui_up") and is_falling
	var is_jump_cancelled = Input.is_action_just_released("ui_up") and velocity.y < 0.0
	var is_idling = is_on_floor() and is_zero_approx(velocity.x)
	var is_running = is_on_floor() and not is_zero_approx(velocity.x)
	
	if Input.is_action_just_pressed("ui_left") and not $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if Input.is_action_just_pressed("ui_right") and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if velocity.y > 1000:
		is_dead = true
		
	if is_jumping:
		$AnimatedSprite.animation = 'jump'
		velocity.y = jump_strength
		jumpcount += 1
	elif is_double_jumping:
		if jumpcount<1:
			$AnimatedSprite.animation = 'jump'
			velocity.y = jump_strength
			jumpcount += 1
	elif is_falling:
		$AnimatedSprite.animation = "fall"
	elif is_running:
		$AnimatedSprite.animation = "walking"
	elif is_idling:
		$AnimatedSprite.animation = "idle"
	
	if is_on_floor():
		jumpcount = 0
	
	move_and_slide(velocity,Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("enemy"):
			var enemy = collision.collider
			if not enemy.dying:
				if is_falling:
					enemy.get_killed()
					score += 100
				else:
					is_dead = true
	
	$score.text = str(score)
	if is_dead:
		get_tree().change_scene("res://levels/game_over.tscn")
