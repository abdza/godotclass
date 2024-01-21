extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$card_1/picture_1.texture = load("res://images/car.jpg")
	
	$card_2/picture_2.texture = load("res://images/cat.jpg")
	$card_3/picture_3.texture = load("res://images/chicken.png")
	$card_4/picture_4.texture = load("res://images/cow.png")
	$card_4/picture_4.
	$card_5/picture_5.texture = load("res://images/elephant.jpg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
