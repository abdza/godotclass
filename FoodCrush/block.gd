extends Node2D

signal mouse_entered
@export var posx = 0
@export var posy = 0
@export var cur_selected = false
@export var current_animation = ""

var on_mouse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_animation = ""
	$selected.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# $selected.visible = cur_selected
	if cur_selected:
		$animation.play('selected')
	else:
		if current_animation!="":
			print("Will play ",current_animation)
			$animation.play(current_animation)

func _on_area_mouse_entered():
	on_mouse = true
	mouse_entered.emit(posx,posy)


func _on_area_mouse_exited():
	on_mouse = false


func _on_animation_animation_finished(anim_name):
	current_animation = ""
