extends Node2D

var foodpics = [
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
	]

var grid = []
var selected_pic = []
var curhover = Vector2(0,0)

func changepic(row,col,pic):
	var nodename = 'food_' + str(row) + '_' + str(col)
	var curnode = get_node(nodename)
	var imagename = "res://images/" + foodpics[pic]
	curnode.get_node('sprite').texture = load(imagename)
	
func change_selected(location):
	var nodename = 'food_' + str(location.x) + '_' + str(location.y)
	var curnode = get_node(nodename)
	curnode.cur_selected = not curnode.cur_selected
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for row in range(6):
		for col in range(5):
			grid.append(randi() % len(foodpics))
			changepic(row,col,grid[row * 5 + col])				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func swap_pic(a,b):
	print("Will swap ",a," with ",b)
	change_selected(a)
	change_selected(b)
	selected_pic.clear()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		print("First:",selected_pic)
		change_selected(curhover)
		if selected_pic.size()==0:
			selected_pic.append(curhover)			
		elif selected_pic.size()==1:
			if selected_pic[0]==curhover:
				selected_pic.clear()
			else:
				var distance_one = abs(selected_pic[0].x - curhover.x)<2 and abs(selected_pic[0].y - curhover.y)<2
				var same_row_col = selected_pic[0].x==curhover.x or selected_pic[0].y==curhover.y
				if distance_one and same_row_col:
					selected_pic.append(curhover)
					swap_pic(curhover,selected_pic[0])
				else:
					change_selected(selected_pic[0])
					selected_pic.clear()
					selected_pic.append(curhover)
		else:
			for sp in selected_pic:
				change_selected(sp)
			selected_pic.clear()
		print("Last:",selected_pic)
		
func _on_food_mouse_entered(posy,posx):
	curhover.x = posx
	curhover.y = posy