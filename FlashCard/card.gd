extends Node2D

enum state { picture, text }
@export var cur_state : state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_picture(pic,name_of_pic):
	$Polygon2D/picture.texture = load(pic) 
	$translation.text = name_of_pic
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cur_state==state.text:
		$translation.visible = true
		$Polygon2D/picture.visible = false
	else:
		$translation.visible = false
		$Polygon2D/picture.visible = true
