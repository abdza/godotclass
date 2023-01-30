extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lvl1large = false
	var centerx = get_viewport().size.x / 2
	var centery = get_viewport().size.y / 2
	$level1.rect_position.x = 75 
	$level1.rect_position.y = 50
	if get_global_mouse_position().x < $level1.rect_position.x + 90 and get_global_mouse_position().x > $level1.rect_position.x - 90 \
	and get_global_mouse_position().y < $level1.rect_position.y + 40 and get_global_mouse_position().y > $level1.rect_position.y - 40:
		lvl1large = true
	if lvl1large == true:
		$level1.rect_scale.x = 4
		$level1.rect_scale.y = 4
	if lvl1large == false:
		$level1.rect_scale.x = 3
		$level1.rect_scale.y = 3
	if Input.is_mouse_button_pressed(1) and lvl1large == true:
		get_tree().change_scene("res://secne/gamemode_defance.tscn")
