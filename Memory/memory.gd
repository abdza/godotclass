extends Node2D

var curpos = Vector2(0,0)
func _input(event):
	
	var positionsx = [200,415,635,845]
	var positionsy = [200,370]	
	
	if event.is_action_pressed("ui_right"):
		if curpos.x<len(positionsx)-1:
			curpos.x += 1
	if event.is_action_pressed("ui_left"):
		if curpos.x>0:
			curpos.x -= 1
	if event.is_action_pressed("ui_up"):
		if curpos.y>0:
			curpos.y -= 1
	if event.is_action_pressed("ui_down"):
		if curpos.y<len(positionsy)-1:
			curpos.y += 1
	
	print(curpos)
	var finalposition = Vector2(positionsx[curpos.x],positionsy[curpos.y])
	$selector.position = finalposition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
