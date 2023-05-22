extends CharacterBody2D

var velocity := Vector2.ZERO
@export var gravity := 300
@export var speed := 100
@export var direction := -1
@export var detect_cliffs := true
var dying = false

func get_killed():
	dying = true
	$AnimatedSprite2D.playing = false
	$AnimationPlayer.play("dying")

func _ready():
	dying = false
	$AnimatedSprite2D.playing = true
	$AnimatedSprite2D.play("run")
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta):
	
	if is_on_wall() or detect_cliffs and not $floor_checker.is_colliding() and is_on_floor():
		direction = direction * -1
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	var horizontal = direction
	velocity.x = horizontal * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if not dying:
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
