extends Area2D

export var level := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Exit_body_entered(body):
	if body.is_in_group("player"):
		var nextlevel = level + 1
		var nextlevelresource = "res://levels/Level " + str(nextlevel) + ".tscn"
		if ResourceLoader.exists(nextlevelresource):
			get_tree().change_scene(nextlevelresource)
		else:
			get_tree().change_scene("res://levels/winner.tscn")
