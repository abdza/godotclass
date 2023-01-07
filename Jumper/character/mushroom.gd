extends KinematicBody2D

var velocity := Vector2.ZERO
export var gravity := 300
export var speed := 100
export var direction := -1
export var detect_cliffs := true
var dying = false

func get_killed():
	dying = true
	$AnimatedSprite.playing = false
	$AnimationPlayer.play("dying")

func _ready():
	dying = false
	$AnimatedSprite.playing = true
	$AnimatedSprite.play("run")
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta):
	
	if is_on_wall() or detect_cliffs and not $floor_checker.is_colliding() and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	var horizontal = direction
	velocity.x = horizontal * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if not dying:
		move_and_slide(velocity,Vector2.UP)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
