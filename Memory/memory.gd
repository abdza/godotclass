extends Node2D

var foodpics = [
	'01_dish.png',
	'03_dish_pile.png',
	'06_apple_pie_dish.png',
	'08_bread_dish.png',
	'10_baguette_dish.png',
	'12_bun_dish.png',
	'14_bacon_dish.png',
	'16_burger_dish.png',
	'19_burrito_dish.png',
	'21_bagel_dish.png',
	'23_cheesecake_dish.png',
	'27_chocolate_dish.png',
	'29_cookies_dish.png',
	'31_chocolatecake_dish.png',
	'33_curry_dish.png',
	'35_donut_dish.png',
	'37_dumplings_dish.png'
	]

var hiddendishes = [0,0,0,0,0,0,0,0]
var curdishes = [0,0,0,0,0,0,0,0]

var selected_plate = []

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
	if event.is_action_pressed("ui_text_newline"):
		var curselect = curpos.x + curpos.y * 4  # find the currently selected plate
		print(curselect)
		if not curselect in selected_plate:  # check that the currently selected plate is not yet selected
			if len(selected_plate)<2:  # check that the user has not selected more than 2 plates
				selected_plate.append(curselect)  # add the currently selected plate to the list of selected plates
				display_plate(curselect, hiddendishes[curselect])  # display the dish of the plate that was selected
				
				if len(selected_plate)==2:  # user already selected 2 plates now, we need to compate them
					if hiddendishes[selected_plate[0]] == hiddendishes[selected_plate[1]]: # both plate 1 and 2 are the same
						curdishes[selected_plate[0]] = hiddendishes[selected_plate[0]] # set first selection solved
						curdishes[selected_plate[1]] = hiddendishes[selected_plate[1]] # set second selection solved
						selected_plate.clear() # clear the list of currently user selected plates
			else: # user has chosen more than 2 plates. Need to clear them
				for i in range(8):  #  loop over the 8 dished
					display_plate(i,curdishes[i])  # display them back to the currently solved plates
				selected_plate.clear()  # clear the list of currently user selected plates

	var finalposition = Vector2(positionsx[curpos.x],positionsy[curpos.y])
	$selector.position = finalposition

func display_plate(plate, food_num):
	var nodename = 'food' + str(plate + 1)
	print(nodename)
	var curnode = get_node(nodename)
	var imagename = "res://images/" + foodpics[food_num]
	print(imagename)
	curnode.texture = load(imagename)
	
# Called when the node enters the scene tree for the first time.
func _ready():	
	var donechoice = []
	for i in range(4):		
		var randomchoice = ( randi() % ( len(foodpics) - 2 ) ) + 2  # always between 2 - 15
		while randomchoice in donechoice:
			randomchoice = ( randi() % ( len(foodpics) - 2 ) ) + 2  # always between 2 - 15
		
		donechoice.append(randomchoice)
		
		var firstplate = randi() % 8
		while hiddendishes[firstplate] != 0:
			firstplate = randi() % 8
		
		hiddendishes[firstplate] = randomchoice
		
		var secondplate = randi() % 8
		while hiddendishes[secondplate] != 0:
			secondplate = randi() % 8
		
		hiddendishes[secondplate] = randomchoice
		
		display_plate(firstplate,curdishes[firstplate])
		display_plate(secondplate,curdishes[secondplate])
		
		#var nodename = 'food' + str(firstplate + 1)
		#print(nodename)
		#var curnode = get_node(nodename)
		#var imagename = "res://images/" + foodpics[hiddendishes[firstplate]]
		#print(imagename)
		#curnode.texture = load(imagename)
	
		#nodename = 'food' + str(secondplate + 1)
		#print(nodename)
		#curnode = get_node(nodename)
		#imagename = "res://images/" + foodpics[hiddendishes[secondplate]]
		#print(imagename)
		#curnode.texture = load(imagename)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

