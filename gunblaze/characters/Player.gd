extends KinematicBody2D

var vel = Vector2.ZERO
export var accelspeed := 25
export var speedcap := 250
export var rotatespeed := 5
var Ryspeedcap = 0
var Rxspeedcap = 0
var Rxspeed = 0
var Ryspeed = 0
var speedupy = 0
var speedupx = 0

func _physics_process(delta):
	var Rspeed = float(accelspeed*0.01111111111111111111111111111111)
	var Rspeedcap = float(speedcap*0.01111111111111111111111111111111)
	var northwest = false
	var southwest = false
	var southeast = false
	var northeast = false
	var moving = false
###################################user control
	if Input.is_key_pressed(KEY_W):
		speedupy -= Ryspeed
		speedupx += Rxspeed
		moving = true
	if Input.is_key_pressed(KEY_S):
		speedupy += Ryspeed
		speedupx -= Rxspeed
		moving = true
	if Input.is_key_pressed(KEY_A):
		rotation_degrees -= rotatespeed
	if Input.is_key_pressed(KEY_D):
		rotation_degrees += rotatespeed
		
###############################################################rotation speed control
	if rotation_degrees < 0:
		rotation_degrees += 360
	if rotation_degrees >= 360:
		rotation_degrees = 0
	if rotation_degrees >= 0 and rotation_degrees < 90:
		Ryspeed = (Rspeed*(90-rotation_degrees))
		Rxspeed = (Rspeed*(0+rotation_degrees))
		Ryspeedcap = (Rspeedcap*(90-rotation_degrees))
		Rxspeedcap = (Rspeedcap*(0+rotation_degrees))
		northeast = true
	if rotation_degrees >= 90 and rotation_degrees < 180:
		Ryspeed = (Rspeed*(0-(rotation_degrees-90)))
		Rxspeed = (Rspeed*(90-(rotation_degrees-90)))
		Ryspeedcap = (Rspeedcap*(0-(rotation_degrees-90)))
		Rxspeedcap = (Rspeedcap*(90-(rotation_degrees-90)))
		southeast = true
	if rotation_degrees >= 180 and rotation_degrees < 270:
		Ryspeed = (Rspeed*(-90+(rotation_degrees-180)))
		Rxspeed = (Rspeed*(0-(rotation_degrees-180)))
		Ryspeedcap = (Rspeedcap*(-90+(rotation_degrees-180)))
		Rxspeedcap = (Rspeedcap*(0-(rotation_degrees-180)))
		southwest = true
	if rotation_degrees >= 270 and rotation_degrees < 360:
		Ryspeed = (Rspeed*(0+(rotation_degrees-270)))
		Rxspeed = (Rspeed*(-90+(rotation_degrees-270)))
		Ryspeedcap = (Rspeedcap*(0+(rotation_degrees-270)))
		Rxspeedcap = (Rspeedcap*(-90+(rotation_degrees-270)))
		northwest = true
		
###############################################################All rotaional speed code
	if northeast == true:
		if speedupy < 0 and !moving:
			speedupy += Ryspeed
			if speedupy > 0:
				speedupy = 0
		if speedupy > 0 and !moving:
			speedupy -= Ryspeed
			if speedupy < 0:
				speedupy = 0
		if speedupx < 0 and !moving:
			speedupx += Rxspeed
			if speedupx > 0:
				speedupx = 0
		if speedupx > 0 and !moving:
			speedupx -= Rxspeed
			if speedupx < 0:
				speedupx = 0
				
	if southeast == true:
		if speedupy > 0 and !moving:
			speedupy += Ryspeed
			if speedupy < 0:
				speedupy = 0
		if speedupy < 0 and !moving:
			speedupy -= Ryspeed
			if speedupy > 0:
				speedupy = 0
		if speedupx < 0 and !moving:
			speedupx += Rxspeed
			if speedupx > 0:
				speedupx = 0
		if speedupx > 0 and !moving:
			speedupx -= Rxspeed
			if speedupx < 0:
				speedupx = 0

	if southwest == true:
		if speedupy > 0 and !moving:
			speedupy += Ryspeed
			if speedupy < 0:
				speedupy = 0
		if speedupy < 0 and !moving:
			speedupy -= Ryspeed
			if speedupy > 0:
				speedupy = 0
		if speedupx > 0 and !moving:
			speedupx += Rxspeed
			if speedupx < 0:
				speedupx = 0
		if speedupx < 0 and !moving:
			speedupx -= Rxspeed
			if speedupx > 0:
				speedupx = 0
				
	if northwest == true:
		if speedupy < 0 and !moving:
			speedupy += Ryspeed
			if speedupy > 0:
				speedupy = 0
		if speedupy > 0 and !moving:
			speedupy -= Ryspeed
			if speedupy < 0:
				speedupy = 0
		if speedupx < 0 and !moving:
			speedupx -= Rxspeed
			if speedupx > 0:
				speedupx = 0
		if speedupx > 0 and !moving:
			speedupx += Rxspeed
			if speedupx < 0:
				speedupx = 0
	
	if northeast:
		if speedupy > Ryspeedcap:
			speedupy = Ryspeedcap
		if speedupy < -Ryspeedcap:
			speedupy = -Ryspeedcap
		if speedupx > Rxspeedcap:
			speedupx = Rxspeedcap
		if speedupx < -Rxspeedcap:
			speedupx = -Rxspeedcap
	if southeast:
		if speedupy < Ryspeedcap:
			speedupy = Ryspeedcap
		if speedupy > -Ryspeedcap:
			speedupy = -Ryspeedcap
		if speedupx > Rxspeedcap:
			speedupx = Rxspeedcap
		if speedupx < -Rxspeedcap:
			speedupx = -Rxspeedcap
	if southwest:
		if speedupy < Ryspeedcap:
			speedupy = Ryspeedcap
		if speedupy > -Ryspeedcap:
			speedupy = -Ryspeedcap
		if speedupx < Rxspeedcap:
			speedupx = Rxspeedcap
		if speedupx > -Rxspeedcap:
			speedupx = -Rxspeedcap
	if northwest:
		if speedupy > Ryspeedcap:
			speedupy = Ryspeedcap
		if speedupy < -Ryspeedcap:
			speedupy = -Ryspeedcap
		if speedupx < Rxspeedcap:
			speedupx = Rxspeedcap
		if speedupx > -Rxspeedcap:
			speedupx = -Rxspeedcap
	
	
	
	
	
	
	if moving == true:
		$Player_model.play("walk")
	if moving == false:
		$Player_model.play("idle")
		
	vel.y = speedupy
	vel.x = speedupx
	
	move_and_slide(vel,Vector2.UP)


















