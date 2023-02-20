extends KinematicBody2D

var vel = Vector2.ZERO
export var speed := 1
export var speedcap := 250
var speedup = 0


func _physics_process(delta):
	var moving = false
	if Input.is_key_pressed(KEY_W):
		speedup -= 25
		moving = true
	if Input.is_key_pressed(KEY_S):
		speedup += 25
		moving = true
	
	
	if speedup < 0 and !moving:
		speedup += 25
		if speedup > 0:
			speedup = 0
		
	if speedup > 0 and !moving:
		speedup -= 25
		if speedup < 0:
			speedup = 0
	
	if moving == true:
		$Player_model.play("walk")
	if moving == false:
		$Player_model.play("idle")
	
	if speedup > speedcap:
		speedup = speedcap
	if speedup < -speedcap:
		speedup = -speedcap
	
	
	
	
	vel.y = speedup
	
	
	move_and_slide(vel,Vector2.UP)


















