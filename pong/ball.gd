extends CharacterBody2D

@export var speed = 300

func _ready():
	randomize()
	reset_ball()

func reset_ball():
	position = Vector2(400, 300)
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized() * speed

func _physics_process(delta):
	move_and_slide()

func _on_Ball_body_entered(body):
	if body is CharacterBody2D and body.name.startswith("Paddle"):
		velocity.x = -velocity.x
		velocity = velocity.bounce(velocity.normalized())
	elif body is StaticBody2D:
		velocity.y = -velocity.y

func _on_Ball_area_entered(area):
	if area.name == "LeftGoal" or area.name == "RightGoal":
		reset_ball()
