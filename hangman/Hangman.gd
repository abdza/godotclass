extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var wordlist = []
var found_letters = []
var random_word
var tries = 0
var max_tries = 5

func load_file(var length):
	var file = File.new()
	file.open("res://word_lists.txt", File.READ)
	var curword
	while not file.eof_reached():
		curword = file.get_line()
		if len(curword)==length:
			wordlist.append(curword)
	file.close()

func get_random_word():
	wordlist.clear()
	var random = RandomNumberGenerator.new()
	random.randomize()
	load_file(5)
	var random_index = random.randi_range(0,len(wordlist))
	random_word = wordlist[random_index]
	print(random_word)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	get_random_word()

func _input(event):
	# a = 65 z = 90
	if event is InputEventKey and event.pressed:
		var keyin = PoolByteArray([event.scancode]).get_string_from_ascii()
		print(keyin)
		var update = ''
		var foundletter = false
		var complete = true
		for i in range(len(random_word)):
			if keyin.to_lower()==random_word[i]:
				update += keyin.to_lower() + ' '
				found_letters.append(i)
				print('found ',keyin, ' at ',i)
				foundletter = true
			elif i in found_letters:
				update += random_word[i] + ' '
			else:
				update += '_ '
				complete = false
		$word.text = update
		if not foundletter:
			tries += 1
		if tries > max_tries:
			$message.text = 'GAME OVER'
			$retry_button.visible = true
		else:
			$message.text = str(tries) + ' tries'
		if complete:
			$message.text = 'YOU WIN!'
			$retry_button.visible = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_retry_button_button_up():
	tries = 0
	get_random_word()
	$retry_button.visible = false
	found_letters.clear()
	$message.text = ""
	$word.text = "_ _ _ _ _"
