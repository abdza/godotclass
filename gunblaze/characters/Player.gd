extends KinematicBody2D

var vel = Vector2.ZERO
var inputvactor = Vector2.ZERO
export var accelspeed := 25
export var speedcap := 250
export var rotatespeed := 10
var speedup = 0

func _physics_process(delta):
	var rotatedirection = 0
	var moving = false
###################################user control
	if Input.is_key_pressed(KEY_W):
		speedup += -accelspeed
		moving = true
	if Input.is_key_pressed(KEY_S):
		speedup += accelspeed
		moving = true
	if Input.is_key_pressed(KEY_A):
		rotatedirection -= 1
	if Input.is_key_pressed(KEY_D):
		rotatedirection += 1
	if speedup < 0 and !moving:
		speedup += accelspeed
		if speedup > 0:
			speedup = 0
	if speedup > 0 and !moving:
		speedup -= accelspeed
		if speedup < 0:
			speedup = 0
	
	if speedup > speedcap:
		speedup = speedcap
	if speedup < -speedcap:
		speedup = -speedcap
	if speedup > speedcap:
		speedup = speedcap
	if speedup < -speedcap:
		speedup = -speedcap
	inputvactor.y = speedup
	
	
	if moving == true:
		$Player_model.play("walk")
	if moving == false:
		$Player_model.play("idle")
	rotation += rotatedirection*rotatespeed*delta
	
	vel = Vector2.ZERO
	vel += inputvactor.rotated(rotation)
	
	move_and_slide(vel,Vector2.UP)


















