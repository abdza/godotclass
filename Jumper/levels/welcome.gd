extends Node2D

var menuselected = 0
var menuchanged = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$animation_start.play("highlight_start")
	menuselected = 0
	menuchanged = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	menuchanged = false
	if Input.is_action_just_pressed("ui_up"):
		menuselected -= 1
		if menuselected<0:
			menuselected = 1
		menuchanged = true
	elif Input.is_action_just_pressed("ui_down"):
		menuselected += 1
		if menuselected>1:
			menuselected = 0
		menuchanged = true
	elif Input.is_action_just_pressed("ui_accept"):
		if menuselected==0:
			get_tree().change_scene("res://levels/Level 1.tscn")
		elif menuselected==1:
			get_tree().quit()
	
	if menuchanged:
		if menuselected==0:
			$animation_start.play("highlight_start")
			$animation_exit.stop()
		elif menuselected==1:
			$animation_exit.play("highlight_exit")
			$animation_start.stop()
	print("Menu selected:" + str(menuselected))
	
