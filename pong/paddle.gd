extends CharacterBody2D

const SPEED = 300.0
@export var move_up_action: String = "ui_up"
@export var move_down_action: String = "ui_down"

func _physics_process(delta):

	var direction = 0
	if Input.is_action_pressed(move_up_action):
		direction -= 1
	if Input.is_action_pressed(move_down_action):
		direction += 1
		
	velocity = Vector2(0, direction * SPEED)

	move_and_slide()
