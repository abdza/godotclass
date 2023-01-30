extends Node2D
var relarge = false
var quitlarge = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	relarge =  false
	quitlarge = false
	var centerx = get_viewport().size.x / 2
	var centery = get_viewport().size.y / 2
	$gameover.rect_position.x = centerx
	$gameover.rect_position.y = centery
	$restartbutton.rect_position.x = centerx + 250
	$restartbutton.rect_position.y = centery + 120
	$restartKey.rect_position.x = $restartbutton.rect_position.x
	$restartKey.rect_position.y = $restartbutton.rect_position.y + 50
	$quitbutton.rect_position.x = centerx - 250
	$quitbutton.rect_position.y = centery + 120
	$quitKey.rect_position.x = $quitbutton.rect_position.x + 20
	$quitKey.rect_position.y = $quitbutton.rect_position.y + 50
	if get_global_mouse_position().x < $restartbutton.rect_position.x + 90 and get_global_mouse_position().x > $restartbutton.rect_position.x - 90 \
	and get_global_mouse_position().y < $restartbutton.rect_position.y + 40 and get_global_mouse_position().y > $restartbutton.rect_position.y - 40:
		relarge = true
	if get_global_mouse_position().x < $quitbutton.rect_position.x + 150 and get_global_mouse_position().x > $quitbutton.rect_position.x - 100 \
	and get_global_mouse_position().y < $quitbutton.rect_position.y + 35 and get_global_mouse_position().y > $quitbutton.rect_position.y - 35:
		quitlarge = true
	if relarge == true:
		$restartbutton.rect_scale.x = 5
		$restartbutton.rect_scale.y = 5
	if relarge == false:
		$restartbutton.rect_scale.x = 4
		$restartbutton.rect_scale.y = 4
	if quitlarge == true:
		$quitbutton.rect_scale.x = 4
		$quitbutton.rect_scale.y = 4
	if quitlarge == false:
		$quitbutton.rect_scale.x = 3
		$quitbutton.rect_scale.y = 3
	if Input.is_key_pressed(KEY_ENTER) or Input.is_mouse_button_pressed(1) and relarge == true:
		get_tree().change_scene("res://secne/gamemode_defance.tscn")
	if Input.is_key_pressed(KEY_ESCAPE) or Input.is_mouse_button_pressed(1) and quitlarge == true:
		get_tree().change_scene("res://secne/start.tscn")
