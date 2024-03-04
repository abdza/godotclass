extends Node2D

var word_choices = [
	["res://images/car.jpg","Kereta"],
	["res://images/cat.jpg","Kucing"],
	["res://images/chicken.png","Ayam"],
	["res://images/elephant.jpg","Gajah"],
	["res://images/cow.png","Lembu"]
]

var word_selection = []
var word_target 

func randomize_selection():
	while len(word_selection)<4:
		var current_word = randi() % len(word_choices)
		if not current_word in word_selection:
			word_selection.append(current_word)
	$card_1.set_picture(word_choices[word_selection[0]][0],word_choices[word_selection[0]][1])
	$card_2.set_picture(word_choices[word_selection[1]][0],word_choices[word_selection[1]][1])
	$card_3.set_picture(word_choices[word_selection[2]][0],word_choices[word_selection[2]][1])
	$card_4.set_picture(word_choices[word_selection[3]][0],word_choices[word_selection[3]][1])
	word_target = randi() % len(word_selection)	
	$target.text = word_choices[word_selection[word_target]][1]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_selection()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
