extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$card_1.set_picture("res://images/car.jpg","Kereta")
	$card_2.set_picture("res://images/cat.jpg","Kucing")
	$card_3.set_picture("res://images/chicken.png","Ayam")
	$card_4.set_picture("res://images/elephant.jpg","Gajah")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
