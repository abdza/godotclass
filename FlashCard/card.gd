extends Node2D

enum state { picture, text }
var mouse_hover
@export var cur_state : state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_picture(pic,name_of_pic):
	$Area2D/Polygon2D/picture.texture = load(pic) 
	$Area2D/Polygon2D/translation.text = name_of_pic
	
func _input(event):
	if event is InputEventMouseButton and mouse_hover and not event.is_pressed():		
		if cur_state==state.text:
			cur_state = state.picture
		else:
			cur_state = state.text
		get_tree().change_scene_to_file("res://flash_card.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cur_state==state.text:
		$Area2D/Polygon2D/translation.visible = true
		$Area2D/Polygon2D/picture.visible = false
	else:
		$Area2D/Polygon2D/translation.visible = false
		$Area2D/Polygon2D/picture.visible = true


func _on_area_2d_mouse_entered():
	mouse_hover = true


func _on_area_2d_mouse_exited():
	mouse_hover = false
